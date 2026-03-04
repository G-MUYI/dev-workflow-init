# dev-workflow-init

一个 AI 对话式 skill，通过需求访谈自动初始化项目开发工作流。

## 安装

```bash
# 通过 skills CLI 安装（推荐）
npx skills add <your-repo>/dev-workflow-init

# 或手动复制
# 将 dev-workflow-init/ 文件夹复制到对应 Agent 的 skills 目录：
# Claude Code: .claude/skills/
# Kiro:        .kiro/skills/
# Cursor:      .agents/skills/
```

## 使用

1. 用 AI IDE 打开目标项目文件夹
2. 在对话框中输入以下任一指令：
   - `启动`
   - `start`
   - `开始`
   - `初始化项目`
   - 或直接问："如何开始这个项目？"
3. AI 会逐步提问，收集项目需求（共 8 个问题）
4. 收集完成后自动生成：
   - 项目专属的 `AGENTS.md`（统一规则源）
   - 推荐适配的 skills / 工具列表
   - 编排好的工作流步骤

**提示**：如果 AI 没有自动识别，可以明确说："请使用 dev-workflow-init skill"

## 工作流程

```
启动 → 需求访谈 → 确认摘要 → 生成 AGENTS 规则 → 推荐 Skills → 编排工作流
```

## 文件结构

```
dev-workflow-init/
├── SKILL.md                        # 核心 skill 文件
├── README.md                       # 本说明文件
├── USAGE_EXAMPLES.md               # 使用示例与场景
├── TESTING.md                      # 测试指南与问题排查
└── references/
    ├── search-strategy.md          # Skills 搜索策略与网页抓取方案
    └── agents-template.md          # AGENTS.md 生成模板
```

## 更多资源

- [使用示例](USAGE_EXAMPLES.md) - 查看不同场景下的触发方式
- [测试指南](TESTING.md) - 快速测试和问题排查
- [搜索策略](references/search-strategy.md) - 了解如何搜索和推荐 skills
