<?php

namespace App\Http\Controllers;

use App\Models\Conversation;
use App\Models\File;
use App\Models\Message;
use App\Models\User;
use Illuminate\Http\Request;
use Pusher\Pusher;
use Tymon\JWTAuth\Facades\JWTAuth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
class MessageController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index($id)
    {
      
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */


public function send(Request $request)
{
    try {
        // **1. التحقق من المستخدم**
        $user = JWTAuth::parseToken()->authenticate();

        $content = $request->input('content');
        $receiverId = $request->input('receiver_id');
        $file = $request->file('file');

        // **2. التحقق إذا كان content و file كلاهما null**
        if (is_null($content) && is_null($file)) {
            return response()->json(['message' => 'Content or file is required'], 400);
        }

        // **3. التحقق من وجود المستخدم المستلم**
        $receiver = User::find($receiverId);
        
        if (!$receiver) {
            return response()->json(['message' => 'Receiver user not found'], 404);
        }

        // **4. التحقق من وجود المحادثة**
        $conversation = $this->getConversation($user, $receiver);

        if (!$conversation) {
            $conversation = Conversation::create([
                'user1_id' => $user->id,
                'user2_id' => $receiver->id,
            ]);
        }

        // **5. تخزين الرسالة**
        $messageData = [
            'conversation_id' => $conversation->id,
            'sender_id' => $user->id,
            'content' => $content,
            'is_read' => false,
            'is_received' => false
        ];

        $fileUrl = null;

        if ($file) {
            try {
                // حفظ الملف
                $filePath = $file->store('messages/files', 'public');
                $fileUrl = Storage::url($filePath);
            } catch (\Exception $e) {
                return response()->json(['message' => 'File upload failed', 'error' => $e->getMessage()], 500);
            }
        }

        $message = Message::create($messageData);

        $filess = null;
        if ($fileUrl) {
            $filess = File::create([
                'file_path' => $fileUrl,
                'message_id' => $message->id,
            ]);
        }

        $response = [
            'id' => $message->id,
            'conversation_id' => $message->conversation_id,
            'sender_id' => $message->sender_id,
            'content' => $message->content,
            'is_read' => $message->is_read,
            'is_received' => $message->is_received,
            'created_at' => $message->created_at,
            'updated_at' => $message->updated_at,
            'file' => $filess
        ];

        // **6. دفع الرسالة عبر Pusher**
            // $resp=null;
        try {
            $resp=  $this->pushMessage($response);
            $resp2= $this->sendNotification($response, $user, $receiver);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }

        

       

        // **7. إرجاع الاستجابة النهائية**
        return response()->json($response, 201);

    } catch (\Exception $e) {
        return response()->json(['message' => 'An error occurred', 'error' => $e->getMessage()], 500);
    }
}



    private function getConversation($user, $receiver)
{
    $conversation = Conversation::where(function ($query) use ($user, $receiver) {
        $query->where('user1_id', $user->id)
              ->where('user2_id', $receiver->id);
    })->orWhere(function ($query) use ($user, $receiver) {
        $query->where('user1_id', $receiver->id)
              ->where('user2_id', $user->id);
    })->first();

 

    return $conversation;
}




    /**
     * Display the specified resource.
     */
    public function show($id)
    {

        try{
            $user = JWTAuth::parseToken()->authenticate();

        
            $message = Message::find($id);
        
            if (!$message) {
                return response()->json(['message' => 'messege not found'], 404);
            }

         $conversation  = Conversation::find($message->conversation_id);

         if ($conversation->user1_id != $user->id && $conversation->user2_id != $user->id  ){

            return response()->json(['message' => 'No acsess to this messege'], 404);
         }


            $filePath = null;
            $file1 = File::where(function ($query)  use ($message){
                $query->where('message_id', $message->id);
            })->first();

            if($file1){
                $filePath = $file1->file_path;

            }

            return response()->json([
                // 'message' => 'Message found successfully',
                // 'data' => [
                  
                // ]
                'id' => $message->id,
                'conversation_id' => $message->conversation_id,
                'sender_id' => $message->sender_id,
                'content' => $message->content,
                'is_read' => $message->is_read,
                'is_received' => $message->is_received,
                'created_at' => $message->created_at,
                'updated_at' => $message->updated_at,
                'file' =>  $file1 ?? null // إرجاع الرابط أو null إذا لم يكن هناك ملف
            ], 201);
        }
        catch (\Exception $e) {
            return response()->json(['message' => 'Could not find messeges'], 401);
        }
        // return response()->json(['message' => $message]);
       
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Message $message)
    {
        //
    }

    public function pushMessage($message)
    {
        $pusher = new Pusher(
            env('PUSHER_APP_KEY'),
            env('PUSHER_APP_SECRET'),
            env('PUSHER_APP_ID'),
            [
                'cluster' => env('PUSHER_APP_CLUSTER'),
                'useTLS' => true,
            ]
        );
        $batch[] = array(
            'channel' => 'presence-conversation-'.$message['conversation_id'] ,
            'name' => 'new-message',
            'data' => $message,
            'info' => 'user_count'
          );
        // $data = ['message' => 'Hello World'];
    //   $resp=  $pusher->trigger('presence-conversation-'.$message['conversation_id'], 'new-message', $message,array('info' => 'subscription_count'));
    $resp = $pusher->triggerBatch($batch);
        return $resp;
    }


    // pusher_client.trigger(f'conversation-{conversation.id}', 'new-message', {
    //     'message': MessageSerializer(message).data
    // })

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Message $message)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Message $message)
    {
        //
    }

    public function sendNotification($message , $sender , $receiver)
{

        $contetn_ar = null;
       

        if($message['file']!=null){
            $contetn_ar = 'ارسل اليك ملف';
          
        }
        else{
            $contetn_ar = $message['content'];
            
        }
   
    $data = [
        "app_id" => "a3fbc9cd-0357-4aae-b2c4-b7747af2e011",
        "headings" => [
            "en" =>"Messege from : ".$sender->name,
            "ar" =>  "رسالة من :" .$sender->name
        ],
        "contents" => [
            
            "ar" => $contetn_ar
        ],
        "data" => [
            "type" => "messege",
            "chatId" => $message['conversation_id']
        ],
        "include_external_user_ids" => [
            (string)$receiver->id
        ],
        "target_channel" => "push",
       
        "android_sound" => "welcome_sound",
        "ios_sound" => "welcome_sound",
        "small_icon" => "ic_welcome",
    
    ];

    $response = Http::withHeaders([
        'Content-Type' => 'application/json',
        'Authorization' => 'Basic NWVmOGE0ZjMtNzc2Mi00OWNjLWI4NTktOGE2ZDZmYzM3ZmI4'
    ])->post('https://api.onesignal.com/notifications', $data);

    // التحقق من استجابة API
    if ($response->successful()) {
            return $response->json();
   
    } else {
        
        throw new \Exception("Failed to send notification. Status: " . $response->status() . " - " . $response->body());
   
    }
}

}
