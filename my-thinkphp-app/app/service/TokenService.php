<?php
namespace app\service;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class TokenService
{
    private static $key = 'sxaukrf'; // 加密密钥
    private static $alg = 'HS256';          // 加密算法

    // 生成Token
    public static function createToken($uid,$role_id)
    {
        $payload = [
            'iss' => 'your-issuer',     // 签发者
            'aud' => 'your-audience',   // 接收方
            'iat' => time(),            // 签发时间
            'exp' => time() + 15,     // 过期时间(2小时)
            'userId' => $uid,               // 用户ID
            'userRoleId' => $role_id        //角色ID
        ];
        return JWT::encode($payload, self::$key, self::$alg);
    }

    // 验证Token
    public static function verifyToken($token)
    {
        try {
            $decoded = JWT::decode($token, new Key(self::$key, self::$alg));
            return (array)$decoded;
        } catch (\Exception $e) {
            return false;
        }
    }
}
