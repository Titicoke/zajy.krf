<?php

namespace app\service\controller;
use app\BaseController;
use think\facade\Db;

class User extends BaseController
{
// 控制器中直接使用Db门面+缓存
    public function checkUsername()
    {
        $username = input('username');
        if (empty($username) || strlen($username) < 6) {
            return json(['code' => 400, 'msg' => '用户名长度至少6位']);
        }

        // 带缓存的查询
        $exists = Db::name('users')
            ->where('username', $username)
            //->cache(60, 'username_check') // 自定义缓存标识
            ->count();

        $data = $exists ? 1 : 0;
        return show(config("status.success"),'正常返回用户名测试结果',$data);
    }
    public function getDepartments()
    {
        try {
            // 构建基础查询
            $query = Db::name('departments')
                ->field('dept_id, dept_name') // 严格限制返回字段
                ->order('dept_id ASC'); // 保持默认排序

            // 执行查询并处理结果
            $list = $query->select()->toArray();

            return show(config("status.success"),'获取单位列表成功',$list);

        } catch (\Throwable $e) {

            return json([
                'code' => 500,
                'msg' => '数据服务暂不可用',
                'error' => "服务器异常" ? $e->getMessage() : null
            ]);
        }
    }

    public function getpartyBranches()
    {
        try {
            // 构建基础查询
            $query = Db::name('party_branches')
                ->field('branch_id, branch_name') // 严格限制返回字段
                ->order('branch_id ASC'); // 保持默认排序

            // 执行查询并处理结果
            $list = $query->select()->toArray();

            return show(config("status.success"),'获取党支部成功',$list);

        } catch (\Throwable $e) {

            return json([
                'code' => 500,
                'msg' => '数据服务暂不可用',
                'error' => "服务器异常" ? $e->getMessage() : null
            ]);
        }
    }
}