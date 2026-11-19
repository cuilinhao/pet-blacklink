# Pettenderly：11月18日结果及明日续投交接

## 已核实事实

- 推广网站仅 https://pettenderly.com/ 。目前唯一获准分工清单为 `soul-cat/platforms/supplemental-free-2026-11-16.csv`，共371行。这是候选来源，并非371个已核实免费且未投的平台。
- 全局台账：`platform-progress.csv`；全371行历史映射与证据：`runs/2026-11-18-windows-recovery-audit.csv`；尚有问题条目的逐域名原因：`runs/2026-11-18-windows-current-blockers.csv`。已处理包括成功、去重、跳过及阻塞，不等于全部成功或全部收费。尚未核实入口的条目不能写成确认收费。
- 11月18日有效7/20，缺13：公开外链1、明确待审3、正式接收2、明确排期1。没有把缺口虚报为提交。

## 今天有效回执

| 平台 | 实际状态 | 回执/证据 |
|---|---|---|
| AI Agents Info | 公开且指向官网 | https://www.aiagentsinfo.com/directory/pettenderly ；evidence/2026-11-18-windows/aiagentsinfo-live.jpg |
| ToolTrove | 待审；旧提交今天取得确认，未重投 | https://tooltrove.net/submit/verify （不公开验证令牌）；evidence/2026-11-18-windows/tooltrove-confirmed.jpg |
| LaCrème AI | 待审，免费档 | https://www.lacreme.ai/lister-un-outil/success?free=1 ；evidence/2026-11-18-windows/lacreme-submission-result.jpg |
| Britain Business Directory | 明确待审 | https://www.britainbusinessdirectory.com/submit.php ；evidence/2026-11-18-windows/britain-directory-submitted.jpg |
| AI分享圈 | 正式接收，未核实公开 | https://aisharenet.com/woyaotougao/ ；evidence/2026-11-18-windows/aisharenet-submission-result.jpg |
| 不死鸟 iui.su | 官方投稿问卷正式接收，未核实公开 | https://wj.qq.com/s2/26413457/ypqh/ ；evidence/2026-11-18-windows/iui-submitted.jpg |
| ProductPerch | 免费排期2027-01-04 00:00 UTC，审核中，可能顺延；非公开上线 | https://productperch.com/products/pettenderly/ （预览入口）；evidence/2026-11-18-windows/productperch-scheduled.jpg |

## 关键未计数结果

- ShareYourStartup：用户已完成Cloudflare验证，截图绿色成功；全部必填字段有效，但提交按钮仍disabled。是网站未解锁提交，不是缺用户许可，不再让用户重复验证。证据shareyourstartup-verified-disabled.jpg。
- Mergeek：换已批准首页截图后成功生成 https://mergeek.com/latest/k16ZvAq455Ln8GEg ，但获取产品按钮disabled，官网链接0；开放外链需99元或至少21枚至少160天有效全球兑换码。单独记录为无外链免费收录，按当前收费排除规则不计有效投稿；没有付款或承诺赠送额度。证据mergeek-public-no-outbound.jpg、mergeek-outbound-paid.jpg。
- TheSEOBacklink：验证码通过后单次提交，数据库INSERT权限拒绝，无回执，不能盲重发。
- AIG123、IAHunt、ToolGPT、findaitools、lbbai、mogudh、Viesearch：历史单次发送回执未明，先查回执，不能因搜不到邮件就重投。
- AIExtension等已确认强制徽章/反链；其他确已收费、不适配、重复条目按台账排除，不重新反复检查。
- Softonic：入口已恢复，免费发布开发者中心存在，但账号新协议和网页版产品资格尚未核实；不能称已确认收费。
- 其余技术故障、缺账号/身份、未答复协议及入口未核实，逐域名详见current-blockers.csv，不混为同一种原因。

## 明天（11月19日）按什么投

1. 仍按本用户同一CSV、全局台账及合伙人已发布认领去重；先读本机指引、最新日报和本交接。若合伙人给出更具体官方免费入口，只映射回本清单对应域名及精确source_key推进；未经本用户批准不扩清单、不换合伙人清单。
2. 先查已有待审/不明回执和平台状态变化，再处理确已解除的阻塞。旧投稿上线或确认单独更新原条目，不再当新投稿重复计数。对无变化的付费、强制反链、同一故障不循环重试。
3. 仅恢复有明确下一步且可独立执行的入口。Softonic等先核实资格；账号/身份及未答复协议按用户要求暂放。ShareYourStartup只有按钮实际解锁才提交，不能强制启用；Mergeek不付款换外链。没有合规可操作项就如实报告，不能保证每天必有20个。

