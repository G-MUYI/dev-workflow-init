# dev-workflow-init

一个 AI 对话式 skill，通过需求访谈自动初始化项目开发工作流。

> 💡 **第一次使用？** 查看 [5 分钟快速上手指南](GETTING_STARTED.md)

## 这是什么？

想象一下：
- 🤖 你和 AI 聊天，它问你 8 个问题
- 📝 AI 自动生成项目规范文档
- 🔍 AI 推荐适合你项目的工具
- 🔄 AI 帮你规划开发流程

**就这么简单！**

## 特性

- 🎯 通过 8 个问题收集项目需求
- 📝 自动生成项目专属的 `AGENTS.md` 规则文件
- 🔍 联网搜索并推荐适配的 skills 和工具
- 🔄 编排完整的开发工作流步骤
- 🤖 **跨 IDE 支持**：Claude Code、Kiro、Cursor、VSCode Copilot、Windsurf 等

## 快速开始

### 🎯 三步上手

1. **安装** - 运行一个命令
2. **启动** - 对 AI 说"启动"
3. **回答** - 回答 8 个问题

就这么简单！

### 📦 详细安装步骤

**新手推荐：** [图文安装教程](INSTALLATION.md)

**快速安装：**

在**目标项目**根目录运行：

```bash
# Windows
path\to\dev-workflow-init\install-unified.bat

# Linux/Mac
bash path/to/dev-workflow-init/install-unified.sh
```

**特点：**
- ✅ 创建统一的 `.ai/skills/` 目录存储 skill
- ✅ 自动为所有 IDE 配置（Claude Code、Kiro、Cursor、VSCode、Windsurf）
- ✅ 优先使用符号链接（需要管理员权限），失败则自动降级为复制文件
- ✅ 一次安装，支持所有 IDE

### 🚀 开始使用

在 AI IDE 中打开项目，在对话框输入：

```
启动
```

AI 会开始问你问题，像这样：

```
你好！我会通过 8 个问题帮你梳理项目需求...

现在开始第一个问题：

1️⃣ 你想实现的核心效果是什么？请用 1-2 句话描述。
```

然后跟随 AI 的提问完成需求访谈。

**更多帮助：**
- 📖 [5 分钟快速上手](GETTING_STARTED.md) - 小白友好的完整教程
- 📦 [图文安装教程](INSTALLATION.md) - 详细的安装步骤
- 📚 [快速开始指南](QUICKSTART.md) - 技术文档

## 文档导航

### 🎓 新手入门
- [5 分钟快速上手](GETTING_STARTED.md) - **推荐第一次使用的用户阅读**
- [图文安装教程](INSTALLATION.md) - 详细的安装步骤说明

### 📚 进阶文档
- [跨 IDE 兼容性指南](CROSS_IDE_COMPATIBILITY.md) - 支持的 IDE 和配置详情
- [快速开始指南](QUICKSTART.md) - 技术文档
- [Skill 说明](dev-workflow-init/README.md) - 详细功能介绍
- [使用示例](dev-workflow-init/USAGE_EXAMPLES.md) - 不同场景的使用方式
- [测试指南](dev-workflow-init/TESTING.md) - 测试和问题排查

## 工作流程

```
启动 → 需求访谈 → 确认摘要 → 生成 AGENTS.md → 推荐 Skills → 编排工作流
```

## 项目结构

```
dev-workflow-init-repo/
├── README.md                    # 本文件
├── QUICKSTART.md                # 快速开始指南
├── CROSS_IDE_COMPATIBILITY.md   # 跨 IDE 兼容性指南
├── install-unified.bat          # Windows 统一安装脚本
├── install-unified.sh           # Linux/Mac 统一安装脚本
└── dev-workflow-init/           # Skill 源码
    ├── SKILL.md                 # 核心 skill 文件
    ├── README.md                # Skill 说明
    ├── USAGE_EXAMPLES.md        # 使用示例
    ├── TESTING.md               # 测试指南
    └── references/              # 参考文档
        ├── search-strategy.md   # 搜索策略
        └── agents-template.md   # AGENTS.md 模板
```

**安装后的项目结构：**
```
your-project/
├── .ai/skills/dev-workflow-init/        # 统一存储位置
├── .claude/skills/dev-workflow-init/    # Claude Code（符号链接或副本）
├── .kiro/skills/dev-workflow-init/      # Kiro（符号链接或副本）
├── .cursor/skills/dev-workflow-init/    # Cursor（符号链接或副本）
├── .vscode/skills/dev-workflow-init/    # VSCode（符号链接或副本）
├── .windsurf/skills/dev-workflow-init/  # Windsurf（符号链接或副本）
├── .cursorrules                         # Cursor 规则
├── .vscode/settings.json                # VSCode 配置
└── AGENTS.md                            # 通用规则（初始化后生成）
```

## 常见问题

### Q: 为什么 AI 说"启动"后没有反应？

A: 确保 skill 安装在正确位置。运行 `install-unified.bat/sh` 会自动配置所有 IDE。

### Q: 符号链接和复制文件有什么区别？

A:
- **符号链接**（需要管理员权限）：只需维护 `.ai/skills/` 中的一份文件，所有 IDE 自动同步
- **复制文件**（无需特殊权限）：每个 IDE 有独立副本，更新时需重新运行安装脚本

安装脚本会自动尝试符号链接，失败则降级为复制文件。

### Q: 可以在多个项目中使用吗？

A: 可以。在每个项目中运行安装脚本即可。

**更多问题？** 查看 [完整 FAQ](FAQ.md) 或 [提交 Issue](https://github.com/G-MUYI/dev-workflow-init/issues)

### Q: 支持哪些 AI IDE？

A:
- ✅ Claude Code
- ✅ Kiro
- ✅ Cursor
- ✅ VSCode (with GitHub Copilot)
- ✅ Windsurf
- ⚠️ Trae (待测试)

详见 [跨 IDE 兼容性指南](CROSS_IDE_COMPATIBILITY.md)。

## 许可证

MIT

## 作者

YY
