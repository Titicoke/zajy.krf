<?php

namespace app\admin\controller;

use app\BaseController;

class Home extends BaseController
{
    public function home()
    {
        return 'index控制器下的index方法';
    }

    public function hello($name = 'ThinkPHP8')
    {
        return 'hello,' . $name;
    }
}
