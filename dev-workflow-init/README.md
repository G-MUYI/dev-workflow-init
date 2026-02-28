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
2. 在对话框中输入 `启动` 或 `start`
3. AI 会逐步提问，收集项目需求（共 8 个问题）
4. 收集完成后自动生成：
   - 项目专属的 `AGENTS.md`（统一规则源）
   - 推荐适配的 skills / 工具列表
   - 编排好的工作流步骤

## 工作流程

```
启动 → 需求访谈 → 确认摘要 → 生成 AGENTS 规则 → 推荐 Skills → 编排工作流
```

## 文件结构

```
dev-workflow-init/
├── SKILL.md                        # 核心 skill 文件
├── README.md                       # 本说明文件
└── references/
    ├── search-strategy.md          # Skills 搜索策略与网页抓取方案
    └── agents-template.md          # AGENTS.md 生成模板
```
