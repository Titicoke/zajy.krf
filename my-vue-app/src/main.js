// 应用初始化阶段
import { createApp } from 'vue'
import App from './App.vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import { createPinia } from 'pinia'
import router from './router'
import api from "@/api/api"
import { useAllDataStore } from "@/stores"
import "@/assets/less/index.less"

// 路由守卫配置
// 获取所有路由记录的完整列表，用于校验目标路由是否存在
function isRoute(to) {
  return router.getRoutes().filter(item => item.path === to.path).length > 0
}

// 全局前置路由守卫
router.beforeEach((to, from) => {
  // 非登录页面且无token时重定向到登录页
  if (to.path !== '/login' && !store.state.token) {
    return { name: 'login' }
  }
  // 路由不存在时跳转到404页面
  if (!isRoute(to)) {
    return { name: "404" }
  }
})

// 应用实例创建与配置
const app = createApp(App)
const pinia = createPinia()

// 全局图标组件注册（必须在挂载前完成）
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component)
}
// 插件注册顺序
app.use(pinia)       // 状态管理库
app.use(ElementPlus) // UI组件库

// 初始化store并添加菜单
const store = useAllDataStore()
store.addMenu(router, "refresh")

// 路由插件注册
app.use(router)

// 全局属性配置
app.config.globalProperties.$api = api

// Mock数据配置（开发环境按需加载）
// if (import.meta.env.DEV) {
//  import("@/api/mock.js")
// }
import("@/api/mock.js")

// 应用挂载阶段（必须最后执行）
app.mount('#app')