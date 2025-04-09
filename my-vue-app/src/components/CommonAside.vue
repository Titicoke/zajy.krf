<template>
    <el-aside :width="width">
        <el-menu 
        text-color="#fff" 
        :collapse="isCollapse"
        :collapse-transition="false"
        :default-active="activeMenu"
        >
            <h3 v-show="!isCollapse">志爱晋医</h3>
            <h3 v-show="isCollapse">后台</h3>
            
            <!-- 无子菜单项 -->
            <el-menu-item 
             v-for="item in noChildren"
              :index="item.path" 
               :key="item.path" 
               @click="handleMenu(item)"
            >
                <component class="icons" :is="item.icon"></component> 
                <span>{{item.label}}</span> 
            </el-menu-item>
            
            <!-- 有子菜单项 -->
            <el-sub-menu 
              v-for="item in hasChildren" 
              :index="item.path"  
              :key="item.path" 
            >
                <template #title>
                    <component class="icons" :is="item.icon"></component> 
                    <span>{{item.label}}</span> 
                </template>
                <el-menu-item-group>
                    <el-menu-item 
                     v-for="(subItem) in item.children" 
                        :index="subItem.path" 
                        :key="subItem.path" 
                        @click="handleMenu(subItem)"
                    >
                        <span>{{subItem.label}}</span> 
                    </el-menu-item>
                </el-menu-item-group>
            </el-sub-menu>
        </el-menu>
    </el-aside>
</template>
 
<script setup>
import { ref, computed } from 'vue'
import { useAllDataStore } from '@/stores/index.js' 
import { useRoute, useRouter } from 'vue-router'
 
const store = useAllDataStore()
const router = useRouter()
const route = useRoute()
 
// 核心修改部分：添加排序逻辑 
const sortedMenuList = computed(() => {
  // 深拷贝后排序 
  const sorted = [...store.state.menuList].sort((a,  b) => a.sort  - b.sort) 
  // 子菜单排序 
  return sorted.map(item  => ({
    ...item,
    children: item.children  ? [...item.children].sort((a,  b) => a.sort  - b.sort)  : []
  }))
})
 
// 计算属性使用排序后的数据 
const noChildren = computed(() => 
  sortedMenuList.value.filter(item  => !item.children  || item.children.length  === 0)
)
 
const hasChildren = computed(() => 
  sortedMenuList.value.filter(item  => item.children  && item.children.length  > 0)
)
 
// 其他原有计算属性 
const isCollapse = computed(() => store.state.isCollapse) 
const width = computed(() => store.state.isCollapse  ? '64px' : '180px')
const activeMenu = computed(() => route.path) 
 
const handleMenu = (item) => {
  router.push(item.path) 
  store.selectMenu(item) 
}

console.log('所有可用路由信息：', router.options.routes);
</script>
<style lang="less" scoped>
/* 基础布局样式 */
.el-aside {
  background-color: #1a2332;
  height: 100vh;
  position: relative;
  z-index: 10;
  box-shadow: 4px 0 12px rgba(0, 0, 0, 0.15);
  transition: width 0.3s ease;
}

/* 菜单整体样式 */
.el-menu {
  --el-menu-active-color: #4a8cff;
  --el-menu-text-color: #b0bac9;
  --el-menu-hover-bg-color: rgba(74, 140, 255, 0.1);
  --el-menu-bg-color: transparent;
  border-right: none;
  padding: 12px 0;
  
  /* 标题样式 */
  h3 {
    color: #ffffff;
    font-size: 16px;
    font-weight: 600;
    text-align: center;
    margin: 0;
    padding: 16px 0;
    position: relative;
    
    &::after {
      content: "";
      display: block;
      width: 40px;
      height: 2px;
      background: linear-gradient(90deg, rgba(74, 140, 255, 0.5), transparent);
      margin: 8px auto 0;
    }
  }
}

/* 图标样式 */
.icons {
  width: 18px;
  height: 18px;
  margin-right: 10px;
  color: currentColor;
  transition: all 0.2s ease;
}

/* 一级菜单项 */
.el-menu-item {
  margin: 4px 12px;
  border-radius: 6px;
  height: 44px;
  line-height: 44px;
  transition: all 0.2s ease;
  
  &:hover {
    color: #ffffff !important;
    background-color: rgba(74, 140, 255, 0.15) !important;
    
    .icons {
      transform: translateX(2px);
    }
  }
  
  &.is-active {
    color: #4a8cff !important;
    background-color: rgba(74, 140, 255, 0.1) !important;
    font-weight: 500;
    
    &::before {
      content: "";
      position: absolute;
      left: 0;
      top: 0;
      bottom: 0;
      width: 3px;
      background-color: #4a8cff;
      border-radius: 0 3px 3px 0;
    }
  }
}

/* 子菜单标题 */
.el-sub-menu {
  margin: 4px 12px;
  
  &__title {
    border-radius: 6px;
    height: 44px;
    line-height: 44px;
    transition: all 0.2s ease;
    
    &:hover {
      color: #ffffff !important;
      background-color: rgba(74, 140, 255, 0.15) !important;
    }
  }
  
  &.is-active {
    > .el-sub-menu__title {
      color: #4a8cff !important;
    }
  }
  
  &.is-opened {
    > .el-sub-menu__title {
      color: #ffffff !important;
    }
  }
}

/* 子菜单项容器 */
.el-menu--inline {
  background-color: rgba(0, 0, 0, 0.2) !important;
  padding: 8px 0;
  border-radius: 0 0 8px 8px;
  
  .el-menu-item {
    height: 36px;
    line-height: 36px;
    margin: 0;
    padding-left: 48px !important;
    color: #a0aec0;
    
    &:hover {
      color: #ffffff !important;
      background-color: rgba(74, 140, 255, 0.1) !important;
    }
    
    &.is-active {
      color: #4a8cff !important;
      background-color: rgba(74, 140, 255, 0.08) !important;
      
      &::before {
        height: 16px;
        top: 50%;
        transform: translateY(-50%);
        border-radius: 3px;
      }
    }
  }
}

/* 折叠状态样式 */
.el-menu--collapse {
  .el-menu-item,
  .el-sub-menu {
    margin: 4px 8px;
  }
  
  .el-sub-menu__title {
    padding-left: 20px !important;
  }
  
  .el-tooltip__trigger {
    justify-content: center;
  }
  
  .icons {
    margin-right: 0;
  }
}

/* 响应式调整 */
@media (max-width: 768px) {
  .el-aside {
    position: absolute;
    z-index: 1000;
  }
  
  .el-menu--collapse {
    width: 64px;
  }
}
</style>