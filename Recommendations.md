# Recommendations

> 收集自社区的优秀 skills，按类别整理。

---

## 交互规范

### [i-have-adhd](https://github.com/ayghri/i-have-adhd)

- **介绍**：
  - 让 AI 回答变得直接、结构化，不再啰嗦。即使没有 ADHD 也适用。
  - 行动优先、编号分步、结尾给出具体下一步、抑制跑题、最多 5 条、不要客套话
- **安装**：`npx skills@latest add ayghri/i-have-adhd --skill=i-have-adhd`
- **评价**：非常适合GPT这种啰嗦的模型：P话很多还喜欢自己造词，白瞎了这么高的智力。对于Claude或GLM来说提升反而不明显，因为它本身就很言简意赅了。

---

## 工作流程

### [grill-with-docs](https://www.aihero.dev/grill-with-docs)

- **介绍**：
  - 通过一对一追问帮你对齐需求、统一领域语言，并自动生成术语表（`CONTEXT.md`）和架构决策记录（ADR）。
  - 它其实是多个Skill的入口，其自身Skill只有一句话，因此需要在安装时将被依赖的Skill一并安装
  - **适用时机**：需求模糊、领域语言未统一时，在写代码之前先对齐认知
- **安装**：
  - `npx skills add mattpocock/skills`
  - 选择  `grill-with-docs`, `grilling`, `domain-modeling`, `grill-me`, `to-spec`, `to-tickets`, `implement`, `code-review`, `ask-matt`
  - 在每次讨论需求时从`grill-with-docs`开始
- **评价**：在大量重构或讨论需求时或许可以使用，在小修改或小脚本上使用会让AI过度思考，且其预设的每次只问一个问题会导致效率过低，反而不推荐使用。
