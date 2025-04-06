import { createRouter,createWebHashHistory} from "vue-router";

//制定路由规则

const routes =[
    {
        path:'/',
        name:'main',
        component:()=>import('@/views/Main.vue'),
        redirect:"/home",
        children:[]
    },
    {
        path:'/login',
        name:'login',
        component:()=>import('@/views/Login.vue'),        
    },
    {
        path:'/reg',
        name:'reg',
        component:()=>import('@/views/Reg.vue'),        
    },
    {
        path:'/reg1',
        name:'reg1',
        component:()=>import('@/views/reg1.vue'),        
    },
    {
        path: '/404',
        name: '404',
        component: () => import('@/views/404.vue')
    }
];

const router = createRouter({
    history:createWebHashHistory(),
    routes,
});

export default router;