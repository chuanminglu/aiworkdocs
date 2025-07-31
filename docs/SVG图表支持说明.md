# SVG图表支持说明

## 📋 SVG图表能力概览

我可以为您生成各种类型的SVG图表，包括手写SVG代码和通过PlantUML生成的SVG格式图表。

---

## 🎨 原生SVG图表示例

### 1. 简单饼图

```svg
<svg width="300" height="300" xmlns="http://www.w3.org/2000/svg">
  <!-- 背景圆 -->
  <circle cx="150" cy="150" r="100" fill="#f0f0f0" stroke="#ddd" stroke-width="2"/>
  
  <!-- 数据扇形 -->
  <!-- 40% - 蓝色 -->
  <path d="M 150 150 L 150 50 A 100 100 0 0 1 235.2 108.8 Z" fill="#4285f4" stroke="white" stroke-width="2"/>
  
  <!-- 30% - 绿色 -->
  <path d="M 150 150 L 235.2 108.8 A 100 100 0 0 1 235.2 191.2 Z" fill="#34a853" stroke="white" stroke-width="2"/>
  
  <!-- 20% - 橙色 -->
  <path d="M 150 150 L 235.2 191.2 A 100 100 0 0 1 108.8 235.2 Z" fill="#fbbc04" stroke="white" stroke-width="2"/>
  
  <!-- 10% - 红色 -->
  <path d="M 150 150 L 108.8 235.2 A 100 100 0 0 1 150 50 Z" fill="#ea4335" stroke="white" stroke-width="2"/>
  
  <!-- 图例 -->
  <text x="20" y="30" fill="#333" font-family="Arial" font-size="14" font-weight="bold">数据分布图</text>
  
  <!-- 图例项 -->
  <rect x="20" y="50" width="15" height="15" fill="#4285f4"/>
  <text x="45" y="62" fill="#333" font-family="Arial" font-size="12">服务A (40%)</text>
  
  <rect x="20" y="75" width="15" height="15" fill="#34a853"/>
  <text x="45" y="87" fill="#333" font-family="Arial" font-size="12">服务B (30%)</text>
  
  <rect x="20" y="100" width="15" height="15" fill="#fbbc04"/>
  <text x="45" y="112" fill="#333" font-family="Arial" font-size="12">服务C (20%)</text>
  
  <rect x="20" y="125" width="15" height="15" fill="#ea4335"/>
  <text x="45" y="137" fill="#333" font-family="Arial" font-size="12">服务D (10%)</text>
</svg>
```

### 2. 柱状图

