<!-- Copyright The Project Template Contributors -->

# Git 与 Commit 规范

> **模板使用说明**
>
> 本文件来自公司项目模板。派生项目应根据实际分支策略、DCO 要求和发布流程修改。

## Git 规则

- PR 应小而可审。
- 一个提交尽量只处理一个关注点。
- 未经明确批准，不重写共享历史。
- 不把无关重构混入功能或 bugfix。
- 破坏性操作需要人工确认，包括 force push、重写历史、批量删除、reset、生产数据修改。

## Commit 规范

默认采用 Conventional Commits 风格：

```text
<type>(<scope>)!: <subject>

<body>

<footer>
```

`type` 必须使用英文小写，允许值：

| type | 使用场景 |
|------|----------|
| `feat` | 新功能或能力 |
| `fix` | bug 修复 |
| `refactor` | 不改变外部行为的重构 |
| `perf` | 性能优化 |
| `test` | 测试新增或调整 |
| `docs` | 文档变更 |
| `build` | 构建系统、依赖、工具链 |
| `ci` | CI/CD 配置 |
| `chore` | 维护性杂项，不影响源码行为 |
| `style` | 格式、空白、排序等不改变语义的变更 |
| `revert` | 回退先前提交 |

规则：

- `scope` 可选，使用英文，表示影响范围，例如 `api`、`web`、`core`、`docs`、`devcontainer`。
- `!` 表示 breaking change。存在破坏性变化时必须使用 `!`，并在 body 或 footer 中说明迁移方式。
- `subject` 使用中文优先，保留必要英文术语；使用祈使或陈述式短句，不加句号，尽量不超过 72 个字符。
- body 可选，用于说明为什么改、怎么改、风险是什么；不要重复 diff 已经表达清楚的内容。
- footer 可选，用于关联 Issue/PR、注明 breaking change 或 DCO 签署。
- 默认每个 commit 必须带 DCO sign-off，即使用 `git commit -s`。如果派生项目不采用 DCO，必须在本节明确删除或改写这条规则。
- 禁止使用无信息量提交信息，例如 `update`、`fix bug`、`misc`、`wip`、`changes`。

仓库提供 `.gitmessage` 作为可选提交模板；需要时可执行：

```bash
git config commit.template .gitmessage
```

## 示例

```text
feat(api): 支持 OAuth callback
fix(runtime): 修复 Windows 路径分隔符处理
docs(agents): 明确 commit 规范
build(devcontainer): 升级 Ubuntu 26.04 基础镜像
refactor(core)!: 重命名 PluginRegistry 接口
```

破坏性变更示例：

```text
feat(config)!: 调整 provider 配置结构

BREAKING CHANGE: `providers[].apiKey` 改为 `providers[].credentials.apiKey`。
迁移时需要更新现有配置文件。
```
