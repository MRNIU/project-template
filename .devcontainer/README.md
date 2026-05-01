<!-- Copyright The Project Template Contributors -->

# Dev Container

本目录负责模板项目的开发容器和公司通用基础镜像。

模板仓库发布的基础镜像：

```Dockerfile
FROM ghcr.io/libodynamics/project_template/devcontainer:latest
```

公司策略是统一使用 `latest`。派生项目默认继承这个镜像，并在自己的 `.devcontainer/Dockerfile` 中追加项目专用工具链、SDK、模拟器、数据库客户端、硬件工具或缓存配置。

## 文件分工

- `devcontainer.json`
- `Dockerfile`：派生项目默认入口，基于 `ghcr.io/libodynamics/project_template/devcontainer:latest`
- `base.Dockerfile`：模板仓库维护的基础镜像源文件，由 CI 发布到 GHCR
- `compose.yaml`：需要本地数据库、缓存、消息队列等服务时再添加
- `scripts/`：容器初始化脚本

除非项目明确发布生产容器镜像，否则不要在仓库根目录添加 Dockerfile。

## 基础镜像工具

模板默认安装跨项目常用工具：

- 基础构建：`build-essential`、`pkg-config`、`cmake`、`ninja-build`、`make`
- C/C++/FFI：`clang`、`llvm`、`lld`、`libclang-dev`、`libssl-dev`
- Rust：`rustup stable`、`clippy`、`rustfmt`、`llvm-tools-preview`
- Shell 与排障：`zsh`、`vim`、`less`、`tree`、`htop`
- 文本与 JSON：`jq`、`ripgrep`、`fd`、`bat`
- 脚本与文档：`python3`、`pre-commit`、Ubuntu 26.04 archive 提供的 `nodejs`、`npm@latest`、`graphviz`、`@mermaid-js/mermaid-cli`、latest upstream `plantuml`
- Dev Container 辅助：`@devcontainers/cli`
- 依赖维护：`npm-check-updates`
- 协作：`git`、`git-lfs`、`openssh-client`、`gh`
- Locale：`en_US.UTF-8`

默认交互用户是 `dev`，默认 shell 是 `zsh`，并允许免密码 `sudo`。Dockerfile 构建阶段仍使用 root；派生项目需要安装系统包时，继续在 `.devcontainer/Dockerfile` 中使用 `RUN apt-get ...`。

## 派生项目可选工具

不要把只有单个项目使用的工具强制装入基础镜像。派生项目按需要在 `.devcontainer/Dockerfile` 中追加：

```Dockerfile
FROM ghcr.io/libodynamics/project_template/devcontainer:latest

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

项目专用工具也应由派生项目按需添加，例如 Tauri Linux 依赖、交叉编译器、RT 工具、CAN 工具、MATLAB/Simulink 外部脚本入口、数据库客户端或硬件 SDK。

## 手动 Docker 验证

维护模板基础镜像时，可以在本地直接构建：

```bash
docker build --pull -f .devcontainer/base.Dockerfile -t ghcr.io/libodynamics/project_template/devcontainer:latest .devcontainer
docker build --pull=false -f .devcontainer/Dockerfile -t project-template-devcontainer:latest .devcontainer
docker run --rm -v "$PWD:/workspace" -w /workspace project-template-devcontainer:latest bash -lc 'pre-commit run --all-files && rustc --version && node --version && npm --version && devcontainer --version && mmdc --version && plantuml -version && ncu --version'
```

手动 `docker run`、Compose volume 和 Dev Container mount 只能把当前仓库或仓库内子目录挂载到容器项目工作区内，例如 `$PWD:/workspace`。不要把用户主目录、上级目录、系统目录或无关临时目录挂入容器。

CI 会在 `main` 分支和每周定时任务中把基础镜像发布为：

```text
ghcr.io/libodynamics/project_template/devcontainer:latest
```

## 验证环境

```bash
cat /etc/os-release
git --version
gh --version
python3 --version
node --version
npm --version
rustc --version
cargo --version
cargo clippy --version
rustfmt --version
pre-commit --version
rg --version
fd --version
bat --version
devcontainer --version
mmdc --version
plantuml -version
ncu --version
```
