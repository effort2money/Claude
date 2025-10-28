# Claude 开发指南

## 开发原则

**代码质量**：
- 遵循 KISS、YAGNI、DRY、SOLID 原则
- 避免过度抽象和预先优化
- 定期清理死代码和未使用功能
- 所有包测试通过率 100%

**文件组织规范**：
- 文档文件统一放在 `docs/` 目录下
- 脚本文件统一放在 `scripts/` 目录下
- Windows 脚本使用 `.ps1` 格式（PowerShell）
- 测试脚本使用 Go 的 `*_test.go` 方式编写
