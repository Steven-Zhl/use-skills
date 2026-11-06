# use-skills

> 我的 Claude Code **skill 市场（marketplace）**，按个人用途和工作用途分为两个插件，共包含五个 skills。

| 插件 | Skill | 说明 |
|---|---|---|
| **my-personal-skills** | **as-doctor** | 疾病/症状问诊：结构化问诊、权威检索，以及分诊与就医建议 |
| **my-personal-skills** | **find-information** | 非工作场景下浏览 AI Agent、大模型、前端开发和国际局势领域的信息 |
| **my-personal-skills** | **clear-communication** | 让回答自然、清楚、易于理解，包含表达规则、正反例和输出前的检查方法 |
| **my-work-skills** | **weekly-report** | 根据 Git 提交与未提交改动生成工作周报 |
| **my-work-skills** | **system-to-skill** | 将内部系统的业务和 API 整理为 Agent Skill，并封装调用脚本 |

## 目录结构

```text
.
├── .claude-plugin/
│   └── marketplace.json       # 声明两个插件
├── plugins/
│   ├── my-personal-skills/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json    # 注册个人技能
│   │   └── skills/
│   │       ├── as-doctor/
│   │       ├── find-information/
│   │       └── clear-communication/
│   └── my-work-skills/
│       ├── .claude-plugin/
│       │   └── plugin.json    # 注册工作技能
│       └── skills/
│           ├── weekly-report/
│           └── system-to-skill/
└── README.md
```

## How to use

### Claude Code

添加市场后，按需安装个人插件或工作插件：

```bash
claude plugin marketplace add Steven-Zhl/use-skills

# 个人用途
claude plugin install my-personal-skills@use-skills

# 工作用途
claude plugin install my-work-skills@use-skills
```

或者交互式：

1. 启动 Claude Code，运行 `/plugin` 打开插件管理器。
2. 切到 **Marketplaces** 标签 → **Add Marketplace**。
3. 粘贴本仓库 Git URL（`https://github.com/Steven-Zhl/use-skills`）。
4. 按需安装 **my-personal-skills** 或 **my-work-skills** 插件，并重新启动会话以加载技能。

每个 skill 的适用场景写在其 `SKILL.md` 的 `description` 中。使用 `clear-communication` 时，可以明确提出：

> 接下来请使用 clear-communication，让回答自然、清楚，保留必要解释。

该技能也支持只改写指定文本；要求后续沿用时，在当前会话可获得这些要求的范围内继续应用。

## Recommendations

see: [Recommendations](./Recommendations.md)