```svg
<svg width="500" height="350" xmlns="http://www.w3.org/2000/svg">
  <!-- 背景 -->
  <rect width="500" height="350" fill="#fafafa"/>
  
  <!-- 标题 -->
  <text x="250" y="30" text-anchor="middle" fill="#333" font-family="Arial" font-size="18" font-weight="bold">
    月度销售数据统计
  </text>
  
  <!-- Y轴 -->
  <line x1="80" y1="50" x2="80" y2="280" stroke="#666" stroke-width="2"/>
  
  <!-- X轴 -->
  <line x1="80" y1="280" x2="450" y2="280" stroke="#666" stroke-width="2"/>
  
  <!-- Y轴刻度和标签 -->
  <line x1="75" y1="80" x2="85" y2="80" stroke="#666"/>
  <text x="70" y="85" text-anchor="end" fill="#666" font-family="Arial" font-size="12">100</text>
  
  <line x1="75" y1="130" x2="85" y2="130" stroke="#666"/>
  <text x="70" y="135" text-anchor="end" fill="#666" font-family="Arial" font-size="12">75</text>
  
  <line x1="75" y1="180" x2="85" y2="180" stroke="#666"/>
  <text x="70" y="185" text-anchor="end" fill="#666" font-family="Arial" font-size="12">50</text>
  
  <line x1="75" y1="230" x2="85" y2="230" stroke="#666"/>
  <text x="70" y="235" text-anchor="end" fill="#666" font-family="Arial" font-size="12">25</text>
  
  <text x="70" y="285" text-anchor="end" fill="#666" font-family="Arial" font-size="12">0</text>
  
  <!-- 数据柱 -->
  <!-- 1月: 85 -->
  <rect x="100" y="110" width="40" height="170" fill="#4285f4" opacity="0.8"/>
  <text x="120" y="300" text-anchor="middle" fill="#666" font-family="Arial" font-size="12">1月</text>
  <text x="120" y="105" text-anchor="middle" fill="#333" font-family="Arial" font-size="11">85</text>
  
  <!-- 2月: 72 -->
  <rect x="160" y="136" width="40" height="144" fill="#34a853" opacity="0.8"/>
  <text x="180" y="300" text-anchor="middle" fill="#666" font-family="Arial" font-size="12">2月</text>
  <text x="180" y="131" text-anchor="middle" fill="#333" font-family="Arial" font-size="11">72</text>
  
  <!-- 3月: 95 -->
  <rect x="220" y="90" width="40" height="190" fill="#fbbc04" opacity="0.8"/>
  <text x="240" y="300" text-anchor="middle" fill="#666" font-family="Arial" font-size="12">3月</text>
  <text x="240" y="85" text-anchor="middle" fill="#333" font-family="Arial" font-size="11">95</text>
  
  <!-- 4月: 63 -->
  <rect x="280" y="154" width="40" height="126" fill="#ea4335" opacity="0.8"/>
  <text x="300" y="300" text-anchor="middle" fill="#666" font-family="Arial" font-size="12">4月</text>
  <text x="300" y="149" text-anchor="middle" fill="#333" font-family="Arial" font-size="11">63</text>
  
  <!-- 5月: 88 -->
  <rect x="340" y="104" width="40" height="176" fill="#9c27b0" opacity="0.8"/>
  <text x="360" y="300" text-anchor="middle" fill="#666" font-family="Arial" font-size="12">5月</text>
  <text x="360" y="99" text-anchor="middle" fill="#333" font-family="Arial" font-size="11">88</text>
  
  <!-- 6月: 78 -->
  <rect x="400" y="124" width="40" height="156" fill="#ff9800" opacity="0.8"/>
  <text x="420" y="300" text-anchor="middle" fill="#666" font-family="Arial" font-size="12">6月</text>
  <text x="420" y="119" text-anchor="middle" fill="#333" font-family="Arial" font-size="11">78</text>
  
  <!-- 轴标签 -->
  <text x="265" y="330" text-anchor="middle" fill="#666" font-family="Arial" font-size="14">月份</text>
  <text x="30" y="170" text-anchor="middle" fill="#666" font-family="Arial" font-size="14" transform="rotate(-90, 30, 170)">销售额 (万元)</text>
</svg>
```

### 3. 折线图

