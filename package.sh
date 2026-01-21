#!/bin/bash

# 项目打包脚本 - 生成干净的代码包
# 用法: ./package.sh [输出文件名]

# 设置输出文件名（默认使用项目名 + 时间戳）
OUTPUT_NAME=${1:-"longmao-repo-demo-$(date +%Y%m%d-%H%M%S).zip"}

# 固定项目目录名
PROJECT_DIR="longmao-repo-demo"

echo "📦 开始打包项目..."
echo "📁 项目目录: $PROJECT_DIR"
echo "💾 输出文件: $OUTPUT_NAME"
echo ""

# 创建临时目录
TEMP_DIR=$(mktemp -d)
PACKAGE_DIR="$TEMP_DIR/$PROJECT_DIR"

# 复制项目文件到临时目录
echo "📋 复制项目文件..."
mkdir -p "$PACKAGE_DIR"
rsync -a --progress \
  --exclude='node_modules' \
  --exclude='.git' \
  --exclude='dist' \
  --exclude='build' \
  --exclude='.DS_Store' \
  --exclude='*.log' \
  --exclude='coverage' \
  --exclude='.next' \
  --exclude='.cache' \
  --exclude='*.swp' \
  --exclude='*.swo' \
  --exclude='.vscode' \
  --exclude='.idea' \
  --exclude='*.zip' \
  --exclude='package.sh' \
  --exclude='backend/.env' \
  --exclude='frontend/.env' \
  . "$PACKAGE_DIR/"

echo ""
echo "🗜️  压缩文件..."
cd "$TEMP_DIR" && zip -r -q "$OLDPWD/$OUTPUT_NAME" "$PROJECT_DIR"

# 清理临时目录
rm -rf "$TEMP_DIR"

# 获取文件大小
SIZE=$(du -h "$OUTPUT_NAME" | cut -f1)

echo ""
echo "✅ 打包完成！"
echo "📦 文件: $OUTPUT_NAME"
echo "📊 大小: $SIZE"
echo ""
echo "💡 提示: 可以使用以下命令解压："
echo "   unzip $OUTPUT_NAME"
