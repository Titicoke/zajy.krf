import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
  server: {
    proxy: {
      '/api': {
        target: 'http://www.zajy.krf', 
        changeOrigin: true,
        rewrite: path => path.replace(/^\/api/,  '')
      }
    }
  },
  plugins: [vue()],
  //添加的别名
  resolve:{
    alias:{
      "@":"/src"
    }
  }
})
