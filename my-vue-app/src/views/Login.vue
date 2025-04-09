<template>
  <div class="body-login">
      <el-form :model="loginForm" class="login-container" :rules="rules" ref="formRef">
          <h3>欢迎登录</h3>
          <el-form-item label="用户名" prop="username">
              <el-input type="input" placeholder="请输入账户" v-model="loginForm.username"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="password">
              <el-input type="password" placeholder="请输入密码" v-model="loginForm.password"></el-input>
          </el-form-item>
          <el-form-item label="验证码" prop="captcha">
              <div class="captcha-container">
                  <el-input type="text" placeholder="请输入验证码" v-model="loginForm.captcha"></el-input>
                  <img :src="captchaUrl" @click="refreshCaptcha" alt="验证码" style="cursor: pointer; height: 32px; vertical-align: middle;">
              </div>
          </el-form-item>
          <el-form-item class="button-container">
              <el-button type="primary" @click="login"> 登录 </el-button>
              <el-button type="text" @click="reg" style="color: #409eff; text-decoration: underline">
                  注册账号 
              </el-button>
          </el-form-item>
      </el-form>
  </div>
</template>
<script setup>
import { reactive, getCurrentInstance, ref } from 'vue'
import { useAllDataStore } from '@/stores/index.js'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage } from 'element-plus';

const { proxy } = getCurrentInstance()
const store = useAllDataStore()
const router = useRouter()
const route = useRoute()

const formRef = ref(null);
const loginForm = reactive({
  username: '',
  password: '',
  captcha: ''
});

const rules = reactive({
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' }
  ],
  captcha: [
    { required: true, message: '请输入验证码', trigger: 'blur' }
  ]
});



// 在组件挂载时，检查查询参数并填充表单
const initForm = () => {
  const { username, password } = route.query
  if (username) {
      loginForm.username = username
  }
  if (password) {
      loginForm.password = password
  }
}

initForm()

const captchaUrl = ref('api/captcha_img'); // 假设ThinkPHP验证码接口路径为 /captcha
const refreshCaptcha = () => {
  captchaUrl.value = `api/captcha_img')?${new Date().getTime()}`; // 刷新验证码，添加时间戳防止缓存
}

const login = async () => {
  await formRef.value.validate();
  const res = await proxy.$api.login(loginForm);
  if (res) {
    if (res.data.code === 1) {
      //ElMessage.success('登录成功');
      // 新增本地存储（需同步更新store）
      localStorage.setItem('access_token', res.data.data.token); 

      store.updateMenuList(res.data.data.menuList)     
      // 在这里执行添加路由方法，并传入router
      await store.addMenu(router) 
      store.state.token = res.data.data.token  
      store.state.userInfo = res.data.data.userInfo
      router.push("/home")
    } else {      
      refreshCaptcha();
      ElMessage({
        message: res.data.msg,
        type: 'error',
        duration: 1500,
        showClose: true
      });
      return;
    }
      
  }
}

const reg = () => {
  router.push("/reg")
}
</script>
<style scoped lang="less">

.body-login{  
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-image: url("../assets/images/background.png");
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  display: flex;
  align-items: center;
  justify-content: center;
}
.login-container {
  width: 450px;
  background-color: #fff;
  border: 1px solid #eaeaea;
  border-radius: 15px;
  padding: 35px;
  box-shadow: 0 0 25px #cacaca;
  margin: 180px auto;
  h3 {
      text-align: center;
      margin-bottom: 20px;
      color: #505450;
  }
  .captcha-container {
      display: flex;
      align-items: center;
      justify-content: space-between;
  }
  .button-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding-left: 100px;
  }
  :deep(.el-form-item__content) {
      margin-bottom: 1px;
  }
  :deep(.el-form-item__label) {
      text-align: right;
      width: 80px; /* 调整宽度以适应文本长度 */
  }
  }

</style>    