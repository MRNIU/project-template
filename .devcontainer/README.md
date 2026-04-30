# Dev Container

本目录负责开发容器实现。

开发环境相关 Docker 文件放在这里：

- `devcontainer.json`
- `Dockerfile`
- `compose.yaml`：需要本地数据库、缓存、消息队列等服务时再添加
- `scripts/`：容器初始化脚本

除非项目明确发布生产容器镜像，否则不要在仓库根目录添加 Dockerfile。

