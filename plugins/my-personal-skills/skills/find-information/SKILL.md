---
name: find-information
description: 非工作场景下无明确目的地浏览 AI Agent、大模型、前端开发、国际局势领域的新闻与知识，提供消息源和输出规范指导；其他场景无需使用。
---

# Find Information — 信息浏览指南

非工作状态下，无明确目的地扫览四个领域的新动态与知识。各领域内容分三类存放，按需读取：

| 分类  | 目录                            | 说明                                     |
|-----|-------------------------------|----------------------------------------|
| 消息源 | `references/source/`          | 纯发现型消息源（Blog/周报/Newsletter/社区），不含参考型文档 |
| 约束  | `references/rules.md`         | 各领域浏览红线和国际局势交叉验证流程                     |
| 输出  | `references/output-format.md` | 简洁摘要格式，非学术报告风格                         |

## 路由表

| 领域       | 消息源                                | 核心关注           |
|----------|------------------------------------|----------------|
| 大模型      | `references/source/llm.md`         | 模型发布、论文趋势、官方动态 |
| AI Agent | `references/source/ai-agent.md`    | 研究进展、新趋势、热门项目  |
| 前端开发     | `references/source/frontend.md`    | 框架更新、社区趋势      |
| 国际新闻     | `references/source/global-news.md` | 国际新闻           |

## 执行步骤

1. 收到浏览请求，**先判断领域**，不在四领域内不启用本 Skill。
2. **读取对应 `references/source/*.md`**，从中选取合适的消息源。
3. **读取 `references/rules.md`** 中对应领域的约束（国际局势强制交叉验证）。
4. 优先使用 **WebFetch** 直读官方 Blog/新闻页面，WebSearch 仅用于聚合发现。
5. 按 `references/output-format.md` 组织简洁摘要输出。
