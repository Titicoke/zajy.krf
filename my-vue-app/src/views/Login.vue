<template>
    <div class="body-login">
        <el-form :model="loginForm" class="login-container">
            <h3>欢迎登录</h3>
            <el-form-item>
                <el-input type="input" placeholder="请输入账户" v-model="loginForm.username"></el-input>
            </el-form-item>
            <el-form-item>
                <el-input type="password" placeholder="请输入密码" v-model="loginForm.password"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="login"> 登录 </el-button>
            </el-form-item>
        </el-form>
    </div>
</template>
<script setup>

import {reactive,getCurrentInstance} from 'vue'
import { useAllDataStore } from '@/stores/index.js'
import { useRouter } from 'vue-router'

const { proxy } = getCurrentInstance()
const store=useAllDataStore()
const router=useRouter()
const loginForm = reactive({
  username: 'admin',
  password: 'admin',
});

const login=async ()=>{
    const res = await proxy.$api.getMenu(loginForm);
    if(res){

        // 新增本地存储（需同步更新store）
        localStorage.setItem('access_token',  res.token); 

        store.updateMenuList(res.menuList)     
        //在这里执行添加路由方法,并传入router
        store.addMenu(router) 
        store.state.token=res.token  
        store.state.userInfo=res.userInfo 

        // 强制刷新路由（避免动态路由加载问题）
        //window.location.reload();  

        console.log(res)
        router.push("/home")
    }
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
  width: 350px;
  background-color: #fff;
  border: 1px solid #eaeaea;
  border-radius: 15px;
  padding: 35px 35px 15px 35px;
  box-shadow: 0 0 25px #cacaca;
  margin: 180px auto;
  h3 {
    text-align: center;
    margin-bottom: 20px;
    color: #505450;
  }
  :deep(.el-form-item__content) {
    justify-content: center;
  }
}
</style>