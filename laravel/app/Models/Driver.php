<?php

namespace App\Models;

use App\Models\Car;
//use Illuminate\Database\Eloquent\Model;
use App\Models\Image;
use Laravel\Passport\HasApiTokens;
use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Driver extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $table = 'drivers';

    protected $fillable = [
        'id', 'first_name','last_name', 'email', 'email_verified_at', 'password', 'remember_token', 'number',
        'is_available', 'is_active', 'car_id','token_message'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function car()
    {
        $this->hasOne(Car::class, 'car_id', 'id');
    }

    /**
     * The roles that belong to the User
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function user()
    {
        return $this->belongsToMany(User::class, 'requests', 'driver_id', 'user_id');
    }

    public function imageCar()
    {
        $this->hasOneThrough(Image::class, Car::class, 'car_id', 'car_id'/*driver_id*/, 'id', 'id');
    }
}
