import Mock from "mockjs";
import homeApi from "./mockData/home"
import userApi from "./mockData/user"
import permissionApi from './mockData/permission'

//1.拦截路径 2.方法 3.制造出来的假数据
//使用正则表达式是局部匹配，下面的代码能批到到api home getTableData就能拦截住
 Mock.mock(/home\/getTableData/,"get",homeApi.getTableData);
 Mock.mock(/home\/getCountData/,"get",homeApi.getCountData);
 Mock.mock(/home\/getChartData/,"get",homeApi.getChartData);
 Mock.mock(/home\/getUserData/,"get",userApi.getUserList);
// Mock.mock(/user\/deleteUser/, "get", userApi.deleteUser);
// Mock.mock(/user\/addUser/,"post", userApi.createUser);
// Mock.mock(/user\/editUser/, "post",userApi.updateUser)
//Mock.mock(/permission\/getMenu/, "post",permissionApi.getMenu)


//Mock.mock("/api/home/getTableData","get",homeApi.getTableData);