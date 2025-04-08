<?php
namespace app\exception;
use think\exception\Handle;
use think\facade\Log;
use think\Response;
use Throwable;

class Http extends Handle
{    public $httpStatus = 502;
    public function render($request, Throwable $e): Response
    {
        /**
         * Render an exception into an HTTP response.
         *
         * @access public
         * @param \think\Request   $request
         * @param Throwable $e
         * @return Response
         */
        // 添加自定义异常处理机制
        if(method_exists($e, 'getStatusCode')){
            $statusCode = $e->getStatusCode();
        }else{
            $statusCode = $this->httpStatus;
        }
        Log::error('错误信息：' . $e->getMessage() . '，错误文件：' . $e->getFile() . '，错误行号：' . $e->getLine());
        return show(config('code.error'), $e->getMessage(),[],$statusCode);
        //return parent::render($request, $e);
    }
}