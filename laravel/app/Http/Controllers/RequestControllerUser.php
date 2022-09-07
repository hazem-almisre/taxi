<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Driver;
use App\Models\Location;
use Illuminate\Support\Facades\Auth;
use App\Models\Request as ModelsRequest;
use Illuminate\Support\Facades\Validator;

use function PHPUnit\Framework\isEmpty;

class RequestControllerUser extends Controller
{

    public function index($id)
    {
        $request = ModelsRequest::query()->where('user_id',$id)->get();
        if(!$request)
        {
            return response()->json(['massge'=>'you not have request']);
        }
        // $driver=Driver::query()->find($request->driver_id);
        // $user=Auth::user();
        return response()->json(['data'=>$request,'massge'=>'succsesful'/*,'driver'=>$driver['first_name'],
    'user'=>$user['first_name']*/]);
    }


    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'from_x' => ['required'],
            'from_y' => ['required'],
            'to' => ['required', 'string'],
            // 'price' => ['required', 'integer'],
            // 'status' => ['required', ''],
            // 'car_rating' => ['required', ''],
            //'time_waiting' => ['required', '']
        ]);
        if ($validator->fails()) {
            return response()->json(['massge'=>
                $validator->errors()
            ]);
        }

        $loction=Location::query()->where('place',$request->to)->first();
        $driver=Driver::query()->where('is_active',false)->first();
        $dist=sqrt(pow(($request->from_x-$loction['x']),2)+pow(($request->from_y-$loction['y']),2));
        // $from=Location::query()->where('x',$request->from_x)->where('y',$request->from_x)->first();

        $re=ModelsRequest::query()->create([
            'from' => 'همك',
            'to' => $request->to,
            'price' => $dist*1000/2,
            //'status' => $request->status,
            'driver_id' => $driver->id,
            //'time_waiting' => $request->time_waiting,
            'user_id' => Auth::id(),
            // 'from' => $id,
        ]);

        return response()->json(['massge'=>'successful','data'=>$driver,'price'=>$dist*1000/2,'request'=>$re]);
    }

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


    public function destroy($id)
    {
        $request=ModelsRequest::query()->find($id);

        if(!$request){
            return response()->json(['massge'=>'error']);
        }
        $request->delete();
        return response()->json(['massge'=>'successful']);
    }
}
