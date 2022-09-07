<?php

namespace App\Http\Controllers;

use App\Models\Driver;
use Illuminate\Http\Request;

class SendNotifiction extends Controller
{
    public function choseDriver($id) {

        $driver = Driver::query()->find($id);

        $token_1=$driver['token_message'];

        $SERVER_API_KEY = 'AAAAz1g2slo:APA91bH-q83yxjatjodvCXVAOX_9lkl79WRn7d5Fwkq9M7d9QFvom2bhRrXfYHRfBL2XIUBkekCeZANUnMvW7Wvgbr5BnyY89O4qNt_F-cXpViIjMfD19X9giMQI1UrLBHNneIc0wZX4';

        //$token_1 = 'Test Token';

        $data = [

            "registration_ids" => [
                $token_1
            ],

            "notification" => [

                "title" => 'Welcome',

                "body" => 'Description',

                "sound"=> "default" // required for sound on ios

            ],

        ];

        $dataString = json_encode($data);

        $headers = [

            'Authorization: key=' . $SERVER_API_KEY,

            'Content-Type: application/json',

        ];

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send');

        curl_setopt($ch, CURLOPT_POST, true);

        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        curl_setopt($ch, CURLOPT_POSTFIELDS, $dataString);

        $response = curl_exec($ch);

        return response()->json(['massge'=>'plase wit driver']);

    }
}
