<!-- Copyright The Project Template Contributors -->

# 项目约定

> **模板使用说明**
>
> 本文件保存跨项目常用约定。派生项目应删除不适用内容，并补充本项目真实规则。

## 语言策略

- 项目以中文为首选语言。
- 项目文档、注释、ADR、RFC、Spec、Plan、提交信息、PR 描述和用户可见文案优先使用中文。
- 技术术语、行业术语、专有名词、缩写、协议名、标准名、产品名、代码变量、函数名、类型名、模块名、文件名、命令、配置键、环境变量等保持英文或其所在生态的通用写法。
- 不为了“全中文”而翻译已经稳定的英文术语。例如 API、SDK、CLI、CI、CD、HTTP、JSON、token、schema、runtime、adapter、plugin、handler、callback、middleware 等可直接使用英文。
- 代码标识符遵循对应语言生态惯例，例如 `snake_case`、`camelCase`、`PascalCase`、`SCREAMING_SNAKE_CASE`。
- 如果中文解释和英文术语同时出现，优先采用“中文说明 + 英文术语”的形式，例如“运行时 runtime”“适配器 adapter”“模式 schema”。

## 仓库结构

```text
  repo/
    AGENTS.md
    CONTRIBUTING.md
    LICENSE
    README.md
    SECURITY.md
  .devcontainer/
    devcontainer.json
    Dockerfile
    base.Dockerfile      # 模板仓库维护基础镜像时使用
    compose.yaml          # 可选，仅在本地开发需要多服务时使用
    scripts/              # 可选，容器初始化脚本
  docs/
    README.md
    conventions.md
    git.md
    SAD.md                # 可选，Software Architecture Document
    SDD.md                # 可选，Software Design Document
    adr/
    rfcs/
    specs/
    plans/
    templates/
    screenshots/
    hardware/            # 可选，硬件设计、接口、BOM、测试夹具
    production/          # 可选，生产、测试、发布、回滚流程
    suppliers/           # 可选，供应商资料、接口、交付物记录
    sop/                 # 可选，标准作业流程
  3rd/                   # 可选，第三方源码、固件、C/C++库等 submodule/vendor
  .github/
    workflows/
    PULL_REQUEST_TEMPLATE.md
    CODEOWNERS
  src/
```

目录规则：

- 开发环境相关 Docker 文件统一放在 `.devcontainer/`。
- 根目录不放开发用 `Dockerfile`。只有当项目明确发布生产容器镜像时，才允许在根目录或专用目录放生产镜像构建文件，并在 `README.md` 中说明。
- 生成文件必须说明来源、生成命令、是否提交仓库，以及变更时如何校验。
- 大模块如果有独立架构边界、依赖约束或修改 checklist，应在模块根目录放一个局部 `AGENTS.md`，推荐从 `docs/templates/local-AGENTS.md` 复制后改写。
- 第三方源码、固件、C/C++ 库、硬件供应商 SDK 等可放在 `3rd/`，优先使用 git submodule 记录来源和版本。Rust Cargo、npm、pip、Go modules、Maven 等自带包管理器的依赖不放入 `3rd/`，应由对应 manifest/lockfile 管理。
- 涉及硬件设计、生产、供应商或 SOP 的项目，应建立对应目录或文档，并在 `README.md` 的运行模式与验证模式中链接。
- 本地 AI/agent 会话状态不进 git；默认忽略 `.claude/`、`.codex/`、`.superpowers/`、`.aider*` 和 `.worktrees/`。

## 开发环境

默认开发环境是 Dev Container。

宿主机依赖应保持最少：

- Git
- Docker / Docker Desktop
- 支持 Dev Container 的编辑器或 AI agent 工具
- 无法放进容器的平台原生 SDK、硬件工具或签名工具，必须在 `README.md` 中说明

开发、编译、测试、生成、打包、发布和 pre-commit hooks 过程中用到的工具、语言工具链、SDK、模拟器、数据库客户端和其他二进制文件，默认必须安装并运行在 Dev Container 或 CI/self-hosted runner 声明的隔离环境中。项目不应要求贡献者通过 `brew`、系统包管理器或手工复制文件来修改宿主机全局环境；确实无法容器化的原生工具必须记录原因、影响范围和替代验证路径。

平台约定：

- Windows 开发者优先使用 WSL2 工作区。
- macOS/Linux 开发者按公司策略使用 Docker Desktop 或 Docker Engine。
- 硬件访问、签名、公证、GUI 验证、平台安装包构建，可能需要原生机器或 self-hosted runner。

