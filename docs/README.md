# docs/

本目录保存项目文档。

## 目录结构

```text
docs/
  README.md
  conventions.md
  git.md
  adr/
    README.md
    template.md
  rfcs/
    README.md
    template.md
  specs/
    template.md
  plans/
    template.md
  screenshots/
```

## 文档类型指南

| 需求 | 应写文档 |
|------|----------|
| 记录已经做出的架构决策 | `docs/adr/` |
| 在决策前讨论较大的设计方向 | `docs/rfcs/` |
| 描述功能或子系统设计 | `docs/specs/` |
| 跟踪实施步骤 | `docs/plans/` |
| 记录语言、文档、测试、安全等长期约定 | `docs/conventions.md` |
| 记录 Git 工作流和 commit 规范 | `docs/git.md` |
| 说明安装、编译、运行、测试命令 | 根目录 `README.md` |
| 定义项目级规则 | 根目录 `AGENTS.md` |
