<?php
namespace app\controller;

use think\facade\Db;
use think\facade\Request;

class AdminUser
{
    public function getUserlist()
    {
        try {
            // 获取分页参数，默认页码为1，每页显示10条记录。
            $page = Request::param('page', 1, 'intval');
            $limit = Request::param('limit', 10, 'intval');

            // 构建查询条件
            $query = Db::name('users')->order('user_id', 'desc');

            // 获取用户列表数据，使用paginate方法进行分页查询
            $users = $query->paginate([
                'list_rows' => $limit,
                'page' => $page,
            ]);

            // 处理用户数据，将部分字段转换为更易读的形式
            $data = $users->toArray();
            foreach ($data['data'] as &$user) {
                $user['gender_label'] = $user['gender'] === 1 ? '男' : '女';
                $user['status_label'] = $this->getStatusLabel($user['status']);
                $user['role_label'] = $this->getRoleLabel($user['role_id']);
                $user['is_party_member_label'] = $user['is_party_member'] === 1 ? '是' : '否';
            }

            // 使用show函数返回成功响应，包含用户列表数据和分页信息
            return show(config("code.success"), '获取用户列表成功', [
                'data' => $data['data'],
                'total' => $data['total'],
            ]);
        } catch (\Exception $e) {
            // 使用show函数捕获异常并返回错误响应
            return show(config("code.error"), '获取用户列表失败：' . $e->getMessage(), [], 200);
        }
    }

    // 根据状态码获取状态标签
    private function getStatusLabel($status)
    {
        switch ($status) {
            case 0:
                return '待审核';
            case 1:
                return '正常';
            case 2:
                return '禁用';
            default:
                return '未知状态';
        }
    }

    // 根据角色ID获取角色标签
    private function getRoleLabel($roleId)
    {
        switch ($roleId) {
            case 0:
                return '普通志愿者';
            case 1:
                return '管理员';
            default:
                return '未知角色';
        }
    }
}