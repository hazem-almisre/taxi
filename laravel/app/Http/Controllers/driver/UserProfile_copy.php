<?php

namespace App\Http\Controllers\driver;

use App\Models\Driver;
use App\Models\Suggestions;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;


class UserProfile_copy extends Controller
{
    
    public function addSuggestion(Request $request,$id)
    {
        $validator = Validator::make($request->all(), [
            'title' =>['required','string'],
            'suggest_for_developer' => ['required', 'string'],
            'user' => ['required', 'string'],
        ], [
            'your do not add suggestion'
        ]);
        if ($validator->fails()) {
            return response()->json(['massge'=>$validator->errors()
            ]);
        }

        $user='driver';
        if($id && Auth::id() &&  $id!=Auth::id())
        {
            return response()->json(["massge"=>'you are not auth']);
        }
        if(!Auth::id())
        {
            return response()->json(["massge"=>'you are not auth']);
        }

        Suggestions::query()->create([
            'suggest_for_developer' => $request->suggest_for_developer,
            'title' => $request->title,
            'user' => $user,
            'user_id' => Auth::id(),
        ]);

        return response()->json(['massge'=>'think you for give us your suggest']);
    }

}
