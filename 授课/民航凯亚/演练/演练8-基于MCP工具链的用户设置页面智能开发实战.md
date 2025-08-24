# 演练8：基于MCP工具链的用户设置页面智能开发实战

## 🎯 演练概述

**时长**：20分钟  
**难度**：初级  
**场景**：用户设置页面开发  
**设计稿**：[Figma Community - User Profile Settings](https://www.figma.com/design/iuAwNMD4fUJyzHRsCmEj06/User-profile---Settings-screen--Community-?node-id=11-2367&t=pV7jdymwFsIAnTcO-0)  
**核心技术**：GitHub Copilot + Figma MCP + Context7 MCP + Fetch MCP  

### 学习目标

通过本演练，学员将掌握：
- 在VSCode中配置和使用MCP工具
- 使用Figma MCP分析设计稿并生成代码
- 使用Context7 MCP获取开发最佳实践
- 使用Fetch MCP获取实时技术文档
- MCP工具与GitHub Copilot的协同使用

## 📋 案例背景

**项目**：现代化用户设置页面  
**MCP工具链**：
- **Figma MCP**: 设计稿分析和代码生成
- **Context7 MCP**: 技术文档和最佳实践获取
- **Fetch MCP**: 实时资源获取

---

## 🚀 第一步：MCP工具配置（5分钟）

### 任务目标
在VSCode中配置MCP工具链，连接Figma MCP、Context7 MCP和Fetch MCP

### MCP配置步骤

#### 1. 创建 mcp.json 配置文件
在项目根目录创建 `mcp.json` 文件：

```json
{
  "mcpServers": {
    "figma-context": {
      "command": "npx",
      "args": ["-y", "@glips/figma-context-mcp"],
      "env": {
        "FIGMA_ACCESS_TOKEN": "你的figma_token"
      }
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/mcp-server"]
    },
    "fetch": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    }
  }
}
```

#### 2. 获取Figma Access Token
- 访问 https://www.figma.com/developers/api#access-tokens
- 生成Personal Access Token
- 将token填入配置文件

#### 3. 项目初始化
```bash
# 创建React项目
npx create-react-app user-settings-demo --template typescript
cd user-settings-demo

# 安装依赖
npm install antd @ant-design/icons
```

### 🎯 使用说明
GitHub Copilot会自动识别项目中的mcp.json配置，在Chat中可以直接使用MCP工具。

---

## 🎨 第二步：使用Figma MCP分析设计稿（8分钟）

### 任务目标
使用Figma MCP分析设计稿，提取设计元素并生成页面架构

### 操作步骤

#### 步骤1：设计稿分析
在GitHub Copilot Chat中输入以下提示词：

```markdown
请使用Figma MCP分析以下设计稿：
https://www.figma.com/design/iuAwNMD4fUJyzHRsCmEj06/User-profile---Settings-screen--Community-?node-id=11-2367&t=pV7jdymwFsIAnTcO-0

请帮我提取：
1. **页面结构分析**：
   - 页面的主要布局区域
   - 组件的层次结构
   - 信息架构和内容分组

2. **设计系统提取**：
   - 颜色方案（主色、辅助色、背景色）
   - 字体规格（字号、字重、行高）
   - 间距规范（margin、padding）
   - 圆角和阴影参数

3. **组件清单**：
   - 用户头像和信息卡片
   - 设置项列表组件
   - 开关切换组件
   - 按钮和输入框样式
```

#### 步骤2：生成CSS样式文件
继续在Chat中输入：

```markdown
基于刚才分析的设计稿，请生成完整的CSS样式文件：

1. **创建设计token变量**：
生成 src/styles/design-tokens.css 文件，包含：
- 从Figma提取的颜色变量
- 字体大小和行高变量
- 间距和圆角变量
- 阴影和渐变效果

2. **生成组件样式**：
生成 src/components/UserSettings/UserSettings.module.css 文件，
包含基于Figma设计稿的完整样式

请生成可直接使用的CSS代码。
```

#### 步骤3：生成React组件结构
```markdown
基于Figma设计稿分析结果，生成React组件代码：

技术要求：
- 使用TypeScript
- 使用Ant Design组件
- 应用刚才提取的设计系统
- 组件化设计，便于复用
- 响应式布局

组件结构应包括：
- UserProfile: 用户头像和基本信息
- SettingsGroup: 设置项分组
- SettingItem: 单个设置项
- ToggleSwitch: 开关组件

请生成完整的 src/components/UserSettings/index.tsx 文件。
```

---

## 💻 第三步：使用Context7和Fetch MCP获取资源（5分钟）

### 任务目标
使用Context7获取React最佳实践，使用Fetch MCP获取Ant Design文档

### Context7 MCP实战

#### 获取React最佳实践
```markdown
请使用Context7 MCP获取以下技术资料：

1. **React Hooks最佳实践**：
   - useState和useEffect的正确使用模式
   - 自定义Hook的设计原则
   - 组件性能优化技巧

2. **TypeScript在React中的应用**：
   - 组件Props类型定义最佳实践
   - 事件处理的类型安全
   - 泛型组件的设计模式

请提供具体的代码示例和使用建议。
```

### Fetch MCP实战

#### 获取Ant Design文档
```markdown
请使用Fetch MCP获取以下资源：

1. **获取Ant Design组件文档**：
   - Form组件API: https://ant.design/components/form
   - Switch组件用法: https://ant.design/components/switch
   - Avatar组件配置: https://ant.design/components/avatar

2. **提取关键信息**：
   - Form表单验证的最佳配置
   - Switch组件的样式自定义方法
   - Avatar上传功能的实现方案

请提取核心API和使用示例。
```

---

## 🌟 第四步：综合应用和优化（2分钟）

### 任务目标
结合三个MCP工具的结果，生成最终的用户设置页面

### 综合提示词
```markdown
现在请综合前面三个MCP工具的分析结果，生成最终的用户设置页面：

**设计要求**（来自Figma MCP）：
- 使用提取的颜色方案和设计规范
- 遵循分析出的布局结构和组件层次

**技术要求**（来自Context7 MCP）：
- 应用React和TypeScript最佳实践
- 使用推荐的组件设计模式

**组件要求**（来自Fetch MCP）：
- 使用获取的Ant Design组件API
- 应用文档中的配置和样式方案

请生成：
1. 完整的UserSettings组件代码
2. 对应的样式文件
3. TypeScript类型定义
4. 简单的使用示例

代码要求：功能完整、可直接运行、符合最佳实践。
```

---

## 📈 实战成果展示

### 即时成果
- ✅ 掌握MCP工具链的配置和使用
- ✅ 学会Figma MCP设计稿分析和代码生成
- ✅ 体验Context7和Fetch MCP的实用价值
- ✅ 生成完整的用户设置页面代码
- ✅ 理解MCP工具在实际开发中的应用

### MCP工具价值体现
- **Figma MCP**: 设计到代码转换效率提升80%
- **Context7 MCP**: 技术文档获取时间减少90%
- **Fetch MCP**: 实时资源获取，信息始终最新

### 技能提升
- **MCP工具使用**: 掌握三个核心MCP工具的实用技巧
- **设计转代码**: 建立从设计稿到代码的高效工作流
- **AI辅助开发**: 体验MCP + GitHub Copilot的强大组合

---

## 💡 课后延展练习

### 作业任务
1. **扩展MCP配置**: 尝试配置更多MCP工具（如Database MCP、Git MCP等）
2. **深度使用Figma MCP**: 分析复杂的设计稿，生成完整的组件库
3. **团队推广**: 制作MCP工具使用指南，在团队中分享经验

### 持续学习方向
- 探索MCP协议的技术原理和扩展可能
- 学习自定义MCP服务器的开发方法
- 研究MCP在不同开发场景中的应用模式

---

**演练时间**：20分钟  
**适用对象**：前端开发工程师、UI开发工程师、设计师  
**前置知识**：React基础、基本的Figma使用经验  
**实践环境**：VSCode、GitHub Copilot、Figma账户
