<!-- Copyright The Project Template Contributors -->

# 文档模板

本目录保存可复制到派生项目中的模板。使用时应复制到对应目录并改名，不要直接在本目录填写真实项目内容。

| 模板 | 用途 | 建议目标位置 |
|------|------|--------------|
| `local-AGENTS.md` | 模块、crate、服务、硬件子系统的局部协作规则 | 模块根目录 `AGENTS.md` |
| `hardware-design.md` | 硬件设计、接口、拓扑、测试夹具和生产约束 | `docs/hardware/YYYY-MM-DD-topic.md` |
| `supplier-record.md` | 供应商、外协、第三方交付物和验收记录 | `docs/suppliers/vendor-name.md` |
| `sop.md` | 标准作业流程，覆盖生产、部署、测试、回滚等重复操作 | `docs/sop/topic.md` |

图表优先使用 Mermaid 或 PlantUML。图表必须配套文字说明，不能替代接口、参数、验收标准和责任边界。
