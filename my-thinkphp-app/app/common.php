<?php
// 应用公共文件
/**
 * 通用化API 数据格式输出
 * @param $status
 * @param $message
 * @param $data
 * @param $http_status
 * @return \think\response\Json
 */
function show($code,$message="error",$data=[],$http_status=200)
{
    $result=[
        'code'=>$code,
        'msg'=>$message,
        'data'=>$data,
    ];
    return json($result,$http_status);
}