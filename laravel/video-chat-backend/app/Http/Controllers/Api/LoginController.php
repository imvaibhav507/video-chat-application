<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Carbon\Carbon;
use Error;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Kreait\Firebase\Messaging\CloudMessage;

class LoginController extends Controller {

    public function login(Request $request) {
        $validator = Validator::make($request->all(), [
            'avatar'=>'required',
            'name'=>'required',
            'type'=>'required',
            'open_id'=>'required',
            'email'=>'max:50',
            'phone'=>'max:20',
        ]);

        if($validator->fails()) {
            return ['code'=>-1, "data"=> "no valid data", "msg"=>$validator->errors()->first()];
        }

        try {
            $validated = $validator->validated();

        $map = [];
        $map['type'] = $validated['type'];
        $map['open_id'] = $validated['open_id'];

        $result = DB::table('users')->select('avatar', 'name', 'description', 'type', 'token', 'access_token', 'online')
        ->where($map)->first();

        if(empty($result)) {

            $validated['token'] = md5(uniqid().rand(10000, 99999));
            $validated['created_at'] = Carbon::now();
            $validated['access_token'] = md5(uniqid().rand(1000000, 9999999));
            $validated['expire_date'] = Carbon::now()->addDays(30);

            $user_id = DB::table('users')->insertGetId($validated);
            $user_result = DB::table('users')->select('avatar', 'name', 'description', 'type', 'token', 'access_token', 'online')
            ->where('id', '=', $user_id)->first();

            return ['code'=>0, "data"=> $user_result, "msg"=>"user has been created"];
        }

        $new_access_token = md5(uniqid().rand(1000000, 9999999));
        $new_expire_date = Carbon::now()->addDays(30);

        DB::table('users')->where($map)->update([
            'access_token'=>$new_access_token,
            'expire_date'=>$new_expire_date
        ]);

        $result->access_token = $new_access_token;
        $result->expire_date = $new_expire_date;

        return ['code'=>0, "data"=> $result, "msg"=>"user fetched"];
        } catch (Exception $e) {

            return ['code'=>-1, "data"=> "no data availabe", "msg"=>(string)$e];
        }
    }

    public function getContacts(Request $request) {

        try {

            $user_id = $request->user_id;

            $result = DB::table('users')->select('id', 'avatar', 'name', 'type', 'token', 'online')
            ->where('id', '!=', $user_id)->get();

            return ['code'=>0, "data"=> $result, "msg"=>"contacts fetched"];
        } catch (Exception $e) {
            return ['code'=>-1, "data"=> "no data availabe", "msg"=>(string)$e];
        }
    }

    public function sendNotification(Request $request) {

        // caller info
        $user_token = $request->user_token;
        $user_avatar = $request->user_avatar;
        $user_name = $request->user_name;

        // callee info
        $call_type = $request->input("call_type");
        $to_token =$request->input("to_token");
        // $to_avatar = $request->input("to_avatar");
        // $to_name = $request->input("to_name");
        // $doc_id = $request->input("doc_id");

        // if(empty($doc_id)) {
        //     $doc_id = '';
        // }

        // get the user
        $res = DB::table("users")->select("avatar", "name", "token", "fcmtoken")->where("token", "=", $to_token)->first();

        if(empty($res)) {
            return ['code'=>-1, 'data'=>"", 'msg'=>'user does not exist'];
        }

        $device_token = $res->fcmtoken;
        try {

            if(empty($device_token)) {
                return ['code'=>-1, 'data'=>"", 'msg'=>'device token is empty'];
            }

            $messaging = app("firebase.messaging");
            if($call_type == "voice") {
                $message = CloudMessage::fromArray([
                    'token'=>$device_token,
                    'data'=> [
                        'token'=>$user_token,
                        'avatar'=>$user_avatar,
                        'name'=>$user_name,
                        // 'doc_id'=>$doc_id,
                        'call_type'=>$call_type
                    ],
                    'android'=>[
                        'priority'=>'high',
                        'notification'=> [
                            'channel_id'=>'XXXX',
                            'title'=> 'Incoming call'.$user_name
                        ]
                    ]
                    ]);
                    $messaging->send($message);
            }

        } catch (Exception $e) {
            return ['code'=>-1, 'data'=>'', 'msg'=>(string)$e];
        }
        return ['code'=>0, 'data'=>$to_token, 'msg'=>'success'];

    }

    public function bindFcmtoken(Request $request) {
        $token = $request->user_token;
        $fcmtoken = $request->input("fcmtoken");
        if(empty($fcmtoken)) {
            return ['code'=>-1, 'data'=>'', 'msg'=>'error getting the token'];
        }

        DB::table("users")->where('token', '=', $token)->update(['fcmtoken'=>$fcmtoken]);

        return ['code'=>0, 'data'=>'', 'msg'=>'success'];
    }
}
