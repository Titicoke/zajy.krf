import { defineStore } from "pinia";
import { ref, watch } from "vue";

function initState() {
    return {
        isCollapse: false,
        tags: [
            {
                path: '/home',
                name: 'home',
                label: '首页',
                icon: 'home'
            },
        ],
        currentMenu: null,
        menuList: [],
        token: "",
        routeList: [],
    };
}

export const useAllDataStore = defineStore("allData", () => {
    const state = ref(initState());

    // 监听 state 变化，当 token 存在时将 state 持久化到 localStorage
    watch(state, (newObj) => {
        if (!newObj.token) return;
        try {
            localStorage.setItem('store', JSON.stringify(newObj));
        } catch (error) {
            console.error('Failed to save state to localStorage:', error);
        }
    }, { deep: true });

    // 选择菜单时更新当前菜单和标签列表
    function selectMenu(val) {
        if (val.name === 'home') {
            state.value.currentMenu = null;
        } else {
            state.value.currentMenu = val;
            const index = state.value.tags.findIndex(item => item.name === val.name);
            if (index === -1) {
                state.value.tags.push(val);
            }
        }
    }

    // 更新标签列表，移除指定标签
    function updateTags(tag) {
        const index = state.value.tags.findIndex(item => item.name === tag.name);
        if (index!== -1) {
            state.value.tags.splice(index, 1);
        }
    }

    // 更新菜单列表
    function updateMenuList(val) {
        state.value.menuList = val;
    }

    // 添加菜单路由，支持刷新时从 localStorage 恢复状态
    function addMenu(router, type) {
        if (type === "refresh") {
            const storedData = localStorage.getItem('store');
            if (storedData) {
                try {
                    state.value = JSON.parse(storedData);
                    state.value.routeList = [];
                } catch (error) {
                    console.error('Failed to parse state from localStorage:', error);
                    return;
                }
            } else {
                return;
            }
            console.log("refresh");
        }

        const menu = state.value.menuList;
        const module = import.meta.glob('../views/**/*.vue');
        const routeArr = [];

        // 格式化菜单路由，处理子菜单
        menu.forEach(item => {
            if (item.children) {
                item.children.forEach(val => {
                    const url = `../views/${val.url}.vue`;
                    val.component = module[url];
                });
                routeArr.push(...item.children);
            } else {
                const url = `../views/${item.url}.vue`;
                item.component = module[url];
                routeArr.push(item);
            }
        });

        state.value.routeList = [];

        const routers = router.getRoutes();

        // 移除除 main、login、404、reg 之外的路由
        routers.forEach((item) => {
            if (item.name === "main" || item.name === "login" || item.name === "404" || item.name === "reg") {
                console.log("未删除" + item.name);
                return;
            }
            router.removeRoute(item.name);
            console.log("删除" + item.name);
        });

        // 将路由对象存入 routeList 并添加到路由中
        routeArr.forEach(item => {
            state.value.routeList.push(item);
            router.addRoute("main", item);
        });

        console.log(router.getRoutes());
    }

    // 清除路由和状态，退出登录时调用
    function clearn(router) {
        console.log('router in clearn:', router);
        state.value.routeList.forEach(item => {
            if (item.name) {
                router.removeRoute(item.name);
            }
        });
        state.value = initState();
        localStorage.removeItem('store');
        localStorage.removeItem('access_token');
    }

    return {
        state,
        selectMenu,
        updateTags,
        updateMenuList,
        addMenu,
        clearn,
    };
});    