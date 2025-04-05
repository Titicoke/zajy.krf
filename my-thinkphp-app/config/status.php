<?php
/**
 * 该文件存放业务状态码相关的配置
 */
return [
    "success"=>200,
    "error"=>0,
    "not_login"=>-1,
    "user_is_register"=>-2,//用户被注册
    "action_not_found"=>-3,
    "controller_not_found"=>-4,
    //mysql的状态码定义
    "mysql"=>[
        "table_normal"=>1,
        "table_pending"=>0,
        "table_delete"=>99,
    ],

];