模板默认 Dev Container 基于 `ghcr.io/libodynamics/project_template/devcontainer:latest`。模板仓库用 `.devcontainer/base.Dockerfile` 构建并发布这个基础镜像；基础镜像中的 Node.js 来自 Ubuntu archive，npm 升级到 latest 以匹配全局 npm 工具。派生项目用 `.devcontainer/Dockerfile` 继承 `latest` 后追加自己的语言工具链、SDK、数据库、模拟器、交叉编译器、硬件工具，并记录在 `README.md`。

模板 Dev Container 默认使用 `dev` 用户作为交互用户，默认 shell 是 `zsh`，并允许免密码 `sudo`。Dockerfile 构建阶段仍按 Docker 默认行为使用 root；派生项目确实需要交互式密码时，必须在 README 说明原因和设置方式。

Docker、Docker Compose、Dev Container 和 CI 示例中的 bind mount 必须保持在当前项目边界内：宿主机源路径使用仓库根目录或仓库内子目录，例如 `$PWD`、`${GITHUB_WORKSPACE}` 或 `${localWorkspaceFolder}`；容器内目标路径使用项目工作区，例如 `/workspace` 或 `${containerWorkspaceFolder}`。不要随意挂载宿主机全局目录、用户主目录、上级目录、系统目录或临时目录。确实需要挂载项目外目录时，必须说明用途、最小权限、只读/读写边界、数据生命周期和清理方式。

项目级安装、编译、运行、测试、发布命令只写在 `README.md`。

## 依赖与版本策略

- 原则上，项目使用的包、依赖、工具链、基础镜像和开发环境应采用当前可用的最新稳定版本。
- 公司模板默认使用 `latest` 策略。Dev Container 基础镜像、派生项目继承的基础镜像和通用开发工具不做长期版本冻结。
- 持续更新是默认要求。派生项目应在 README、CI、自动化依赖更新工具或维护计划中说明如何跟随 `latest`。
- 如果因为平台兼容、客户认证、硬件 SDK 限制、监管要求、上游缺陷或安全例外必须固定版本，必须在 `README.md`、本文件或对应 ADR 中说明影响范围、替代方案和重新评估条件。
- 自动更新建议：
  - 依赖库：使用 Dependabot、Renovate 或平台等效工具。
  - 容器基础镜像：默认跟随 `latest`，定期重建并检查安全公告。
  - 语言工具链：优先跟随当前稳定版或当前 LTS 线。
  - 开发容器：定期重新构建，避免缓存掩盖过期依赖。

## 第三方代码与生成物

### 第三方代码

适用于不由语言生态包管理器直接管理、需要随仓库固定版本的第三方源码、固件、硬件 SDK、仿真模型、协议定义或供应商交付物。

记录要求：

| 字段 | 要求 |
|------|------|
| 来源 | 上游仓库、供应商、下载地址或交付批次 |
| 集成方式 | git submodule、vendor copy、下载脚本、包管理器 |
| 版本 | tag、commit SHA、release 编号、供应商版本或校验和 |
| 许可证 | LICENSE、NOTICE、商业授权或内部使用限制 |
| 更新方式 | 更新命令、review 要点、回滚方式 |
| 验证方式 | 构建、测试、仿真、硬件诊断或生产验收命令 |
| 真值源 | 上游、供应商包、生成输入、仓库内源码中的哪一个 |

规则：

- `3rd/` 只放需要随仓库固定的第三方源码或供应商交付物；能由 Cargo/npm/pip 等包管理器解析的依赖，不复制到 `3rd/`。
- 使用 git submodule 时，必须在 README 或对应文档说明初始化、更新和验证命令。
- vendor copy 必须说明为什么不能用 submodule 或包管理器，并记录校验和或来源版本。
- 修改第三方代码时，必须说明是否为本地 patch、如何重放、如何向上游回传或在升级时重新应用。

### 生成物

生成文件必须记录：

- 源输入：schema、IDL、模型、设计文件、脚本或供应商工具版本。
- 生成器：命令、工具版本、运行位置和环境要求。
- 提交策略：生成物是否提交仓库，是否可由 CI 重新生成校验。
- 校验策略：diff 检查、schema 校验、编译检查、仿真或硬件验证。
- 真值源：生成物和源输入冲突时，以哪个为准。

## JSON 与 JSONC

- 默认情况下，`.json` 文件应保持严格 JSON，避免注释和尾随逗号，以兼容通用解析器、CI、包管理器和第三方工具。
- 即使某些工具支持 JSONC，模板默认仍优先使用严格 JSON；需要版权或说明时，写在相邻文档、README、LICENSE/NOTICE 或生成脚本中，不在 JSON 文件里写注释。
- 只有明确由规范或主流工具声明支持 JSONC 且项目确实需要注释的文件，才允许使用 JSONC，并必须配置匹配的校验工具。
- 对于 `package.json`、API schema、数据 fixture、机器交换数据等严格 JSON 文件，不要使用注释或尾随逗号。
- `tsconfig.json` 等部分生态配置虽然常见 JSONC 支持，但仍应按该工具链的官方说明和校验工具配置决定，不能把 JSONC 作为所有 `.json` 文件的默认格式。
- 如果必须给严格 JSON 文件记录版权或元信息，优先使用规范允许的字段，例如 `_copyright`；如果 schema 不允许额外字段，则在相邻文档、LICENSE/NOTICE 或生成脚本中说明，不要破坏 JSON 兼容性。
- 校验工具必须匹配格式：JSON 文件用 JSON parser；JSONC 文件用支持 comments 的 parser 或先剥离注释再校验。

