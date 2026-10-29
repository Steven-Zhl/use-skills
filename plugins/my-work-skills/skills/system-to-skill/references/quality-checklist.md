# 交付前质量检查清单

逐项检查，未通过则修改后重检。

## 内容纯净度
- [ ] SKILL.md 与 references/ 中 grep 不到：`.java`、`.vue`、`.ts`、`Controller`、`Service`、`SpringBoot`、`Vue`、`MyBatis`、表名、包名
- [ ] 没有完整内部 URL、token、账号密码
- [ ] 没有"接口 → 参数 → 返回值"式的 API 文档

## 结构
- [ ] SKILL.md ≤150 行；有 name、description
- [ ] description 含触发关键词，包含"什么时候用"
- [ ] 能力清单表中每个脚本真实存在，示例命令可直接运行
- [ ] references 每个文件在 SKILL.md 中有"何时读"的说明
- [ ] 没有空的、凑数的 references 文件

## 脚本
- [ ] 每个脚本对应一个用户意图，参数为业务语言
- [ ] 输出为精简 JSON，枚举已翻译，无无用字段
- [ ] 错误输出含 error_code / message / suggestion，无堆栈与 HTTP 原文
- [ ] 所有写操作默认 dry-run，需 `--confirm`
- [ ] `--help` 可用；已在测试环境实际运行（记录于 03-verification.md）

## 业务
- [ ] 每条业务规则可追溯到代码或维护者确认
- [ ] 无法确认的问题已列入 02-open-questions.md，未写成既定事实
- [ ] 已排除的功能类别在场景清单中有说明

## 可用性
- [ ] evals/prompts.md 中每个场景有 3~5 句真实口语，包含缺参数、模糊表达
- [ ] 通读 SKILL.md：一个没见过该系统的助手能否仅凭它选对脚本、问对问题、正确转述结果？
