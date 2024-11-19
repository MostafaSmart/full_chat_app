<?php

namespace App\Http\Controllers;
use App\Mail\SendMail;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class MailController extends Controller
{
//     public function index()
//     {
//         $mailData = [
//             'title' => 'مرحبا '$user->name,
//             'body' => 'اليك رمز التحقق من البريد الالكتروني '
//         ];
    
//         Mail::to($user->email)->send(new SendMail($mailData));
             
//         dd("Email is sent successfully.");
//     }
}
