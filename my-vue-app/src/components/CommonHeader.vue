<template>
    <div class="header">    
        <div class="l-content">            
            <!-- 这个点击事件是控制菜单组件的收缩的-->
            <el-button size="small" @click="handleCollapse">
                <!-- 图标的展示,这里我们使用动态组件来展示图标-->
                <component class="icons" is="menu"></component>
            </el-button>
                
                <!-- 面包屑，separator是分隔符-->
            <el-breadcrumb separator="/" class="bread">
                <!-- 首页是一定存在的所以直接写死 -->
                <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <!-- if判断一定要加-->
                <el-breadcrumb-item v-if="current" :to="current.path" >{{
                    current.label
                }}</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        
            <!--右侧用户头像-->
        <div class="r-content">
            <el-dropdown>
            <span>
                <!--我们定义一个URl对象地址，这里是传入图片的名称-->
                <img :src="getImageUrl('user')"  class="user" />
            </span>
            <template #dropdown>
                <el-dropdown-menu>
                <el-dropdown-item>欢迎您：{{name}}</el-dropdown-item>
                <el-dropdown-item @click="handleUsercenter">个人中心</el-dropdown-item>
                <el-dropdown-item @click="handleLoginOut">退出</el-dropdown-item>
                </el-dropdown-menu>
            </template>
            </el-dropdown>
        </div>
    </div>
</template>
<script setup>
import { computed } from 'vue'
import { useAllDataStore } from '@/stores/index.js'
import {useRouter} from 'vue-router'
// 定义 current 属性
const current=computed(()=>store.state.currentMenu)
const name=computed(()=>store.state.userInfo.realName)

const getImageUrl = (user)=>{
    return new URL(`../assets/images/${user}.png`,import.meta.url).href
}
 const store = useAllDataStore()
 const handleCollapse = () => {
    store.state.isCollapse=!store.state.isCollapse
 }
 const router=useRouter()
 const handleLoginOut=()=>{
  //执行重置方法
  store.clearn(router)    
  router.push("/login")
}
const handleUsercenter=()=>{
   router.push("/home")
}
</script>
<style lang="less" scoped>
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: 100%;
  background-color: #333;
  padding: 0px 10px;
}
.icons{
    width: 20px;
    height: 20px;
}
.r-content {
  .user {
    width: 40px;
    height: 40px;
    border-radius: 50%;
  }
}
.l-content {
  display: flex;
  align-items: center;
  .el-button {
    margin-right: 20px;
  }
}

:deep(.bread span) {
  color: #fff !important;
  cursor: pointer !important;
}
</style>