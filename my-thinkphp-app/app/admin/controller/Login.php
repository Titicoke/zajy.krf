<?php
namespace app\admin\controller;

use think\facade\Db;
use think\facade\Request;

class Login
{
    public function login()
    {
        try {
            // 基础参数校验
            $data = Request::post();
            if (empty($data['username']) || empty($data['password'])) {
                throw new \Exception('请输入用户名和密码', 400);
            }

            // 模拟登录验证（实际应验证密码）
            $user = Db::name('users')
                ->alias('u')
                ->leftJoin('departments d', 'u.dept_id  = d.dept_id')
                ->leftJoin('party_branches p', 'u.branch_id  = p.branch_id')
                ->field('u.user_id,u.real_name,u.avatar,u.role_id,u.dept_id,u.branch_id,d.dept_name,p.branch_name')
                ->where('u.username',  $data['username'])
                ->find();

            if (!$user) {
                throw new \Exception('用户不存在', 404);
            }

            // 获取动态菜单
            $menuData = $this->buildMenu($user['role_id']);

            // 生成访问令牌
            $token = md5('hospital_token_' . date('YmdHis'));

            return json([
                'code'    => 200,
                'data'    => [
                    'userInfo' => [
                        'userId'     => $user['user_id'],
                        'realName'   => $user['real_name'],
                        'avatar'     => $user['avatar'] ?? '/static/avatar/default.png',
                        'department' => $user['dept_name'] ?? '未分配科室',
                        'partyBranch'=> $user['branch_name'] ?? '未分配党组织'
                    ],
                    'menuList' => $menuData,
                    'token'    => $token,
                    'expire'   => time() + 7200
                ],
                'message' => '登录成功'
            ]);

        } catch (\Exception $e) {
            return json([
                'code'    => $e->getCode() ?: 500,
                'message' => $e->getMessage(),
                'tip'     => '系统代码：HOSP_' . date('His') . uniqid()
            ]);
        }
    }

    /**
     * 构建动态菜单结构
     */
    private function buildMenu($roleId)
    {
        $role = Db::name('role')->where('id', $roleId)->value('menus');
        $menuIds = json_decode($role, true) ?: [];

        $menus = Db::name('menu')
            ->whereIn('id', $menuIds)
            ->order('sort ASC')
            ->select()
            ->toArray();

        return $this->buildTree($menus);
    }


    /**
     * 递归构建菜单树
     */
    private function buildTree($menus, $parentId = 0)
    {
        $tree = [];
        // 提取当前层级菜单
        $currentLevel = array_filter($menus, function($m) use ($parentId) {
            return $m['parent_id'] == $parentId;
        });

        // 纯sort升序排序（核心修改）
        usort($currentLevel, function($a, $b) {
            return $a['sort'] - $b['sort'];  // 直接比较sort值
        });

        // 构建树形结构
        foreach ($currentLevel as $menu) {
            $children = $this->buildTree($menus, $menu['id']);
            $node = [
                'path'    => $menu['path'],
                'name'    => str_replace('/', '', $menu['path']),
                'label'   => $menu['title'],
                'icon'    => $menu['icon'],
                'url'     => ucfirst(explode('/', $menu['path'])[1] ?? 'Home')
            ];
            if (!empty($children)) {
                $node['children'] = $children;
            }
            $tree[] = $node;
        }
        return $tree;
    }
}