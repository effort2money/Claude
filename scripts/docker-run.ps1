# Docker 运行脚本 (Windows PowerShell)

# 检查 .env 文件
if (-not (Test-Path .env)) {
    Write-Host "⚠️  未找到 .env 文件，正在创建模板..." -ForegroundColor Yellow

    $envContent = @"
# Claude Code OAuth Token (必需)
CLAUDE_CODE_OAUTH_TOKEN=your_token_here

# Anthropic Base URL (可选)
ANTHROPIC_BASE_URL=

# GitHub Token (用于 GitHub CLI)
GITHUB_TOKEN=

# GitHub Repository URL (用于自托管 Runner)
REPO_URL=https://github.com/your-username/your-repo
"@

    $envContent | Out-File -FilePath .env -Encoding UTF8
    Write-Host "✅ 已创建 .env 模板文件，请填写必要的环境变量" -ForegroundColor Green
    exit 1
}

# 选择运行模式
Write-Host "请选择运行模式：" -ForegroundColor Cyan
Write-Host "1) 开发环境 (交互式)" -ForegroundColor White
Write-Host "2) GitHub Actions Runner (后台运行)" -ForegroundColor White
$choice = Read-Host "请输入选项 (1-2)"

switch ($choice) {
    "1" {
        Write-Host "🚀 启动开发环境..." -ForegroundColor Cyan
        docker-compose up -d claude-dev

        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ 开发环境已启动！" -ForegroundColor Green
            Write-Host "使用以下命令进入容器：" -ForegroundColor Cyan
            Write-Host "  docker-compose exec claude-dev bash" -ForegroundColor White
        } else {
            Write-Host "❌ 启动失败！" -ForegroundColor Red
            exit 1
        }
    }
    "2" {
        Write-Host "🚀 启动 GitHub Actions Runner..." -ForegroundColor Cyan
        docker-compose --profile runner up -d github-runner

        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ GitHub Runner 已启动！" -ForegroundColor Green
            Write-Host "查看日志：" -ForegroundColor Cyan
            Write-Host "  docker-compose logs -f github-runner" -ForegroundColor White
        } else {
            Write-Host "❌ 启动失败！" -ForegroundColor Red
            exit 1
        }
    }
    default {
        Write-Host "❌ 无效的选项" -ForegroundColor Red
        exit 1
    }
}
