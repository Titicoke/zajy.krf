<template>
  <div class="page-root"> 
    <div class="card-header">
      <div class="header-body">
        <el-row align="middle" :gutter="20">
          <el-col :span="4">
            <el-image 
              :src="getImageUrl('zyz')"
              fit="contain"
              style="height:48px">
            </el-image>
          </el-col>
          <el-col :span="20">
            <div class="header-title">
              <div class="main">晋城市人民医院</div>
              <div class="sub">志爱晋医 · 用户注册</div>
            </div>
          </el-col>
        </el-row>
      </div>
    </div> 
    <div class="register-container animate__animated animate__fadeInUp">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px">
        <!-- 用户信息 -->
        <el-form-item label="用户名" prop="username" class="required-star">
          <el-input 
            v-model="form.username"  
            placeholder="6-20位字母数字"
            clearable 
            @blur="checkUsernameExists">
            <template #prefix>
              <el-icon><User /></el-icon>
            </template>
          </el-input>
        </el-form-item>
 
      <!-- 密码 -->
      <el-form-item label="密码" prop="password" class="required-star">
        <el-input 
          type="password"
          show-password 
          v-model="form.password" 
          placeholder="8-20位字符"
          clearable>
          <template #prefix>
            <el-icon><Lock /></el-icon>
          </template>
        </el-input>
      </el-form-item>
      <el-form-item label="重复密码" prop="confirmPassword" class="required-star">
        <el-input 
          type="password"
          show-password 
          v-model="form.confirmPassword"  
          placeholder="请再次输入密码"
          clearable>
          <template #prefix>
            <el-icon><Lock /></el-icon>
          </template>
        </el-input>
      </el-form-item>
 
      <!-- 身份信息 -->
      <el-form-item label="真实姓名" prop="real_name" class="required-star">
        <el-input 
          v-model="form.real_name" 
          placeholder="2-10位中文"
          clearable>
          <template #prefix>
            <el-icon><EditPen /></el-icon>
          </template>
        </el-input>
      </el-form-item>
 
      <!-- 身份证验证 -->
      <el-form-item label="身份证号" prop="id_card" class="required-star">
        <el-input 
          v-model="form.id_card" 
          maxlength="18"
          placeholder="18位有效身份证"
          clearable 
          @blur="calculateGenderBirth">
          <template #prefix>
            <el-icon><Document /></el-icon>
          </template>
        </el-input>
      </el-form-item>
 
      <!-- 自动生成字段 -->
      <el-form-item label="出生日期" prop="birthday">
        <el-input v-model="form.birthday"  readonly/>
      </el-form-item>
      <el-form-item label="性别" prop="gender">
        <el-input v-model="form.gender"  readonly/>
      </el-form-item>
 
      <!-- 组织信息 -->
      <el-form-item label="所属科室" prop="dept_id" class="required-star">
        <el-select 
          v-model="form.dept_id" 
          placeholder="请选择科室"
          filterable 
          clearable>
          <el-option 
            v-for="dept in departments"
            :key="dept.dept_id" 
            :label="dept.dept_name" 
            :value="dept.dept_id"/> 
        </el-select>
      </el-form-item>
 
      <!-- 岗位信息 -->
      <el-form-item label="岗位名称" prop="post" class="required-star">
        <el-input 
          v-model="form.post" 
          placeholder="格式：科室 - 职称"
          clearable>
          <template #prefix>
            <el-icon><Briefcase /></el-icon>
          </template>
        </el-input>
      </el-form-item>
 
      <!-- 职称信息 -->
      <el-form-item label="职称" prop="title" class="required-star">
        <el-select 
          v-model="form.title" 
          placeholder="请选择职称"
          filterable 
          clearable>
          <el-option 
            v-for="item in ['主任医师', '副主任医师', '主治医师', '住院医师']"
            :key="item"
            :label="item"
            :value="item"/>
        </el-select>
      </el-form-item>
 
      <!-- 政治面貌 -->
      <el-form-item label="政治面貌" prop="is_party_member" class="required-star">
        <el-radio-group v-model="form.is_party_member"  @change="handlePartyChange">
          <el-radio :value="true" border>中共党员</el-radio>
          <el-radio :value="false" border>非党员</el-radio>
        </el-radio-group>
      </el-form-item>
 
      <!-- 动态党支部选择 -->
      <el-form-item 
        v-if="form.is_party_member" 
        label="所属党支部" 
        prop="party_branch"
        class="required-star">
        <el-select 
          v-model="form.party_branch" 
          placeholder="请选择支部"
          filterable 
          clearable 
          @focus="loadPartyBranches">
          <el-option 
            v-for="branch in partyBranches"
            :key="branch.branch_id" 
            :label="branch.branch_name" 
            :value="branch.branch_id"/> 
        </el-select>
      </el-form-item>
 
      <!-- 手机验证 -->
      <el-form-item label="手机号" prop="phone" class="required-star">
        <el-input 
          v-model="form.phone" 
          placeholder="11位有效号码"
          clearable>
          <template #append>
            <el-button 
              :disabled="smsDisabled" 
              @click="sendSmsCode"
              class="sms-btn">
              {{ smsBtnText }}
            </el-button>
          </template>
        </el-input>
      </el-form-item>
      <el-form-item label="验证码" prop="smsCode" class="required-star">
        <el-input 
          v-model="form.smsCode" 
          placeholder="6位数字验证码"
          maxlength="6"
          clearable>
          <template #prefix>
            <el-icon><Message /></el-icon>
          </template>
        </el-input>
      </el-form-item>
 
      <el-form-item>
        <el-button type="primary" @click="submitForm">立即注册</el-button>
      </el-form-item>
    </el-form>
    </div>
  </div>
