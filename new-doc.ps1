# 文档创建助手脚本
# 用于快速创建基于模板的文档

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("daily-report", "tech-research", "project-review", "weekly-report", "meeting-notes")]
    [string]$Type,
    
    [string]$Topic = "",
    [string]$Domain = "",
    [string]$ProjectName = "",
    [string]$CustomPath = ""
)

# 获取当前日期信息
$CurrentDate = Get-Date
$Year = $CurrentDate.Year
$Month = $CurrentDate.ToString("MM-MMMM")
$DateString = $CurrentDate.ToString("yyyy-MM-dd")
$TimeString = $CurrentDate.ToString("yyyy-MM-dd HH:mm:ss")

# 设置基础路径
$BasePath = "d:\Programs\AI文档s"
$TemplatePath = "$BasePath\模板库"
$TimePath = "$BasePath\时间维度"
$DomainPath = "$BasePath\专业维度"

# 模板文件映射
$TemplateMap = @{
    "daily-report" = "日报模板.md"
    "tech-research" = "技术研究笔记模板.md"
    "project-review" = "项目复盘模板.md"
    "weekly-report" = "周报模板.md"
    "meeting-notes" = "会议记录模板.md"
}

# 检查模板文件是否存在
$TemplateFile = "$TemplatePath\$($TemplateMap[$Type])"
if (-not (Test-Path $TemplateFile)) {
    Write-Error "模板文件不存在: $TemplateFile"
    exit 1
}

# 读取模板内容
$TemplateContent = Get-Content $TemplateFile -Raw -Encoding UTF8

# 生成文件名
$FileName = ""
switch ($Type) {
    "daily-report" { 
        $FileName = "$DateString-日报.md"
        if (-not $Domain) { $Domain = "日常工作" }
    }
    "tech-research" { 
        $TopicSafe = $Topic -replace '[<>:"/\\|?*]', '_'
        $FileName = "$DateString-$TopicSafe-研究笔记.md"
        if (-not $Domain) { $Domain = "技术研究" }
    }
    "project-review" { 
        $ProjectSafe = $ProjectName -replace '[<>:"/\\|?*]', '_'
        $FileName = "$DateString-$ProjectSafe-项目复盘.md"
        if (-not $Domain) { $Domain = "项目管理" }
    }
    "weekly-report" { 
        $WeekNumber = Get-Date -UFormat %V
        $FileName = "$DateString-第$WeekNumber周-周报.md"
        if (-not $Domain) { $Domain = "日常工作" }
    }
    "meeting-notes" { 
        $FileName = "$DateString-会议记录.md"
        if (-not $Domain) { $Domain = "会议管理" }
    }
}

# 确定文件存放路径
$FilePath = ""
if ($CustomPath) {
    $FilePath = $CustomPath
} else {
    # 主路径：时间维度
    $MainPath = "$TimePath\$Year\$Month"
    if (-not (Test-Path $MainPath)) {
        New-Item -ItemType Directory -Path $MainPath -Force | Out-Null
    }
    
    # 子文件夹根据类型决定
    switch ($Type) {
        "daily-report" { $MainPath = "$MainPath\日报" }
        "weekly-report" { $MainPath = "$MainPath\周报" }
        "tech-research" { $MainPath = "$MainPath\技术研究" }
        "project-review" { $MainPath = "$MainPath\项目复盘" }
        "meeting-notes" { $MainPath = "$MainPath\会议记录" }
    }
    
    if (-not (Test-Path $MainPath)) {
        New-Item -ItemType Directory -Path $MainPath -Force | Out-Null
    }
    
    $FilePath = "$MainPath\$FileName"
}

# 替换模板中的占位符
$Content = $TemplateContent
$Content = $Content -replace '\{date\}', $DateString
$Content = $Content -replace '\{timestamp\}', $TimeString
$Content = $Content -replace '\{year\}', $Year
$Content = $Content -replace '\{month\}', $Month
$Content = $Content -replace '\{filename\}', $FileName
$Content = $Content -replace '\{topic\}', $Topic
$Content = $Content -replace '\{domain\}', $Domain
$Content = $Content -replace '\{project_name\}', $ProjectName

# 创建交叉索引路径
$CrossIndexPath = "$DomainPath\$Domain"
if (-not (Test-Path $CrossIndexPath)) {
    New-Item -ItemType Directory -Path $CrossIndexPath -Force | Out-Null
}

# 写入文件
$Content | Out-File -FilePath $FilePath -Encoding UTF8

# 创建交叉索引链接（软链接或快捷方式）
$CrossIndexFile = "$CrossIndexPath\$FileName"
if (-not (Test-Path $CrossIndexFile)) {
    try {
        # 尝试创建符号链接
        New-Item -ItemType SymbolicLink -Path $CrossIndexFile -Target $FilePath -Force | Out-Null
        Write-Host "✅ 创建交叉索引链接: $CrossIndexFile"
    } catch {
        # 如果符号链接失败，创建硬链接
        try {
            New-Item -ItemType HardLink -Path $CrossIndexFile -Target $FilePath -Force | Out-Null
            Write-Host "✅ 创建交叉索引硬链接: $CrossIndexFile"
        } catch {
            Write-Warning "⚠️ 无法创建交叉索引链接，请手动管理"
        }
    }
}

Write-Host "✅ 文档创建成功！"
Write-Host "📁 主路径: $FilePath"
Write-Host "🔗 交叉索引: $CrossIndexFile"
Write-Host "📝 类型: $Type"
Write-Host "🏷️ 领域: $Domain"

# 可选：自动打开文件
$OpenFile = Read-Host "是否立即打开文件？(y/N)"
if ($OpenFile -eq "y" -or $OpenFile -eq "Y") {
    Start-Process $FilePath
}
