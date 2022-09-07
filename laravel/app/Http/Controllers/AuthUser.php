<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Laravel\Passport\HasApiTokens;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthUser extends Controller
{
    use HasApiTokens;

    function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'first_name' => 'required|string',
            'last_name' => 'required|string',
            'email' => 'required|email|string|unique:users,email',
            'password' => 'required|string',
            'confirm_password' => 'required|same:password',
            "phone_number" => 'required|string|unique:users,phone_number'
            //'photo' => ['image','nullable']
        ], [
            'name.required' => 'you do not have name '
        ]);
        if ($validator->fails()) {
            return response()->json([
                'error'=>$validator->errors()
                ,"massage" => "fault"]);
        }

        $input = $request->all();
        //if($input['photo']){
        // $newphoto =  time().$request->photo->getClientOriginalName();
        // $newphoto = $request->photo->move('images', $newphoto);
        //$input['photo'] = $newphoto;}
        $input['password'] = Hash::make($input['password']);
        $user = User::create($input);
        $success['token'] = $user->createToken($request->password . $request->email)->accessToken;
        $success['id'] = $user->id;
        return response()->json(["data"=>$success,  'massage' => 'successful','client'=>'user'], 200);
    }

    function log_in(Request $request)
    {
        if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
            $input = $request->all();
            $input['password'] = Hash::make($input['password']);
            $user = auth()->user();
            $success['token'] = $user->createToken($request->password . $request->email)->accessToken;
            $success['id'] = $user->id;
            return response()->json(["data"=>$success,  'massage' => 'successful','client'=>'user'], 200);
        }
        return response()->json(['massage' => 'the password or email are not true']);

    }
}
