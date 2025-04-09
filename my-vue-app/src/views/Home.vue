<template>
  <el-row class="home" :gutter="24">
    <el-col :span="8" style="margin-top: 20px; height: 80vh; overflow-y: auto;">    
      <el-card shadow="hover">
        <div class="user">
          <img :src="getImageUrl('user')"  class="user" />
          <div class="user-info">
            <p class="user-info-admin">Admin</p>
            <p>管理员</p>
          </div>
        </div>
        <div class="login-info">
          <p>上次登录时间:<span>2025-4-8</span></p>
          <p>上次登录地点:<span>晋城</span></p>
        </div>
      </el-card>
        
      <el-card shadow="hover" class="table" >          
        <el-table :data="tableData">
          <el-table-column
            v-for="(val, key) in tableLabel"
            :key="key"
            :prop="key"
            :label="val"
          >
          </el-table-column>
        </el-table>          
      </el-card>
    </el-col>

    <el-col :span="16" style="margin-top: 20px; height: 80vh; overflow-y: auto;">   
      <div class="num">
        <el-card
          :body-style="{display:'flex',padding:0}"
          v-for="item in countData"
          :key="item.name"
          >
          <component :is="item.icon" class="icons" :style="{background:item.color}"></component>
          <div class="detail">
            <p class="num">{{item.value}}</p>
            <p class="txt">{{item.name}}</p>
          </div>
        </el-card>
      </div>
      
      <el-card class="top-echart">
        <div ref="userEchart" style="height: 350px;"></div>
      </el-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { ref, getCurrentInstance, onMounted, reactive } from 'vue'
import * as echarts from 'echarts'

const tableData = ref([])
const countData = ref([])
const observer = ref(null)
const tableLabel = ref({
    name: "活动名称",
    todayBuy: "发布岗位数",
    monthBuy: "已报名人数",
    totalBuy: "活动时间",
})

// 柱状图的公共配置
const xOptions = reactive({
      // 图例文字颜色
      textStyle: {
        color: "#333",
      },
      legend: {},
      grid: {
        left: "5%",
        right: "3%",
        bottom:"50%",
      },
      // 提示框
      tooltip: {
        trigger: "axis",
      },
      xAxis: {
        type: "category", // 类目轴
        data: [],
        axisLine: {
          lineStyle: {
            color: "#17b3a3",
          },
        },
        axisLabel: {
          interval: 0,
          color: "#333",
          formatter: function (value) {            
            return value.split('').join('\n');
          }
        },
      },
      yAxis: [
        {
          type: "value",
          axisLine: {
            lineStyle: {
              color: "#17b3a3",
            },
          },
        },
      ],
      color: ["#2ec7c9", "#b6a2de", "#5ab1ef", "#ffb980", "#d87a80", "#8d98b3"],
      series: [],
})

const { proxy } = getCurrentInstance()

const getTableData = async () => {
  let res = await proxy.$api.getTableData()
  tableData.value = res.data.data.tableData
}

const getCountData = async () => {
  let res = await proxy.$api.getCountData()
  countData.value = res.data.data
}

const getChartData = async () => {
  let res = await proxy.$api.getChartData()
  const { userData } = res.data.data

  // 对柱状图进行渲染
  xOptions.xAxis.data = userData.map(item => item.date)
  xOptions.series = [
    {
      name: "已注册用户",
      data: userData.map(item => item.new),
      type: 'bar'
    },
    {
      name: "应注册用户",
      data: userData.map(item => item.active),
      type: 'bar'
    },
  ]

  const twoEchart = echarts.init(proxy.$refs['userEchart'])
  twoEchart.setOption(xOptions)

  // 监听页面的变化
  observer.value = new ResizeObserver((en) => {
    twoEchart.resize()
  })

  // 检测容器是否存在
  if (proxy.$refs['userEchart']) {
      observer.value.observe(proxy.$refs['userEchart'])
  }
}

onMounted(() => {
  getTableData()
  getCountData()
  getChartData()
})

const getImageUrl = (user) => {
    return new URL(`../assets/images/${user}.png`, import.meta.url).href
}
</script>

<style lang="less" scoped >
.home {
    height: 100%;
    overflow: hidden;
    .user {
    display: flex;
    align-items: center;
    border-bottom: 1px solid #ccc;
    margin-bottom: 20px;
    img {
      width: 150px;
      height: 150px;
      border-radius: 50%;
      margin-right: 40px;
    }
  }
  .login-info {
    p {
      line-height: 30px;
      font-size: 14px;
      color: #999;
      span {
        color: #666;
        margin-left: 60px;
      }
    }
  }
  .table{
    margin-top: 20px;
  }
  .num {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    .el-card {
      width: 32%;
      margin-bottom: 20px;
    }
    .icons {
      width: 80px;
      height: 80px;
      font-size: 30px;
      text-align: center;
      line-height: 80px;
      color: #fff;
    }
    .detail {
      margin-left: 15px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      .num {
        font-size: 30px;
        margin-bottom: 10px;
      }
      .txt {
        font-size: 14px;
        text-align: center;
        color: #999;
      }
    }
  }
  .top-echart{
    height: 350px
  }
}
</style>    