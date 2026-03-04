# 📦 安装步骤详解（图文版）

## 方式一：Windows 用户（推荐）

### 步骤 1：下载项目

有两种方式：

**方式 A：使用 Git（推荐）**
```cmd
git clone https://github.com/G-MUYI/dev-workflow-init.git
```

**方式 B：直接下载**
1. 访问 https://github.com/G-MUYI/dev-workflow-init
2. 点击绿色的 "Code" 按钮
3. 选择 "Download ZIP"
4. 解压到你喜欢的位置（比如 `D:\ai-skills\dev-workflow-init`）

### 步骤 2：打开你的项目文件夹

假设你的项目在 `D:\my-awesome-project`

**方法 1：使用文件资源管理器**
1. 打开文件资源管理器
2. 进入 `D:\my-awesome-project`
3. 在地址栏输入 `cmd` 然后按回车

**方法 2：使用右键菜单**
1. 打开文件资源管理器
2. 进入 `D:\my-awesome-project`
3. 按住 `Shift` 键，右键点击空白处
4. 选择"在此处打开 PowerShell 窗口"或"在此处打开命令提示符"

### 步骤 3：运行安装脚本

在命令行窗口中输入（记得改成你的实际路径）：

```cmd
D:\ai-skills\dev-workflow-init\install-unified.bat
```

按回车后，你会看到：

```
=== dev-workflow-init 统一安装工具 ===

[普通模式] 将复制文件（建议以管理员身份运行以使用符号链接）

当前目录: D:\my-awesome-project

→ 创建统一 skills 目录: .ai\skills
  ✓ 已复制到: .ai\skills\dev-workflow-init

→ 配置 Claude Code
  ✓ 已复制到: .claude\skills\dev-workflow-init

→ 配置 Kiro
  ✓ 已复制到: .kiro\skills\dev-workflow-init

...

✓ 安装完成！
```

### 步骤 4：验证安装

检查你的项目文件夹，应该能看到这些新文件夹：
```
my-awesome-project/
├── .ai/
├── .claude/
├── .cursor/
├── .kiro/
├── .vscode/
├── .windsurf/
└── AGENTS.md
```

如果看到了，说明安装成功！

---

## 方式二：Mac/Linux 用户

### 步骤 1：下载项目

打开终端（Terminal），运行：

```bash
git clone https://github.com/G-MUYI/dev-workflow-init.git ~/ai-skills/dev-workflow-init
```

或者手动下载 ZIP 并解压到 `~/ai-skills/dev-workflow-init`

### 步骤 2：进入你的项目目录

```bash
cd ~/my-awesome-project
```

### 步骤 3：运行安装脚本

```bash
bash ~/ai-skills/dev-workflow-init/install-unified.sh
```

你会看到类似的输出：

```
=== dev-workflow-init 统一安装工具 ===

当前目录: /Users/yourname/my-awesome-project

→ 创建统一 skills 目录: .ai/skills
  ✓ 已复制到: .ai/skills/dev-workflow-init

→ 配置 Claude Code
  ⚠ 符号链接创建失败（可能需要管理员权限），改为复制文件
  ✓ 已复制到: .claude/skills/dev-workflow-init

...

✓ 安装完成！
```

### 步骤 4：验证安装

运行：

```bash
ls -la | grep "^\."
```

应该能看到 `.ai`、`.claude`、`.cursor` 等文件夹。

---

## 方式三：使用管理员权限（高级用户）

如果你想使用符号链接（更新一次，所有 IDE 同步），需要管理员权限。

### Windows

1. 右键点击"命令提示符"或"PowerShell"
2. 选择"以管理员身份运行"
3. 进入项目目录：
   ```cmd
   cd D:\my-awesome-project
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

### Mac/Linux

使用 `sudo`：

```bash
cd ~/my-awesome-project
sudo bash ~/ai-skills/dev-workflow-init/install-unified.sh
```

---

## 常见安装问题

### ❌ 提示"找不到文件"

**原因：** 路径不对

**解决：**
1. 确认 `install-unified.bat` 或 `install-unified.sh` 文件存在
2. 使用绝对路径（完整路径）
3. 路径中有空格的话，用引号包起来：
   ```cmd
   "D:\my folder\dev-workflow-init\install-unified.bat"
   ```

### ❌ 提示"权限不足"

**原因：** 没有写入权限

**解决：**
- Windows: 以管理员身份运行
- Mac/Linux: 使用 `sudo`

### ❌ 安装后 AI 还是不识别

**原因：** AI 工具没有重新加载

**解决：**
1. 完全关闭 AI 工具
2. 重新打开项目
3. 或者明确说："请使用 dev-workflow-init skill"

---

## 下一步

安装完成后，查看：
- [5 分钟快速上手](GETTING_STARTED.md) - 学习如何使用
- [使用示例](dev-workflow-init/USAGE_EXAMPLES.md) - 看看别人怎么用
- [常见问题](README.md#常见问题) - 遇到问题先看这里

---

**提示：** 如果你是第一次使用，建议先在一个测试项目中练习，熟悉流程后再用到正式项目。
