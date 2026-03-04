#!/bin/bash
# dev-workflow-init skill 安装脚本

set -e

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== dev-workflow-init Skill 安装工具 ===${NC}\n"

# 检测当前目录
CURRENT_DIR=$(pwd)
echo "当前目录: $CURRENT_DIR"

# 检测 AI IDE 类型
SKILL_DIR=""

if [ -d ".claude" ]; then
    SKILL_DIR=".claude/skills"
    IDE_TYPE="Claude Code"
elif [ -d ".kiro" ]; then
    SKILL_DIR=".kiro/skills"
    IDE_TYPE="Kiro"
elif [ -d ".agents" ]; then
    SKILL_DIR=".agents/skills"
    IDE_TYPE="Cursor"
else
    echo -e "${YELLOW}未检测到 AI IDE 配置目录，请选择要安装的 IDE：${NC}"
    echo "1) Claude Code (.claude/skills/)"
    echo "2) Kiro (.kiro/skills/)"
    echo "3) Cursor (.agents/skills/)"
    read -p "请输入选项 (1-3): " choice

    case $choice in
        1) SKILL_DIR=".claude/skills"; IDE_TYPE="Claude Code" ;;
        2) SKILL_DIR=".kiro/skills"; IDE_TYPE="Kiro" ;;
        3) SKILL_DIR=".agents/skills"; IDE_TYPE="Cursor" ;;
        *) echo -e "${RED}无效选项${NC}"; exit 1 ;;
    esac
fi

echo -e "${GREEN}检测到 IDE: $IDE_TYPE${NC}"

# 创建 skills 目录
mkdir -p "$SKILL_DIR"
echo "创建目录: $SKILL_DIR"

# 获取脚本所在目录（skill 源码位置）
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_DIR="$SCRIPT_DIR/dev-workflow-init"

# 检查源码目录是否存在
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}错误: 找不到 dev-workflow-init 源码目录${NC}"
    echo "期望位置: $SOURCE_DIR"
    exit 1
fi

# 复制 skill 文件
TARGET_DIR="$SKILL_DIR/dev-workflow-init"

if [ -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}目标目录已存在，是否覆盖？(y/n)${NC}"
    read -p "> " overwrite
    if [ "$overwrite" != "y" ]; then
        echo "取消安装"
        exit 0
    fi
    rm -rf "$TARGET_DIR"
fi

echo "复制文件到: $TARGET_DIR"
cp -r "$SOURCE_DIR" "$TARGET_DIR"

# 验证安装
if [ -f "$TARGET_DIR/SKILL.md" ]; then
    echo -e "\n${GREEN}✓ 安装成功！${NC}\n"
    echo "Skill 已安装到: $TARGET_DIR"
    echo ""
    echo "使用方法："
    echo "  1. 在 AI 对话框中输入: 启动"
    echo "  2. 或输入: start"
    echo "  3. 或明确说: 请使用 dev-workflow-init skill"
    echo ""
    echo "更多信息请查看: $TARGET_DIR/README.md"
else
    echo -e "${RED}✗ 安装失败${NC}"
    exit 1
fi
