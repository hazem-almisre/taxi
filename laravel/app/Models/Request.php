<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Request extends Model
{
    use HasFactory;

    protected $table = 'requests';

    protected $fillable = ['id', 'from', 'to', 'price', 'user_id', 'driver_id'];

    public $timestamp = true;

    /**
     * Get the user associated with the Request
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function Feedback()
    {
        return $this->hasOne(Feedback::class, 'req_id', 'id');
    }
}
