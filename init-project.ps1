# AI文档管理系统项目初始化脚本

param(
    [string]$ProjectName = "ai_document_system",
    [string]$ProjectPath = ".",
    [switch]$CreateVenv,
    [switch]$InstallDeps
)

Write-Host "🚀 初始化AI文档管理系统项目..." -ForegroundColor Green

# 设置项目路径
$FullProjectPath = Join-Path $ProjectPath $ProjectName

# 创建项目目录结构
Write-Host "📁 创建项目目录结构..." -ForegroundColor Yellow
$Directories = @(
    "$FullProjectPath",
    "$FullProjectPath/config",
    "$FullProjectPath/gui",
    "$FullProjectPath/gui/widgets",
    "$FullProjectPath/gui/resources",
    "$FullProjectPath/gui/resources/icons",
    "$FullProjectPath/gui/resources/styles",
    "$FullProjectPath/gui/resources/ui",
    "$FullProjectPath/api",
    "$FullProjectPath/api/routers",
    "$FullProjectPath/api/models",
    "$FullProjectPath/api/services",
    "$FullProjectPath/core",
    "$FullProjectPath/data",
    "$FullProjectPath/data/search_index",
    "$FullProjectPath/data/embeddings",
    "$FullProjectPath/data/templates",
    "$FullProjectPath/tests",
    "$FullProjectPath/tests/test_api",
    "$FullProjectPath/tests/test_core",
    "$FullProjectPath/tests/test_gui",
    "$FullProjectPath/docs",
    "$FullProjectPath/scripts",
    "$FullProjectPath/logs"
)

foreach ($dir in $Directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "  ✅ 创建目录: $dir" -ForegroundColor Gray
    }
}

# 创建requirements.txt
Write-Host "📋 创建requirements.txt..." -ForegroundColor Yellow
$RequirementsContent = @"
# GUI Framework
PyQt6>=6.6.0
PyQt6-tools>=6.6.0

# Web Framework
fastapi>=0.104.0
uvicorn[standard]>=0.24.0
pydantic>=2.0.0
pydantic-settings>=2.0.0

# Database
sqlalchemy>=2.0.0
alembic>=1.12.0
aiosqlite>=0.19.0

# AI & ML
openai>=1.0.0
sentence-transformers>=2.2.0
numpy>=1.24.0
scikit-learn>=1.3.0
torch>=2.0.0
transformers>=4.30.0

# Search & Text Processing
whoosh>=2.7.4
jieba>=0.42.1

# Utilities
pandas>=2.0.0
python-dotenv>=1.0.0
httpx>=0.25.0
aiofiles>=23.0.0
click>=8.0.0
rich>=13.0.0
pydantic-settings>=2.0.0

# Development
pytest>=7.0.0
pytest-asyncio>=0.21.0
black>=23.0.0
flake8>=6.0.0
isort>=5.12.0
mypy>=1.5.0
pre-commit>=3.0.0

# Optional
jupyter>=1.0.0
matplotlib>=3.6.0
seaborn>=0.12.0
"@

$RequirementsContent | Out-File -FilePath "$FullProjectPath/requirements.txt" -Encoding UTF8

# 创建.env.example
Write-Host "🔧 创建环境变量模板..." -ForegroundColor Yellow
$EnvContent = @"
# AI服务配置
DEEPSEEK_API_KEY=your_deepseek_api_key_here
DEEPSEEK_BASE_URL=https://api.deepseek.com/v1

# 数据库配置
DATABASE_URL=sqlite:///./data/documents.db
DATABASE_ECHO=false

# 搜索配置
SEARCH_INDEX_PATH=./data/search_index
EMBEDDINGS_PATH=./data/embeddings

# 日志配置
LOG_LEVEL=INFO
LOG_FILE=./logs/app.log

# 应用配置
APP_NAME=AI文档管理系统
APP_VERSION=1.0.0
DEBUG=true
"@

$EnvContent | Out-File -FilePath "$FullProjectPath/.env.example" -Encoding UTF8

