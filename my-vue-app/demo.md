sequenceDiagram 
    participant 前端 
    participant 后端 
    participant Redis 
    
    前端->>后端: 1. 提交refresh_token 
    后端->>JWT: 2. 验证签名/有效期 
    后端->>Redis: 3. 检查令牌一致性 
    Redis-->>后端: 返回存储的令牌数据 
    后端->>后端: 4. 设备指纹比对 
    后端->>JWT: 5. 生成新双令牌 
    后端->>Redis: 6. 更新令牌存储 
    Redis-->>后端: 操作确认 
    后端-->>前端: 7. 返回新令牌 
    前端->>前端: 8. 更新本地存储