# use-skills

> My ideas — 一个 Claude Code **skill 市场（marketplace）**，打包两个 skills：

| Skill | 说明 |
|---|---|
| **as-doctor** | 疾病/症状问诊：结构化问诊 + 权威检索，提供分诊与就医建议（模型自动启用） |
| **find-information** | 非工作场景下浏览 AI Agent / 大模型 / 前端 / 国际局势领域的信息（模型自动启用） |

## 目录结构

```
.
├── .claude-plugin/
│   ├── marketplace.json   # marketplace 目录（声明 use-skills 插件）
│   └── plugin.json        # 插件清单（声明两个 skills）
├── skills/
│   ├── as-doctor/
│   └── find-information/
└── README.md
```

## How to use

### Claude Code

```bash
claude plugin marketplace add Steven-Zhl/use-skills
claude plugin install use-skills@use-skills
```

或者交互式：

1. 启动 Claude Code，运行 `/plugin` 打开插件管理器。
2. 切到 **Marketplaces** 标签 → **Add Marketplace**。
3. 粘贴本仓库 Git URL（`https://github.com/Steven-Zhl/use-skills`）。
4. 安装 **use-skills** 插件，然后 `/reload-plugins`。

两个 skill 均为**模型自动调用**（非斜杠命令），命名空间为 `/use-skills:*`。

## Recommendations

see: [Recommendations](./Recommendations.md)
