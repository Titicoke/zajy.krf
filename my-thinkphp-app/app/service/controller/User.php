<?php

namespace app\service\controller;
use app\BaseController;
use think\facade\Request;
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

    public function checkIdCardExists()
    {
        // 获取 POST 请求中的 id_card 参数
        $idCard = Request::post('id_card');
        // 判断身份证号是否为 18 位
        if (strlen($idCard) !== 18) {
            return json(['code' => -1, 'message' => '身份证号必须为 18 位']);
        }
        // 统计 users 表中 id_card 字段等于传入值的记录数量
        $count = Db::name('users')->where('id_card', $idCard)->count();
        // 如果记录数量大于 0，说明已存在，返回 1；否则返回 0
        $data = $count > 0 ? 1 : 0;
        return show(config("status.success"),'正常返回身份证号码查重结果',$data);
    }

    public function checkPhoneExists()
    {
        // 获取 POST 请求中的 phone 参数
        $phone = input('phone');
        // 判断手机号是否为 11 位
        if (strlen($phone) !== 11) {
            return json(['code' => -1, 'message' => '手机号必须为 11 位']);
        }
        // 统计 users 表中 phone 字段等于传入值的记录数量
        $count = Db::name('users')->where('phone', $phone)->count();
        // 如果记录数量大于 0，说明已存在，返回 1；否则返回 0
        $data = $count > 0 ? 1 : 0;
        return show(config("status.success"),'正常返回手机号查重结果',$data);
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

    public function saveUserReg()
    {
        // 获取前端提交的数据
        $data = $this->request->post();

        // 验证数据
        $validate = \think\facade\Validate::rule([
            'username' => 'require|alphaNum|length:6,20|unique:users,username',
            'password' => 'require|length:8,20',
            'real_name' => 'require|chs|length:2,10',
            'id_card' => 'require|length:18|unique:users,id_card',
            'dept_id' => 'require|integer',
            'post' => 'require|length:3,30',
            'title' => 'require',
            'is_party_member' => 'require|boolean',
            'phone' => 'require|regex:/^1[3-9]\d{9}$/|unique:users,phone',
            'smsCode' => 'require|length:6'
        ]);

        if (!$validate->check($data)) {
            //return json(['code' => 200, 'message' => $validate->getError(),0]);
            return show(config("status.success"),$validate->getError(),0);
        }

        // 计算性别和生日
        $idCard = $data['id_card'];
        $birthYear = substr($idCard, 6, 4);
        $birthMonth = substr($idCard, 10, 2);
        $birthDay = substr($idCard, 12, 2);
        $birthDate = $birthYear . '-' . $birthMonth . '-' . $birthDay;
        $genderCode = (int) substr($idCard, 16, 1);
        $gender = $genderCode % 2 === 1 ? 1 : 0;

        // 准备插入数据
        $insertData = [
            'username' => $data['username'],
            'password' => password_hash($data['password'], PASSWORD_DEFAULT),
            'real_name' => $data['real_name'],
            'id_card' => $data['id_card'],
            'birth_date' => $birthDate,
            'gender' => $gender,
            'phone' => $data['phone'],
            'status' => 0,
            'role_id' => 0, // 默认普通志愿者
            'is_party_member' => $data['is_party_member'] ? 1 : 0,
            'dept_id' => $data['dept_id'],
            'branch_id' => $data['is_party_member'] ? $data['party_branch'] : null,
            'position' => $data['post'],
            'title' => $data['title'],
            'wx_openid' => null
        ];

        try {
            // 插入数据到 users 表
            $userId = Db::name('users')->insertGetId($insertData);

            if ($userId) {
                return show(config("status.success"),'注册成功',1);
            } else {
                return show(config("status.success"),'注册失败，请检查注册项',0);
            }
        } catch (\Exception $e) {
            return json(['code' => 0, 'message' => '未知错误，请稍后再试',-1]);
        }
    }
}