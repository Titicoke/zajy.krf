<?php
// 应用公共文件
/**
 * 通用化API 数据格式输出
 * @param $status
 * @param $message
 * @param $data
 * @param $http_status
 * @return int|\think\response\Json
 */
function show($status,$message="error",$data=[])
{
    $result=[
        'code'=>$status,
        'msg'=>$message,
        'data'=>$data,
    ];
    return json($result);

}