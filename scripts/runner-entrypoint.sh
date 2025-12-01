#!/bin/bash
# GitHub Actions Runner 启动脚本

set -e

# 检查必需的环境变量
if [ -z "$GITHUB_TOKEN" ]; then
    echo "错误: GITHUB_TOKEN 环境变量未设置"
    exit 1
fi

if [ -z "$REPO_URL" ]; then
    echo "错误: REPO_URL 环境变量未设置"
    exit 1
fi

# 配置 Runner
echo "配置 GitHub Actions Runner..."

# 获取 Runner Token
RUNNER_TOKEN=$(curl -s -X POST \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    "${REPO_URL/github.com/api.github.com/repos}/actions/runners/registration-token" | jq -r .token)

if [ -z "$RUNNER_TOKEN" ] || [ "$RUNNER_TOKEN" = "null" ]; then
    echo "错误: 无法获取 Runner Token"
    exit 1
fi

# 配置 Runner
./config.sh \
    --url "${REPO_URL}" \
    --token "${RUNNER_TOKEN}" \
    --name "${RUNNER_NAME:-claude-docker-runner}" \
    --work "${RUNNER_WORKDIR:-/workspace}" \
    --labels "docker,claude" \
    --unattended \
    --replace

# 启动 Runner
echo "启动 GitHub Actions Runner..."
./run.sh

# 清理
cleanup() {
    echo "清理 Runner..."
    ./config.sh remove --token "${RUNNER_TOKEN}"
}

trap cleanup EXIT