</template>
 
<script setup>
import { ref, reactive, onMounted, computed,getCurrentInstance } from 'vue'
import { ElMessage } from 'element-plus'
import { User, Lock, Document, Briefcase, Message, EditPen } from '@element-plus/icons-vue'

const {proxy}=getCurrentInstance()

const getImageUrl = (user)=>{
    return new URL(`../assets/images/${user}.png`,import.meta.url).href
}
 
// 表单数据 
const form = reactive({
  username: '',
  password: '',
  confirmPassword: '',
  real_name: '',
  id_card: '',
  birthday: '无需手动改输入，根据身份证号码自动生成',
  gender: '无需手动改输入，根据身份证号码自动生成',
  dept_id: '',
  post: '',
  title: '',
  is_party_member: null,
  party_branch: '',
  phone: '',
  smsCode: ''
})
 
// 验证规则 
const rules = reactive({
  username: [
    { required: true, message: '必填项', trigger: 'blur' },
    { pattern: /^[A-Za-z0-9]{6,20}$/, message: '6-20位字母数字' }
  ],
  password: [
    { required: true, message: '必填项', trigger: 'blur' },
    { min: 8, max: 20, message: '8-20位字符' }
  ],
  confirmPassword: [
    { 
      validator: (_, v, cb) => {
        if(v !== form.password)  cb(new Error('两次输入密码不一致'))
        else cb()
      },
      trigger: 'blur' 
    },
    { required: true, message: '必须确认密码' }
  ],
  real_name: [
    { required: true, message: '必填项', trigger: 'blur' },
    { pattern: /^[\u4e00-\u9fa5]{2,10}$/, message: '2-10位中文' }
  ],
  id_card: [
    { required: true, message: '必填项', trigger: 'blur' },
    { validator: (_, v, cb) => {
      if(!/^\d{17}[\dX]$/i.test(v))  cb('请输入正确的身份证号码')
      else cb()
    }}
  ],
  dept_id: [
    { required: true, message: '请选择科室', trigger: 'change' }
  ],
  post: [
    { required: true, message: '必填项', trigger: 'blur' },
    { pattern: /^.{5,30}$/, message: '5-30位字符' }
  ],
  title: [
    { required: true, message: '请选择职称', trigger: 'change' }
  ],
  is_party_member: [
    { required: true, message: '请选择政治面貌', trigger: 'change' }
  ],
  party_branch: [
    { required: true, message: '党员必须选择支部', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '必填项', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '手机号格式错误' }
  ],
  smsCode: [
    { required: true, message: '必填项', trigger: 'blur' },
    { pattern: /^\d{6}$/, message: '6位数字' }
  ]
})
 
