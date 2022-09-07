<?php

namespace App\Http\Controllers;

use App\Models\Feedback;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class FeedbackController extends Controller
{
    // public function addFeedback(Request $request)
    // {
    //     $validator = Validator::make(
    //         $request->all(),
    //         [
    //             'req_id' => ['required', 'unique:feedback,req_id', 'integer'],
    //             'message' => ['required', 'string'],
    //             'rate' => ['required', 'between:0,9'],
    //         ],
    //         [
    //             'req_id.unique' => 'you can not add your feedback again'
    //         ]
    //     );
    //     if ($validator->fails()) {
    //         return response()->json([
    //             $validator->errors()
    //         ]);
    //     }

    //     Feedback::create($request->all());
    //     return response()->json(['think you for get us your feedback']);
    // }

    // public function updateFeedback(Request $request, int $id)
    // {
    //     $validator = Validator::make(
    //         $request->all(),
    //         [
    //             'req_id' => ['unique:feedback,req_id', 'integer'],
    //             'message' => ['string'],
    //             'rate' => ['between:0,9'],
    //         ],
    //         [
    //             'req_id.unique' => 'you can not add your feedback again'
    //         ]
    //     );
    //     if ($validator->fails()) {
    //         return response()->json([
    //             $validator->errors()
    //         ]);
    //     }

    //     $feedback = Feedback::query()->find($id);
    //     if (!$feedback || Auth::id() != $feedback->request->user_id) {
    //         return response()->json(['you do not have suggestions']);
    //     }
    //     $feedback->message = ($request->message) ? $request->message : $feedback->message;
    //     $feedback->rate = ($request->rate) ? $request->rate : $feedback->rate;
    //     $feedback->save();

    //     return response()->json(['updateFeedback completed'], 200);
    // }

    // public function deleteFeedback($id)
    // {
    //     $feedback = Feedback::query()->find($id);
    //     if (!$feedback || Auth::id() != $feedback->request->user_id) {
    //         return response()->json(['you do not have suggestions']);
    //     }
    //     $feedback->delete();

    //     return response()->json(['suggestions deleted from DB'], 200);
    // }
}
