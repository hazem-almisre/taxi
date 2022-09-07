<?php

use GuzzleHttp\Middleware;
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

Route::prefix('user')->group(function () {
    Route::post('signup', 'AuthUser@register');
    Route::post('login', 'AuthUser@log_in');
});



Route::group(['middleware' => 'auth:users'], function () {
    //for profile
    Route::get('index/{id}', 'UserProfile@index');
    // Route::delete('destroy/{id}', 'UserProfile@destroy');
    //suggestion
    Route::post('addSuggestion/{id}', 'UserProfile@addSuggestion');
    // Route::post('updateSuggestion/{id}', 'UserProfile@updateSuggestion');
    // Route::delete('deleteSuggestion/{id}', 'UserProfile@deleteSuggestion');
    //feedback
    // Route::post('addFeedback', 'FeedbackController@addFeedback');
    // Route::post('updateFeedback/{id}', 'FeedbackController@updateFeedback');
    // Route::delete('deleteFeedback/{id}', 'deleteFeedback@addFeedback');

    //send notfi
    Route::get('sendnotifiction/{id}', 'SendNotifiction@choseDriver');

    //show request
    Route::get('index/request/{id}', 'RequestControllerUser@index');

    //create request
    Route::post('store', 'RequestControllerUser@store');
    //delete request
    Route::post('destroy/{id}', 'RequestControllerUser@destroy');

});

// Route::get('test_for_me', function (Request $request) {

//     return $request['haeem']['ahmad'];
// });
