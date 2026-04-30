<!-- Copyright The Project Template Contributors -->

# 项目名称

> **模板使用说明**
>
> 本仓库是公司项目模板。使用模板创建新项目后，必须把本文件中的项目名称、说明、环境要求和所有 `TODO` 命令替换成项目真实内容；不适用的章节应删除或改写。
>
> 维护 `project_template` 仓库时，本文件中的 `TODO` 是模板占位内容。除非本次变更目标就是调整模板占位策略，否则不要把这些占位内容替换成模板仓库自身信息。

TODO：用一段话说明本项目是什么。

## 模板仓库维护

维护 `project_template` 仓库时，修改模板结构或规则后至少执行：

```bash
git status --short --branch
rg -n "TODO|YYYY-MM-DD|@TODO-owner" .
```

`TODO` 命中应来自模板占位或示例。新增、删除或移动模板文件时，应同步检查 `README.md`、`AGENTS.md`、`docs/README.md` 和 `docs/conventions.md` 中的文档入口。

## 快速开始

TODO：写清楚本项目实际使用的命令。

公司不强制统一命令名。每个项目自己的安装、编译、运行、测试、打包、发布方式都在本文件中说明。
派生项目必须把这些命令补成可直接执行的项目真值源。命令可以由 AI agent 根据真实项目生成或维护，但合并前必须说明运行位置、前置条件，以及是否依赖硬件、外部服务或网络。

## 环境要求

- Git
- Docker / Docker Desktop
- 支持 Dev Container 的编辑器或 AI agent
- TODO：平台原生 SDK、硬件工具、签名工具等

## 开发环境

默认使用 `.devcontainer/`。

默认 Dev Container 使用 Ubuntu 26.04 LTS，并安装通用开发、文档和协作工具。语言工具链、SDK、数据库、模拟器、硬件工具由派生项目按需补充。

TODO：说明如何打开 Dev Container，以及本项目额外的 `postCreateCommand` 会安装什么。

## 运行模式与验证模式

> 创建新项目时，删除不适用的模式，补齐适用模式的命令、运行位置和前置条件。

| 模式 | 用途 | 运行位置 | 是否需要硬件/外部服务 | 命令入口 |
|------|------|----------|------------------------|----------|
| 本地开发 | TODO | TODO：宿主机 / Dev Container / VM | TODO | TODO |
| CI | TODO | TODO：GitHub Actions / GitLab CI / self-hosted runner | TODO | TODO |
| 仿真/模拟器 | TODO：例如 QEMU、浏览器、mock 服务 | TODO | TODO | TODO |
| 无硬件运行 | TODO：验证配置、线程编排或基础流程 | TODO | 否 | TODO |
| 硬件诊断 | TODO：验证设备、总线、传感器或产线夹具 | TODO | 是 | TODO |
| 生产/部署 | TODO：打包、发布、安装、升级、回滚 | TODO | TODO | TODO |

涉及硬件设计、生产、供应商交付物或 SOP 的项目，应在 `docs/templates/` 对应模板基础上建立正式文档，并在本节链接。

## 安装依赖

```bash
# TODO
```

## 编译

```bash
# TODO
```

## 运行

```bash
# TODO
```

## 测试

```bash
# TODO
```

## 打包与发布

```bash
# TODO
```

## 项目文档

- `AGENTS.md`：人类和 AI agent 的项目规则
- `CONTRIBUTING.md`：贡献流程和 PR 要求
- `SECURITY.md`：安全漏洞报告流程
- `docs/conventions.md`：语言、文档、测试、安全等项目约定
- `docs/git.md`：Git 工作流和 commit 规范
- `docs/SAD.md`：可选，软件架构文档（Software Architecture Document）
- `docs/SDD.md`：可选，软件设计文档（Software Design Document）
- `docs/adr/`：架构决策
- `docs/rfcs/`：提案
- `docs/specs/`：设计文档
- `docs/plans/`：实施计划
- `docs/templates/`：局部规则、硬件设计、供应商记录、SOP 模板
- `docs/hardware/`：可选，硬件设计和验证记录
- `docs/production/`：可选，生产、发布、验收、回滚流程
- `docs/suppliers/`：可选，供应商和第三方交付物记录
- `docs/sop/`：可选，标准作业流程

## Commit 规范

默认采用 Conventional Commits 风格，subject 中文优先，type/scope 保持英文，例如 `feat(api): 支持 OAuth callback`。详细规则见 `docs/git.md`。
