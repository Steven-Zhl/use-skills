# dayi.org.cn 检索规范

> 数据源：中国医药信息查询平台（国家中医药管理局审核认证），词条含中西医内容。
> 用途：症状/疾病/药品/中药材的知识检索，为鉴别诊断提供依据。

---

## 搜索 API

```
https://server.dayi.org.cn/api/search?pageNo=1&pageSize=10&keyword={关键词}&type={类型}
```

- **必须用 Bash curl，且带 `-L -k`**：该 API 存在证书/TLS 问题，`-k` 跳过证书校验、`-L` 跟随重定向，否则会被 WAF 拦截或返回错误：
  ```bash
  curl -sL -k -X GET 'https://server.dayi.org.cn/api/search?pageNo=1&pageSize=10&keyword=头晕&type=symptom'
  ```
- WebFetch 对该域名可能因证书校验失败，curl 是第一选择。
- 响应 JSON：
  ```json
  {
    "respCode": "000000",
    "respMsg": "success",
    "totalCount": 96,
    "list": [
      {
        "id": 1143957,
        "title": "<em>头晕</em>",
        "introduction": "<em>头晕</em>（dizziness）是一种…",
        "secondTitle": "症状",
        "type": "symptom"
      }
    ]
  }
  ```
- `title`/`introduction` 含 `<em>…</em>` 高亮，**需清洗**（去标签、合并空白）。

### type 参数

| type | 内容 |
|---|---|
| `symptom` | 症状 |
| `disease` | 疾病 |
| `medical` | 药品 |
| `qa_article` | 问答 |
| `cmedical` | 中药材 |

---

## 详情页 URL（按 type 拼接 `{id}`）

| type | URL |
|---|---|
| symptom | `https://www.dayi.org.cn/symptom/{id}` |
| disease | `https://www.dayi.org.cn/disease/{id}` |
| medical | `https://www.dayi.org.cn/drug/{id}` |
| cmedical | `https://www.dayi.org.cn/cmedical/{id}` |
| qa_article | `https://www.dayi.org.cn/qa/{id}` |

- 详情页为服务端渲染，**curl 或 WebFetch 均可抓取**，正文可直接解析（不需要 `-k`）。
- 页面含结构化字段：**常见症状、主要病因、鉴别诊断、就诊科室、治疗方法**等；疾病/症状页还标注审核认证方。

---

## 检索策略

### 形态 A（自身症状问诊）
1. 先取主诉核心症状词 → `type=symptom` 搜索 → 读 1–2 个症状详情页的「常见症状 / 主要病因」。
2. 基于症状详情 + 采集信息形成 3–5 个候选疾病名 → `type=disease` 搜索每个候选 → 读疾病详情页的「常见症状 / 鉴别诊断 / 就诊科室」，**交叉比对**判断匹配度。
3. 优先采信详情页里的结构化字段，不要只看搜索列表的 `introduction`。

### 形态 B（知识问答）
1. 直接按问题关键词搜 `disease` / `symptom` / `medical` / `qa_article`。
2. 命中后读详情页，按 output-format 结构化作答。

### 通用
- 关键词用主诉核心词，过长先拆词；无结果时换近义词或减小 `pageSize` 后换页（`pageNo`）。
- **中西医内容区分**：dayi 词条中西医融合（中医病机如"湿热虫毒"、西医病因并列）。输出时把"西医常见病因"与"中医角度"分开呈现，**不要**把中医病机当作唯一或确定诊断。
- 内容有审核标识，但仍是信息平台而非医生意见；引用时标注来源。
