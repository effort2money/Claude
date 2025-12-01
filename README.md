# Claude

这是一个集成了 Claude AI 代码助手的 GitHub 仓库，通过 GitHub Actions 自动化代码审查和协助开发。

## 功能特性

- **智能代码助手**: 在 Issues 和 Pull Requests 中使用 `@claude` 来获取 AI 帮助
- **自动代码审查**: Pull Request 自动触发 Claude 进行代码审查
- **多场景支持**: 支持问题解答、代码审查、代码实现等多种场景

## 使用方法

### 在 Issue 中使用

在 Issue 评论中提及 `@claude` 并描述你的需求：

```
@claude 请帮我实现一个用户登录功能
```

### 在 Pull Request 中使用

在 PR 评论中提及 `@claude` 来请求代码审查或其他帮助：

```
@claude 请审查这个 PR 的代码质量
```

### 自动代码审查

当创建或更新 Pull Request 时，Claude 会自动进行代码审查并提供反馈。

## 配置说明

本仓库包含两个 GitHub Actions 工作流：

1. **claude.yml**: 响应 `@claude` 提及的主要工作流
2. **claude-code-review.yml**: 自动代码审查工作流

## 环境要求

- GitHub Actions
- `CLAUDE_CODE_OAUTH_TOKEN` secret（必需）
- `ANTHROPIC_BASE_URL` secret（可选）

## Docker 部署

本项目支持使用 Docker 进行本地开发和部署。详细说明请参考 [Docker 部署指南](docs/docker-deployment.md)。

### 快速开始

1. 配置环境变量：
```bash
cp .env.example .env
# 编辑 .env 文件，填写必要的配置
```

2. 构建 Docker 镜像：
```bash
# Linux/Mac
./scripts/docker-build.sh

# Windows
.\scripts\docker-build.ps1
```

3. 启动容器：
```bash
# Linux/Mac
./scripts/docker-run.sh

# Windows
.\scripts\docker-run.ps1
```

### 部署模式

- **开发环境模式**：用于本地开发和测试
- **GitHub Runner 模式**：运行自托管的 GitHub Actions Runner

更多详细信息，请查看 [Docker 部署文档](docs/docker-deployment.md)。

## 相关链接

- [Claude Code Action](https://github.com/anthropics/claude-code-action)
- [使用文档](https://docs.claude.com/en/docs/claude-code)

## 许可证

本项目使用的 Claude Code Action 遵循其原始许可证。
