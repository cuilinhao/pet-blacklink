# Pettenderly 本轮新增 10 条提交审计报告

记录状态：本轮提交目标、最终徽章部署及页面验收已完成。
审计时间（UTC）：2026-11-14T14:48:43.032481+00:00

本轮已形成 **10/10 条有效提交或待审核记录**，基线 PromptZone、Findly 2 条没有再次计数，今日合计 **12 条**。本轮 **公开新增外链核实为 0 条**。有效提交不等于已经公开发布、搜索引擎收录或 dofollow 外链；MillionShort 是搜索引擎提交，不能据此声称已有目录外链。

本轮共记录 32 个唯一 source_key；所有计数条目均以主台账及回执为依据。Sidehunt 当前没有可用免费排期，未提交且不计数。

| 平台 | 台账状态 | 说明 | 回执图片 |
|---|---|---|---|
| millionshort.com | submitted | 搜索引擎提交回执；不等同目录外链或已索引 | [回执](/Users/pgy/Documents/backlink-workspace/soul-cat/records/evidence/2026-11-14-codex-10/millionshort-submitted.png) |
| resource.fyi | pending review | 审核中；页面显示计划 2026-12-13，实际发布仍待审核 | [回执](/Users/pgy/Documents/backlink-workspace/soul-cat/records/evidence/2026-11-14-codex-10/resource-fyi-submitted.png) |
| aitools.sh | pending review | 明确待审核回执 | [回执](/Users/pgy/Documents/backlink-workspace/soul-cat/records/evidence/2026-11-14-codex-10/aitools-sh-submitted.png) |
| toolhunter.ai | pending review | 人工审核中，后续徽章流程待平台通知 | [回执](/Users/pgy/Documents/backlink-workspace/soul-cat/records/evidence/2026-11-14-codex-10/toolhunter-submitted.png) |
| humanornot.co | submitted | 明确接收回执，公开页待通知 | [回执](/Users/pgy/Documents/backlink-workspace/soul-cat/records/evidence/2026-11-14-codex-10/humanornot-submitted.png) |
| dailyzaps.com | submitted | 明确接收回执 | [回执](/Users/pgy/Documents/backlink-workspace/soul-cat/records/evidence/2026-11-14-codex-10/dailyzaps-submitted.png) |
| aihustle.tools | submitted | 官网互链已上线，Tally 明确提交回执 | [回执](/Users/pgy/Documents/backlink-workspace/soul-cat/records/evidence/2026-11-14-codex-10/aihustle-submitted.png) |
| topfreeaitools.com | pending review | 官网徽章已上线；通知已发送但Nov14 DSN退信（550 Address not found），未送达；既有提交仍待人工审核 | [回执](/Users/pgy/Documents/backlink-workspace/soul-cat/records/evidence/2026-11-14-codex-10/topfreeaitools-badge-required.png) |
| findseotools.com | submitted | 补用户确认品牌 X 与上线年份后获得最终接收回执 | [回执](/Users/pgy/Documents/backlink-workspace/soul-cat/records/evidence/2026-11-14-codex-10/findseotools-submitted.png) |
| launchvault.dev | scheduled | 免费排期已确认：2027-06-07 16:00 至 06-14 16:00（北京时间）；后台 Upcoming(1)、Drafts(0)、Badge verified | [回执](/Users/pgy/Documents/backlink-workspace/soul-cat/records/evidence/2026-11-14-codex-10/launchvault-scheduled.png) |

## 审计结果

- 10 个已计数平台互异，所有 source_key 唯一；主台账没有另一个同平台成功条目。
- 10 张主回执图片及对应草稿全部存在；TopFreeAITools 另有官网徽章、已发送邮件证据，AI Hustle 另有官网互链证据。
- `.png` 文件名中的主回执实际编码为有效 JPEG，原文件及引用路径保留，没有转换或重命名。
- 仅同步 run JSON 与本报告；主 CSV、每日台账和第三方页面均未修改。
- 只读恢复校验：`RESUME_GATE=PASS`；普通队列下一项为 `success-1104-daohang-613-final.csv::somuch.com::somuch.com`。已授权历史候选的续跑与这个普通队列游标是两个分支。