// 短信验证码逻辑 
const smsCountdown = ref(0)
const smsDisabled = ref(false)
const smsBtnText = computed(() => smsCountdown.value  > 0 ? `${smsCountdown.value}s  后重发` : '获取验证码')
 
const sendSmsCode = async () => {
  try {
    if (!/^1[3-9]\d{9}$/.test(form.phone))  {
      return ElMessage.warning(' 请输入有效手机号')
    }
 
    // 调用短信接口（需替换实际API）
    await axios.post('/api/send-sms',  {
      phone: form.phone, 
      scene: 'register'
    })
 
    smsCountdown.value  = 60 
    const timer = setInterval(() => {
      smsCountdown.value-- 
      if (smsCountdown.value  <= 0) {
        clearInterval(timer)
        smsDisabled.value  = false 
      }
    }, 1000)
 
    ElMessage.success(' 验证码已发送')
  } catch (e) {
    ElMessage.error(e.response?.data?.message  || '发送失败')
  } finally {
    smsDisabled.value  = true 
  }
}
 
// 身份证处理 
const calculateGenderBirth = () => {
  const idCard = form.id_card.toUpperCase() 
  if (!/^\d{17}[\dX]$/.test(idCard)) {
    form.birthday  = ''
    form.gender  = ''
    return 
  }
 
  const birthYear = idCard.slice(6,  10)
  const birthMonth = idCard.slice(10,  12)
  const birthDay = idCard.slice(12,  14)
  form.birthday  = `${birthYear}-${birthMonth}-${birthDay}` 
 
  const genderCode = parseInt(idCard.charAt(16)) 
  form.gender  = genderCode % 2 === 1 ? '男' : '女'
}
 
// 组织数据 
const departments = ref([])
const partyBranches = ref([])
 
onMounted(async () => {
  try {
    // 加载科室数据（需替换实际API）
    const res = await proxy.$api.getdepartments() 
    departments.value  = res
  } catch (e) {
    ElMessage.error(' 科室加载失败')
  }
})
 
// 党支部加载 
const loadPartyBranches = async () => {
  try {
    if (partyBranches.value.length  > 0) return 
    // 加载党支部数据（需替换实际API）
    const { data } = await axios.get('/api/party-branches') 
    partyBranches.value  = data 
  } catch (e) {
    ElMessage.error(' 支部加载失败')
  }
}
 
// 表单提交 
const submitForm = async () => {
  try {
    // 执行表单验证 
    await formRef.value.validate() 
    
    // 提交注册（需替换实际API）
    await axios.post('/api/register',  {
      ...form,
      sms_code: form.smsCode  
    })
    
    ElMessage.success(' 注册成功')
  } catch (e) {
    ElMessage.error(e.response?.data?.message  || '注册失败')
  }
}
 
// 其他方法 
const checkUsernameExists = async () => {
  if (!form.username)  return 
  try {
    // const { data } = await axios.get(`/api/check-username?name=${form.username}`) 
    // if (data.exists)  ElMessage.warning(' 用户名已存在')
  } catch (e) {
    console.error(e) 
  }
}
 
const handlePartyChange = (isMember) => {
  if (!isMember) form.party_branch  = ''
}
</script>
 
<style scoped>
/* ========== 全局布局 ========== */
.page-root {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
  background: #f5f7fa;
  scrollbar-width: thin;
  scrollbar-color: rgba(29,59,97,0.2) transparent;
  background: linear-gradient(15deg, 
    rgba(245,251,255,1) 0%,  /* 顶部保持浅色背景 */
    rgba(225,238,255,0.8) 30%,  /* 中间淡蓝过渡 */
    rgba(199,222,255,0.6) 100%  /* 底部加强医疗蓝 */
  );
  background-attachment: fixed; /* 增强渐变稳定性 */
}
 
/* ========== 头部区域 ========== */
.card-header {
  flex: 0 0 auto;
  position: sticky;
  top: 0;
  background: white;
  z-index: 1000;
  padding: 12px 0;
  backdrop-filter: blur(5px);
  background: linear-gradient(145deg, 
    #2a5c9c 20%,  /* 深医院蓝 */
    #1d4a8a 80%   /* 夜色蓝 */
  );
  border-bottom: none;
  box-shadow: 0 2px 8px rgba(29,75,138,0.15);
}
 
