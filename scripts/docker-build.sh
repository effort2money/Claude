#!/bin/bash
# Docker 构建脚本 (Linux/Mac)

set -e

echo "🐳 开始构建 Claude Code Docker 镜像..."

# 构建开发环境镜像
echo "📦 构建开发环境镜像..."
docker build -t claude-code-dev:latest -f Dockerfile .

# 可选：构建 GitHub Runner 镜像
read -p "是否构建 GitHub Actions Runner 镜像? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📦 构建 GitHub Runner 镜像..."
    docker build -t claude-github-runner:latest -f Dockerfile.runner .
fi

echo "✅ Docker 镜像构建完成！"
echo ""
echo "使用以下命令启动容器："
echo "  开发环境: docker-compose up -d claude-dev"
echo "  GitHub Runner: docker-compose --profile runner up -d github-runner"