```svg
<svg width="500" height="300" xmlns="http://www.w3.org/2000/svg">
  <!-- 背景 -->
  <rect width="500" height="300" fill="#fafafa"/>
  
  <!-- 标题 -->
  <text x="250" y="25" text-anchor="middle" fill="#333" font-family="Arial" font-size="16" font-weight="bold">
    系统性能趋势图
  </text>
  
  <!-- 坐标轴 -->
  <line x1="60" y1="40" x2="60" y2="220" stroke="#666" stroke-width="2"/>
  <line x1="60" y1="220" x2="440" y2="220" stroke="#666" stroke-width="2"/>
  
  <!-- Y轴刻度 -->
  <line x1="55" y1="60" x2="65" y2="60" stroke="#666"/>
  <text x="50" y="65" text-anchor="end" fill="#666" font-family="Arial" font-size="10">100%</text>
  
  <line x1="55" y1="100" x2="65" y2="100" stroke="#666"/>
  <text x="50" y="105" text-anchor="end" fill="#666" font-family="Arial" font-size="10">75%</text>
  
  <line x1="55" y1="140" x2="65" y2="140" stroke="#666"/>
  <text x="50" y="145" text-anchor="end" fill="#666" font-family="Arial" font-size="10">50%</text>
  
  <line x1="55" y1="180" x2="65" y2="180" stroke="#666"/>
  <text x="50" y="185" text-anchor="end" fill="#666" font-family="Arial" font-size="10">25%</text>
  
  <!-- X轴刻度 -->
  <text x="100" y="235" text-anchor="middle" fill="#666" font-family="Arial" font-size="10">00:00</text>
  <text x="160" y="235" text-anchor="middle" fill="#666" font-family="Arial" font-size="10">06:00</text>
  <text x="220" y="235" text-anchor="middle" fill="#666" font-family="Arial" font-size="10">12:00</text>
  <text x="280" y="235" text-anchor="middle" fill="#666" font-family="Arial" font-size="10">18:00</text>
  <text x="340" y="235" text-anchor="middle" fill="#666" font-family="Arial" font-size="10">24:00</text>
  
  <!-- 网格线 -->
  <defs>
    <pattern id="grid" width="40" height="40" patternUnits="userSpaceOnUse">
      <path d="M 40 0 L 0 0 0 40" fill="none" stroke="#e0e0e0" stroke-width="1"/>
    </pattern>
  </defs>
  <rect x="60" y="40" width="380" height="180" fill="url(#grid)"/>
  
  <!-- CPU使用率线 -->
  <polyline points="100,160 140,140 180,120 220,100 260,110 300,90 340,95"
            fill="none" stroke="#4285f4" stroke-width="3"/>
  
  <!-- 内存使用率线 -->
  <polyline points="100,180 140,170 180,160 220,150 260,155 300,145 340,150"
            fill="none" stroke="#34a853" stroke-width="3"/>
  
  <!-- 网络使用率线 -->
  <polyline points="100,200 140,190 180,185 220,175 260,180 300,170 340,175"
            fill="none" stroke="#ea4335" stroke-width="3"/>
  
  <!-- 数据点 -->
  <circle cx="100" cy="160" r="4" fill="#4285f4"/>
  <circle cx="140" cy="140" r="4" fill="#4285f4"/>
  <circle cx="180" cy="120" r="4" fill="#4285f4"/>
  <circle cx="220" cy="100" r="4" fill="#4285f4"/>
  <circle cx="260" cy="110" r="4" fill="#4285f4"/>
  <circle cx="300" cy="90" r="4" fill="#4285f4"/>
  <circle cx="340" cy="95" r="4" fill="#4285f4"/>
  
  <!-- 图例 -->
  <rect x="350" y="50" width="120" height="80" fill="white" stroke="#ddd" rx="5"/>
  
  <line x1="360" y1="65" x2="380" y2="65" stroke="#4285f4" stroke-width="3"/>
  <text x="385" y="69" fill="#333" font-family="Arial" font-size="12">CPU使用率</text>
  
  <line x1="360" y1="85" x2="380" y2="85" stroke="#34a853" stroke-width="3"/>
  <text x="385" y="89" fill="#333" font-family="Arial" font-size="12">内存使用率</text>
  
  <line x1="360" y1="105" x2="380" y2="105" stroke="#ea4335" stroke-width="3"/>
  <text x="385" y="109" fill="#333" font-family="Arial" font-size="12">网络使用率</text>
</svg>
```

### 4. 架构图

