<?php

namespace app\service\controller;
use think\facade\Db;

class Departments
{
    public function getDepartments()
    {
        try {


            // 构建基础查询
            $query = Db::name('departments')
                ->field('dept_id, dept_name') // 严格限制返回字段
                ->order('dept_id ASC'); // 保持默认排序


            // 执行查询并处理结果
            $list = $query->select()->toArray();

            return json([
                'code' => 200,
                'msg' => 'success',
                'data' => $list
            ]);

        } catch (\Throwable $e) {
            return json([
                'code' => 500,
                'msg' => '数据服务暂不可用',
                'error' => "服务器异常" ? $e->getMessage() : null
            ]);
        }
    }
}