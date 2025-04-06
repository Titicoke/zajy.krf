<?php
/**
 *Created by 孔瑞锋
 * at:2025/2/13 16:43
 * SmsBase.php
 */
declare(strict_types=1);
namespace app\common\lib\sms;

interface SmsBase
{
    public static function sendCode (string $phone, int $code): bool;
}