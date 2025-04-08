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
            return show(config('code.error'),$e->getError().$phoneNumber);
        }
        //调用business
        if(SmsBus::sendCode($phoneNumber,6,"ali")){
            return show(config("code.success"),"发送验证码成功".$phoneNumber."-".(cache(config("redis.code_pre").$phoneNumber)));
        }else{
            return show(config("code.error"),"发送验证码失败".$phoneNumber);
        }
    }
    public function checkSmscode()
    {
        // 获取用户输入的手机号码和验证码
        $phoneNumber = input('param.phone_number', '', 'trim');
        $code = input('param.code', '', 'trim');

        // 验证输入参数
        $data = [
            'phone_number' => $phoneNumber,
            'code' => $code
        ];
        try {
            validate(\app\service\validate\User::class)->scene('checkCode')->check($data);
        } catch (\think\exception\ValidateException $e) {
            return show(config('code.error'), $e->getError());
        }

        // 从缓存中获取之前存储的验证码
        $cachedCode = cache(config("redis.code_pre") . $phoneNumber);

        // 检查验证码是否匹配
        if ($cachedCode && $cachedCode === $code) {
            // 验证码匹配，删除缓存中的验证码
            cache(config("redis.code_pre") . $phoneNumber, null);
            return show(config("code.success"), '验证码验证成功',[]);
        } else {
            return show(config("code.error"), '验证码错误或已过期',0);
        }
    }

}