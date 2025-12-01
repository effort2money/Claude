# Docker 部署指南

本文档介绍如何使用 Docker 部署和运行 Claude Code Action 环境。

## 目录

- [概述](#概述)
- [前置要求](#前置要求)
- [快速开始](#快速开始)
- [部署模式](#部署模式)
- [配置说明](#配置说明)
- [常见问题](#常见问题)

## 概述

本项目提供了两种 Docker 部署模式：

1. **开发环境模式**：用于本地开发和测试 Claude Code Action
2. **GitHub Runner 模式**：用于运行自托管的 GitHub Actions Runner

## 前置要求

- Docker 20.10 或更高版本
- Docker Compose 2.0 或更高版本
- 有效的 Claude Code OAuth Token
- （可选）GitHub Personal Access Token

## 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/your-username/Claude.git
cd Claude
```

### 2. 配置环境变量

复制环境变量模板：

```bash
cp .env.example .env
```

编辑 `.env` 文件，填写必要的配置：

```env
CLAUDE_CODE_OAUTH_TOKEN=your_actual_token
GITHUB_TOKEN=your_github_token
REPO_URL=https://github.com/your-username/your-repo
```

### 3. 构建 Docker 镜像

**Linux/Mac:**

```bash
chmod +x scripts/docker-build.sh
./scripts/docker-build.sh
```

**Windows (PowerShell):**

```powershell
.\scripts\docker-build.ps1
```

### 4. 启动容器

**Linux/Mac:**

```bash
chmod +x scripts/docker-run.sh
./scripts/docker-run.sh
```

**Windows (PowerShell):**

```powershell
.\scripts\docker-run.ps1
```

## 部署模式

### 开发环境模式

开发环境模式提供了一个交互式的容器环境，用于本地开发和测试。

#### 启动开发环境

```bash
docker-compose up -d claude-dev
```

#### 进入容器

```bash
docker-compose exec claude-dev bash
```

#### 停止开发环境

```bash
docker-compose down
```

#### 功能特性

- 完整的 Git 环境
- GitHub CLI (gh)
- Node.js 20.x
- 自动挂载项目目录到 `/workspace`
- 保留 Git 配置

### GitHub Runner 模式

GitHub Runner 模式允许你运行自托管的 GitHub Actions Runner，用于执行 GitHub Actions 工作流。

#### 启动 Runner

```bash
docker-compose --profile runner up -d github-runner
```

#### 查看 Runner 日志

```bash
docker-compose logs -f github-runner
```

#### 停止 Runner

```bash
docker-compose --profile runner down
```

#### 功能特性

- 自动注册到 GitHub 仓库
- 支持 Docker-in-Docker
- 自动清理和注销
- 可自定义 Runner 名称和标签

## 配置说明

### 环境变量

| 变量名 | 必需 | 说明 |
|--------|------|------|
| `CLAUDE_CODE_OAUTH_TOKEN` | 是 | Claude Code OAuth Token |
| `ANTHROPIC_BASE_URL` | 否 | 自定义 Anthropic API 端点 |
| `GITHUB_TOKEN` | 否* | GitHub Personal Access Token |
| `REPO_URL` | 否* | GitHub 仓库 URL |

\* 仅在使用 GitHub Runner 模式时必需

### Docker Compose 配置

#### 自定义端口映射

如果需要暴露端口，可以在 `docker-compose.yml` 中添加：

```yaml
services:
  claude-dev:
    ports:
      - "8080:8080"
```

#### 自定义卷挂载

添加额外的卷挂载：

```yaml
services:
  claude-dev:
    volumes:
      - ./custom-dir:/custom-dir
```

### Dockerfile 自定义

#### 添加额外的工具

编辑 `Dockerfile`，在 `RUN apt-get install` 部分添加所需的包：

```dockerfile
RUN apt-get update && apt-get install -y \
    git \
    curl \
    your-package \
    && rm -rf /var/lib/apt/lists/*
```

#### 更改时区

修改 `Dockerfile` 中的 `TZ` 环境变量：

```dockerfile
ENV TZ=America/New_York
```

## 常见问题

### 1. 如何获取 Claude Code OAuth Token？

访问 [Claude Settings](https://claude.ai/settings) 获取你的 OAuth Token。

### 2. 如何生成 GitHub Personal Access Token？

1. 访问 [GitHub Token Settings](https://github.com/settings/tokens)
2. 点击 "Generate new token (classic)"
3. 选择所需的权限范围（至少需要 `repo` 和 `workflow`）
4. 生成并保存 Token

### 3. Docker 构建失败怎么办？

检查以下几点：

- 确保 Docker 服务正在运行
- 检查网络连接
- 尝试清理 Docker 缓存：`docker system prune -a`

### 4. 容器无法访问 GitHub API

确保：

- `GITHUB_TOKEN` 已正确设置
- Token 具有足够的权限
- 网络可以访问 GitHub API

### 5. 如何更新 Docker 镜像？

```bash
# 重新构建镜像
docker-compose build --no-cache

# 重启容器
docker-compose up -d
```

### 6. 如何查看容器日志？

```bash
# 查看所有日志
docker-compose logs

# 实时查看日志
docker-compose logs -f

# 查看特定服务的日志
docker-compose logs claude-dev
```

### 7. 如何清理 Docker 资源？

```bash
# 停止并删除容器
docker-compose down

# 删除镜像
docker rmi claude-code-dev:latest

# 清理所有未使用的资源
docker system prune -a
```

## 最佳实践

### 安全性

1. **不要提交 `.env` 文件**：确保 `.env` 在 `.gitignore` 中
2. **定期更新 Token**：定期轮换 OAuth Token 和 GitHub Token
3. **最小权限原则**：只授予必要的权限

### 性能优化

1. **使用 Docker 卷缓存**：避免重复下载依赖
2. **多阶段构建**：减小镜像大小
3. **清理临时文件**：在 Dockerfile 中及时清理

### 维护

1. **定期更新基础镜像**：保持系统安全
2. **监控容器资源**：使用 `docker stats` 监控
3. **备份重要数据**：定期备份配置和数据

## 故障排除

### 容器启动失败

```bash
# 查看详细错误信息
docker-compose logs claude-dev

# 检查容器状态
docker-compose ps
```

### 网络问题

```bash
# 检查 Docker 网络
docker network ls

# 重建网络
docker-compose down
docker-compose up -d
```

### 权限问题

```bash
# 确保脚本有执行权限
chmod +x scripts/*.sh

# 检查文件所有权
ls -la
```

## 相关资源

- [Docker 官方文档](https://docs.docker.com/)
- [Docker Compose 文档](https://docs.docker.com/compose/)
- [Claude Code Action](https://github.com/anthropics/claude-code-action)
- [GitHub Actions 文档](https://docs.github.com/en/actions)

## 支持

如有问题或建议，请在 [GitHub Issues](https://github.com/your-username/Claude/issues) 中提出。
