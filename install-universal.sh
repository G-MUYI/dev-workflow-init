#!/bin/bash
# 跨 AI IDE 通用安装脚本
# 支持: Claude Code, Kiro, Cursor, VSCode Copilot, Windsurf 等

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== dev-workflow-init 跨 IDE 安装工具 ===${NC}\n"

CURRENT_DIR=$(pwd)
echo "当前目录: $CURRENT_DIR"

# 获取脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_DIR="$SCRIPT_DIR/dev-workflow-init"

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}错误: 找不到 dev-workflow-init 源码目录${NC}"
    exit 1
fi

# 检测已安装的 AI IDE
DETECTED_IDES=()

if [ -d ".claude" ] || [ -f ".claude.json" ]; then
    DETECTED_IDES+=("claude")
fi

if [ -d ".kiro" ] || [ -f ".kiro.json" ]; then
    DETECTED_IDES+=("kiro")
fi

if [ -d ".cursor" ] || [ -f ".cursorrules" ]; then
    DETECTED_IDES+=("cursor")
fi

if [ -d ".vscode" ]; then
    DETECTED_IDES+=("vscode")
fi

if [ -d ".windsurf" ]; then
    DETECTED_IDES+=("windsurf")
fi

# 显示检测结果
if [ ${#DETECTED_IDES[@]} -eq 0 ]; then
    echo -e "${YELLOW}未检测到已配置的 AI IDE${NC}"
    echo "将为所有支持的 IDE 创建配置"
    INSTALL_ALL=true
else
    echo -e "${BLUE}检测到以下 IDE:${NC}"
    for ide in "${DETECTED_IDES[@]}"; do
        echo "  - $ide"
    done
    echo ""
    echo "选择安装方式:"
    echo "1) 仅为检测到的 IDE 安装"
    echo "2) 为所有支持的 IDE 安装（推荐）"
    read -p "请选择 (1-2): " choice

    if [ "$choice" = "2" ]; then
        INSTALL_ALL=true
    else
        INSTALL_ALL=false
    fi
fi

# 安装函数
install_for_ide() {
    local ide_name=$1
    local skill_dir=$2
    local extra_files=$3

    echo -e "\n${BLUE}→ 安装到 $ide_name${NC}"

    # 创建 skills 目录
    mkdir -p "$skill_dir"

    # 复制 skill 文件
    local target_dir="$skill_dir/dev-workflow-init"

    if [ -d "$target_dir" ]; then
        echo "  目录已存在，覆盖..."
        rm -rf "$target_dir"
    fi

    cp -r "$SOURCE_DIR" "$target_dir"
    echo "  ✓ 已复制到: $target_dir"

    # 处理额外文件（如 .cursorrules）
    if [ -n "$extra_files" ]; then
        eval "$extra_files"
    fi
}

# 开始安装
echo -e "\n${GREEN}开始安装...${NC}"

# Claude Code
if [ "$INSTALL_ALL" = true ] || [[ " ${DETECTED_IDES[@]} " =~ " claude " ]]; then
    install_for_ide "Claude Code" ".claude/skills"
fi

# Kiro
if [ "$INSTALL_ALL" = true ] || [[ " ${DETECTED_IDES[@]} " =~ " kiro " ]]; then
    install_for_ide "Kiro" ".kiro/skills"
fi

# Cursor
if [ "$INSTALL_ALL" = true ] || [[ " ${DETECTED_IDES[@]} " =~ " cursor " ]]; then
    install_for_ide "Cursor" ".cursor/skills" "
        # 同时创建 .cursorrules 文件
        if [ ! -f '.cursorrules' ]; then
            cat > .cursorrules << 'CURSORRULES'
# AI 开发规则

## 项目初始化

当用户说「启动」、「start」、「开始」或「初始化项目」时，执行以下流程：

1. 通过 8 个问题收集项目需求
2. 生成 AGENTS.md 规则文件
3. 推荐适配的 skills 和工具
4. 编排开发工作流

详细规则请参考: .cursor/skills/dev-workflow-init/SKILL.md

CURSORRULES
            echo '  ✓ 已创建 .cursorrules'
        fi
    "
fi

# VSCode (Copilot)
if [ "$INSTALL_ALL" = true ] || [[ " ${DETECTED_IDES[@]} " =~ " vscode " ]]; then
    install_for_ide "VSCode" ".vscode/skills" "
        # 创建 VSCode 配置
        mkdir -p .vscode
        if [ ! -f '.vscode/settings.json' ]; then
            cat > .vscode/settings.json << 'VSCODE_SETTINGS'
{
  \"github.copilot.chat.codeGeneration.instructions\": [
    {
      \"file\": \".vscode/skills/dev-workflow-init/SKILL.md\"
    }
  ]
}
VSCODE_SETTINGS
            echo '  ✓ 已创建 .vscode/settings.json'
        else
            echo '  ⚠ .vscode/settings.json 已存在，请手动添加配置'
        fi
    "
fi

# Windsurf
if [ "$INSTALL_ALL" = true ] || [[ " ${DETECTED_IDES[@]} " =~ " windsurf " ]]; then
    install_for_ide "Windsurf" ".windsurf/skills"
fi

# 创建通用的 AGENTS.md 引用文件
echo -e "\n${BLUE}→ 创建通用配置${NC}"
if [ ! -f "AGENTS.md" ]; then
    cat > AGENTS.md << 'AGENTS_MD'
# AGENTS 统一规则源

> 本文件将在项目初始化后自动生成完整内容

## 快速开始

在 AI IDE 中输入以下任一指令启动项目初始化：
- `启动`
- `start`
- `开始`
- `初始化项目`

AI 会通过 8 个问题收集需求，然后自动生成完整的项目规则和工作流。

## 支持的 AI IDE

- Claude Code
- Kiro
- Cursor
- VSCode (with Copilot)
- Windsurf

AGENTS_MD
    echo "  ✓ 已创建 AGENTS.md 占位文件"
else
    echo "  ⚠ AGENTS.md 已存在，跳过"
fi

# 完成
echo -e "\n${GREEN}✓ 安装完成！${NC}\n"
echo "已安装的位置:"
[ -d ".claude/skills/dev-workflow-init" ] && echo "  • .claude/skills/dev-workflow-init/"
[ -d ".kiro/skills/dev-workflow-init" ] && echo "  • .kiro/skills/dev-workflow-init/"
[ -d ".cursor/skills/dev-workflow-init" ] && echo "  • .cursor/skills/dev-workflow-init/"
[ -d ".vscode/skills/dev-workflow-init" ] && echo "  • .vscode/skills/dev-workflow-init/"
[ -d ".windsurf/skills/dev-workflow-init" ] && echo "  • .windsurf/skills/dev-workflow-init/"

echo ""
echo "使用方法："
echo "  1. 用任意支持的 AI IDE 打开此项目"
echo "  2. 在对话框中输入: 启动"
echo "  3. 跟随 AI 的提问完成需求访谈"
echo ""
echo "更多信息: .claude/skills/dev-workflow-init/README.md"