.header-body {
  max-width: 1100px;
  margin: 0 auto;
  padding: 0 20px;
}
 
.header-title .main {
  font: 500 22px/1.5 'Microsoft YaHei';
  color: #e8f3ff !important;  /* 高亮白 */
  text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
  letter-spacing: 0.5px;
}
 
.header-title .sub {
  font-size: 13px;
  color: #b3d1ff !important; 
  letter-spacing: 1.2px;
}
 
/* ========== 表单容器 ========== */
.register-container {
  flex: 1;
  min-height: calc(100vh - 160px);
  overflow-y: visible;
  position: relative;
  max-width: 1100px;
  width: 92%;
  margin: 25px auto;
  padding: 50px 70px;
  background: linear-gradient(145deg, #ffffff 0%, #f8fbfe 100%);
  border-radius: 14px;
  box-shadow: 
    0 6px 12px -2px rgba(50, 50, 93, 0.08),
    0 4px 6px -2px rgba(0, 0, 0, 0.06);
  border: 1px solid rgba(29, 59, 97, 0.08);
}
 
.el-form {
  max-height: 75vh;
  overflow-y: auto;
  padding-right: 15px;
  scrollbar-gutter: stable;
}
 
/* ========== 表单元素增强 ========== */
:deep(.el-form-item) {
  margin-bottom: 16px;
}
 
:deep(.el-form-item__label) {
  width: 140px !important;
  font-weight: 600;
  color: #2c3e50 !important;
  padding-right: 30px !important;
  padding-bottom: 4px !important;  /* 标签下移适配 */
}
 
:deep(.el-input__inner) {
  height: 34px !important;  /* 原46px降为38px（降幅17%） */
  line-height: 34px !important;
  padding: 0 15px;
  font-size: 14px;
  border-radius: 8px !important;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
 
:deep(.el-input__inner):focus {
  box-shadow: 0 0 0 3px rgba(47, 128, 237, 0.15);
}
 
:deep(.el-select) {
  width: 100%;
}
 
:deep(.el-radio-group) {
  gap: 35px;
}
 
/* ========== 响应式处理 ========== */
@media (min-width: 1600px) {
  .register-container {
    max-width: 1200px;
    padding: 60px 90px;
  }
  
  :deep(.el-form-item__label) {
    font-size: 16px !important;
  }
}
 
@media (max-width: 992px) {
  .register-container {
    width: 96%;
    padding: 40px;
  }
  
  :deep(.el-form-item__label) {
    width: 120px !important;
  }
}
 
@media (max-width: 768px) {
  .page-root {
    overflow-y: scroll;
  }
  
  .register-container {
    min-height: calc(100vh - 120px);
    margin: 10px;
    padding: 25px;
    border-radius: 12px;
  }
  
  :deep(.el-form-item__label) {
    width: 100% !important;
    margin-bottom: 8px !important;
  }
  
  .header-body {
    padding: 0 15px;
  }
  
  .header-title .main {
    font-size: 18px;
  }
}
 
/* ========== 滚动条美化 ========== */
.el-form::-webkit-scrollbar {
  width: 10px;
  background: rgba(29,59,97,0.05);
}
 
.el-form::-webkit-scrollbar-thumb {
  border-radius: 5px;
  background: rgba(29,59,97,0.2);
  border: 2px solid transparent;
  background-clip: content-box;
}
 
/* ========== 交互增强 ========== */
:deep(.el-icon) {
  color: var(--el-color-primary) !important;
  font-size: 19px;
  margin-right: 8px;
}
 
.el-button--primary {
  width: 100%;
  height: 48px;
  font-size: 16px;
  border-radius: 10px;
  transition: all 0.3s;
  margin-top: 15px;
}
 
.el-button--primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(47, 128, 237, 0.25);
}
 
/* ========== 医疗设备特殊适配 ========== */
@media (max-height: 700px) {
  .register-container {
    min-height: 580px;
    padding: 30px;
  }
  
  :deep(.el-form-item) {
    margin-bottom: 22px;
  }
}
 
@media (orientation: portrait) {
  .register-container {
    width: 94%;
    padding: 30px;
  }
}
</style>