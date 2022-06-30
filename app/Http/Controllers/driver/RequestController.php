<?php

namespace App\Http\Controllers\driver;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use App\Models\Request as ModelsRequest;
use Illuminate\Support\Facades\Validator;

class RequestController extends Controller
{

    public function index()
    {
        $request = ModelsRequest::all();
        return response()->json($request);
    }


    public function store(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'from' => ['required', 'string'],
            'to' => ['required', 'string'],
            'price' => ['required', 'integer'],
            //'status' => ['required', ''],
            'car_rating' => ['required', ''],
            //'time_waiting' => ['required', '']
        ]);
        if ($validator->fails()) {
            return response()->json([
                $validator->errors()
            ]);
        }
        ModelsRequest::query()->create([
            'from' => $request->from,
            'to' => $request->to,
            'price' => $request->price,
            //'status' => $request->status,
            'car_rating' => $request->car_rating,
            //'time_waiting' => $request->time_waiting,
            'user_id' => Auth::id(),
            'from' => $id,
        ]);
    }

    public function showUser()
    {
        $requestUser = ModelsRequest::query()->where('user_id', Auth::id())->get();
        return response()->json($requestUser);
    }

    public function showDriver()
    {
        $requestDriver = ModelsRequest::query()->where('driver_id', Auth::id())->get();
        return response()->json($requestDriver);
    }


    public function update(Request $request, $id)
    {
        //
    }


    public function destroy($id)
    {
        //
    }
}
