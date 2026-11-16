# 2026-11-14 浏览器控制链诊断

范围：Pettenderly / Sadık Chrome / auto-backlink-agent。只读排查及 Details 栏切换；未刷新、重提或关闭原 Findly 表单。

## 已确认

- 原任务 session 20261114_144838_aee7a648，17:56 达 90 工具轮上限后停止；当前无活动 turn。
- Findly 历史 12 次超时累计 20.25 分钟；IndieHunt 2 次累计 2.5 分钟。外层 terminal 超时只保留部分错误信息。
- 历史 tab list 正常而 state/get url/eval/dialog/open 超时；重启 daemon 未恢复，新 target 恢复。不能据此认定网站 React 永久死锁。
- 本次原 Findly 页通过原生 UI 可立即切换 Details；新诊断 session 绑定同一原页后 get url 和 state 均约 0.1 秒成功，原文案仍在。
- 旧 hermes-pettenderly-sadik session 的 tab list 已为空。扩展日志有 owned lease 因空闲释放，发生于 17:52:24，晚于 17:25 首次故障，不能当成首次故障的确定原因。
- CLI 1.8.6 / 扩展 1.0.27；扩展声明兼容 CLI >=1.7.0。未证实版本不兼容。

## 源码确认的耗时放大机制

1. OPENCLI_BROWSER_COMMAND_TIMEOUT 仅用于站点 adapter 的 execution.js，browserAction 不使用该变量。此前设置为 20 不能限制 browser 命令总耗时。
2. daemon-client.js 的请求默认 120 秒；base-page.js 快照失败后继续备用快照，getCurrentUrl 吞错返回 null，cli.js get url 再 evaluate。因此单 CLI 命令可能多次等待。
3. terminal/CLI 超时没有向扩展撤销已送出的 CDP 操作。写入和提交结果必须视为未知，先观察，不自动重放。
4. owned lease 空闲约 10 分钟过期；bound lease 不因空闲过期，适合长表单和人工等待。

本机源码：/opt/homebrew/lib/node_modules/@jackwener/opencli/dist/src/cli.js（browserAction:883；get url:1507）、browser/daemon-client.js:27、browser/base-page.js:919,943、daemon.js:293。官方扩展源码：https://github.com/jackwener/OpenCLI/blob/v2.0.3/extension/src/background.ts 。

## 结论与限制

证据支持旧会话/target 的控制链异常，叠加 CLI 超时与兜底放大等待。精确是 debugger 附着状态还是租约恢复异常，历史日志没有足够细节，不能唯一确定。当前未见原生 dialog；不能排除历史短暂 dialog。没有证据把特定 CLI 新版本修复当作本次已证实根因。

处置：长表单显式 bind；真正子进程总 deadline；无自动写重试；持久草稿和字段读回；一次重新绑定、同类失败最多两次；原页保留，未知提交先核对结果。无需全局升级或清理浏览器。

## 修复与现场交接验证

- 私有 Skill 已替换直接 tab new 丢弃策略，增加草稿检查点、提交未知状态、累计失败/预算及总时限 runner。共享 Skill 和全局 CLI 未改。
- 独立审查已验证 5 个场景；日志输出脱敏和 Pricing/投稿方案分字段列为修复项。
- 本次最终 resume gate PASS：305 条台账，active handled 146，remaining 450，下一个 IndieHunt。
- 诊断 session 已 unbind，原 Findly 草稿仍保留。原生 UI 在已验证 Sadık 中新开 IndieHunt /submit?plan=free（原 IndieHunt owned 标签已不存在），新页空表单、已登录，未填表/上传/提交。
- hermes-pettenderly-sadik 已 bound 此 IndieHunt 页；bind 0.299 秒，get url 0.295 秒。没有占用原 Findly 页面。

- 修复最终验证：checkpoint 14 项、runner 13 项，共 27 项通过；quick_validate 通过。独立输出泄露案例已修复，公开 error.code 保留，未知状态信号不丢失。
- Hermes 原飞书会话 prompts 已 refresh（epoch 4，只刷新 session 20261114_144838_aee7a648，不清历史）；19:14 在既有「自动发外链 Agent」聊天发送明确续跑指令，等待执行确认。

- 续跑已证实：消息1083被原session接收，1084读取新Skill与恢复参考，1091 RESUME_GATE=PASS；IndieHunt草稿/检查点已由Hermes创建，权限0600，检查点35d43023fa76531b1bbee2613572d8d79254270e3c73bdea893dc9f4f9d0c22a.json。
- 实际恢复动作：1109网址、1111名称、1112标题、1114描述由runner填写并读回；1130页面显示AI与Design Tools已选2/3。期间state约0.26–0.33秒。原20任务已交还Hermes继续，当前尚未将IndieHunt计为成功。
- 运行观察限制：Hermes仍有把runner输出再经shell管道裁剪的习惯，虽然返回JSON保留ok/unknown并使用有时限runner，不能宣称整个LLM流程已获得强制执行隔离。新增helper负责持久守卫，Skill约束仍需执行者遵守。
- 飞书可见确认截图：2026-11-14-hermes-resumed.png。