## 文档规则

### 新鲜度契约

1. 代码变更导致文档失效时，必须在同一个 PR 更新文档。
2. 易过期内容必须带日期，例如 roadmap、项目状态、迁移说明、已知技术债。
3. 易漂移的引用应使用稳定路径、ADR 编号、Issue 编号、PR 编号或 commit SHA。
4. 被文档引用的文件移动时，必须同步更新引用。
5. AI 工具的 memory 不是权威来源；引用前必须回到仓库文件验证。

### 图表规则

- 架构、数据流、状态机、生产流程和硬件拓扑优先使用 Mermaid 或 PlantUML。
- 图表必须紧邻解释文字，避免只有图片没有可审查文本。
- 图表描述的是当前承诺状态；如果只是备选方案，应在标题或说明中标注。
- 硬件连接、生产步骤、供应商边界和 SOP 流程变化时，必须同步更新相关图表。

### SAD 与 SDD

SAD（Software Architecture Document）用于描述项目当前架构，回答“系统由什么组成、边界在哪里、关键质量属性和运行/部署视图是什么”。SDD（Software Design Document）用于描述当前系统或子系统设计，回答“接口、数据模型、状态机、算法、错误处理、并发和验证如何落地”。

规则：

- SAD/SDD 是当前状态文档；ADR/RFC 记录决策历史和提案过程，不能替代 SAD/SDD。
- 架构边界、运行时模型、部署视图、硬件/供应商/生产边界变化时，应更新 SAD。
- 公开接口、数据模型、状态机、核心算法、错误处理、并发模型或生成物契约变化时，应更新 SDD。
- 大项目可以维护项目级 `docs/SAD.md`/`docs/SDD.md`，也可以按子系统拆分，但根文档必须提供索引。
- 新项目如果暂时不维护 SAD/SDD，应在 `README.md` 或 `AGENTS.md` 说明架构与设计真值源在哪里。

### ADR 规则

需要写 ADR 的情况：

- 决策建立或改变了架构不变量。
- 拒绝过一个合理备选方案。
- 决策影响多个模块、团队、平台或发布流程。
- 从既有代码中发现未文档化但必须长期保持的约定。

不需要写 ADR 的情况：

- 单纯实施步骤。
- 明显的局部代码选择。
- 临时任务 checklist。

ADR 文件放在：

```text
docs/adr/NNNN-title.md
```

新增 ADR 时必须更新 `docs/adr/README.md` 索引。

### RFC 规则

RFC 用于在最终决策前探索设计空间。一个被接受的 RFC 可以拆出一个或多个 ADR。

RFC 文件放在：

```text
docs/rfcs/NNNN-title.md
```

### Spec 与 Plan 规则

Spec 用于设计阶段，记录某个功能或子系统的设计输入。设计稳定后，应同步到 SDD 或在 SDD 中链接：

```text
docs/specs/YYYY-MM-DD-topic-design.md
```

Plan 用于执行阶段：

```text
docs/plans/YYYY-MM-DD-topic.md
```

Plan 至少包含：

- Goal
- Architecture
- Tech Stack
- 预计变更文件
- checkbox 任务
- 验证步骤
- 完成或废弃后的状态说明

## 测试

> 创建新项目时，替换成本项目真实测试分层。

默认要求：

- 单元测试覆盖局部业务逻辑。
- 集成测试覆盖模块边界。
- E2E 或系统测试覆盖关键用户路径。
- 平台 matrix 测试覆盖项目承诺支持的平台。
- bugfix 尽量补充能复现问题的回归测试。

涉及行为变化的 PR 应说明：

- 已测试什么。
- 未测试什么。
- 残余风险为什么可接受。

## 安全与密钥

- 密钥来自批准的密钥系统或本地未提交环境文件。
- 只提交 `.env.example`，不提交真实 `.env`。
- 不在日志中输出凭证、token、私有 URL、个人数据或专有业务 payload。
- 对可复现性有强要求且不能跟随 `latest` 的依赖、代码生成器、下载工具，必须说明固定版本的原因、影响范围和重新评估条件。
- 访问生产数据需要明确人工批准，并记录回滚方式。
