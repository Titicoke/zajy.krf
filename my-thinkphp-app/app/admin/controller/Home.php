<?php

namespace app\admin\controller;

use app\BaseController;

class Home extends BaseController
{
    public function getTableData()
    {
        return 'index控制器下的index方法';
    }

    public function hello($name = 'ThinkPHP8')
    {
        return 'hello,' . $name;
    }
}
