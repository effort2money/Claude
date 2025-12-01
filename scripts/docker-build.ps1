# Docker 构建脚本 (Windows PowerShell)

Write-Host "🐳 开始构建 Claude Code Docker 镜像..." -ForegroundColor Cyan

# 构建开发环境镜像
Write-Host "📦 构建开发环境镜像..." -ForegroundColor Yellow
docker build -t claude-code-dev:latest -f Dockerfile .

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ 开发环境镜像构建失败！" -ForegroundColor Red
    exit 1
}

# 可选：构建 GitHub Runner 镜像
$buildRunner = Read-Host "是否构建 GitHub Actions Runner 镜像? (y/N)"
if ($buildRunner -eq "y" -or $buildRunner -eq "Y") {
    Write-Host "📦 构建 GitHub Runner 镜像..." -ForegroundColor Yellow
    docker build -t claude-github-runner:latest -f Dockerfile.runner .

    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ GitHub Runner 镜像构建失败！" -ForegroundColor Red
        exit 1
    }
}

Write-Host "✅ Docker 镜像构建完成！" -ForegroundColor Green
Write-Host ""
Write-Host "使用以下命令启动容器：" -ForegroundColor Cyan
Write-Host "  开发环境: docker-compose up -d claude-dev" -ForegroundColor White
Write-Host "  GitHub Runner: docker-compose --profile runner up -d github-runner" -ForegroundColor White