## 未计数的重要候选

| 候选 | 当前结论 |
|---|---|
| Sidehunt | 免费 Nofollow 方案的可见周 2026-W47 至 2027-W29 全部 Week full，选择项 disabled；421 词表单已准备，但未提交。 |
| TinyStartups | 资料已保存，但发布必须支付 £69；标记 paid，未付款，不计数。 |
| NXGN | Google 登录后要求先给另一位 maker 点赞才能继续；未进行虚假推荐或提交。 |
| Victrays | 视频广告覆盖登录入口，有限关闭/重观后仍未进入 OAuth；未提交。没有证据把它归因为浏览器广告拦截扩展。 |
| mridul.tech | 曾点击一次提交但没有明确回执；结果未知，禁止直接重复发送。 |

其他暂停、连接失败、身份资料缺失、仅付费或不匹配平台的逐条原因保留在 run JSON，均不计入成功。已经取得的用户授权不会因仍显示 deferred 而自动撤销。

## 官网配套部署与验收

- 用户要求的五个图片徽章已统一为 10×10 像素，移到版权文字后的底部横排；AI Hustle 原文字链接保留。官方目标链接、图片源和 rel 保留，原 IndieHunt 及用户变更未丢失。
- 最终生产版本：`9e3bf9f4-ea76-45d2-9ff3-6fdeeca95dc4`；BUILD_ID：`cudGZMhSKOyWAnsklr5nq`；`pnpm run deploy` 退出码 0。
- 最终版本类型检查、TSX 定向 Biome、diff 检查及新增 CSS 规则检查通过；生产只读 HTML/CSS 核验 **9/9** 通过。整份旧 CSS 的 10 条既有 lint 错误由 HEAD 基线复核，本次新增规则没有引入错误。
- 最终版本真实 Chrome **8/8** 通过：页面注册与自动登录、刷新后会话保持、退出后刷新仍未登录、错误密码拒绝、正确密码登录、重复注册拒绝、最终已退出、底部徽章视觉核验。测试使用获准的专用 QA，拒绝了浏览器保存密码提示。
- 本次退出验证仅覆盖 UI 与刷新状态，**没有声称重新执行令牌重放验证**。历史版本 `f0076d90-5811-4233-ae47-0b101c850dd5` 的 auth API 11/11、Google 边界 6/6 单独保留，不冒充最终版本 API 重测。
- 未调用真实支付或付费生图，未使用客户凭据；没有新增 Git 提交。
- IndexNow 后置流程正常：0 条新接收、92 条因 24 小时去重跳过、0 失败；不代表新增收录。
- [最终 UI 验收 JSON](/Users/pgy/Desktop/pettenderly/.deployment-evidence/2026-11-14-directory-badges/ui-auth-results.json) 与其中四张截图均存在；[最终 10×10 页脚截图](/Users/pgy/Documents/backlink-workspace/soul-cat/records/evidence/2026-11-14-codex-10/pettenderly-footer-10px-live.png) 已核对存在。
- 主流程关闭了 11 个已完成且无需继续的任务标签，留下 Mridul 未知结果、Sidehunt 草稿、LaunchVault 回执和 Pettenderly 最终页脚供后续查看。

## 事实与证据索引

- 用户确认的产品事实：官方品牌 X 为 https://x.com/soulpaw_art，首次上线为 2026 年 10 月，国家中国。具体上线日、公司成立日期和个人身份未推断。
- [本轮完整 JSON](/Users/pgy/Documents/backlink-workspace/soul-cat/records/runs/2026-11-14-codex-additional-10.json)
- [主台账](/Users/pgy/Documents/backlink-workspace/soul-cat/records/platform-progress.csv)
- [当日日报](/Users/pgy/Documents/backlink-workspace/soul-cat/records/daily/2026-11-14.md)
- [徽章部署记录](/Users/pgy/Desktop/pettenderly/docs/operations/2026-11-14-pettenderly-directory-badges.md)

报告不含密码、Cookie、令牌、验证码或其它凭据。
