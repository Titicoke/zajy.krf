<template>
  <div class="page-root">
    <div class="card-header">
      <div class="header-body">
        <el-row align="middle" :gutter="20">
          <el-col :span="4">
            <el-image :src="getImageUrl('zyz')" fit="contain" style="height:55px"></el-image>
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
        <el-form-item label="用户名" prop="username" :data-prop="'username'" class="required-star">
          <el-input
            v-model="form.username"
            placeholder="请输入6 - 20位字母或数字"
            clearable
            @input="handleUsernameInput"
            @blur="checkUsernameExists"
          >
            <template #prefix>
              <el-icon><User /></el-icon>
            </template>
          </el-input>
          <div v-if="usernameCheckMessage" :class="{'text-success': isUsernameAvailable, 'text-error':!isUsernameAvailable}">
            {{ usernameCheckMessage }}
          </div>
        </el-form-item>
        <!-- 密码 -->
        <el-form-item label="密码" prop="password" :data-prop="'password'" class="required-star">
          <el-input
            type="password"
            show-password
            v-model="form.password"
            placeholder="请输入8 - 20位字符"
            clearable
            autocomplete="new-password"
          >
            <template #prefix>
              <el-icon><Lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item label="重复密码" prop="confirmPassword" :data-prop="'confirmPassword'" class="required-star">
          <el-input
            type="password"
            show-password
            v-model="form.confirmPassword"
            placeholder="请再次输入相同密码"
            clearable
          >
            <template #prefix>
              <el-icon><Lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <!-- 身份信息 -->
        <el-form-item label="真实姓名" prop="real_name" :data-prop="'real_name'" class="required-star">
          <el-input
            v-model="form.real_name"
            placeholder="请输入2 - 10位中文姓名"
            clearable
          >
            <template #prefix>
              <el-icon><EditPen /></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <!-- 身份证验证 -->
        <el-form-item label="身份证号" prop="id_card" :data-prop="'id_card'" class="required-star">
          <el-input
            v-model="form.id_card"
            maxlength="18"
            placeholder="请输入18位有效身份证号"
            clearable
            @blur="calculateGenderBirth"
            @input="handleIDCardInput"
          >
            <template #prefix>
              <el-icon><Document /></el-icon>
            </template>
          </el-input>
          <div v-if="idCardCheckMessage" :class="{'text-success': isIdCardAvailable, 'text-error':!isIdCardAvailable}">
          {{ idCardCheckMessage }}
          </div>
        </el-form-item>
        <!-- 自动生成字段 -->
        <el-form-item label="出生日期" prop="birthday" :data-prop="'birthday'">
          <el-input v-model="form.birthday" readonly />
        </el-form-item>
        <el-form-item label="性别" prop="gender" :data-prop="'gender'">
          <el-input v-model="form.gender" readonly />
        </el-form-item>
        <!-- 组织信息 -->
        <el-form-item label="所属科室" prop="dept_id" :data-prop="'dept_id'" class="required-star">
          <el-select
            v-model="form.dept_id"
            placeholder="请选择所属科室"
            filterable
            clearable
             @change="loadPositions"
          >
            <el-option
              v-for="dept in departments"
              :key="dept.dept_id"
              :label="dept.dept_name"
              :value="dept.dept_id"
            />
          </el-select>
        </el-form-item>
        <!-- 岗位信息 -->
        <el-form-item label="岗位类别" prop="post_id" :data-prop="'post_id'" class="required-star">
          <el-select
            v-model="form.post_id"
            placeholder="请选择岗位类别"
            filterable
            clearable
          >
            <el-option
              v-for="position in positions"
              :key="position.position_id"
              :label="position.position_name"
              :value="position.position_id"
            />
          </el-select>
        </el-form-item>

        <!-- 职称信息 -->
        <el-form-item label="职称" prop="title" :data-prop="'title'" class="required-star">
          <el-select
            v-model="form.title"
            placeholder="请选择您的职称"
            filterable
            clearable
          >
            <el-option
              v-for="item in ['正高', '副高', '中级', '初级']"
              :key="item"
              :label="item"
              :value="item"
            />
          </el-select>
        </el-form-item>
        <!-- 政治面貌 -->
        <el-form-item label="政治面貌" prop="is_party_member" :data-prop="'is_party_member'" class="required-star">
          <el-radio-group v-model="form.is_party_member" @change="handlePartyChange">
            <el-radio :value="true" border>中共党员</el-radio>
            <el-radio :value="false" border>非党员</el-radio>
          </el-radio-group>
        </el-form-item>
        <!-- 动态党支部选择 -->
        <el-form-item
          v-if="form.is_party_member"
          label="所属党支部"
          prop="party_branch"
          class="required-star"
        >
          <el-select
            v-model="form.party_branch"
            placeholder="请选择所属党支部"
            filterable
            clearable
            @focus="loadPartyBranches"
          >
            <el-option
              v-for="branch in partyBranches"
              :key="branch.branch_id"
              :label="branch.branch_name"
              :value="branch.branch_id"
            />
          </el-select>
        </el-form-item>
        <!-- 手机验证 -->
        <el-form-item label="手机号" prop="phone" :data-prop="'phone'" class="required-star">
          <el-input
            v-model="form.phone"
            @input="validatePhone"
            placeholder="请输入11位有效手机号码"
            clearable
          >
            <template #append>
              <el-button :disabled="smsDisabled" @click="sendSmsCode" class="sms-btn">
                {{ smsBtnText }}
              </el-button>
            </template>
          </el-input>
          <div v-if="phoneCheckMessage" :class="{'text-success': isPhoneAvailable, 'text-error':!isPhoneAvailable}">
            {{ phoneCheckMessage }}
          </div>
        </el-form-item>
        <el-form-item label="验证码" prop="smsCode" :data-prop="'smsCode'" class="required-star">
          <el-input
            v-model="form.smsCode"
            placeholder="请输入6位数字验证码"
            maxlength="6"
            clearable
            @input="handleSmsCodeInput"
          >
            <template #prefix>
              <el-icon><Message /></el-icon>
            </template>
          </el-input>
          <div v-if="smsCodeCheckMessage" :class="{'text-success': isSmsCodeValid, 'text-error':!isSmsCodeValid}">
            {{ smsCodeCheckMessage }}
          </div>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm">立即注册</el-button>
        </el-form-item>
        <el-form-item>
          <el-button type="text" @click="goLogin" style="color: #409eff; text-decoration: underline;text-align:right;padding-left: 200px;">
            已有账户，前去登录
          </el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed, getCurrentInstance, nextTick } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';
