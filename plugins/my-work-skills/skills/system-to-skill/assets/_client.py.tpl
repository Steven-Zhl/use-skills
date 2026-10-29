"""公共客户端：鉴权、请求、错误翻译、统一输出。

替换 <SYS> 为系统简称（大写）。鉴权方式以 00-context.md 为准，修改 _headers()。
"""
import json
import os
import sys
import time

import requests

BASE_URL = os.environ.get("<SYS>_BASE_URL", "").rstrip("/")
TOKEN = os.environ.get("<SYS>_TOKEN", "")
TIMEOUT = 15

# 系统特有业务错误码 → (error_code, 中文说明, 建议)。阶段1从代码中收集。
ERROR_MAP = {
    # "E4031": ("FORBIDDEN", "无权访问该项目", "请联系项目负责人开通权限"),
}


class SkillError(Exception):
    def __init__(self, code, message, suggestion=""):
        self.code, self.message, self.suggestion = code, message, suggestion


def _headers():
    if not TOKEN:
        raise SkillError("AUTH_EXPIRED", "缺少登录凭据", "请重新登录后再试")
    return {"Authorization": f"Bearer {TOKEN}"}  # 按实际鉴权方式修改


def call(method, path, *, params=None, json_body=None, retry=1):
    """调用底层接口。仅 GET 自动重试。失败一律抛 SkillError。"""
    if not BASE_URL:
        raise SkillError("UPSTREAM_ERROR", "未配置系统地址", "请联系管理员配置")
    attempts = retry + 1 if method.upper() == "GET" else 1
    for i in range(attempts):
        try:
            r = requests.request(method, BASE_URL + path, headers=_headers(),
                                 params=params, json=json_body, timeout=TIMEOUT)
            break
        except requests.RequestException:
            if i == attempts - 1:
                raise SkillError("UPSTREAM_ERROR", "系统暂时无法访问", "请稍后再试")
            time.sleep(1)
    if r.status_code == 401:
        raise SkillError("AUTH_EXPIRED", "登录已失效", "请重新登录")
    if r.status_code == 403:
        raise SkillError("FORBIDDEN", "没有权限执行该操作", "请联系相关负责人")
    if r.status_code >= 500:
        raise SkillError("UPSTREAM_ERROR", "系统处理出错", "请稍后再试")
    try:
        body = r.json()
    except ValueError:
        raise SkillError("UPSTREAM_ERROR", "系统返回了无法识别的内容", "请稍后再试")
    return unwrap(body)


def unwrap(body):
    """按该系统的统一响应结构解包（code/msg/data 等），失败时映射为 SkillError。"""
    code = str(body.get("code", "0"))  # 按实际结构修改
    if code not in ("0", "200"):
        c, m, s = ERROR_MAP.get(code, ("UPSTREAM_ERROR", body.get("msg", "操作失败"), ""))
        raise SkillError(c, m, s)
    return body.get("data")


def translate(mapping, value, default="未知状态"):
    return mapping.get(value, default)


def emit(data=None, summary="", hint=""):
    out = {"ok": True, "data": data}
    if summary:
        out["summary"] = summary
    if hint:
        out["hint"] = hint
    print(json.dumps(out, ensure_ascii=False, indent=2))


def fail(err):
    print(json.dumps({"ok": False, "error_code": err.code, "message": err.message,
                      "suggestion": err.suggestion}, ensure_ascii=False, indent=2))
    sys.exit(1)
