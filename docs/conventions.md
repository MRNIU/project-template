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
  README.md
  SECURITY.md
  .devcontainer/
    devcontainer.json
    Dockerfile
    compose.yaml          # 可选，仅在本地开发需要多服务时使用
    scripts/              # 可选，容器初始化脚本
  docs/
    README.md
    conventions.md
    git.md
    adr/
    rfcs/
    specs/
    plans/
    screenshots/
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
- 大模块如果有独立架构边界、依赖约束或修改 checklist，应在模块根目录放一个局部 `AGENTS.md`。

## 开发环境

默认开发环境是 Dev Container。

宿主机依赖应保持最少：

- Git
- Docker / Docker Desktop
- 支持 Dev Container 的编辑器或 AI agent 工具
- 无法放进容器的平台原生 SDK、硬件工具或签名工具，必须在 `README.md` 中说明

平台约定：

- Windows 开发者优先使用 WSL2 工作区。
- macOS/Linux 开发者按公司策略使用 Docker Desktop 或 Docker Engine。
- 硬件访问、签名、公证、GUI 验证、平台安装包构建，可能需要原生机器或 self-hosted runner。

模板默认 Dev Container 基于 Ubuntu 26.04 LTS。通用工具放在 `.devcontainer/Dockerfile`；语言工具链、SDK、数据库、模拟器、交叉编译器、硬件工具由派生项目按需添加并记录在 `README.md`。

项目级安装、编译、运行、测试、发布命令只写在 `README.md`。

## 文档规则

### 新鲜度契约

1. 代码变更导致文档失效时，必须在同一个 PR 更新文档。
2. 易过期内容必须带日期，例如 roadmap、项目状态、迁移说明、已知技术债。
3. 易漂移的引用应使用稳定路径、ADR 编号、Issue 编号、PR 编号或 commit SHA。
4. 被文档引用的文件移动时，必须同步更新引用。
5. AI 工具的 memory 不是权威来源；引用前必须回到仓库文件验证。

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

Spec 用于设计阶段：

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
- 对可复现性有要求的依赖、代码生成器、下载工具必须固定版本。
- 访问生产数据需要明确人工批准，并记录回滚方式。
