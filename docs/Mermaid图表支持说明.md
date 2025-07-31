# Mermaid图表支持说明

## 📋 Mermaid图表能力概览

Mermaid是一种基于JavaScript的图表绘制工具，支持多种图表类型，特别适合在Markdown文档、GitHub、GitLab等平台中使用。

---

## 🎨 支持的Mermaid图表类型

### 1. 流程图 (Flowchart)

```mermaid
flowchart TD
    A[开始] --> B{是否登录?}
    B -->|是| C[进入主页]
    B -->|否| D[跳转登录页]
    D --> E[输入用户名密码]
    E --> F{验证成功?}
    F -->|是| C
    F -->|否| G[显示错误信息]
    G --> E
    C --> H[结束]
    
    style A fill:#e1f5fe
    style C fill:#e8f5e8
    style H fill:#fff3e0
    style G fill:#ffebee
```

### 2. 时序图 (Sequence Diagram)

```mermaid
sequenceDiagram
    participant U as 用户
    participant F as 前端
    participant G as API网关
    participant S as 用户服务
    participant D as 数据库
    
    U->>F: 1. 登录请求
    F->>G: 2. POST /api/auth/login
    G->>S: 3. 验证用户信息
    S->>D: 4. 查询用户数据
    D-->>S: 5. 返回用户信息
    S->>S: 6. 验证密码
    S->>S: 7. 生成JWT Token
    S-->>G: 8. 返回认证结果
    G-->>F: 9. 返回登录响应
    F-->>U: 10. 显示登录状态
    
    Note over S,D: 密码使用bcrypt加密
    Note over F,G: 使用HTTPS传输
```

### 3. 甘特图 (Gantt Chart)

```mermaid
gantt
    title 项目开发进度计划
    dateFormat  YYYY-MM-DD
    section 项目规划
    需求分析           :done,    des1, 2024-01-01,2024-01-15
    系统设计           :done,    des2, 2024-01-10,2024-01-30
    技术选型           :done,    des3, 2024-01-20,2024-02-05
    
    section 开发阶段
    数据库设计         :active,  dev1, 2024-02-01,2024-02-15
    后端API开发        :         dev2, 2024-02-10,2024-03-20
    前端界面开发       :         dev3, 2024-02-20,2024-03-25
    
    section 测试阶段
    单元测试           :         test1, 2024-03-15,2024-03-30
    集成测试           :         test2, 2024-03-25,2024-04-10
    用户验收测试       :         test3, 2024-04-05,2024-04-20
    
    section 部署上线
    环境准备           :         deploy1, 2024-04-10,2024-04-15
    生产部署           :         deploy2, 2024-04-15,2024-04-20
    监控运维           :         deploy3, 2024-04-20,2024-05-01
```

### 4. 类图 (Class Diagram)

```mermaid
classDiagram
    class User {
        -Long id
        -String username
        -String email
        -String password
        -UserStatus status
        -Date createdAt
        +login() boolean
        +logout() void
        +updateProfile() void
        +changePassword() boolean
    }
    
    class UserService {
        -UserRepository userRepository
        -PasswordEncoder passwordEncoder
        +createUser(User) User
        +findUserById(Long) User
        +findUserByUsername(String) User
        +updateUser(User) User
        +deleteUser(Long) void
        +validatePassword(String, String) boolean
    }
    
    class UserRepository {
        <<interface>>
        +save(User) User
        +findById(Long) Optional~User~
        +findByUsername(String) Optional~User~
        +findByEmail(String) Optional~User~
        +delete(Long) void
    }
    
    class UserController {
        -UserService userService
        +register(UserDto) ResponseEntity
        +login(LoginDto) ResponseEntity
        +getUserProfile(Long) ResponseEntity
        +updateProfile(Long, UserDto) ResponseEntity
    }
    
    class UserStatus {
        <<enumeration>>
        ACTIVE
        INACTIVE
        SUSPENDED
        PENDING
    }
    
    UserController --> UserService : uses
    UserService --> UserRepository : uses
    UserService --> User : manages
    User --> UserStatus : has
    User ||--o{ Order : "has many"
    
    class Order {
        -Long id
        -Long userId
        -BigDecimal amount
        -OrderStatus status
        -Date createdAt
    }
```

### 5. 状态图 (State Diagram)

