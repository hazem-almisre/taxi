<?php

namespace App\Http\Controllers;

use App\Models\Driver;
use App\Models\Suggestions;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class UserProfile extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index($id)
    {
        if(Auth::id() && Auth::id()==$id)
        {
        $user = User::query()->find($id);
        // $user->makeHidden(['email']);
        if($user)
        return response()->json(["data"=>$user,  'massage' => 'successful']);
        else
        return response()->json(["errore"=>'we have fault plase try agine',  'massage' => 'fault']);
        }
        else{
            return response()->json(["errore"=>'we have fault plase try agine',  'massage' => 'fault']);
        }
    }

    // public function update(Request $request, $id)
    // {
    //     $validator = Validator::make(
    //         $request->all(),
    //         [
    //             'name' => 'string',
    //             'email' => 'email|string|unique:users,email',
    //             //'photo' => ['image', 'nullable']
    //         ]
    //     );
    //     if ($validator->fails()) {
    //         return response()->json([
    //             $validator->errors()
    //         ]);
    //     }

    //     $user = User::query()->find($id);

    //     if (!$user || $id != Auth::id()) {
    //         return response()->json(['you are not authorization']);
    //     }

    //     if (!is_null($request->photo)) {
    //         if (!is_null($user->photo)) {
    //             unlink($user->photo);
    //         }
    //         $newphoto = time() . $request->photo->getClientOriginalName();
    //         $newphoto = $request->photo->move('image', $newphoto);
    //         $user->photo = $newphoto;
    //     }
    //     $user->name = (isset($request->name)) ? $request->name : $user->name;
    //     $user->email = (isset($request->email)) ? $request->email : $user->email;
    //     $user->save();
    // }

    // public function destroy($id)
    // {
    //     $t = User::query()->find($id);

    //     if (!$t || $id != Auth::id()) {
    //         return response()->json(['you are not authorization']);
    //     }
    //     if (!is_null($t->photo))
    //         unlink($t->photo);
    //     $t->delete();
    //     return response()->json(['your profile deleted']);
    // }

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

        $user='';
        if($request->user=='client')
        {
            $user='client';
        }
        else
        {
        $user='driver';
        }
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

    // public function updateSuggestion(Request $request, int $id)
    // {
    //     $suggestions = Suggestions::query()->find($id);
    //     if (!$suggestions || Auth::id() != $suggestions->user_id) {
    //         return response()->json(['you do not have suggestions']);
    //     }
    //     $suggestions->suggest_for_developer = ($request->suggest_for_developer) ? $request->suggest_for_developer : $suggestions->suggest_for_developer;
    //     $suggestions->save();

    //     return response()->json(['completed'], 200);
    // }

    // public function deleteSuggestion(int $id)
    // {
    //     $suggestions = Suggestions::query()->find($id);
    //     if (!$suggestions || Auth::id() != $suggestions->user_id) {
    //         return response()->json(['you do not have suggestions']);
    //     }
    //     $suggestions->delete();

    //     return response()->json(['suggestions deleted from DB'], 200);
    // }
}
