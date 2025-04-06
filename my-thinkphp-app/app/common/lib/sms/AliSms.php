<?php
declare(strict_types=1);
namespace app\common\lib\sms;
use Darabonba\OpenApi\OpenApiClient;
use AlibabaCloud\OpenApiUtil\OpenApiUtilClient;
use Darabonba\OpenApi\Models\Config;
use Darabonba\OpenApi\Models\Params;
use AlibabaCloud\Tea\Utils\Utils\RuntimeOptions;
use Darabonba\OpenApi\Models\OpenApiRequest;
use think\Console;
use think\facade\Log;
class AliSms implements SmsBase
{
    /**
     * aliyun发送短信
     * @param string $phone
     * @param int $code
     * @return bool
     */
    public static function sendCode(string $phone, int $code):bool
    {



        return true; //实际应用环境下把这行代码注释掉



        $config = new \Darabonba\OpenApi\Models\Config([
            'accessKeyId' => config('aliyun.access_key_id'),
            'accessKeySecret' => config('aliyun.access_key_secret'),
        ]);
        $config->endpoint = config('aliyun.host');
        $client = new \AlibabaCloud\SDK\Dysmsapi\V20170525\Dysmsapi($config);
        $templateParams = [
            'code' => $code,
        ];
        $res = new \AlibabaCloud\SDK\Dysmsapi\V20170525\Models\SendSmsRequest([
            'phoneNumbers' => $phone,
            'signName' => config("aliyun.sign_name"),
            'templateCode' => config("aliyun.template_code"),
            'templateParam' => json_encode($templateParams),
        ]);
        try {
            $result = $client->sendSmsWithOptions($res, new \AlibabaCloud\Tea\Utils\Utils\RuntimeOptions(['ignoreSSL' => true]));

        } catch (Exception $error) {
            if (!($error instanceof \AlibabaCloud\Tea\Exception\TeaError)) {
                $error = new \AlibabaCloud\Tea\Exception\TeaError([], $error->getMessage(), $error->getCode(), $error);
            }
            \AlibabaCloud\Tea\Utils\Utils::assertAsString($error->message);
            Log::error("aliyun sendCode exception{$phone}".$error->message);
            return false;
        }

        $responseArray = $result->toMap();
        $codeValue = $responseArray['body']['Code'];
        if($codeValue == 'OK') {
            Log::info("aliyun sendCode success {$phone}".json_encode($result->toMap()));
            return true;
        }
        return false;

    }

}