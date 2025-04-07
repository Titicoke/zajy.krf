import axios from "axios";
import { ElMessage } from "element-plus";
import config from "@/config"
import { da } from "element-plus/es/locales.mjs";

const service = axios.create();
//const NETWORK_ERROR = "网络错误……";

//添加请求拦截器
service.interceptors.request.use(
    function(config){
        const accessToken = localStorage.getItem('access_token'); 
        if (accessToken) {
            config.headers.Authorization  = `Bearer ${accessToken}`;
            //config.headers['X-CSRF-TOKEN']  = getCSRFToken(); // 可选安全增强 
        }
        return config;
    },
    function(error){
        return Promise.reject(error)
    }
);

//添加相应拦截器
service.interceptors.response.use((res)=>{
    const {code,data,msg}=res.data;
    if(code===200){
        console.log("正常返回");        
        console.log(data)
        let meRes=[data,msg];
        return meRes;
    }else{
        console.log("异常");   
        const NETWORK_ERROR = "网络错误…";
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