# ❓ 常见问题解答

## 安装相关

### 我不知道怎么打开命令行？

**Windows:**
1. 打开你的项目文件夹
2. 在地址栏输入 `cmd` 然后按回车
3. 或者按住 `Shift` 键，右键点击空白处，选择"在此处打开 PowerShell 窗口"

**Mac:**
1. 打开"启动台"（Launchpad）
2. 搜索"终端"（Terminal）
3. 打开后输入 `cd ` 然后把项目文件夹拖进去，按回车

### 提示"找不到文件"怎么办？

**检查路径是否正确：**
```cmd
# 错误示例（路径不对）
C:\skills\install-unified.bat

# 正确示例（使用完整路径）
D:\ai-skills\dev-workflow-init\install-unified.bat
```

**如果路径有空格，用引号包起来：**
```cmd
"D:\my folder\dev-workflow-init\install-unified.bat"
```

### 安装后多了很多 `.` 开头的文件夹，正常吗？

**完全正常！** 这些是隐藏文件夹，用来存储 AI 工具的配置：
- `.ai/` - 统一的 skill 存储位置
- `.claude/` - Claude Code 的配置
- `.cursor/` - Cursor 的配置
- `.vscode/` - VSCode 的配置

这些文件夹不会影响你的项目代码。

### 我可以删除这些文件夹吗？

**可以，但不建议。** 删除后 AI 工具就无法识别这个 skill 了。

如果你想卸载，删除以下文件夹即可：
- `.ai/`、`.claude/`、`.cursor/`、`.kiro/`、`.vscode/`、`.windsurf/`
- `.cursorrules` 文件
- `AGENTS.md` 文件（如果是 skill 生成的）

---

## 使用相关

### 我说"启动"后 AI 没有反应？

**可能的原因和解决方法：**

1. **Skill 没有正确安装**
   - 检查项目文件夹里是否有 `.ai` 文件夹
   - 重新运行安装脚本

2. **AI 工具没有重新加载**
   - 完全关闭 AI 工具
   - 重新打开项目

3. **AI 没有识别到触发词**
   - 尝试明确说："请使用 dev-workflow-init skill"
   - 或者说："帮我初始化项目开发工作流"

### AI 问的问题我不知道怎么回答？

**没关系！你可以：**

- **跳过：** 说"跳过"或"不确定"
- **随便说：** AI 会根据你的回答调整
- **要建议：** 说"给我一些建议"或"有什么推荐吗？"

### 我可以中途暂停吗？

**可以！**

- 说"暂停"或"稍后继续"
- AI 会保存当前进度
- 下次说"继续"就能恢复

### 我想重新开始怎么办？

说"重来"、"重新开始"或"restart"，AI 会清空之前的回答，从第一个问题重新开始。

### 生成的 AGENTS.md 文件可以修改吗？

**当然可以！**

`AGENTS.md` 是一个普通的文本文件，你可以：
- 用任何文本编辑器打开
- 修改里面的内容
- 添加或删除规则

---

## 技术相关

### 符号链接和复制文件有什么区别？

**符号链接（Symlink）：**
- 类似"快捷方式"
- 只有一份文件（在 `.ai/skills/` 中）
- 更新一次，所有 IDE 同步
- 需要管理员权限

**复制文件：**
- 每个 IDE 有独立副本
- 不需要特殊权限
- 更新时需要重新运行安装脚本

**安装脚本会自动选择：**
- 有管理员权限 → 使用符号链接
- 没有管理员权限 → 自动降级为复制文件

### 我用的是 XXX IDE，支持吗？

**目前支持：**
- ✅ Claude Code
- ✅ Cursor
- ✅ VSCode (with GitHub Copilot)
- ✅ Kiro
- ✅ Windsurf

**不确定的：**
- ⚠️ Trae（待测试）
- ⚠️ 其他 AI IDE（可能需要手动配置）

如果你的 IDE 不在列表中，可以尝试安装，或者在 [GitHub Issues](https://github.com/G-MUYI/dev-workflow-init/issues) 提问。

### 我可以在多个项目中使用吗？

**可以！**

在每个项目中运行一次安装脚本即可。每个项目都会有自己的配置。

### 这个 skill 会修改我的代码吗？

**不会！**

这个 skill 只会：
- 创建配置文件夹（`.ai/`、`.claude/` 等）
- 生成 `AGENTS.md` 规范文档
- 推荐工具和插件

**不会修改你的任何代码文件。**

---

## 需要更多帮助？

- 查看 [完整使用指南](GUIDE.md)
- 查看 [使用示例](dev-workflow-init/USAGE_EXAMPLES.md)
- 提交问题：[GitHub Issues](https://github.com/G-MUYI/dev-workflow-init/issues)
- 社区讨论：[GitHub Discussions](https://github.com/G-MUYI/dev-workflow-init/discussions)

