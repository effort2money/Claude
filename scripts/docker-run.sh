#!/bin/bash
# Docker 运行脚本 (Linux/Mac)

set -e

# 检查 .env 文件
if [ ! -f .env ]; then
    echo "⚠️  未找到 .env 文件，正在创建模板..."
    cat > .env << EOF
# Claude Code OAuth Token (必需)
CLAUDE_CODE_OAUTH_TOKEN=your_token_here

# Anthropic Base URL (可选)
ANTHROPIC_BASE_URL=

# GitHub Token (用于 GitHub CLI)
GITHUB_TOKEN=

# GitHub Repository URL (用于自托管 Runner)
REPO_URL=https://github.com/your-username/your-repo
EOF
    echo "✅ 已创建 .env 模板文件，请填写必要的环境变量"
    exit 1
fi

# 选择运行模式
echo "请选择运行模式："
echo "1) 开发环境 (交互式)"
echo "2) GitHub Actions Runner (后台运行)"
read -p "请输入选项 (1-2): " choice

case $choice in
    1)
        echo "🚀 启动开发环境..."
        docker-compose up -d claude-dev
        echo "✅ 开发环境已启动！"
        echo "使用以下命令进入容器："
        echo "  docker-compose exec claude-dev bash"
        ;;
    2)
        echo "🚀 启动 GitHub Actions Runner..."
        docker-compose --profile runner up -d github-runner
        echo "✅ GitHub Runner 已启动！"
        echo "查看日志："
        echo "  docker-compose logs -f github-runner"
        ;;
    *)
        echo "❌ 无效的选项"
        exit 1
        ;;
esac
