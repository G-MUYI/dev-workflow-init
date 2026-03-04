#!/bin/bash
# 统一 AI Skills 安装脚本（使用符号链接方案）
# 创建 .ai/skills/ 作为统一存储，各 IDE 通过符号链接访问

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== dev-workflow-init 统一安装工具 ===${NC}\n"

CURRENT_DIR=$(pwd)
echo "当前目录: $CURRENT_DIR"

# 获取脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_DIR="$SCRIPT_DIR/dev-workflow-init"

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}错误: 找不到 dev-workflow-init 源码目录${NC}"
    exit 1
fi

# 创建统一的 .ai/skills 目录
UNIFIED_SKILLS_DIR=".ai/skills"
echo -e "${BLUE}→ 创建统一 skills 目录: $UNIFIED_SKILLS_DIR${NC}"
mkdir -p "$UNIFIED_SKILLS_DIR"

# 复制 skill 到统一目录
TARGET_DIR="$UNIFIED_SKILLS_DIR/dev-workflow-init"
if [ -d "$TARGET_DIR" ]; then
    echo "  目录已存在，覆盖..."
    rm -rf "$TARGET_DIR"
fi

cp -r "$SOURCE_DIR" "$TARGET_DIR"
echo -e "  ${GREEN}✓${NC} 已复制到: $TARGET_DIR"

# 创建符号链接函数
create_symlink() {
    local ide_name=$1
    local ide_skills_dir=$2
    local extra_config=$3

    echo -e "\n${BLUE}→ 配置 $ide_name${NC}"

    # 创建 IDE skills 目录（确保父目录存在）
    mkdir -p "$ide_skills_dir"

    # 创建符号链接
    local link_path="$ide_skills_dir/dev-workflow-init"

    if [ -L "$link_path" ]; then
        echo "  符号链接已存在，重新创建..."
        rm "$link_path"
    elif [ -d "$link_path" ]; then
        echo "  发现实体目录，转换为符号链接..."
        rm -rf "$link_path"
    fi

    # 创建相对路径符号链接（更便携）
    local relative_path=$(realpath --relative-to="$ide_skills_dir" "$TARGET_DIR" 2>/dev/null || echo "../../$TARGET_DIR")

    # 尝试创建符号链接
    if ln -s "$relative_path" "$link_path" 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} 已创建符号链接: $link_path -> $TARGET_DIR"
    else
        # 符号链接失败，降级为复制文件
        echo -e "  ${YELLOW}⚠${NC} 符号链接创建失败（可能需要管理员权限），改为复制文件"
        cp -r "$TARGET_DIR" "$link_path"
        echo -e "  ${GREEN}✓${NC} 已复制到: $link_path"
    fi

    # 执行额外配置
    if [ -n "$extra_config" ]; then
        eval "$extra_config"
    fi
}

# 为各个 IDE 创建符号链接
create_symlink "Claude Code" ".claude/skills"

create_symlink "Kiro" ".kiro/skills"

create_symlink "Cursor" ".cursor/skills" "
    # 创建 .cursorrules
    if [ ! -f '.cursorrules' ]; then
        cat > .cursorrules << 'CURSORRULES'
# AI 开发规则

## 项目初始化

当用户说「启动」、「start」、「开始」或「初始化项目」时，执行以下流程：

1. 通过 8 个问题收集项目需求
2. 生成 AGENTS.md 规则文件
3. 推荐适配的 skills 和工具
4. 编排开发工作流

详细规则请参考: .ai/skills/dev-workflow-init/SKILL.md

CURSORRULES
        echo -e '  ${GREEN}✓${NC} 已创建 .cursorrules'
    fi
"

create_symlink "VSCode" ".vscode/skills" "
    # 创建 VSCode 配置
    if [ ! -f '.vscode/settings.json' ]; then
        cat > .vscode/settings.json << 'VSCODE_SETTINGS'
{
  \"github.copilot.chat.codeGeneration.instructions\": [
    {
      \"file\": \".ai/skills/dev-workflow-init/SKILL.md\"
    }
  ]
}
VSCODE_SETTINGS
        echo -e '  ${GREEN}✓${NC} 已创建 .vscode/settings.json'
    else
        echo -e '  ${YELLOW}⚠${NC} .vscode/settings.json 已存在，请手动添加配置'
    fi
"

create_symlink "Windsurf" ".windsurf/skills"

# 创建 .ai/README.md 说明文件
cat > .ai/README.md << 'AI_README'
# .ai 目录说明

这是项目的统一 AI 配置目录。

## 目录结构

```
.ai/
├── README.md           # 本文件
└── skills/             # 统一的 skills 存储目录
    └── dev-workflow-init/
        ├── SKILL.md
        └── ...
```

## 工作原理

- 所有 skill 文件实际存储在 `.ai/skills/` 目录中
- 各个 AI IDE 的 skills 目录（如 `.claude/skills/`、`.kiro/skills/` 等）通过符号链接指向这里
- 这样只需维护一份文件，所有 IDE 都能访问

## 支持的 IDE

- Claude Code (`.claude/skills/` → `.ai/skills/`)
- Kiro (`.kiro/skills/` → `.ai/skills/`)
- Cursor (`.cursor/skills/` → `.ai/skills/`)
- VSCode (`.vscode/skills/` → `.ai/skills/`)
- Windsurf (`.windsurf/skills/` → `.ai/skills/`)

## 添加新 Skill

将新的 skill 文件夹放入 `.ai/skills/` 目录即可，所有 IDE 会自动识别。

AI_README

echo -e "  ${GREEN}✓${NC} 已创建 .ai/README.md"

# 创建通用 AGENTS.md
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

## 技术说明

本项目使用统一的 `.ai/skills/` 目录存储所有 AI skills，各 IDE 通过符号链接访问。

AGENTS_MD
    echo -e "\n${BLUE}→ 创建通用配置${NC}"
    echo -e "  ${GREEN}✓${NC} 已创建 AGENTS.md"
fi

# 完成
echo -e "\n${GREEN}✓ 安装完成！${NC}\n"
echo "项目结构："
echo "  .ai/skills/dev-workflow-init/  ← 统一存储位置"
echo ""
echo "符号链接："
[ -L ".claude/skills/dev-workflow-init" ] && echo "  • .claude/skills/dev-workflow-init → .ai/skills/dev-workflow-init"
[ -L ".kiro/skills/dev-workflow-init" ] && echo "  • .kiro/skills/dev-workflow-init → .ai/skills/dev-workflow-init"
[ -L ".cursor/skills/dev-workflow-init" ] && echo "  • .cursor/skills/dev-workflow-init → .ai/skills/dev-workflow-init"
[ -L ".vscode/skills/dev-workflow-init" ] && echo "  • .vscode/skills/dev-workflow-init → .ai/skills/dev-workflow-init"
[ -L ".windsurf/skills/dev-workflow-init" ] && echo "  • .windsurf/skills/dev-workflow-init → .ai/skills/dev-workflow-init"

echo ""
echo "使用方法："
echo "  1. 用任意支持的 AI IDE 打开此项目"
echo "  2. 在对话框中输入: 启动"
echo "  3. 跟随 AI 的提问完成需求访谈"
echo ""
echo "优势："
echo "  • 只需维护一份 skill 文件（在 .ai/skills/ 中）"
echo "  • 更新一次，所有 IDE 同步"
echo "  • 项目结构更清晰"
