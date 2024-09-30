# ComfyUI-Docker

## 简介
本项目提供了一个 Docker 环境，用于运行 ComfyUI 及其相关的自定义节点和模型。通过使用 Docker，可以轻松地在不同的系统上部署和运行 ComfyUI。

## 目录结构
- `builder-scripts/`: 包含生成依赖文件的脚本。
  - `generate-pak5.sh`: 下载并处理各个依赖文件的脚本。
- `runner-scripts/`: 包含运行和下载脚本。
  - `download.sh`: 下载 ComfyUI 及其自定义节点的脚本。
  - `entrypoint.sh`: 容器入口脚本，负责初始化和启动 ComfyUI。
  - `download-models.txt`: 包含需要下载的模型列表。
  - `pre-start.sh.example`: 示例预启动脚本。
  - `set-proxy.sh.example`: 示例代理设置脚本。

## 使用方法

### 1. 构建 Docker 镜像
在项目根目录下运行以下命令以构建 Docker 镜像：
```bash
docker build -t comfyui-docker .
```

### 2. 运行 Docker 容器

在构建镜像后，可以运行以下命令来启动容器：
```bash
docker run -d -p 8188:8188 --name comfyui-docker comfyui-docker
```

### 3. 访问 ComfyUI
在浏览器中打开 `http://localhost:8188` 即可访问 ComfyUI 界面。

## 自定义脚本
### 设置代理
如果需要设置代理，可以在 `runner-scripts/set-proxy.sh.example` 中配置代理设置，并重命名为 `set-proxy.sh`。

### 预启动脚本
如果需要在启动 ComfyUI 之前执行一些自定义操作，可以在 `runner-scripts/pre-start.sh.example` 中编写脚本，并重命名为 `pre-start.sh`。

## 贡献
欢迎提交 Issue 和 Pull Request 来改进本项目。

## 许可证
本项目使用 MIT 许可证。详细信息请参阅 LICENSE 文件。