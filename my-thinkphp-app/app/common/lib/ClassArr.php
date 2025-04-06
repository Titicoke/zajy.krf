<?php

namespace app\common\lib;

class ClassArr
{
    public static function smsClassStat()
    {
        return[
            "ali"=>"app\common\lib\sms\AliSms",
            "baidu"=>"app\common\lib\sms\BaiduSms",
            "jd"=>"app\common\lib\sms\JdSms",
        ];
    }
    public static function initClass($type,$classs,$params=[],$needInstance=false)
    {
        //如果我们工厂模式调用的方式是静态的，那么返回类库
        if(!array_key_exists($type,$classs)){
            return false;
        }
        $className = $classs[$type];

        //new ReflectionClass('A')  建立A反射类
        // ->newInstanceArgs($args)  相当于实例化A对象
        return $needInstance==true ? (new \Reflection($className))->newInstanceArgs($params) : $className;
    }
}