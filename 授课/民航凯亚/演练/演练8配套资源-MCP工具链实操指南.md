# 演练8配套资源：MCP工具链实操指南-重构版

## MCP配置文件示例

全局文件路径：C:\Users\windl\AppData\Roaming\Code\User\mcp.json

### 项目根目录 mcp.json 配置

```json
{
  "mcpServers": {
    "figma-context": {
      "command": "npx",
      "args": ["-y", "@glips/figma-context-mcp"],
      "env": {
        "FIGMA_ACCESS_TOKEN": "figd_你的figma_token_填写在这里"
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

## Figma Access Token 获取步骤

### 1. 登录Figma并进入开发者设置

1. 访问 https://www.figma.com 并登录账户
2. 点击头像 → Settings
3. 选择 Account 选项卡
4. 滚动到 Personal Access Tokens 部分

### 2. 生成Token

1. 点击 "Create new token"
2. 输入token名称（如：MCP Demo Token）
3. 设置适当的权限范围
4. 复制生成的token（格式：figd_xxxxxxxxxxxx）
5. 将token填入 mcp.json 的 FIGMA_ACCESS_TOKEN 字段

## 核心MCP工具提示词模板

### 1. Figma MCP 提示词模板

#### 设计稿分析模板

```markdown
请使用Figma MCP分析以下设计稿：
[设计稿URL]

分析内容：
1. **页面结构**：布局区域、层次结构、内容分组
2. **设计系统**：颜色、字体、间距、圆角、阴影
3. **组件识别**：可复用组件、交互元素、状态变化
4. **技术转换**：CSS变量、组件架构、响应式方案

输出格式：结构化分析 + 代码建议
```

#### CSS生成模板

```markdown
基于Figma分析结果，生成完整的CSS：

输出要求：
1. **Design Tokens**：CSS自定义属性格式的设计变量
2. **组件样式**：模块化CSS，支持响应式
3. **布局系统**：Grid/Flexbox布局方案
4. **主题系统**：支持明暗模式切换

请生成可直接使用的生产级CSS代码。
```

#### React组件生成模板

```markdown
基于Figma设计稿，生成React组件：

技术栈：React 18 + TypeScript + Ant Design
组件要求：
1. **类型安全**：完整的TypeScript类型定义
2. **组件化**：合理的组件拆分和props设计
3. **可复用**：支持不同场景的配置
4. **响应式**：移动端优先的适配方案

请生成完整的组件代码和使用示例。
```

### 2. Context7 MCP 提示词模板

#### React最佳实践查询

```markdown
请使用Context7 MCP获取以下React开发资料：

查询主题：
1. **Hooks使用模式**：useState、useEffect、自定义Hook最佳实践
2. **组件设计**：组件拆分、Props设计、状态管理策略
3. **性能优化**：React.memo、useMemo、useCallback应用场景
4. **TypeScript集成**：类型定义、泛型使用、类型推断技巧

输出格式：核心概念 + 代码示例 + 使用建议
```

#### 技术选型建议查询

```markdown
请查询以下技术方案的最佳实践：

技术栈：[具体技术栈]
应用场景：[具体场景描述]

查询内容：
1. **架构选择**：技术方案对比和选择建议
2. **配置优化**：工具配置和性能调优
3. **开发规范**：代码规范和团队协作
4. **问题解决**：常见问题和解决方案

请提供权威来源的最新资料和实践指导。
```

### 3. Fetch MCP 提示词模板

#### 官方文档获取模板

```markdown
请使用Fetch MCP获取以下官方文档：

文档列表：
1. **Ant Design组件API**：
   - Form: https://ant.design/components/form
   - Switch: https://ant.design/components/switch
   - Avatar: https://ant.design/components/avatar

2. **重点提取内容**：
   - 核心API和配置选项
   - 使用示例和最佳实践
   - 样式自定义和主题配置
   - 版本更新和注意事项

输出格式：结构化摘要 + 关键代码示例
```

#### 技术趋势调研模板

```markdown
请获取以下技术趋势资料：

调研方向：
1. **设计趋势**：2024年UI/UX设计发展趋势
2. **技术演进**：前端框架和工具链最新动态
3. **最佳实践**：行业标准和开发规范更新
4. **性能优化**：Web性能优化新方法和工具

信息来源：权威技术网站、官方博客、技术会议资料
输出要求：趋势分析 + 实际应用建议
```

## 实战案例提示词库

### 综合实战提示词

```markdown
现在请综合使用三个MCP工具完成用户设置页面开发：

**第一步 - Figma MCP设计分析**：
分析设计稿：https://www.figma.com/design/iuAwNMD4fUJyzHRsCmEj06/User-profile---Settings-screen--Community-?node-id=11-2367&t=pV7jdymwFsIAnTcO-0

**第二步 - Context7 MCP技术咨询**：
获取React + TypeScript + Ant Design的最佳实践

**第三步 - Fetch MCP资源获取**：  
获取最新的Ant Design组件文档和使用示例

**最终输出**：
1. 完整的React组件代码
2. 对应的CSS样式文件
3. TypeScript类型定义
4. 组件使用文档和示例

请按步骤执行并生成生产就绪的代码。
```

## 常见问题和解决方案

### 1. Figma Token问题

**问题**：Token获取失败或权限不足
**解决方案**：

- 确保Figma账户已登录
- 检查Token权限设置
- 验证设计稿的访问权限

### 2. MCP连接问题

**问题**：MCP服务无法连接
**解决方案**：

- 检查网络连接
- 验证mcp.json配置格式
- 重启GitHub Copilot服务

### 3. 代码生成质量问题

**问题**：生成的代码不符合预期
**解决方案**：

- 细化提示词描述
- 分步骤生成，逐步优化
- 结合多个MCP工具交叉验证
