<?php
namespace app\admin\controller;
use app\service\TokenService;
use think\facade\Db;
use think\facade\Request;
use think\captcha\facade\Captcha; // 引入验证码门面

class Login
{
    public function login()
    {
        // 基础参数校验，获取POST请求的数据
        $data = Request::post();

        // 验证验证码
        if (!Captcha::check($data['captcha'])) {
            return show(400, '验证码错误: ' . $data['captcha'], []);
        }

        // 检查用户名和密码是否为空
        if (empty($data['username']) || empty($data['password'])) {
            return show(400, '请输入用户名和密码', []);
        }

        // 模拟登录验证，从数据库中查找用户信息，同时获取用户的密码字段
        $user = Db::name('users')
            ->alias('u')
            ->leftJoin('departments d', 'u.dept_id  = d.dept_id')
            ->leftJoin('party_branches p', 'u.branch_id  = p.branch_id')
            ->field('u.user_id,u.real_name,u.avatar,u.role_id,u.dept_id,u.branch_id,d.dept_name,p.branch_name, u.password')
            ->where('u.username',  $data['username'])
            ->find();

        if (!$user) {
            return show(404, '用户不存在', []);
        }

        // 验证密码
        if (!password_verify($data['password'], $user['password'])) {
            return show(400, '密码不正确', []);
        }

        // 获取动态菜单
        $menuData = $this->buildMenu($user['role_id']);

        // 生成Token
        $token = TokenService::createToken($user['user_id'],$user['role_id']);

        // 整理登录成功后要返回的数据
        $resultData =  [
            'userInfo' => [
                'userId'     => $user['user_id'],
                'userRoleId' => $user['role_id'],
                'realName'   => $user['real_name'],
                'avatar'     => $user['avatar'] ?? '/static/avatar/default.png',
                'department' => $user['dept_name'] ?? '未分配科室',
                'partyBranch'=> $user['branch_name'] ?? '未分配党组织'
            ],
            'menuList' => $menuData,
            'token'    => $token,
            'expire'   => time() + 7200
        ];

        // 登录成功，使用show函数返回成功信息和数据
        return show(config("code.success"), '登录成功', $resultData);
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
            ->order('sort_order ASC')
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
            return $a['sort_order'] - $b['sort_order'];  // 直接比较sort值
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