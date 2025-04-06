<?php
/**
 *Created by 孔瑞锋
 * at:2025/2/13 14:41
 * Num.php
 */

namespace app\common\lib;

class Num
{
    public static function getCode (int $len=4): int
    {
        $code = rand(1000, 9999);
        if ($len == 6) {
            $code = rand(100000, 999999);
        }
        return $code;
    }
}