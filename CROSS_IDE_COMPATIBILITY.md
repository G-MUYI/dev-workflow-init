# 跨 AI IDE 兼容性指南

本 skill 支持多个 AI IDE，每个 IDE 有不同的配置机制。

## 支持的 AI IDE

| IDE | 配置目录 | 配置文件 | 状态 |
|-----|---------|---------|------|
| **Claude Code** | `.claude/skills/` | `SKILL.md` | ✅ 完全支持 |
| **Kiro** | `.kiro/skills/` | `SKILL.md` | ✅ 完全支持 |
| **Cursor** | `.cursor/skills/` | `.cursorrules` + `SKILL.md` | ✅ 完全支持 |
| **VSCode (Copilot)** | `.vscode/skills/` | `settings.json` | ✅ 支持 |
| **Windsurf** | `.windsurf/skills/` | `SKILL.md` | ✅ 支持 |
| **Trae** | 待确认 | 待确认 | ⚠️ 待测试 |

## 安装方式

### 方法 1：通用安装脚本（推荐）

使用 `install-universal.sh` 或 `install-universal.bat` 可以一次性为所有 IDE 安装：

```bash
# Windows
install-universal.bat

# Linux/Mac
bash install-universal.sh
```

脚本会：
1. 自动检测已安装的 AI IDE
2. 询问是否为所有 IDE 安装
3. 创建对应的配置文件和目录结构

### 方法 2：单独安装

如果只想为特定 IDE 安装，使用原始脚本：

```bash
# Windows
install.bat

# Linux/Mac
bash install.sh
```

## 各 IDE 的配置详情

### Claude Code

**目录结构：**
```
.claude/
└── skills/
    └── dev-workflow-init/
        ├── SKILL.md
        ├── README.md
        └── ...
```

**触发方式：**
- 直接说"启动"或"start"
- AI 会自动识别 SKILL.md 中的触发条件

### Kiro

**目录结构：**
```
.kiro/
└── skills/
    └── dev-workflow-init/
        ├── SKILL.md
        └── ...
```

**触发方式：**
- 同 Claude Code

### Cursor

**目录结构：**
```
.cursor/
└── skills/
    └── dev-workflow-init/
        └── SKILL.md
.cursorrules  ← 额外的规则文件
```

**配置文件 `.cursorrules`：**
```markdown
# AI 开发规则

## 项目初始化

当用户说「启动」、「start」、「开始」或「初始化项目」时，执行以下流程：

1. 通过 8 个问题收集项目需求
2. 生成 AGENTS.md 规则文件
3. 推荐适配的 skills 和工具
4. 编排开发工作流

详细规则请参考: .cursor/skills/dev-workflow-init/SKILL.md
```

**触发方式：**
- Cursor 会读取 `.cursorrules` 文件
- 说"启动"时会按照规则执行

### VSCode (with GitHub Copilot)

**目录结构：**
```
.vscode/
├── skills/
│   └── dev-workflow-init/
│       └── SKILL.md
└── settings.json
```

**配置文件 `.vscode/settings.json`：**
```json
{
  "github.copilot.chat.codeGeneration.instructions": [
    {
      "file": ".vscode/skills/dev-workflow-init/SKILL.md"
    }
  ]
}
```

**触发方式：**
- 在 Copilot Chat 中说"启动"
- Copilot 会读取 SKILL.md 作为指令

**注意事项：**
- 需要安装 GitHub Copilot 扩展
- 需要 Copilot Chat 功能（付费订阅）

### Windsurf

**目录结构：**
```
.windsurf/
└── skills/
    └── dev-workflow-init/
        └── SKILL.md
```

**触发方式：**
- 同 Claude Code

### Trae

**状态：** 待确认

Trae 的 skill 机制尚未完全确认。如果你使用 Trae，可以尝试：
1. 将 skill 放在项目根目录的 `.ai/` 或 `.trae/` 目录
2. 或直接将 SKILL.md 内容添加到项目的 README.md 中

## 通用配置：AGENTS.md

所有 IDE 都会读取项目根目录的 `AGENTS.md` 文件。安装脚本会创建一个占位文件：

```markdown
# AGENTS 统一规则源

> 本文件将在项目初始化后自动生成完整内容

## 快速开始

在 AI IDE 中输入以下任一指令启动项目初始化：
- `启动`
- `start`
- `开始`
- `初始化项目`
```

当你完成需求访谈后，这个文件会被自动填充完整的项目规则和工作流。

## 测试兼容性

安装后，在不同 IDE 中测试：

1. **Claude Code / Kiro / Windsurf**
   ```
   启动
   ```
   应该立即开始访谈

2. **Cursor**
   ```
   启动
   ```
   会根据 `.cursorrules` 执行

3. **VSCode Copilot**
   ```
   @workspace 启动
   ```
   或在 Copilot Chat 中直接说"启动"

## 故障排除

### 问题：某个 IDE 无法识别 skill

**解决方法：**
1. 检查对应的目录是否存在
2. 重启 IDE
3. 查看 IDE 的日志/控制台是否有错误
4. 尝试明确说："请使用 dev-workflow-init skill"

### 问题：VSCode Copilot 没有反应

**可能原因：**
- 没有安装 GitHub Copilot 扩展
- 没有订阅 Copilot
- `settings.json` 配置不正确

**解决方法：**
1. 确认已安装并激活 Copilot
2. 检查 `.vscode/settings.json` 配置
3. 尝试在 Copilot Chat 中使用 `@workspace` 前缀

### 问题：Cursor 没有读取 .cursorrules

**解决方法：**
1. 确认 `.cursorrules` 文件在项目根目录
2. 重启 Cursor
3. 在设置中检查是否启用了 Rules 功能

## 推荐的项目结构

为了最大化兼容性，推荐的项目结构：

```
your-project/
├── .claude/skills/dev-workflow-init/    # Claude Code
├── .kiro/skills/dev-workflow-init/      # Kiro
├── .cursor/skills/dev-workflow-init/    # Cursor
├── .vscode/
│   ├── skills/dev-workflow-init/        # VSCode
│   └── settings.json
├── .windsurf/skills/dev-workflow-init/  # Windsurf
├── .cursorrules                         # Cursor 规则
├── AGENTS.md                            # 通用规则（初始化后生成）
└── (你的项目文件)
```

使用 `install-universal.bat` 或 `install-universal.sh` 会自动创建这个结构。

## 参考资料

- [Claude Code Skills 文档](https://docs.anthropic.com/claude-code)
- [Cursor Rules 指南](https://cursor101.com/article/cursor-rules-customizing-ai-behavior)
- [VSCode Copilot Agent Skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- [GitHub Copilot 配置](https://docs.github.com/en/copilot)

---

**Sources:**
- [Cursor Rules: Customizing AI Behavior](https://cursor101.com/article/cursor-rules-customizing-ai-behavior)
- [Use Agent Skills in VS Code](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- [Mastering AI Coding with Cursor Rules](https://apidog.com/blog/awesome-cursor-rules/)
