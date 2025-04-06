<?php
/**
 *Created by 孔瑞锋
 * at:2025/2/13 16:40
 * JdSms.php
 */

namespace app\common\lib\sms;

class JdSms implements SmsBase
{
    public static function sendCode($phone, $code):bool{
        return true;
    }
}