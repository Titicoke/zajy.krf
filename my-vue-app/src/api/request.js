import axios from "axios";
import { ElMessage } from "element-plus";
import config from "@/config"

const service = axios.create();
//添加请求拦截器
service.interceptors.request.use(
    function(config){
        return config;
    },
    function(error){
        return Promise.reject(error)
    }
);

//添加响应拦截器
service.interceptors.response.use((res)=>{
    const {code,data,msg}=res.data;
    if(code===200){
        return data;
    }else{
        const NETWORK_ERROR = "访问接口未获得数据，网络错误…";
        ElMessage.error(msg || NETWORK_ERROR);
        return Promise.reject(msg || NETWORK_ERROR)
    }
});

function request(options){
    options.method = options.method || "get";

    //统一post和get请求参数传递方式
    if(options.method.toLowerCase()==="get"){
        options.params = options.data;
    }
    //对mock的开关进行处理
    let isMock=config.mock;
    if(typeof options.mock!=="undefined"){
        isMock=options.mock;
    }

    //针对环境做一个处理
    if(config.env==="prod"){
        //不能用mock
        service.defaults.baseURL=config.baseApi;
    }else{
        service.defaults.baseURL=isMock ? config.mockApi : config.baseApi;
    }
    return service(options);
}

export default request;