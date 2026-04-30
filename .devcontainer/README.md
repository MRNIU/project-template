<!-- Copyright The Project Template Contributors -->

# Dev Container

本目录负责开发容器实现。

默认基础镜像：

```Dockerfile
FROM ubuntu:26.04
```

开发环境相关 Docker 文件放在这里：

- `devcontainer.json`
- `Dockerfile`
- `compose.yaml`：需要本地数据库、缓存、消息队列等服务时再添加
- `scripts/`：容器初始化脚本

除非项目明确发布生产容器镜像，否则不要在仓库根目录添加 Dockerfile。

## 默认工具

模板默认安装跨项目常用工具：

- 基础构建：`build-essential`、`pkg-config`
- Shell 与排障：`zsh`、`vim`、`less`、`tree`、`htop`
- 文本与 JSON：`jq`、`ripgrep`、`fd`、`bat`
- 脚本与文档：`python3`、`nodejs`、`npm`、`graphviz`、`@mermaid-js/mermaid-cli`
- 协作：`git`、`gh`
- Locale：`en_US.UTF-8`

## 派生项目可选工具

不要把所有项目都用不到的工具强制装入模板。派生项目按需要追加：

```Dockerfile
# 嵌入式 / 内核 / 固件开发常见工具
RUN apt-get update && apt-get install --no-install-recommends -y \
    qemu-system-arm \
    qemu-system-misc \
    gdb-multiarch \
    device-tree-compiler \
    u-boot-tools \
    dosfstools \
    gcc-riscv64-linux-gnu \
    binutils-riscv64-linux-gnu \
    gcc-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    gcc-arm-linux-gnueabihf \
    binutils-arm-linux-gnueabihf \
    && rm -rf /var/lib/apt/lists/*
```

语言工具链也应由派生项目按需添加，例如 Rust、Go、Java、.NET、Node LTS 管理器或嵌入式 SDK。

## 验证环境

```bash
cat /etc/os-release
git --version
gh --version
python3 --version
node --version
npm --version
rg --version
fd --version
bat --version
mmdc --version
```
