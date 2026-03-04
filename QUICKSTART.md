# 快速开始指南

## 第一次使用

### 1. 安装到目标项目

假设你想在 `E:\projects\my-new-project` 中使用这个 skill：

```bash
# 进入目标项目
cd E:\projects\my-new-project

# 运行安装脚本（假设 dev-workflow-init 仓库在 D:\skills\dev-workflow-init）
D:\skills\dev-workflow-init\install.bat
```

安装后的目录结构：
```
E:\projects\my-new-project\
├── .claude\
│   └── skills\
│       └── dev-workflow-init\    ← skill 安装在这里
│           ├── SKILL.md
│           ├── README.md
│           └── ...
└── (你的项目文件)
```

### 2. 启动 skill

在 AI IDE（Claude Code/Kiro/Cursor）中打开 `my-new-project` 项目，然后在对话框中输入：

```
启动
```

或

```
start
```

### 3. 回答 8 个问题

AI 会逐个提问，例如：

```
1️⃣ 你想实现的核心效果是什么？请用 1-2 句话描述。
```

回答后，AI 会继续下一个问题，直到收集完所有信息。

### 4. 确认并生成

AI 会展示需求摘要让你确认，确认后会：
- 生成 `AGENTS.md` 文件
- 推荐适配的 skills 和工具
- 编排工作流步骤

## 常见场景

### 场景 1：全新项目

```bash
# 1. 创建项目文件夹
mkdir my-awesome-app
cd my-awesome-app

# 2. 初始化 git（可选）
git init

# 3. 安装 skill
path\to\install.bat

# 4. 用 AI IDE 打开项目
# 5. 在对话框输入：启动
```

### 场景 2：现有项目添加工作流

```bash
# 1. 进入现有项目
cd existing-project

# 2. 安装 skill
path\to\install.bat

# 3. 用 AI IDE 打开项目
# 4. 在对话框输入：启动
```

### 场景 3：多个项目使用同一个 skill

你可以在每个项目中都安装这个 skill，或者：

1. 将 skill 仓库克隆到一个固定位置，如 `D:\ai-skills\dev-workflow-init`
2. 在每个项目中运行 `D:\ai-skills\dev-workflow-init\install.bat`

## 验证安装

安装后，检查目录结构：

```bash
# Claude Code
ls .claude/skills/dev-workflow-init/SKILL.md

# Kiro
ls .kiro/skills/dev-workflow-init/SKILL.md

# Cursor
ls .agents/skills/dev-workflow-init/SKILL.md
```

如果文件存在，说明安装成功。

## 故障排除

### 问题：AI 说"启动"后没有反应

**原因**：skill 没有安装在正确位置

**解决**：
1. 检查 skill 是否在 `.claude/skills/`、`.kiro/skills/` 或 `.agents/skills/` 目录下
2. 重启 AI IDE
3. 明确说："请使用 dev-workflow-init skill"

### 问题：找不到 install.bat 或 install.sh

**原因**：安装脚本在仓库根目录，不在 `dev-workflow-init/` 文件夹内

**解决**：
```
dev-workflow-init-repo/
├── install.bat          ← 在这里
├── install.sh           ← 在这里
└── dev-workflow-init/   ← skill 源码在这里
    ├── SKILL.md
    └── ...
```

### 问题：Windows 提示"无法运行脚本"

**解决**：
1. 右键 `install.bat` → "以管理员身份运行"
2. 或在 PowerShell 中运行：`cmd /c install.bat`

## 下一步

安装成功后，查看：
- [使用示例](dev-workflow-init/USAGE_EXAMPLES.md)
- [测试指南](dev-workflow-init/TESTING.md)