# 创建.gitignore
Write-Host "📝 创建.gitignore..." -ForegroundColor Yellow
$GitignoreContent = @"
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Virtual Environment
venv/
env/
ENV/
.venv/
.env/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Project specific
.env
data/documents.db
data/search_index/
data/embeddings/
logs/*.log
temp/
cache/

# Tests
.pytest_cache/
htmlcov/
.coverage
.coverage.*
coverage.xml
*.cover
"@

$GitignoreContent | Out-File -FilePath "$FullProjectPath/.gitignore" -Encoding UTF8

# 创建README.md
Write-Host "📖 创建README.md..." -ForegroundColor Yellow
$ReadmeContent = @"
# AI文档管理系统

基于Python + PyQt6 + FastAPI + DeepSeek的智能文档管理系统。

## 特性

- 🎯 **双维度索引**: 时间维度 + 专业领域维度
- 🔍 **智能搜索**: 全文搜索 + 语义搜索
- 🤖 **AI增强**: 自动分类、标签建议、内容摘要
- 📊 **知识图谱**: 文档关联关系可视化
- 🎨 **现代界面**: PyQt6构建的美观桌面应用

## 技术栈

- **前端**: PyQt6 + Python
- **后端**: FastAPI + SQLAlchemy
- **数据库**: SQLite
- **搜索**: Whoosh + 向量检索
- **AI服务**: DeepSeek API

## 快速开始

### 1. 环境要求

- Python 3.11+
- Git

### 2. 安装依赖

\`\`\`bash
# 创建虚拟环境
python -m venv venv

# 激活虚拟环境
# Windows
venv\Scripts\activate
# Linux/Mac
source venv/bin/activate

# 安装依赖
pip install -r requirements.txt
\`\`\`

### 3. 配置环境变量

\`\`\`bash
# 复制环境变量模板
cp .env.example .env

# 编辑配置文件，填入您的DeepSeek API密钥
# 编辑 .env 文件
\`\`\`

### 4. 初始化数据库

\`\`\`bash
python scripts/init_db.py
\`\`\`

### 5. 启动应用

\`\`\`bash
# 启动API服务 (后台运行)
uvicorn api.main:app --reload &

# 启动GUI应用
python gui/main_window.py
\`\`\`

## 项目结构

\`\`\`
ai_document_system/
├── config/          # 配置文件
├── gui/            # PyQt6界面
├── api/            # FastAPI后端
├── core/           # 核心功能
├── data/           # 数据存储
├── tests/          # 测试代码
└── docs/           # 文档
\`\`\`

## 开发指南

### 运行测试

\`\`\`bash
pytest tests/
\`\`\`

### 代码格式化

\`\`\`bash
black .
isort .
flake8 .
\`\`\`

### 构建文档

\`\`\`bash
# TODO: 添加文档构建命令
\`\`\`

## 贡献指南

1. Fork 项目
2. 创建特性分支
3. 提交更改
4. 推送到分支
5. 创建Pull Request

## 许可证

MIT License

## 联系方式

- 作者: AI Assistant
- 邮箱: your-email@example.com
- 项目地址: https://github.com/your-username/ai-document-system
"@

$ReadmeContent | Out-File -FilePath "$FullProjectPath/README.md" -Encoding UTF8

# 创建__init__.py文件
Write-Host "🐍 创建__init__.py文件..." -ForegroundColor Yellow
$InitFiles = @(
    "$FullProjectPath/config/__init__.py",
    "$FullProjectPath/gui/__init__.py",
    "$FullProjectPath/gui/widgets/__init__.py",
    "$FullProjectPath/api/__init__.py",
    "$FullProjectPath/api/routers/__init__.py",
    "$FullProjectPath/api/models/__init__.py",
    "$FullProjectPath/api/services/__init__.py",
    "$FullProjectPath/core/__init__.py",
    "$FullProjectPath/tests/__init__.py",
    "$FullProjectPath/tests/test_api/__init__.py",
    "$FullProjectPath/tests/test_core/__init__.py",
    "$FullProjectPath/tests/test_gui/__init__.py"
)

foreach ($file in $InitFiles) {
    if (-not (Test-Path $file)) {
        New-Item -ItemType File -Path $file -Force | Out-Null
        '"""' + (Split-Path $file -Parent | Split-Path -Leaf) + ' package."""' | Out-File -FilePath $file -Encoding UTF8
    }
}

# 创建虚拟环境
if ($CreateVenv.IsPresent) {
    Write-Host "🐍 创建Python虚拟环境..." -ForegroundColor Yellow
    Push-Location $FullProjectPath
    try {
        python -m venv venv
        Write-Host "  ✅ 虚拟环境创建成功" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ 虚拟环境创建失败: $_" -ForegroundColor Red
    }
    Pop-Location
}

# 安装依赖
if ($InstallDeps.IsPresent -and $CreateVenv.IsPresent) {
    Write-Host "📦 安装Python依赖包..." -ForegroundColor Yellow
    Push-Location $FullProjectPath
    try {
        if ($IsWindows) {
            & "venv\Scripts\activate.ps1"
        } else {
            & "venv/bin/activate"
        }
        pip install -r requirements.txt
        Write-Host "  ✅ 依赖包安装成功" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ 依赖包安装失败: $_" -ForegroundColor Red
        Write-Host "  💡 请手动运行: pip install -r requirements.txt" -ForegroundColor Yellow
    }
    Pop-Location
}

# 初始化Git仓库
Write-Host "📚 初始化Git仓库..." -ForegroundColor Yellow
Push-Location $FullProjectPath
try {
    git init
    git add .
    git commit -m "Initial commit: AI文档管理系统项目初始化"
    Write-Host "  ✅ Git仓库初始化成功" -ForegroundColor Green
} catch {
    Write-Host "  ❌ Git仓库初始化失败: $_" -ForegroundColor Red
}
Pop-Location

Write-Host "`n🎉 项目初始化完成！" -ForegroundColor Green
Write-Host "📁 项目路径: $FullProjectPath" -ForegroundColor Cyan
Write-Host "`n📋 下一步操作:" -ForegroundColor Yellow
Write-Host "1. 进入项目目录: cd $ProjectName" -ForegroundColor White
Write-Host "2. 激活虚拟环境: venv\Scripts\activate" -ForegroundColor White
Write-Host "3. 配置环境变量: 编辑 .env 文件" -ForegroundColor White
Write-Host "4. 初始化数据库: python scripts/init_db.py" -ForegroundColor White
Write-Host "5. 启动应用: python gui/main_window.py" -ForegroundColor White
Write-Host "`n🔗 相关文档:" -ForegroundColor Yellow
Write-Host "- 项目结构说明: 项目结构说明.md" -ForegroundColor White
Write-Host "- 任务计划: tasks.md" -ForegroundColor White
Write-Host "- 产品需求: prd.md" -ForegroundColor White