```mermaid
stateDiagram-v2
    [*] --> 待支付
    
    待支付 --> 已支付 : 支付成功
    待支付 --> 已取消 : 超时/用户取消
    
    已支付 --> 已发货 : 商家发货
    已支付 --> 退款中 : 申请退款
    
    已发货 --> 运输中 : 快递揽收
    已发货 --> 退货中 : 申请退货
    
    运输中 --> 已送达 : 快递送达
    运输中 --> 退货中 : 运输异常
    
    已送达 --> 已完成 : 用户确认
    已送达 --> 退货中 : 申请退货
    
    退货中 --> 已退款 : 退货成功
    退货中 --> 已发货 : 退货失败
    
    已完成 --> [*]
    已取消 --> [*]
    已退款 --> [*]
    
    note right of 待支付 : 订单创建后15分钟内需要支付
    note right of 已发货 : 商家确认发货，生成物流信息
    note right of 已完成 : 系统自动确认或用户手动确认
```

### 6. 实体关系图 (ER Diagram)

```mermaid
erDiagram
    USER ||--o{ ORDER : "places"
    USER {
        bigint id PK
        varchar username UK
        varchar email UK
        varchar password
        enum status
        timestamp created_at
        timestamp updated_at
    }
    
    ORDER ||--|{ ORDER_ITEM : "contains"
    ORDER {
        bigint id PK
        bigint user_id FK
        decimal total_amount
        enum status
        varchar shipping_address
        timestamp created_at
        timestamp updated_at
    }
    
    ORDER_ITEM ||--|| PRODUCT : "references"
    ORDER_ITEM {
        bigint id PK
        bigint order_id FK
        bigint product_id FK
        int quantity
        decimal unit_price
        decimal subtotal
    }
    
    PRODUCT ||--o{ PRODUCT_CATEGORY : "belongs_to"
    PRODUCT {
        bigint id PK
        varchar name
        text description
        decimal price
        int stock_quantity
        bigint category_id FK
        enum status
        timestamp created_at
        timestamp updated_at
    }
    
    PRODUCT_CATEGORY {
        bigint id PK
        varchar name
        text description
        bigint parent_id FK
        int sort_order
        enum status
        timestamp created_at
    }
    
    USER ||--o{ USER_ADDRESS : "has"
    USER_ADDRESS {
        bigint id PK
        bigint user_id FK
        varchar name
        varchar phone
        varchar address
        boolean is_default
        timestamp created_at
    }
```

### 7. 用户旅程图 (User Journey)

```mermaid
journey
    title 用户购物旅程
    section 发现阶段
      搜索商品         : 5: 用户
      浏览商品详情     : 4: 用户
      查看用户评价     : 3: 用户
      比较价格         : 3: 用户
    section 考虑阶段
      加入购物车       : 4: 用户
      查看购物车       : 3: 用户
      计算运费         : 2: 用户
      使用优惠券       : 4: 用户
    section 购买阶段
      确认订单信息     : 3: 用户
      选择支付方式     : 4: 用户
      完成支付         : 5: 用户
      收到确认邮件     : 4: 用户
    section 售后阶段
      跟踪物流信息     : 4: 用户
      收货确认         : 5: 用户
      商品评价         : 3: 用户
      申请售后         : 2: 用户
```

### 8. Git流程图 (Git Graph)

```mermaid
gitgraph
    commit id: "初始提交"
    branch develop
    checkout develop
    commit id: "基础框架"
    commit id: "用户模块"
    branch feature/order
    checkout feature/order
    commit id: "订单模型"
    commit id: "订单API"
    checkout develop
    merge feature/order
    commit id: "集成测试"
    checkout main
    merge develop
    commit id: "v1.0.0"
    branch hotfix/payment
    checkout hotfix/payment
    commit id: "修复支付bug"
    checkout main
    merge hotfix/payment
    commit id: "v1.0.1"
    checkout develop
    merge main
    branch feature/notification
    checkout feature/notification
    commit id: "通知服务"
    commit id: "邮件模板"
    checkout develop
    merge feature/notification
    commit id: "功能测试"
    checkout main
    merge develop
    commit id: "v1.1.0"
```

### 9. 饼图 (Pie Chart)

```mermaid
pie title 系统资源使用分布
    "数据库" : 35
    "应用服务" : 25
    "缓存服务" : 15
    "文件存储" : 12
    "监控日志" : 8
    "其他服务" : 5
```

### 10. 象限图 (Quadrant Chart)

