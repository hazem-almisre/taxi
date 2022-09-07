<?php

namespace App\Http\Controllers\driver;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use App\Models\Request as ModelsRequest;
use Illuminate\Support\Facades\Validator;

use function PHPUnit\Framework\isEmpty;

class RequestController extends Controller
{

    public function index($id)
    {
        $request = ModelsRequest::query()->where('driver_id',$id)->get();
        if(!$request)
        {
            return response()->json(['massge'=>'you not have request']);
        }
        return response()->json(['data'=>$request,'massge'=>'succsesful']);
    }


    // public function store(Request $request, $id)
    // {
    //     $validator = Validator::make($request->all(), [
    //         'from' => ['required', 'string'],
    //         'to' => ['required', 'string'],
    //         'price' => ['required', 'integer'],
    //         //'status' => ['required', ''],
    //         'car_rating' => ['required', ''],
    //         //'time_waiting' => ['required', '']
    //     ]);
    //     if ($validator->fails()) {
    //         return response()->json([
    //             $validator->errors()
    //         ]);
    //     }
    //     ModelsRequest::query()->create([
    //         'from' => $request->from,
    //         'to' => $request->to,
    //         'price' => $request->price,
    //         //'status' => $request->status,
    //         'car_rating' => $request->car_rating,
    //         //'time_waiting' => $request->time_waiting,
    //         'user_id' => Auth::id(),
    //         'from' => $id,
    //     ]);
    // }

    // public function showUser($id)
    // {
    //     $requestUser = ModelsRequest::query()->where('user_id', $id/*Auth::id()*/)->get();
    //     if($requestUser || isEmpty($requestUser))
    //     return response()->json(['massge'=>'you are not have request']);

    //     return response()->json(['data'=>$requestUser,'massge'=>'successful']);
    // }

    // public function showDriver($id)
    // {
    //     $requestDriver = ModelsRequest::query()->where('driver_id', $id/*Auth::id()*/)->get();

    //     if($requestDriver || isEmpty($requestDriver))
    //     return response()->json(['massge'=>'you are not have request']);

    //     return response()->json(['data'=>$requestDriver,'massge'=>'successful']);
    // }


    // public function update(Request $request, $id)
    // {
    //     //
    // }


    // public function destroy($id)
    // {
    //     //
    // }
}
