# 📖 完整使用指南

> 从安装到使用的完整教程

## 目录

- [这是什么？](#这是什么)
- [安装步骤](#安装步骤)
- [开始使用](#开始使用)
- [使用场景](#使用场景)
- [故障排除](#故障排除)

---

## 这是什么？

这是一个 AI 助手的"技能包"，可以帮你：
- 通过对话的方式梳理项目需求
- 自动生成项目规范文档
- 推荐适合你项目的工具
- 规划开发流程

**就像和 AI 聊天一样简单！**

---

## 安装步骤

### Windows 用户

#### 方式 A：使用 Git（推荐）

1. 克隆项目：
```cmd
git clone https://github.com/G-MUYI/dev-workflow-init.git
```

2. 进入你的项目文件夹（比如 `D:\my-project`）：
   - 在文件资源管理器中打开项目文件夹
   - 在地址栏输入 `cmd` 然后按回车

3. 运行安装脚本（记得改成你的实际路径）：
```cmd
D:\dev-workflow-init\install-unified.bat
```

#### 方式 B：直接下载

1. 访问 https://github.com/G-MUYI/dev-workflow-init
2. 点击绿色的 "Code" 按钮
3. 选择 "Download ZIP"
4. 解压到你喜欢的位置（比如 `D:\ai-skills\dev-workflow-init`）
5. 按照方式 A 的步骤 2-3 操作

#### 使用管理员权限（可选）

如果你想使用符号链接（更新一次，所有 IDE 同步），需要管理员权限：

1. 右键点击"命令提示符"或"PowerShell"
2. 选择"以管理员身份运行"
3. 进入项目目录：
   ```cmd
   cd D:\my-project
   ```
4. 运行安装脚本：
   ```cmd
   D:\ai-skills\dev-workflow-init\install-unified.bat
   ```

你会看到：
```
[管理员模式] 将使用符号链接
...
→ 配置 Claude Code
  ✓ 已创建符号链接: .claude\skills\dev-workflow-init -> .ai\skills\dev-workflow-init
```

### Mac/Linux 用户

1. 克隆项目：
```bash
git clone https://github.com/G-MUYI/dev-workflow-init.git ~/ai-skills/dev-workflow-init
```

2. 进入你的项目目录：
```bash
cd ~/my-project
```

3. 运行安装脚本：
```bash
bash ~/ai-skills/dev-workflow-init/install-unified.sh
```

#### 使用管理员权限（可选）

使用 `sudo` 来创建符号链接：
```bash
cd ~/my-project
sudo bash ~/ai-skills/dev-workflow-init/install-unified.sh
```

### 验证安装

安装完成后，检查你的项目文件夹，应该能看到这些新文件夹：
```
my-project/
├── .ai/skills/dev-workflow-init/    # 初始化工具
├── .claude/
├── .cursor/
├── .kiro/
├── .vscode/
├── .windsurf/
├── skills/                          # 项目特定的工作流 skills（初始化后创建）
└── AGENTS.md                        # 统一规则源（初始化后生成）
```

如果看到了，说明安装成功！

---

## 开始使用

### 第一步：启动 AI 对话

在 AI IDE（Claude Code、Cursor、VSCode 等）中打开项目，在对话框输入：

```
启动
```

或者

```
start
```

AI 会开始问你问题，像这样：

```
你好！我会通过 8 个问题帮你梳理项目需求...

现在开始第一个问题：

1️⃣ 你想实现的核心效果是什么？请用 1-2 句话描述。
```

### 第二步：回答问题

AI 会问你 8 个问题，比如：

- 你的项目要做什么？
- 给谁用的？
- 用什么技术？
- 什么时候完成？
- ...

**你只需要像聊天一样回答就行！**

例如：
```
问：你想实现的核心效果是什么？
答：我想做一个在线记账本，可以记录每天的收支

问：主要面向哪些用户？
答：个人用户，主要是想管理自己日常开销的人
```

**不知道怎么回答？**
- 说"跳过"或"不确定"
- 说"给我一些建议"
- 随便说点什么，AI 会根据你的回答调整

### 第三步：确认并生成

回答完 8 个问题后，AI 会给你看一个摘要：

```
📋 需求摘要确认

1. 核心目标：在线记账本，记录每天收支
2. 目标用户：个人用户
3. 成功标准：...
...

请确认以上信息是否正确
```

确认后，AI 会自动：
- 生成 `AGENTS.md` 文件（项目规范）
- 推荐适合的工具和插件
- 规划开发步骤

---

## 使用场景

### 场景 1：全新项目

```bash
# 1. 创建项目文件夹
mkdir my-awesome-app
cd my-awesome-app

# 2. 初始化 git（可选）
git init

# 3. 安装 skill
path\to\install-unified.bat

# 4. 用 AI IDE 打开项目
# 5. 在对话框输入：启动
```

### 场景 2：现有项目添加工作流

```bash
# 1. 进入现有项目
cd existing-project

# 2. 安装 skill
path\to\install-unified.bat

# 3. 用 AI IDE 打开项目
# 4. 在对话框输入：启动
```

### 场景 3：多个项目使用

你可以在每个项目中都安装这个 skill：

1. 将 skill 仓库克隆到一个固定位置，如 `D:\ai-skills\dev-workflow-init`
2. 在每个项目中运行 `D:\ai-skills\dev-workflow-init\install-unified.bat`

---

## 故障排除

### 问题：找不到文件

**原因：** 路径不对

**解决：**
1. 确认 `install-unified.bat` 或 `install-unified.sh` 文件存在
2. 使用绝对路径（完整路径）
3. 路径中有空格的话，用引号包起来：
   ```cmd
   "D:\my folder\dev-workflow-init\install-unified.bat"
   ```

### 问题：权限不足

**原因：** 没有写入权限

**解决：**
- Windows: 以管理员身份运行
- Mac/Linux: 使用 `sudo`

### 问题：说"启动"后 AI 没反应

**可能原因和解决方法：**

1. **Skill 没有正确安装**
   - 检查项目文件夹里是否有 `.ai` 文件夹
   - 重新运行安装脚本

2. **AI 工具没有重新加载**
   - 完全关闭 AI 工具
   - 重新打开项目

3. **AI 没有识别到触发词**
   - 尝试明确说："请使用 dev-workflow-init skill"
   - 或者说："帮我初始化项目开发工作流"

### 问题：可以中途暂停吗？

**可以！**

- 说"暂停"或"稍后继续"
- AI 会保存当前进度
- 下次说"继续"就能恢复

### 问题：想重新开始怎么办？

说"重来"、"重新开始"或"restart"，AI 会清空之前的回答，从第一个问题重新开始。

### 问题：生成的 AGENTS.md 可以修改吗？

**当然可以！**

`AGENTS.md` 是一个普通的文本文件，你可以：
- 用任何文本编辑器打开
- 修改里面的内容
- 添加或删除规则

---

## 支持的 AI IDE

✅ **Claude Code** - Anthropic 官方 AI 编程工具
✅ **Cursor** - 流行的 AI 代码编辑器
✅ **VSCode + Copilot** - 微软的 AI 编程助手
✅ **Kiro** - 新兴的 AI 开发工具
✅ **Windsurf** - 另一个 AI 编程工具

详见 [跨 IDE 兼容性指南](CROSS_IDE_COMPATIBILITY.md)。

---

## 小贴士 💡

1. **第一次使用建议用测试项目**，熟悉流程后再用到正式项目
2. **回答问题时尽量具体**，AI 生成的规范会更准确
3. **不用担心回答错误**，后面可以随时修改 `AGENTS.md`
4. **安装一次就够了**，以后打开项目直接说"启动"

---

## 需要更多帮助？

- 查看 [常见问题](FAQ.md)
- 查看 [使用示例](dev-workflow-init/USAGE_EXAMPLES.md)
- 提交问题：[GitHub Issues](https://github.com/G-MUYI/dev-workflow-init/issues)

---

**祝你使用愉快！🎉**
