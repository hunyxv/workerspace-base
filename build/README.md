### 创建golang运行环境
容器启动后，可以通过 ssh 免密连接容器（使用过程中，最好不要删除容器）。

### build
```shell
chmod u+x build.sh
# 创建 go1.12 容器
./build.sh go1.12

# 创建 go1.15 容器
./build.sh go1.15
```

### 启动
```
docker run -d -p 2222:22 workspace-go1.12  # workspace-go1.12
# or
docker run -d -p 2222:22 -v xxx/go:/root/go  workspace-go1.12 # workspace-go1.12
```

### 连接
使用 IDE 直接连接到容器
或 使用 `ssh root@127.0.0.1 -p 2222` 连接到容器