- Windows自动任务仍每日北京时间10点在原聊天续跑。11月19日按实际日期新记账，目标20；今天7份保持原日，13是今天缺口，不自动加成明天33，也不把旧7份重计。
- 仅明确免费正式回执、待审、排期或指向官网公开页计入；草稿、验证、无外链付费门槛页、无回执不计。

## 可以直接转发给合伙人的3组问题

1. **清单口径与可用入口**：这份371行是广泛候选库，还是你们逐站验证过的免费投稿名单？能否在其中优先标出目前仍接受中国网页AI宠物写真产品、免费且不要求官网反链/徽章的具体域名和官方投稿URL，并注明最近验证日期？如果有尚未走到的免费入口，请直接指出，避免我们只在主页上找不到。
2. **分工与去重**：除了GitHub已发布台账，还有没有合伙人已认领、已发但未同步或正在操作的平台？请提供域名+当前状态+时间（有公开URL/回执更好），不要提供密码、Cookie、验证码或私密确认链接。确认是否继续只用本用户这份CSV；若确需补充新候选，先由本用户明确批准新来源和分工。
3. **必要资料及计数口径**：有哪些已确认可以公开使用的创始人名姓、主体名称和业务电话，或无需这些资料的替代免费入口？账号如需本用户创建，应在本机完成，不共享密码。另请对齐“免费生成但官网外链收费”的收录是否仅列曝光、不计本轮有效外链；当前Mergeek按不计处理。平台协议/验证码如工具强制本人确认，仍需本用户具体同意，合伙人历史同意不自动继承。

## 最新增量（覆盖上文旧计数）

- Tech.eu官方免费推介表 https://tech.eu/startup-form/ 已经本用户具体确认验证码后完成提交，正式回执“您的答案已成功保存。谢谢。”，截图tech-eu-submitted.jpg。尚无公开报道或官网外链。
- 11月18日累计8/20，缺12：公开1、待审3、正式接收3、排期1。11月17日8份不变，两天有效回执合计16，公开外链仍2。
- 此项原是免费入口未核实，继续核查后发现实际可投；故仍不能把所有入口未明项概括为收费或永远不可投。TKTOC/AIAppVN本轮具体检查未找到正式免费表，保留原因待后续信息。

## Fundl最新增量与剩余候选核对

- Fundl免费项目创建成功，专属URL https://www.fundl.us/projects/pettenderly ，含官网链接；先记正式创建而非已证实匿名公开，无融资/支付/统计账号连接。今日9/20（公开1、待审3、接收4、排期1），缺11；两天有效回执17，公开外链仍2。
- 今日尚未核对的18条已分别实际核查或明确仅台账分流；媒体未核实免费入口、工具安全策略、真实身份资料及旧回执不明仍是不同阻塞，不能笼统称全收费。详见最新current-blockers.csv。


### 继续补足20份：两项原清单表单恢复与新候选具体草案

- 今日仍9/20，缺11；公开1、待审3、正式接收4、排期1。其中8份今日新提交，ToolTrove为旧投稿今日补确认，不混为9份新发送。本轮新增0。
- Chrome扩展正常识别directory.llmstxt.cloud/submit及sonicrun.com/freelisting.html，已重新核实表单内容。两页为仅保留的任务投稿页；未点击最终提交、SonicRun条款未勾选。当前工具要求绑定协议当场确认，已将两个具体条款检查点集中提出一次，未把展示问题视为授权。原精确source_key状态保持deferred，不制造新回执。
- LLMS免费nofollow，1–3个月审核，llms.txt须有效，法国法/波尔多法院；SonicRun免费约30天，需邮件确认，并自动提供可退订的FreeWebMonitoring免费账户/订阅。两份可复查截图llmstxt-current-ready.jpg与sonicrun-current-ready.jpg已保存。
- 按用户最新指示独立准备 records/runs/2026-11-18-new-candidates-DRAFT.csv 和同名.md：优先6站NavTools、Best of AI、ShowMeBest、Altern、YAATD、AI Kaptan有官方免费说明；6站条件未解决，3站明确排除。EveryAI命中全局历史而排除，GPTBot/AIDust当前官方收费而排除，不能照旧免费目录盲投。
- 草案未改原CSV，未写正式投稿台账，未对新候选填表或发送。已将6站具体新增范围集中询问一次，等待用户确认才可执行。706唯一source_key及现有soul-cat/platforms可用CSV检查未见这6站；合伙人未同步认领未知，不作保证。付款、强制徽章、身份缺失继续排除，AI Kaptan普通免费外链属性仍需现场核实。
- git fetch确认当前原分支与origin一致；没有机械重试371行、没有重投不明回执、没有把候选草案当成功。目标20尚未完成，现存两项绑定协议和补充范围待回答，不空转重试。
