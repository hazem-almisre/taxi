<?php

namespace App\Http\Controllers;

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
    public function index()
    {
        $user = Auth::user();
        // $user->makeHidden(['email']);
        return $user;
    }



    public function update(Request $request, $id)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'name' => 'string',
                'email' => 'email|string|unique:users,email',
                //'photo' => ['image', 'nullable']
            ]
        );
        if ($validator->fails()) {
            return response()->json([
                $validator->errors()
            ]);
        }

        $user = User::query()->find($id);

        if (!$user || $id != Auth::id()) {
            return response()->json(['you are not authorization']);
        }

        if (!is_null($request->photo)) {
            if (!is_null($user->photo)) {
                unlink($user->photo);
            }
            $newphoto = time() . $request->photo->getClientOriginalName();
            $newphoto = $request->photo->move('image', $newphoto);
            $user->photo = $newphoto;
        }
        $user->name = (isset($request->name)) ? $request->name : $user->name;
        $user->email = (isset($request->email)) ? $request->email : $user->email;
        $user->save();
    }

    public function destroy($id)
    {
        $t = User::query()->find($id);

        if (!$t || $id != Auth::id()) {
            return response()->json(['you are not authorization']);
        }
        if (!is_null($t->photo))
            unlink($t->photo);
        $t->delete();
        return response()->json(['your profile deleted']);
    }

    public function addSuggestion(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'suggest_for_developer' => ['required', 'string']
        ], [
            'your do not add suggestion'
        ]);
        if ($validator->fails()) {
            return response()->json([
                $validator->errors()
            ]);
        }

        Suggestions::query()->create([
            'suggest_for_developer' => $request->suggest_for_developer,
            'user_id' => Auth::id(),
        ]);

        return response()->json(['think you for give me your suggest']);
    }

    public function updateSuggestion(Request $request, int $id)
    {
        $suggestions = Suggestions::query()->find($id);
        if (!$suggestions || Auth::id() != $suggestions->user_id) {
            return response()->json(['you do not have suggestions']);
        }
        $suggestions->suggest_for_developer = ($request->suggest_for_developer) ? $request->suggest_for_developer : $suggestions->suggest_for_developer;
        $suggestions->save();

        return response()->json(['completed'], 200);
    }

    public function deleteSuggestion(int $id)
    {
        $suggestions = Suggestions::query()->find($id);
        if (!$suggestions || Auth::id() != $suggestions->user_id) {
            return response()->json(['you do not have suggestions']);
        }
        $suggestions->delete();

        return response()->json(['suggestions deleted from DB'], 200);
    }
}
