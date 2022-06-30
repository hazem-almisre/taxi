<?php

namespace App\Http\Controllers\driver;

use App\Http\Controllers\Controller;
use App\Models\Car;
use App\Models\Driver;
use App\Models\Image;
use Illuminate\Http\Request;
use Laravel\Passport\HasApiTokens;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthDriver extends Controller
{
    use HasApiTokens;

    function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string'],
            'email' => ['required', 'email', 'string', 'unique:drivers,email'],
            'password' => ['required', 'string'],
            'confirm_password' => ['required', 'same:password'],
            'number' => ['required', 'string'],
            'gender' => ['required', 'string'],
            'birthday' => ['required', 'date'],
            'nutation_number' => ['required', 'string'],
            'type'    => ['required', 'string'],
            'color'    => ['required', 'string'],
            'description' => ['required', 'string'],
            'engine_capacity'    => ['required', 'between:2,15', 'integer'],
            'manufacturing_year' => ['required', 'date'],
            'car_number' => ['required', 'string']
            //'photo_driver =>  ['image','nullable'],
            //'photos_car' =>[]
        ]);
        if ($validator->fails()) {
            return response()->json([
                $validator->errors()
            ]);
        }
        $input = $request->all();
        $car = Car::query()->create(
            [
                'type'  => $input['type'],
                'color' => $input['color'],
                'description' => $input['description'],
                'engine_capacity'  => $input['engine_capacity'],
                'manufacturing_year' => $input['manufacturing_year'],
                'car_number' => $input['car_number'],
            ]
        );

        // if ($request->photos_car) {
        //     $image = Image::query();
        //     foreach ($request->photos_car as $photo) {
        //         $newphoto =  time(). $photo->getClientOriginalName();
        //         $newphoto = $photo->move('images', $newphoto);
        //         $image->create([
        //             'photos_car' => $newphoto,
        //             'car_id' =>$car->id
        //         ]);
        //     }
        // }

        $input['password'] = Hash::make($input['password']);

        //if($input['photo_driver']){
        // $newphoto =  time().$request->photo->getClientOriginalName();
        // $newphoto = $request->photo->move('images', $newphoto);
        //$input['photo_driver'] = $newphoto;}

        $user = Driver::create([
            'name' => $input['name'],
            'email' => $input['email'],
            'password' => $input['password'],
            'confirm_password' => $input['confirm_password'],
            'number' => $input['number'],
            'gender' => $input['gender'],
            'birthday' => $input['birthday'],
            'nutation_number' => $input['nutation_number'],
            'car_id' => $car->id
            //'photo_driver' => $input['photo_driver']
        ]);

        $success['token'] = $user->createToken($request->password . $request->email)->accessToken;
        $success['name'] = $user->name;
        return response()->json([$success,  'massage' => 'successful'], 200);
    }

    function log_in(Request $request)
    {
        $driver = Driver::query()->where('email', $request->email)->first();

        if ($driver && Hash::check($request->password, $driver->password)) {
            $input = $request->all();
            $input['password'] = Hash::make($input['password']);
            $success['token'] = $driver->createToken($request->password . $request->email)->accessToken;
            $success['name'] = $driver->name;
            return response()->json([$success,  'massage' => 'successful'], 200);
        }

        return response()->json(['massage' => 'the password or email are not true']);
    }
}
