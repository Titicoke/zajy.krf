<?php
namespace app\demo\controller;
use app\BaseController;

class E extends BaseController
{
    public function index(){
        //下面这行用于测试未知错误
       //echo $ddd;
       //下面这行也用于测试
        throw new \think\exception\HttpException(404, '找不到数据');
    }
}