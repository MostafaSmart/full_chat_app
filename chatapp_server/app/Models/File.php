<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class File extends Model
{
    use HasFactory;

    protected $fillable = ['file_path', 'message_id'];

    // علاقة مع جدول الرسائل
    public function message()
    {
        return $this->belongsTo(Message::class);
    }
}
