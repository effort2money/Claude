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

## 相关链接

- [Claude Code Action](https://github.com/anthropics/claude-code-action)
- [使用文档](https://docs.claude.com/en/docs/claude-code)

## 许可证

本项目使用的 Claude Code Action 遵循其原始许可证。
