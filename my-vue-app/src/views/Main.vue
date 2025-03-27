<script setup>
import CommonAside from '@/components/CommonAside.vue'
import CommonHeader from '@/components/CommonHeader.vue'
import CommonTag from '@/components/CommonTag.vue'
</script>

<template>
  <div class="common-layout">
    <el-container class="lay-container">
      <!-- 左侧菜单 -->
      
        <CommonAside />

      <!-- 右侧区域（包含header和main） -->
      <el-container direction="vertical">  <!-- 新增这个垂直容器 -->
        <el-header class="el-header">
          <CommonHeader></CommonHeader>
        </el-header>

        <CommonTag></CommonTag>

        <el-main class="right-main">
          <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<style scoped lang="less">
.common-layout {
  height: 100vh;
  
  .lay-container {
    height: 100%;
    


    // 右侧垂直容器
    > .el-container {
      flex: 1;
      flex-direction: column;

      .el-header {
        height: 60px;  // 建议设置固定高度
        padding: 0;
        background: #222;
      }

      .right-main {
        flex: 1;
        padding: 20px;
        overflow: auto;
      }
    }
  }
}
</style>