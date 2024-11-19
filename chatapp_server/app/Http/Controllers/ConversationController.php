<?php

namespace App\Http\Controllers;

use App\Models\Conversation;
use Illuminate\Http\Request;
use Tymon\JWTAuth\Facades\JWTAuth;

class ConversationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $user = JWTAuth::parseToken()->authenticate();
        $conversations = Conversation::where(function ($query) use ($user) {
            $query->where('user1_id', $user->id)
                  ->orWhere('user2_id', $user->id);
        })
        ->with(['messages' => function ($query) {
            $query->with(['file' => function ($query) {
                $query->select('message_id', 'file_path'); // اختر فقط file_path من الملف
            }])->latest()->take(1);
        }])
        ->get()
        ->map(function ($conversation) use ($user) {
            // إرجاع بيانات الطرف الآخر فقط
            $otherUser = $conversation->user1_id == $user->id ? $conversation->user2 : $conversation->user1;
    
            // إضافة بيانات الطرف الآخر إلى المحادثة
            $conversation->other_user = $otherUser;
    
            // حذف بيانات المستخدم الحالي (user1 أو user2)
            unset($conversation->user1);
            unset($conversation->user2);
            $response = [
                'id' => $conversation->id,
                'user1'=>$conversation->user1_id,
                'user2'=>$conversation->user2_id,
                'created_at'=>$conversation->created_at,
                'other_user' =>$otherUser,
                'last_message' => $conversation->messages[0],
            ];

            return $response;
        });


        
    
        return response()->json($conversations);
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
    public function store(Request $request)
    {
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $user = JWTAuth::parseToken()->authenticate();
    
        // جلب المحادثة بناءً على الـ id
        $conversation = Conversation::where(function ($query) use ($user) {
            $query->where('user1_id', $user->id)
                ->orWhere('user2_id', $user->id);
        })->where('id', $id)
            ->with([

                'messages' => function ($query) {
                    $query->with([
                        'file' => function ($query) {
                            $query->select('message_id', 'file_path'); // اختر فقط file_path من الملف
                        }
                    ]);
              }
          ])
          ->first();
    
        // إذا لم يتم العثور على المحادثة أو المستخدم ليس جزءًا منها
        if (!$conversation) {
            return response()->json(['message' => 'Unauthorized or conversation not found'], 403);
        }
    
        // تجهيز بيانات المستخدم الآخر
        $otherUser = $conversation->user1_id == $user->id ? $conversation->user2 : $conversation->user1;
    
        // تجهيز قائمة الرسائل مع تضمين `file_path` أو `null` لكل رسالة
        $messages = $conversation->messages->map(function ($message) {
            return [
                'id' => $message->id,
                'conversation_id' => $message->conversation_id,
                'sender_id' => $message->sender_id,
                'content' => $message->content,
                'is_read' => $message->is_read,
                'is_received' => $message->is_received,
                'created_at' => $message->created_at,
                'updated_at' => $message->updated_at,
                'file' => $message->file ? $message->file->file_path : null, // تضمين `file_path` أو `null`
            ];
        });
    

        $conversation->other_user = $otherUser;
        // بناء الاستجابة النهائية
        $response = [
            'conversation_id' => $conversation->id,
            'other_user' => [
                'id' => $otherUser->id,
                'name' => $otherUser->name,
            ],
            'messages' => $conversation->messages,
        ];
    
        return response()->json($conversation->messages);
    }
    

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Conversation $conversation)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Conversation $conversation)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Conversation $conversation)
    {
        //
    }
}
