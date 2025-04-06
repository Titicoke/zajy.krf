<?php
/**
 *Created by 孔瑞锋
 * at:2025/2/13 16:38
 * BaiduSms.php
 */

namespace app\common\lib\sms;

class BaiduSms implements SmsBase
{
    public static function sendCode(string $phone, int $code):bool{
        return true;
    }
}