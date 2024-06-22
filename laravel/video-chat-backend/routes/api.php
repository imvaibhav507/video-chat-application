<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route:: group(['namespace'=>'Api'], function() {
    Route:: any('/login', 'LoginController@login');
    Route:: any('/get_profile', 'LoginController@get_profile');
    Route:: any('/contacts', 'LoginController@getContacts')->middleware('checkUser');
    Route:: any('/get_rtc_token', 'AccessTokenController@get_rtc_token')->middleware('checkUser');
    Route:: any('/send_notice', 'LoginController@sendNotification')->middleware('checkUser');
    Route:: any('/bind_fcmtoken', 'LoginController@bindFcmtoken')->middleware('checkUser');
});
