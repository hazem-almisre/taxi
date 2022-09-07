<?php

namespace App\Http\Controllers\driver;

use App\Models\Driver;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\Image;
use Illuminate\Support\Facades\Auth;

class DriverController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    // public function index()
    // {
    //     $user = Auth::user();
    //     // $user->makeHidden(['car_id']);
    //     return $user;
    // }


    public function show($id)
    {
        $driver = Driver::query()->find($id);
        if (!$driver) {
            return response()->json(['massge'=>'driver is not exit']);
        }

        // $driver = $driver->with(['car' => function ($car) {
        //     $car->with('images');
        // }])->get();

        //or
        // $driver =$driver->with('imageCar');

        //or
        // $driver = DB::table('drivers')->join('cars', 'cars.id', '=', 'drivers.car_id')
        //     ->join('images', 'images.car_id', '=', 'cars.id')->select('drivers.*', 'images.photos_car')->get();

        return response()->json(['data'=>$driver,'massge'=>'successful']);
    }


    // public function update(Request $request, $id)
    // {
    //     //
    // }


    // public function destroy($id)
    // {
    //     $driver = Driver::query()->find($id);
    //     if (!$driver) {
    //         return response()->json(['driver is not exit']);
    //     }

    //     Image::query()->where('car_id', $driver->car_id)->delete();
    //     $driver->delete();
    //     return response()->json(['driver`s account is deleted']);
    // }
}
