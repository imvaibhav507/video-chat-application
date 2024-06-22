<?php
namespace App\Http\Middleware;

use Carbon\Carbon;
use Closure;
use Illuminate\Support\Facades\DB;

class CheckUser {
    public function handle($request, Closure $next) {

        $Authorization = $request->header('Authorization');

        if(empty($Authorization)) {
            return response(['code'=>401, 'message'=>'Authentication failed'], 401);
        }

        $access_token = trim(ltrim($Authorization, 'Bearer'));
        $res_user = DB::table('users')->select('id', 'avatar', 'name', 'description', 'type', 'token', 'access_token', 'online', 'expire_date')
        ->where('access_token', $access_token)->first();

        if(empty($res_user)) {
            return response(['code'=>401, 'message'=>'User not found'], 401);
        }

        $expire_date = $res_user->expire_date;
        if(empty($expire_date) || $expire_date<Carbon::now()) {
            return response(['code'=>401, 'message'=>'User must log in again'], 401);
        }

        $request->user_id = $res_user->id;
        $request->user_type = $res_user->type;
        $request->user_name = $res_user->name;
        $request->user_avatar = $res_user->avatar;
        $request->user_token = $res_user->token;

        return $next($request);
    }
}