```svg
<svg width="600" height="400" xmlns="http://www.w3.org/2000/svg">
  <!-- 背景 -->
  <rect width="600" height="400" fill="#f8f9fa"/>
  
  <!-- 标题 -->
  <text x="300" y="30" text-anchor="middle" fill="#333" font-family="Arial" font-size="18" font-weight="bold">
    微服务架构图
  </text>
  
  <!-- 用户层 -->
  <rect x="50" y="60" width="100" height="60" fill="#e3f2fd" stroke="#1976d2" stroke-width="2" rx="5"/>
  <text x="100" y="85" text-anchor="middle" fill="#1976d2" font-family="Arial" font-size="12" font-weight="bold">用户界面</text>
  <text x="100" y="100" text-anchor="middle" fill="#1976d2" font-family="Arial" font-size="10">Web/Mobile</text>
  
  <!-- API网关 -->
  <rect x="250" y="60" width="100" height="60" fill="#f3e5f5" stroke="#7b1fa2" stroke-width="2" rx="5"/>
  <text x="300" y="85" text-anchor="middle" fill="#7b1fa2" font-family="Arial" font-size="12" font-weight="bold">API网关</text>
  <text x="300" y="100" text-anchor="middle" fill="#7b1fa2" font-family="Arial" font-size="10">Gateway</text>
  
  <!-- 负载均衡 -->
  <rect x="450" y="60" width="100" height="60" fill="#fff3e0" stroke="#f57c00" stroke-width="2" rx="5"/>
  <text x="500" y="85" text-anchor="middle" fill="#f57c00" font-family="Arial" font-size="12" font-weight="bold">负载均衡</text>
  <text x="500" y="100" text-anchor="middle" fill="#f57c00" font-family="Arial" font-size="10">Load Balancer</text>
  
  <!-- 微服务层 -->
  <rect x="50" y="170" width="90" height="50" fill="#e8f5e8" stroke="#388e3c" stroke-width="2" rx="5"/>
  <text x="95" y="190" text-anchor="middle" fill="#388e3c" font-family="Arial" font-size="11" font-weight="bold">用户服务</text>
  <text x="95" y="205" text-anchor="middle" fill="#388e3c" font-family="Arial" font-size="9">User Service</text>
  
  <rect x="160" y="170" width="90" height="50" fill="#e8f5e8" stroke="#388e3c" stroke-width="2" rx="5"/>
  <text x="205" y="190" text-anchor="middle" fill="#388e3c" font-family="Arial" font-size="11" font-weight="bold">订单服务</text>
  <text x="205" y="205" text-anchor="middle" fill="#388e3c" font-family="Arial" font-size="9">Order Service</text>
  
  <rect x="270" y="170" width="90" height="50" fill="#e8f5e8" stroke="#388e3c" stroke-width="2" rx="5"/>
  <text x="315" y="190" text-anchor="middle" fill="#388e3c" font-family="Arial" font-size="11" font-weight="bold">支付服务</text>
  <text x="315" y="205" text-anchor="middle" fill="#388e3c" font-family="Arial" font-size="9">Payment Service</text>
  
  <rect x="380" y="170" width="90" height="50" fill="#e8f5e8" stroke="#388e3c" stroke-width="2" rx="5"/>
  <text x="425" y="190" text-anchor="middle" fill="#388e3c" font-family="Arial" font-size="11" font-weight="bold">通知服务</text>
  <text x="425" y="205" text-anchor="middle" fill="#388e3c" font-family="Arial" font-size="9">Notify Service</text>
  
  <!-- 数据库层 -->
  <rect x="100" y="280" width="80" height="50" fill="#ffebee" stroke="#d32f2f" stroke-width="2" rx="5"/>
  <text x="140" y="300" text-anchor="middle" fill="#d32f2f" font-family="Arial" font-size="11" font-weight="bold">用户数据库</text>
  <text x="140" y="315" text-anchor="middle" fill="#d32f2f" font-family="Arial" font-size="9">MySQL</text>
  
  <rect x="200" y="280" width="80" height="50" fill="#ffebee" stroke="#d32f2f" stroke-width="2" rx="5"/>
  <text x="240" y="300" text-anchor="middle" fill="#d32f2f" font-family="Arial" font-size="11" font-weight="bold">业务数据库</text>
  <text x="240" y="315" text-anchor="middle" fill="#d32f2f" font-family="Arial" font-size="9">PostgreSQL</text>
  
  <rect x="300" y="280" width="80" height="50" fill="#fff8e1" stroke="#fbc02d" stroke-width="2" rx="5"/>
  <text x="340" y="300" text-anchor="middle" fill="#f57f17" font-family="Arial" font-size="11" font-weight="bold">缓存</text>
  <text x="340" y="315" text-anchor="middle" fill="#f57f17" font-family="Arial" font-size="9">Redis</text>
  
  <!-- 连接线 -->
  <!-- 用户到API网关 -->
  <line x1="150" y1="90" x2="250" y2="90" stroke="#666" stroke-width="2" marker-end="url(#arrowhead)"/>
  
  <!-- API网关到负载均衡 -->
  <line x1="350" y1="90" x2="450" y2="90" stroke="#666" stroke-width="2" marker-end="url(#arrowhead)"/>
  
  <!-- 负载均衡到微服务 -->
  <line x1="500" y1="120" x2="500" y2="140" stroke="#666" stroke-width="2"/>
  <line x1="500" y1="140" x2="95" y2="140" stroke="#666" stroke-width="2"/>
  <line x1="95" y1="140" x2="95" y2="170" stroke="#666" stroke-width="2" marker-end="url(#arrowhead)"/>
  
  <line x1="500" y1="140" x2="205" y2="140" stroke="#666" stroke-width="2"/>
  <line x1="205" y1="140" x2="205" y2="170" stroke="#666" stroke-width="2" marker-end="url(#arrowhead)"/>
  
  <line x1="500" y1="140" x2="315" y2="140" stroke="#666" stroke-width="2"/>
  <line x1="315" y1="140" x2="315" y2="170" stroke="#666" stroke-width="2" marker-end="url(#arrowhead)"/>
  
  <line x1="500" y1="140" x2="425" y2="140" stroke="#666" stroke-width="2"/>
  <line x1="425" y1="140" x2="425" y2="170" stroke="#666" stroke-width="2" marker-end="url(#arrowhead)"/>
  
  <!-- 微服务到数据库 -->
  <line x1="95" y1="220" x2="140" y2="280" stroke="#666" stroke-width="2" marker-end="url(#arrowhead)"/>
  <line x1="205" y1="220" x2="240" y2="280" stroke="#666" stroke-width="2" marker-end="url(#arrowhead)"/>
  <line x1="315" y1="220" x2="240" y2="280" stroke="#666" stroke-width="2" marker-end="url(#arrowhead)"/>
  
  <!-- 微服务到缓存 -->
  <line x1="205" y1="220" x2="340" y2="280" stroke="#666" stroke-width="2" marker-end="url(#arrowhead)"/>
  <line x1="315" y1="220" x2="340" y2="280" stroke="#666" stroke-width="2" marker-end="url(#arrowhead)"/>
  
  <!-- 箭头定义 -->
  <defs>
    <marker id="arrowhead" markerWidth="10" markerHeight="7" 
            refX="9" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="#666"/>
    </marker>
  </defs>
  
  <!-- 说明文字 -->
  <text x="30" y="370" fill="#666" font-family="Arial" font-size="12">
    数据流向：用户请求 → API网关 → 负载均衡 → 微服务 → 数据存储
  </text>
</svg>
```

