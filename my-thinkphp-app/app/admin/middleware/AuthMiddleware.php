<?php

namespace app\admin\middleware;
use app\service\TokenService;
class AuthMiddleware
{
    public function handle($request, \Closure $next)
    {
        //login控制器中的方法向外暴露
        if(!preg_match("/login/",$request->pathinfo())){
            $token = $request->header('Authorization');
            if (!$token) {
                return json(['code' => 401, 'msg' => '用户未登录']);
            }

            $info = TokenService::verifyToken(str_replace('Bearer ', '', $token));
            if (!$info) {
                return json(['code' => 401, 'msg' => 'Token无效或已过期1']);
            }

            // 将用户信息存入请求
            $request->userId = $info['userId'];
            $request->userRoleId = $info['userRoleId'];
        }
        return $next($request);
    }
}