<?php

namespace App\Http\Controllers;

use App\Mail\SendMail;
use App\Models\User;
use App\Models\Verification;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;

class JWTAuthController extends Controller
{
    // User registration
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'user_name'=>'required|string|min:5',
            'password' => 'required|string|min:6',
        ]);

        if($validator->fails()){
            return response()->json($validator->errors()->toJson(), 400);
        }

        $user = User::create([
            'name' => $request->get('name'),
            'email' => $request->get('email'),
            'user_name' => $request->get('user_name'),
            'password' => Hash::make($request->get('password')),
        ]);

        $token = JWTAuth::fromUser($user);

    //     $verificationCode = Str::random(6); // توليد رمز تحقق عشوائي من 6 خانات
    //     $expiryTime = Carbon::now()->addMinutes(5); // تعيين وقت انتهاء الصلاحية (5 دقائق)

    //     $user->verification()->create([
    //         'verification_code' => $verificationCode,
    //         'expiry_at' => $expiryTime,
    //     ]);
    //     $mailData = [
    //         'title' => 'رمز التحقق من بريدك الالكتروني',
    //         'body' => 'اليك رمز التحقق الخاص بك:',
    //         'code' => $verificationCode
    //     ];
       
    // try {
    //     // محاولة إرسال البريد الإلكتروني
    //     Mail::to($user->email)->send(new SendMail($mailData));
        
    //     // التأكد من أنه تم إرسال البريد الإلكتروني بنجاح
    //     if (Mail::failures()) {
    //         // في حال حدوث خطأ أثناء إرسال البريد
    //         return response()->json(['message' => 'حدث خطأ أثناء إرسال البريد الإلكتروني. الرجاء المحاولة لاحقاً.'], 500);
    //     }
    // } catch (\Exception $e) {
    //     // التعامل مع الاستثناء في حال حدوث خطأ أثناء إرسال البريد
    //     return response()->json(['message' => 'حدث خطأ أثناء إرسال البريد الإلكتروني: ' . $e->getMessage()], 500);
    // }

    // إذا تم إرسال البريد بنجاح، إرجاع الاستجابة بنجاح
    return response()->json(compact('user', 'token'), 201);
    }

    public function requestVerifyEmail()
    {
        $user = JWTAuth::parseToken()->authenticate();
    
        // توليد رمز تحقق عشوائي من 6 خانات
        $verificationCode = Str::random(6);
    
        // تعيين وقت انتهاء الصلاحية (5 دقائق)
        $expiryTime = Carbon::now()->addMinutes(5);
    
        // التحقق إذا كان هناك سجل تحقق سابق للمستخدم
        $verification = Verification::where('user_id', $user->id)->first();
    
        // إذا كان يوجد سجل تحقق للمستخدم، نقوم بتحديثه
        if ($verification) {
            $verification->update([
                'verification_code' => $verificationCode,
                'expiry_at' => $expiryTime,
            ]);
        } else {
            // إذا لم يكن هناك سجل تحقق، نقوم بإنشائه
            $user->verification()->create([
                'verification_code' => $verificationCode,
                'expiry_at' => $expiryTime,
            ]);
        }
    
        // إرسال البريد الإلكتروني مع رمز التحقق الجديد
        $mailData = [
            'title' => 'رمز التحقق من بريدك الالكتروني',
            'body' => 'اليك رمز التحقق الخاص بك: ',
            'code' => $verificationCode
        ];
    
        try {
            Mail::to($user->email)->send(new SendMail($mailData));
            
            return response()->json(['message' => 'تم طلب رمز التحقق مرة أخرى وتم إرساله إلى بريدك الإلكتروني.'], 200);
        } catch (\Exception $e) {
            // في حال فشل إرسال البريد
            return response()->json(['message' => 'حدث خطأ أثناء إرسال البريد الإلكتروني.'. $e->getMessage()], 500);
        }
    }

    public function verifyEmail(Request $request)
    {
        $user = JWTAuth::parseToken()->authenticate();
        $userVerification = Verification::where('user_id', $user->id)
            ->where('verification_code', $request->input('verification_code'))
            ->first();

        if (!$userVerification || $userVerification->expiry_at < Carbon::now()) {
            return response()->json(['message' => 'رمز التحقق غير صالح أو انتهت صلاحيته.'], 400);
        }

        // تحديث حالة التحقق في جدول المستخدمين
       
        $user->email_verified_at = Carbon::now();
        $user->save();
        $token = JWTAuth::fromUser($user);


        return response()->json(compact('user', 'token'), 201);
    }

    // User login
    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        try {
            if (! $token = JWTAuth::attempt($credentials)) {
                return response()->json(['error' => 'Invalid credentials'], 401);
            }

            // Get the authenticated user.
            $user = auth()->user();

            // (optional) Attach the role to the token.
            $token = JWTAuth::claims(['role' => $user->role])->fromUser($user);

            return response()->json(compact('user','token'), 201);
        } catch (JWTException $e) {
            return response()->json(['error' => 'Could not create token'], 500);
        }
    }

    // Get authenticated user
    public function getUser()
    {
        try {
            if (! $user = JWTAuth::parseToken()->authenticate()) {
                return response()->json(['error' => 'User not found'], 404);
            }
        } catch (JWTException $e) {
            return response()->json(['error' => 'Invalid token'], 400);
        }

        return response()->json(compact('user'));
    }

    // User logout
    public function logout()
    {
        JWTAuth::invalidate(JWTAuth::getToken());

        return response()->json(['message' => 'Successfully logged out']);
    }
}