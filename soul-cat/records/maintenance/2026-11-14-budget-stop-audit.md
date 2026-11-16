# IndieHunt 预算停止审计

依据：Hermes SQLite 原 session 20261114_144838_aee7a648 及压缩子 session 20261114_191955_ba3390，最终回复 ID1414；公开命令日志、草稿、检查点、台账。本次无浏览器操作。

- init 19:16:24，墙钟 deadline 19:24:24，19:25:11 再次检查 guard 才得知过期。
- 约 125 秒上下文压缩，60 秒等待工具审批且命令未执行，64 秒资料准备与重写。61 条已执行 terminal 命令累计约 26.32 秒，中位数 0.43 秒、最长 2.05 秒；未找到浏览器超时证据。
- checkpoint 从 init 后未成功更新：status=draft、page=null、verified_fields/assets 空、旧描述约 140 词；外部草稿已是 217 词。第一次 observe-fields 已在预算到期后，被旧 guard 拒绝。
- 报告中的 checkpoint“stop”其实是 guard.action，不是文件 status。
- 错误 eval、find 语法和 stale ref 没有持久计入 failures。19:24:30/31 预算到期后仍发生分类移除写操作；仅靠 Skill 手动 guard 没有落实到每次动作。
- 未提交：仍 Step 1，无 logo 上传、无 mark-submit、未进 Step 2/3；台账 deferred、不计数、普通 next Aura++。

修复方向：按真实浏览器执行时间计账；写入口强制守卫；同步草稿校验；本地保存与外部写权限分开；一次有限旧预算迁移并保留历史。

访问限制：上一轮 CUA 拒绝当前页面，电脑操作已结束。本次只做本地代码修正与离线验证，不改真实 deferred 记录或触发外部续跑。

## 本地修复验收

2026-11-14 20:07:32：helper/runner/Skill/reference已修正，45项测试全部通过（main实际运行18.276秒），Skill validator通过，独立fakeCLI场景审查通过。测试只使用临时目录与模拟CLI。

新策略累计浏览器实际执行时间，并有80次正常命令与停止后3次诊断上限；写入口自动检查并记录、草稿不同步阻断、未知命令不可重放、旧墙钟仅可显式迁移一次并保留历史。

已请求刷新子会话20261114_191955_ba3390的本地prompts，下一次对话读取新Skill；未触发新对话。真实IndieHunt检查点仍是旧draft/已过期，台账仍deferred，未迁移、重开或操作外站。
