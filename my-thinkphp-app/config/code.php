<?php
/**
 * 该文件存放业务状态码相关的配置
 */
return [
    "success"=>1,
    "unoccupied"=>8,
    "error"=>0,

    "not_login"=>-1,
    "user_is_register"=>-2,//用户被注册
    "action_not_found"=>-3,
    "controller_not_found"=>-4,
    "UDE"=>-5,//Username does not exist
    "PI"=>-6,//Password is incorrect
    "VCI"=>-7,//Verification code is incorrect
    //mysql的状态码定义
    "mysql"=>[
        "table_normal"=>1,
        "table_pending"=>0,
        "table_delete"=>99,
    ],

];