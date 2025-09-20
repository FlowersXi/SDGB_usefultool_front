# 使用官方的Node.js镜像作为基础镜像
FROM node:23-alpine

# 设置工作目录
WORKDIR /app

# 将package.json和package-lock.json复制到工作目录
COPY package*.json ./

# 安装依赖
RUN npm install

# 将项目源代码复制到容器中
COPY . .

# 构建Vite项目
RUN npm run build

# 使用nginx服务来提供构建后的文件
FROM nginx:alpine

# 复制构建后的文件到nginx的html目录
COPY --from=0 /app/dist /usr/share/nginx/html

# 暴露容器的80端口
EXPOSE 80

# 启动nginx服务
CMD ["nginx", "-g", "daemon off;"]
