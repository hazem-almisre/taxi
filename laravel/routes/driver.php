<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::prefix('/')->group(function () {
    Route::post('signup', 'driver\AuthDriver@register');
    Route::post('login', 'driver\AuthDriver@log_in');
});



Route::group(['namespace' => 'driver', 'middleware' => 'auth:drivers'], function () {
    // Route::get('index', 'DriverController@index');
    
    //show user prpfile
    Route::get('show/{id}', 'DriverController@show');
    //show request
    Route::get('index/request/{id}', 'RequestController@index');
    //add feedback
    Route::post('addSuggestion_UserProfile_copy/{id}', 'UserProfile_copy@addSuggestion');

});
