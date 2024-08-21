<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class delbert extends Model
{
    use HasFactory;
    protected $fillable =['age', 'nickname', 'preferred_activity', 'class'];
}
