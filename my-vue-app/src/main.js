//"先注册 -> 再配置 -> 最后挂载" 的生命周期顺序
import { createApp } from 'vue';
import App from './App.vue';
import "@/assets/less/index.less";
import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css';
import * as ElementPlusIconsVue from '@element-plus/icons-vue';
import router from './router';
import { createPinia } from 'pinia';
import api from "@/api/api";
import {useAllDataStore} from "@/stores"

 //getRoutes获得所有路由记录的完整列表。
 //这个方法判断要跳转的路由是否存在
 function isRoute(to){
  return router.getRoutes().filter(item=>item.path===to.path).length>0
}

router.beforeEach((to, from) => {
    //如果要跳转的不是login,且token不存在(可以通过不存在token判断出用户未登录)
   if(to.path !== '/reg1'&&to.path !== '/reg'&&to.path !== '/login'&&!store.state.token){
       //跳转到login
       return { name: 'login' }
   }
   //如果路由记录不存在
   if(!isRoute(to)){
       //跳转到404界面
       return {name: "404"}
   }
})

const app = createApp(App);
const pinia = createPinia();


// 注册图标组件 (必须在挂载前完成)
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component);
}

// 按顺序使用插件

app.use(pinia);
app.use(ElementPlus);




//user pinia 之后 use router之前
const store=useAllDataStore();
store.addMenu(router,"refresh")

app.use(router);
// 配置全局属性
app.config.globalProperties.$api = api;
//按需加载 mock
// if (import.meta.env.DEV) {
//  import("@/api/mock.js");
// }
import("@/api/mock.js");

// 最后挂载
app.mount('#app');