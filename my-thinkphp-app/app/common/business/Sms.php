<?php
declare(strict_types=1);
namespace app\common\business;
use app\common\lib\Sms\AliSms;
use app\common\lib\Num;
use app\common\lib\ClassArr;

class Sms
{
    public static function sendCode(string $phoneNumber,int $len,$type="ali"):bool{
        //根据参数len生成指定位数的验证码
        $code = Num::getCode($len);
        $sms=AliSms::sendCode($phoneNumber, $code);



        if($sms){
            //需要把短信验证码记录到redis，并对应手机号，并且需要给出一个失效时间，比如3分钟
            //需要安装redis扩展
            cache((config("redis.code_pre").$phoneNumber),$code,config("redis.code_expire"));
            return true;
        }else{
            return false;
        }

    }
}