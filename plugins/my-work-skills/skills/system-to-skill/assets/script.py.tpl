#!/usr/bin/env python3
"""<一句话业务用途，如：查询订单当前物流进度>

参数：
  --order-no   订单号 / 运单号 / 柜号
  --limit      最多返回条数（默认 10）
示例：
  python query_shipment.py --order-no PO2026-0815
输出：
  {"ok": true, "data": {"shipments": [{"bill_no": "...", "status": "海运在途", "eta": "..."}]}}
"""
import argparse

from _client import SkillError, call, emit, fail, translate

STATUS = {0: "待发运", 1: "已订舱", 2: "海运在途", 3: "已到港"}  # 从代码中收集


def main():
    ap = argparse.ArgumentParser(description="查询订单物流进度")
    ap.add_argument("--order-no", required=True, help="订单号/运单号/柜号")
    ap.add_argument("--limit", type=int, default=10)
    # 写操作脚本额外加：
    # ap.add_argument("--confirm", action="store_true", help="确认后才真正提交；不加则只预检")
    args = ap.parse_args()

    try:
        # 1) 定位  2) 取详情  3) 取节点 —— 多接口编排都在这里完成
        order = call("GET", "/xxx/order/find", params={"no": args.order_no})
        if not order:
            raise SkillError("NOT_FOUND", "未找到该单号", "请确认是订单号还是运单号")
        rows = call("GET", "/xxx/shipment/list", params={"orderId": order["id"]})

        # 裁剪 + 翻译：只保留助手需要的字段
        shipments = [{
            "bill_no": r["billNo"],
            "status": translate(STATUS, r["status"]),
            "eta": r.get("eta"),
        } for r in rows[: args.limit]]

        emit({"order_no": args.order_no, "shipments": shipments, "total": len(rows),
              "truncated": len(rows) > args.limit},
             hint="存在多个运单时，请向用户确认是哪一个" if len(rows) > 1 else "")
    except SkillError as e:
        fail(e)


if __name__ == "__main__":
    main()
