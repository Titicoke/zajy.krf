export default {
    getTableData: () => {
      return {
        code: 200,
        data: {
          tableData: [
            {
              name: "交通岗执勤",
              todayBuy: 20,
              monthBuy: 19,
              totalBuy: "2025-4-18",
            },
            {
              name: "导诊",
              todayBuy: 25,
              monthBuy: 21,
              totalBuy: "2025-5-1",
            },
            {
              name: "交通",
              todayBuy: 80,
              monthBuy: 49,
              totalBuy: "2025-5-11",
            },
            {
              name: "导诊",
              todayBuy: 15,
              monthBuy: 12,
              totalBuy: "2025-5-15",
            },
          ],
        },
      }
    },
    getCountData: () => {
      return {
        code: 200,
        data: [
          {
            name: "上月活动数量",
            value: 32,
            icon: "SuccessFilled",
            color: "#2ec7c9",
          },
          {
            name: "上月积分发放",
            value: 210,
            icon: "StarFilled",
            color: "#ffb980",
          },
          {
            name: "上月积分回收",
            value: 1234,
            icon: "GoodsFilled",
            color: "#5ab1ef",
          },
          {
            name: "本月活动数量",
            value: 1234,
            icon: "SuccessFilled",
            color: "#2ec7c9",
          },
          {
            name: "本月发放积分",
            value: 236,
            icon: "StarFilled",
            color: "#ffb980",
          },
          {
            name: "本月积分回收",
            value: 1152,
            icon: "GoodsFilled",
            color: "#5ab1ef",
          },
        ],
      };
    },
    getChartData: () => {
      return {
        code: 200,
        data: {         
          userData: [
            { date: "神经内科党支部", new: 12, active: 25 },
            { date: "心血管内科党支部", new: 15, active: 30 },
            { date: "骨科党支部", new: 18, active: 35 },
            { date: "消化内科党支部", new: 20, active: 40 },
            { date: "呼吸与危重症医学科党支部", new: 22, active: 45 },
            { date: "普通外科党支部", new: 25, active: 50 },
            { date: "儿科党支部", new: 10, active: 20 },
            { date: "妇产科党支部", new: 13, active: 26 },
            { date: "麻醉手术科党支部", new: 16, active: 32 },
            { date: "急诊重症科党支部", new: 19, active: 38 },
            { date: "内科综合第一党支部", new: 21, active: 42 },
            { date: "内科综合第二党支部", new: 23, active: 46 },
            { date: "内科综合第三党支部", new: 24, active: 48 },
            { date: "内科综合第四党支部", new: 26, active: 52 },
            { date: "外科综合第一党支部", new: 27, active: 54 },
            { date: "外科综合第二党支部", new: 28, active: 56 },
            { date: "医技第一党支部", new: 14, active: 28 },
            { date: "医技第二党支部", new: 17, active: 34 },
            { date: "医技第三党支部", new: 20, active: 40 },
            { date: "职能第一党支部", new: 11, active: 22 },
            { date: "职能第二党支部", new: 13, active: 26 },
            { date: "职能第三党支部", new: 15, active: 30 },
            { date: "离退休第一党支部", new: 8, active: 16 },
            { date: "离退休第二党支部", new: 9, active: 18 }
        ],
        },
      };
    }
  }