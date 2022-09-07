<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Feedback extends Model
{
    use HasFactory;

    protected $table  = 'feedback';

    protected $fillable = ['id', 'req_id', 'message', 'rate'];

    public $timestamp  = true;

    /**
     * Get the user associated with the Feedback
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function request()
    {
        return $this->belongsTo(Request::class, 'req_id', 'id');
    }
}
