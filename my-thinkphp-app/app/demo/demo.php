<?php

namespace app\demo;

class demo
{
//    下面是一个静态演示
    public function login1()
    {
        try {
            // 基础参数校验（不验证真实性）
            if (!request()->post('username') || !request()->post('password')) {
                throw new \Exception('参数格式错误', 400);
            }

            // 模拟菜单数据（开发测试用）
            $menuList = [
                [
                    'path' => '/home',
                    'name' => 'home',
                    'label' => '首页',
                    'icon' => 'house',
                    'url' => 'Home'
                ],
                [
                    'path' => '/mall',
                    'name' => 'mall',
                    'label' => '商品管理',
                    'icon' => 'video-play',
                    'url' => 'Mall'
                ],
                [
                    'path' => '/user',
                    'name' => 'user',
                    'label' => '用户管理',
                    'icon' => 'user',
                    'url' => 'User'
                ],
                [
                    'path' => 'system',
                    'label' => '系统管理',
                    'icon' => 'setting',
                    'children' => [
                        [
                            'path' => '/page1',
                            'name' => 'page1',
                            'label' => '页面1',
                            'url' => 'page1'
                        ],
                        [
                            'path' => '/page2',
                            'name' => 'page2',
                            'label' => '页面2',
                            'url' => 'page2'
                        ]
                    ]
                ]
            ];

            return json([
                'code' => 200,
                'data' => [
                    'menuList' => $menuList,
                    'token' => md5('test_token_' . date('YmdHis')),
                    'expire' => time() + 7200
                ],
                'message' => '模拟登录成功'
            ]);

        } catch (\Exception $e) {
            return json([
                'code' => $e->getCode() ?: 500,
                'message' => $e->getMessage(),
                'tip' => '当前为测试模式，错误代码：DEV_' . uniqid()
            ]);
        }
    }
}