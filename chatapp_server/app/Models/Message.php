<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Message extends Model
{
    use HasFactory;

    protected $fillable = ['conversation_id', 'sender_id', 'content', 'is_read', 'is_received'];

    // علاقة مع جدول المحادثات
    public function conversation()
    {
        return $this->belongsTo(Conversation::class);
    }

    // علاقة مع جدول المستخدمين
    public function sender()
    {
        return $this->belongsTo(User::class, 'sender_id');
    }

    public function file()
{
    return $this->hasOne(File::class);
}
}
