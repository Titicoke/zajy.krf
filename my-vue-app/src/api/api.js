/**
 * 整个项目api的管理
 * 
 */
import request from "./request"

export default {
  // home组件 左侧表格数据获取
  getTableData() {
    return request({
      url: 'home/getTableData',
      method: 'get',
      //mock:false,
    })
  },

  getCountData() {
    return request({
      url: 'home/getCountData',
      method: 'get',
      //mock:false,
    })
  } ,

  getChartData() {
    return request({
      url: 'home/getChartData',
      method: 'get',
      //mock:false,
    })
  },

  getUserData(data) {
    return request({
      url: 'home/getUserData',
      method: 'get',
      data,
      //mock:false,
    })
  },

  deleteUser(params) {
    return request({
      url: '/user/deleteUser',
      method: 'get',
      data: params
    })
  },
  addUser(params) {
    return request({
      url: '/user/addUser',
      method: 'post',
      data: params
    })
  },
  editUser(params) {
    return request({
      url: '/user/editUser',
      method: 'post',
      data: params
    })
  },
  login(params) {
    return request({
      url: '/admin/login/login',
      method: 'post',
      data: params
    })
  },
  getdepartments(params) {
    return request({
      url: '/service/user/getdepartments',
      method: 'post',
      data: params
    })
  },
  getpartyBranches(params) {
    return request({
      url: '/service/user/getpartyBranches',
      method: 'post',
      data: params
    })
  },
  getSmsCode(params) {
    return request({
      url: '/service/smscode',
      method: 'post',
      data: params
    })
  },
  checkUsername(params) {
    return request({
      url: '/service/checkUsername',
      method: 'post',
      data: params
    })
  },
}