<!-- Copyright The Project Template Contributors -->

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
  templates/
    README.md
    local-AGENTS.md
    hardware-design.md
    supplier-record.md
    sop.md
  screenshots/
  hardware/       # 可选
  production/     # 可选
  suppliers/      # 可选
  sop/            # 可选
```

## 文档类型指南

| 需求 | 应写文档 |
|------|----------|
| 记录已经做出的架构决策 | `docs/adr/` |
| 在决策前讨论较大的设计方向 | `docs/rfcs/` |
| 描述功能或子系统设计 | `docs/specs/` |
| 跟踪实施步骤 | `docs/plans/` |
| 创建局部模块规则、硬件设计、供应商记录或 SOP | `docs/templates/` |
| 记录语言、文档、测试、安全等长期约定 | `docs/conventions.md` |
| 记录 Git 工作流和 commit 规范 | `docs/git.md` |
| 说明安装、编译、运行、测试命令 | 根目录 `README.md` |
| 定义项目级规则 | 根目录 `AGENTS.md` |

图表优先使用 Mermaid 或 PlantUML。涉及硬件拓扑、生产流程、供应商边界或 SOP 的文档，应同时保留可审查的文字说明和图表。