```mermaid
quadrantChart
    title 产品功能优先级矩阵
    x-axis 低实现难度 --> 高实现难度
    y-axis 低业务价值 --> 高业务价值
    quadrant-1 优先实现
    quadrant-2 考虑实现
    quadrant-3 暂缓实现
    quadrant-4 不建议实现
    
    用户登录: [0.2, 0.9]
    商品搜索: [0.3, 0.8]
    订单管理: [0.4, 0.9]
    支付集成: [0.7, 0.8]
    社交分享: [0.6, 0.3]
    AI推荐: [0.9, 0.7]
    数据分析: [0.8, 0.6]
    多语言: [0.7, 0.4]
```

### 11. 时间线图 (Timeline)

```mermaid
timeline
    title 产品发展历程
    
    2023Q1 : 项目启动
           : 市场调研
           : 技术选型
    
    2023Q2 : 原型设计
           : MVP开发
           : 内测启动
    
    2023Q3 : 公测版本
           : 用户反馈
           : 功能优化
    
    2023Q4 : 正式发布
           : 营销推广
           : 版本迭代
    
    2024Q1 : 功能扩展
           : 性能优化
           : 用户增长
    
    2024Q2 : 移动端发布
           : API开放
           : 合作伙伴
```

### 12. 架构图 (C4 Model)

```mermaid
C4Context
    title 系统上下文图
    
    Person(customer, "顾客", "购买商品的用户")
    Person(admin, "管理员", "管理系统的用户")
    
    System(ecommerce, "电商系统", "在线购物平台")
    
    System_Ext(payment, "支付系统", "第三方支付平台")
    System_Ext(logistics, "物流系统", "快递物流服务")
    System_Ext(email, "邮件系统", "邮件发送服务")
    
    Rel(customer, ecommerce, "浏览商品、下单购买")
    Rel(admin, ecommerce, "管理商品、订单")
    Rel(ecommerce, payment, "处理支付")
    Rel(ecommerce, logistics, "查询物流")
    Rel(ecommerce, email, "发送邮件")
```

---

## 🎨 Mermaid图表样式定制

### 主题设置

```mermaid
%%{init: {'theme':'base', 'themeVariables': {'primaryColor':'#ff0000', 'primaryTextColor':'#fff', 'primaryBorderColor':'#7C0000', 'lineColor':'#F8B229', 'secondaryColor':'#006100', 'tertiaryColor':'#fff'}}}%%

flowchart TD
    A[自定义主题示例] --> B[红色主色调]
    B --> C[黄色连接线]
    C --> D[绿色次要颜色]
```

### 自定义样式

```mermaid
flowchart LR
    A[开始] --> B[处理]
    B --> C[结束]
    
    classDef startEnd fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    classDef process fill:#e8f5e8,stroke:#2e7d32,stroke-width:2px
    
    class A,C startEnd
    class B process
```

---

## 💡 Mermaid图表最佳实践

### ✅ 推荐做法

1. **简洁明了** - 避免过于复杂的图表
2. **一致性** - 保持命名和样式的一致
3. **合理布局** - 使用适当的方向和间距
4. **颜色搭配** - 使用专业的配色方案
5. **文档化** - 为图表添加说明和注释

### 📋 图表选择指南

| 使用场景 | 推荐图表类型 | 优势 |
|----------|--------------|------|
| **业务流程** | 流程图 | 清晰展示步骤和决策点 |
| **系统交互** | 时序图 | 显示时间顺序和消息传递 |
| **项目管理** | 甘特图 | 可视化项目进度和依赖 |
| **数据模型** | 类图/ER图 | 展示实体关系和结构 |
| **状态变化** | 状态图 | 清晰显示状态转换 |
| **数据分布** | 饼图 | 直观显示比例关系 |
| **系统架构** | C4图 | 分层展示系统结构 |

### 🔧 工具支持

Mermaid图表支持多种平台：

- ✅ **GitHub/GitLab** - 原生支持
- ✅ **VS Code** - 扩展插件
- ✅ **Notion** - 代码块支持
- ✅ **Markdown编辑器** - 大部分支持
- ✅ **在线编辑器** - mermaid.live

---

## 🚀 使用示例

### 在Markdown中使用

````markdown
```mermaid
flowchart TD
    A[开始] --> B[处理]
    B --> C[结束]
```
````

### 在HTML中使用

```html
<div class="mermaid">
flowchart TD
    A[开始] --> B[处理]
    B --> C[结束]
</div>

<script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
<script>mermaid.initialize({startOnLoad:true});</script>
```

---

## 📚 相关文档

- [PlantUML图表对比](图表类型展示.md#plantuml图表类型)
- [SVG图表支持](SVG图表支持说明.md)
- [系统架构图模板](系统架构图模板.md)

---

**创建时间**：2025年7月15日  
**更新时间**：2025年7月15日  
**版本号**：v1.0
