<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Suggestions extends Model
{
    use HasFactory;

    protected $table = 'suggestions';

    protected $fillable = ['id','title','user', 'suggest_for_developer', 'user_id'];

    public $timestamp = true;

    /**
     * Get the user that owns the Suggestions
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
