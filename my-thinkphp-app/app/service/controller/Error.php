<?php

namespace app\service\controller;
use think\facade\Request;

class Error
{
    public function __call(string $name, array $arguments)
    {
        // TODO: Implement __call() method.
        //dump($name);
        //dump(count($arguments));
        //逻辑：如果我们的模块是API模块，需要输出API格式
        $controller=Request::controller();
        $result = [
            'status' => config('status.controller_not_found'),
            'message' => '找不到控制器'.$controller,
            'result' => [],
        ];
        return json($result,400);
        //逻辑：如果我们是模版引擎方式，那么需要输出一个页面
    }
}