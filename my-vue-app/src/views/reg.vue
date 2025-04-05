<!-- src/views/reg.vue  -->
<template>
    <div class="register-container">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px">
        <!-- 基础信息 -->
        <el-form-item label="用户名" prop="username">
          <el-input v-model="form.username"  placeholder="请输入工号/用户名"
                    @blur="checkUsernameExists"/>
        </el-form-item>
        
        <!-- 密码相关 -->
        <el-form-item label="密码" prop="password">
          <el-input type="password" show-password v-model="form.password"/> 
        </el-form-item>
        
        <!-- 身份信息 -->
        <el-form-item label="真实姓名" prop="real_name">
          <el-input v-model="form.real_name"/> 
        </el-form-item>
        
        <!-- 身份证验证 -->
        <el-form-item label="身份证号" prop="id_card">
          <el-input v-model="form.id_card"  maxlength="18" 
                    @blur="calculateGenderBirth"/>
        </el-form-item>
        
        <!-- 联系信息 -->
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="form.phone"  @blur="checkPhoneExists"/>
        </el-form-item>
        
        <!-- 组织信息 -->
        <el-form-item label="所属科室" prop="dept_id">
          <el-select v-model="form.dept_id"  filterable>
            <el-option v-for="dept in departments" 
                       :key="dept.dept_id"  
                       :label="dept.dept_name"  
                       :value="dept.dept_id"/> 
          </el-select>
        </el-form-item>
        
        <!-- 提交按钮 -->
        <el-form-item>
          <el-button type="primary" @click="submitForm">立即注册</el-button>
        </el-form-item>
      </el-form>
    </div>
  </template>
   
  <script setup>
  import { ref,getCurrentInstance, reactive, onMounted } from 'vue'
  import { ElMessage } from 'element-plus'
  const {proxy}=getCurrentInstance()
   
  // 表单数据 
  const form = reactive({
    username: '',
    password: '',
    real_name: '',
    id_card: '',
    phone: '',
    dept_id: null 
  })
   
  // 验证规则 
  const rules = reactive({
    username: [
      { required: true, message: '请输入用户名', trigger: 'blur' },
      { pattern: /^[A-Za-z0-9]{6,20}$/, message: '6-20位字母数字组合' }
    ],
    password: [
      { required: true, message: '请输入密码', trigger: 'blur' },
      { min: 8, max: 20, message: '长度8-20位' }
    ],
    id_card: [
      { validator: (_, v, cb) => {
        if(!/^\d{17}[\dXx]$/.test(v)) return cb('身份证格式错误')
        cb()
      }}
    ],
    phone: [
      { pattern: /^1[3-9]\d{9}$/, message: '手机号格式错误' }
    ]
  })
   
  // 部门数据 
  const departments = ref([])
   
  // 数据加载 
  onMounted(async () => {
    const data = await proxy.$api.getdepartments()
    console.log("ddd")
    console.log(data)
    departments.value  = data
  })
   
  // 唯一性校验 
  const checkUsernameExists = async () => {
    if(!form.username)  return 
    const { data } = await axios.post('/api/check-username',  { username: form.username  })
    if(data.exists)  ElMessage.warning(' 该用户名已存在')
  }
   
  // 提交处理 
  const submitForm = async () => {
    try {
      await axios.post('/api/register',  form)
      ElMessage.success(' 注册成功，请等待审核')
    } catch(e) {
      ElMessage.error(e.response?.data?.message  || '注册失败')
    }
  }
  </script>