import { User, Lock, Document, Briefcase, Message, EditPen } from '@element-plus/icons-vue';
import { useRouter } from 'vue-router';

const router = useRouter();

const goLogin = () => {
  router.push('/login');
};

const { proxy } = getCurrentInstance();

const getImageUrl = (user) => {
  return new URL(`../assets/images/${user}.png`, import.meta.url).href;
};

// 表单数据
const form = reactive({
  username: '',
  password: '',
  real_name: '',
  id_card: '',
  birthday: '无需手动输入，根据身份证号码自动生成',
  gender: '无需手动输入，根据身份证号码自动生成',
  dept_id: '',
  post_id: '',
  title: '',
  is_party_member: null,
  party_branch: '',
  phone: '',
  smsCode: ''
});

// 验证规则
const rules = reactive({
  username: [
    { required: true, message: '用户名是必填项，请输入', trigger: 'blur' },
    { pattern: /^[A-Za-z0-9]{6,20}$/, message: '用户名需为6 - 20位字母或数字' }
  ],
  password: [
    { required: true, message: '密码是必填项，请输入', trigger: 'blur' },
    { min: 8, max: 20, message: '密码长度应为8 - 20位字符' }
  ],
  confirmPassword: [
    {
      validator: (_, v, cb) => {
        if (!v) return cb(new Error('重复密码不能为空，请输入'));
        if (v !== form.password) return cb(new Error('两次输入的密码不一致，请重新输入'));
        cb();
      },
      trigger: ['blur', 'change']
    }
  ],
  real_name: [
    { required: true, message: '真实姓名是必填项，请输入', trigger: 'blur' },
    { pattern: /^[\u4e00-\u9fa5]{2,10}$/, message: '真实姓名需为2 - 10位中文' }
  ],
  id_card: [
    { required: true, message: '身份证号是必填项，请输入', trigger: 'blur' },
    {
      validator: (_, v, cb) => {
        if (!/^\d{17}[\dX]$/i.test(v)) {
          return cb(new Error('请输入正确格式的18位身份证号码'));
        }
        const idCard = v.toUpperCase();
        // 验证出生日期
        const birthYear = parseInt(idCard.slice(6, 10));
        const birthMonth = parseInt(idCard.slice(10, 12));
        const birthDay = parseInt(idCard.slice(12, 14));
        const date = new Date(birthYear, birthMonth - 1, birthDay);
        if (
          date.getFullYear()!== birthYear ||
          date.getMonth()!== birthMonth - 1 ||
          date.getDate()!== birthDay
        ) {
          return cb(new Error('身份证号码中的出生日期无效'));
        }
        // 验证校验位
        const factors = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
        const parityBits = ['1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'];
        let sum = 0;
        for (let i = 0; i < 17; i++) {
          sum += parseInt(idCard[i]) * factors[i];
        }
        const mod = sum % 11;
        if (idCard[17]!== parityBits[mod]) {
          return cb(new Error('身份证号码的校验位无效'));
        }
        cb();
      },
      trigger: 'blur'
    }
  ],
  dept_id: [
    { required: true, message: '请选择所属科室', trigger: 'change' }
  ],
  post_id: [
    { required: true, message: '请选择岗位名称', trigger: 'change' }
  ],
  title: [
    { required: true, message: '请选择您的职称', trigger: 'change' }
  ],
  is_party_member: [
    { required: true, message: '请选择您的政治面貌', trigger: 'change' }
  ],
  party_branch: [
    { required: true, message: '党员必须选择所属党支部', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '手机号是必填项，请输入', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入真实有效的11位手机号码' }
  ],
  smsCode: [
    { required: true, message: '验证码是必填项，请输入', trigger: 'blur' },
    { pattern: /^\d{6}$/, message: '验证码应为6位数字' }
  ]
});

// 短信验证码逻辑
const smsCountdown = ref(0);
const smsBtnText = computed(() => (smsCountdown.value > 0 ? `${smsCountdown.value}s  后可重新获取` : '获取验证码'));
const isPhoneValid = ref(false);
const smsDisabled = computed(() => smsCountdown.value > 0 || !isPhoneAvailable.value);

const validatePhone = () => {
  isPhoneValid.value = /^1[3-9]\d{9}$/.test(form.phone);
  if (isPhoneValid.value) {
    checkPhoneExists();
  } else {
    phoneCheckMessage.value = '';
    isPhoneAvailable.value = false; // 手机号格式不对时，设置为不可用
    smsDisabled.value = true; // 禁用获取验证码按钮
  }
};

const sendSmsCode = async () => {
  if (!isPhoneValid.value) {
    return ElMessage.warning('请输入有效的11位手机号码');
  }
  try {
    await proxy.$api.getSmsCode({ phone_number: form.phone });
    smsCountdown.value = 10;
    const timer = setInterval(() => {
      smsCountdown.value--;
      if (smsCountdown.value <= 0) {
        clearInterval(timer);
        smsDisabled.value = false;
      }
    }, 1000);
    ElMessage.success('验证码已成功发送，请查收');
  } catch (e) {
    ElMessage.error('验证码发送失败，请稍后重试');
  } finally {
    smsDisabled.value = true;
  }
};

// 验证码验证相关
const smsCodeCheckMessage = ref('');
const isSmsCodeValid = ref(false);
const isSmsVerified = ref(false);

const handleSmsCodeInput = async () => {
  if (form.smsCode.length === 6) {
    try {
      const res = await proxy.$api.checkSmsCode({ phone_number: form.phone, code: form.smsCode });
      if (res[0] === 1) {
        smsCodeCheckMessage.value = '✓  验证码验证通过';
        isSmsCodeValid.value = true;
        isSmsVerified.value = true;
      } else {
        smsCodeCheckMessage.value = '✖ 验证码输入错误，请重新输入';
        isSmsCodeValid.value = false;
      }
    } catch (e) {
      smsCodeCheckMessage.value = '验证码验证失败，请稍后重试';
      isSmsCodeValid.value = false;
    }
  } else {
    smsCodeCheckMessage.value = '';
  }
};

// 身份证处理
const calculateGenderBirth = () => {
  const idCard = form.id_card.toUpperCase();
  if (!/^\d{17}[\dX]$/.test(idCard)) {
    form.birthday = '';
    form.gender = '';
    return;
  }
  const birthYear = idCard.slice(6, 10);
  const birthMonth = idCard.slice(10, 12);
  const birthDay = idCard.slice(12, 14);
  form.birthday = `${birthYear}-${birthMonth}-${birthDay}`;
  const genderCode = parseInt(idCard.charAt(16));
  form.gender = genderCode % 2 === 1 ? '男' : '女';

    checkIdCardExists();

};

// 组织数据
const departments = ref([]);
const partyBranches = ref([]);

onMounted(async () => {
  try {
    const res = await proxy.$api.getdepartments();
    departments.value = res[0];
  } catch (e) {
    ElMessage.error('科室数据加载失败，请稍后重试');
  }
});

// 岗位列表
const positions = ref([]);

// 加载岗位列表
const loadPositions = async () => {
  const deptId = form.dept_id;
  if (deptId) {
    try {
      const res = await proxy.$api.getPositions( {
          dept_id: deptId
        });
      positions.value = res[0];
    } catch (error) {
      console.error('获取岗位列表失败:', error);
      ElMessage.error('获取岗位列表失败，请稍后重试');
    }
  } else {
    positions.value = [];
  }
};

// 党支部加载
const handlePartyChange = (isMember) => {
  if (!isMember) form.party_branch = '';
};

const loadPartyBranches = async () => {
  if (partyBranches.value.length > 0) return;
  try {
    const res = await proxy.$api.getpartyBranches();
    partyBranches.value = res[0];
  } catch (e) {
    ElMessage.error('党支部数据加载失败，请稍后重试');
  }
};

// 表单提交相关方法
const formRef = ref();

const submitForm = async () => {
  try {
  await formRef.value.validate();
  if (!isUsernameAvailable.value) {
    ElMessage.warning('该用户名已被使用，请选择其他用户名');
    focusErrorInput('username');
    return;
  }
  if (!isIdCardAvailable.value) {
      ElMessage.warning('该身份证号已被注册，请更换');
      focusErrorInput('id_card');
      return;
    }
  if (!isPhoneAvailable.value) {
    ElMessage.warning('该手机号已被注册，请更换');
    focusErrorInput('phone');
    return;
  }
  if (!isSmsCodeValid.value) {
    ElMessage.warning('请输入正确的验证码');
    focusErrorInput('smsCode');
    return;
  } 
  
  console.log(' 提交数据:', form);

  try {
    const res = await proxy.$api.saveUserReg({
    username: form.username,
    password: form.password,
    real_name: form.real_name,
    id_card: form.id_card,
    dept_id: form.dept_id,
    post_id: form.post_id,
    title: form.title,
    is_party_member: form.is_party_member,
    party_branch: form.party_branch,
    phone: form.phone,
    smsCode: form.smsCode
    });
    if (res[0] === 1) {
      // ElMessage.success('验证通过，正在为您注册...');
      // // 注册成功后可以跳转到登录页面或者其他页面
      // router.push('/login');
      ElMessageBox.alert('恭喜您，注册成功，点击确定进入登录界面。', '注册成功', {
          confirmButtonText: '确定',
          callback: () => {
            // 点击确定后跳转到登录页面
            router.push({
              path: '/login',
              query: {
                username: form.username,
                password: form.password
              }
            });
          }
        });
    } else {
      ElMessage.warning(res[1]);
    }
  } catch (e) {
    ElMessage.warning('未知错误，请稍后再试');
  }
    
  } catch (error) {
    const firstErrorField = Object.keys(error)[0];
    const firstErrorMessage = error[firstErrorField][0].message;
    if (firstErrorField) {
      await scrollToErrorField(firstErrorField);
      focusErrorInput(firstErrorField);
    }
    ElMessage.error(firstErrorMessage || '请完善所有必填信息');
  }
};

// 滚动定位优化
const scrollToErrorField = async (propName) => {
  await nextTick();
  const selector = `[data-prop="${propName}"]`;
  const element = document.querySelector(selector);
  if (element) {
    element.classList.add('error-highlight');
    setTimeout(() => element.classList.remove('error-highlight'), 2000);
    element.scrollIntoView({
      behavior: 'smooth',
      block: 'center'
    });
  }
};

// 聚焦逻辑增强
const focusErrorInput = (propName) => {
  nextTick(() => {
    const container = document.querySelector(`[data-prop="${propName}"]`);
    if (!container) return;
    const input = container.querySelector([
      'input:not([type="hidden"])',
      'textarea',
      '.el-select',
      '.el-radio-group'
    ].join(','));
    if (input) {
      if (input.classList.contains('el-select')) {
        input.querySelector('.el-input__inner').focus();
      } else {
        input.focus();
      }
    }
  });
};

// 验证用户名是否可用
const usernameCheckMessage = ref('');
const isUsernameAvailable = ref(false);

const checkUsernameExists = async () => {
  if (!/^[A-Za-z0-9]{6,20}$/.test(form.username)) {
    ElMessage.warning('用户名需为6 - 20位字母或数字，请重新输入');
    focusErrorInput('username');
    isUsernameAvailable.value = false;
    return;
  }
  try {
    const res = await proxy.$api.checkUsername({ username: form.username });
    if (res[0] === 1) {
      usernameCheckMessage.value = '✖ 该用户名已被占用，请选择其他用户名。';
      isUsernameAvailable.value = false;
      focusErrorInput('username');
    } else {
      usernameCheckMessage.value = '✓  用户名可用';
      isUsernameAvailable.value = true;
    }
  } catch (e) {
    usernameCheckMessage.value = '用户名验证失败，请稍后重试';
    isUsernameAvailable.value = false;
  }
};

const handleUsernameInput = () => {
  usernameCheckMessage.value = '';
};



// 新增身份证号验证相关变量
const isIdCardAvailable = ref(true);
const idCardCheckMessage = ref('');

// 新增手机号验证相关变量
const isPhoneAvailable = ref(true);
const phoneCheckMessage = ref('');

// 检查身份证号是否存在
const checkIdCardExists = async () => {
  const idCard = form.id_card;
  if (!idCard) return;
  try {
    const response = await proxy.$api.checkIdCardExists({ id_card: idCard });
    if (response[0]===1) {
      isIdCardAvailable.value = false;
      idCardCheckMessage.value = '该身份证号已被注册，请更换';
    } 
  } catch (error) {
    ElMessage.error('检查身份证号时出错，请稍后重试');
  }
};

const handleIDCardInput = () => {
  idCardCheckMessage.value = '';
  isIdCardAvailable.value = true; // 重置状态
};
// 检查手机号是否存在
const checkPhoneExists = async () => {
  const phone = form.phone;
  if (!phone) return;
  try {
    const response = await proxy.$api.checkPhoneExists({ phone: phone });
    if (response[0] === 1) {
      isPhoneAvailable.value = false;
      phoneCheckMessage.value = '该手机号已被注册，请更换';
      smsDisabled.value = true; // 手机号已被注册，禁用获取验证码按钮
    } else {
      isPhoneAvailable.value = true;
      phoneCheckMessage.value = '该手机号可用';
      smsDisabled.value = smsCountdown.value > 0 ? true : false; // 根据倒计时状态更新
    }
  } catch (error) {
    ElMessage.error('检查手机号时出错，请稍后重试');
    smsDisabled.value = true; // 检查出错时，禁用获取验证码按钮
  }
};

</script>

<style scoped>
/* 全局布局 */
.page-root {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
  background: linear-gradient(15deg,
      rgba(245, 251, 255, 1) 0%,
      rgba(225, 238, 255, 0.8) 30%,
      rgba(199, 222, 255, 0.6) 100%);
  background-attachment: fixed;
}

/* 头部区域 */
.card-header {
  flex: 0 0 auto;
  position: sticky;
  top: 0;
  background: linear-gradient(145deg,
      #2a5c9c 20%,
      #1d4a8a 80%);
  border-bottom: none;
  box-shadow: 0 2px 8px rgba(29, 75, 138, 0.15);
  padding: 12px 0;
  backdrop-filter: blur(5px);
  z-index: 1000;
}

.header-body {
  max-width: 1100px;
  margin: 0 auto;
  padding: 0 20px;
}

.header-title .main {
  font: 500 22px/1.5 'Microsoft YaHei';
  color: #e8f3ff;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
  letter-spacing: 0.5px;
}

.header-title .sub {
  font-size: 13px;
  color: #b3d1ff;
  letter-spacing: 1.2px;
}

/* 表单容器 */
.register-container {
  flex: 1;
  min-height: calc(100vh - 160px);
  max-width: 1100px;
  width: 92%;
  margin: 15px auto;
  padding: 40px 100px;
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

/* 表单元素增强 */
:deep(.el-form-item) {
  margin-bottom: 13px;
}

:deep(.el-form-item__label) {
  width: 140px !important;
  font-weight: 600;
  color: #2c3e50;
  padding-right: 30px !important;
  padding-bottom: 4px !important;
}

:deep(.el-input__inner) {
  height: 34px !important;
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

/* 响应式处理 */
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

/* 滚动条美化 */
.el-form::-webkit-scrollbar {
  width: 10px;
  background: rgba(29, 59, 97, 0.05);
}

.el-form::-webkit-scrollbar-thumb {
  border-radius: 5px;
  background: rgba(29, 59, 97, 0.2);
  border: 2px solid transparent;
  background-clip: content-box;
}

/* 交互增强 */
:deep(.el-icon) {
  color: var(--el-color-primary);
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

/* 医疗设备特殊适配 */
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

/* 验证码按钮可用状态样式 */
:deep(.sms-btn:not([disabled])) {
  color: #409EFF;
}

/* 禁用状态保持默认灰色 */
:deep(.sms-btn[disabled]) {
  color: var(--el-disabled-text-color);
}

/* 验证结果消息颜色 */
.text-success {
  color: green;
}

.text-error {
  color: red;
}
</style>    