---

## 🔄 PlantUML转SVG

PlantUML生成的图表可以直接导出为SVG格式，这样既保持了图表的矢量特性，又具有很好的兼容性。

### PlantUML SVG输出示例

```plantuml
@startuml
!theme amiga
!define AWSPUML https://raw.githubusercontent.com/awslabs/aws-icons-for-plantuml/v15.0/dist
!includeurl AWSPUML/AWSCommon.puml
!includeurl AWSPUML/AWSSimplified.puml

' 这个PlantUML图表可以导出为SVG格式
package "云架构" {
  [Web应用] as web
  [API服务] as api
  [数据库] as db
}

web --> api : HTTPS
api --> db : SQL

@enduml
```

---

## 🎯 SVG图表的优势

### ✅ 优点：
1. **矢量图形** - 无损缩放，任何尺寸都清晰
2. **文件体积小** - 比位图格式更小
3. **可编辑** - 可以直接修改代码
4. **浏览器兼容** - 所有现代浏览器都支持
5. **可交互** - 支持CSS和JavaScript
6. **可访问性** - 支持屏幕阅读器

### 💡 使用建议：

| 图表类型 | 推荐方式 | 说明 |
|----------|----------|------|
| **简单图表** | 手写SVG | 完全控制，体积最小 |
| **复杂架构图** | PlantUML转SVG | 专业图表，易于维护 |
| **数据可视化** | 手写SVG | 自定义性强，交互性好 |
| **流程图** | PlantUML转SVG | 标准化，专业外观 |

---

## 🚀 如何使用

1. **复制SVG代码** - 直接使用上面的SVG代码
2. **保存为.svg文件** - 可以在浏览器中直接查看
3. **嵌入HTML** - 直接插入到网页中
4. **转换为PNG** - 如需要位图格式

如果您需要特定类型的SVG图表，请告诉我您的具体需求，我会为您定制生成！

---

**创建时间**：2025年7月15日  
**更新时间**：2025年7月15日  
**版本号**：v1.0
