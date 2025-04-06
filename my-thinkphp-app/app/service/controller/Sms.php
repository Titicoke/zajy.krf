<?php
declare(strict_types=1);
namespace app\service\controller;

use app\BaseController;
use app\common\business\sms as SmsBus;

class Sms extends BaseController
{
    public function code():object{
        $phoneNumber = input('param.phone_number','','trim');

        $date = [
            'phone_number' => "$phoneNumber",
        ];
        try {
            validate(\app\service\validate\User::class)->scene('send_code')->check($date);

        }catch (\think\exception\ValidateException $e){
            return show(config('status.error'),$e->getError().$phoneNumber);
        }
        //调用business
        if(SmsBus::sendCode($phoneNumber,6,"ali")){
            return show(config("status.success"),"发送验证码成功".$phoneNumber."-".(cache(config("redis.code_pre").$phoneNumber)));
        }else{
            return show(config("status.error"),"发送验证码失败".$phoneNumber);
        }
    }

}