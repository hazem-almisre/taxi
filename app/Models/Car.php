<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Car extends Model
{
    use HasFactory;

    protected $table = 'cars';

    protected $fillable = ['id', 'type', 'color', 'description', 'engine_capacity', 'manufacturing_year', 'car_number'];

    public $timestamp = false;

    /**
     * Get all of the comments for the Car
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function images()
    {
        return $this->hasMany(Image::class, 'car_id', 'id');
    }
}
