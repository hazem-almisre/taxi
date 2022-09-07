<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ban extends Model
{
    use HasFactory;

    protected $table = 'bans';

    protected $fillable = ['id', 'counter',    'request_id', 'reason'];

    public $timestampe = true;

    /**
     * Get the user that owns the Ban
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function request()
    {
        return $this->belongsTo(Request::class, 'request_id', 'id');
    }
}
