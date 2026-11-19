# Pettenderly 原CSV剩余卡点明细

核对时间：2026-11-19 18:15（北京时间）。仅限 `supplemental-free-2026-11-16.csv`，排除合伙人清单与历史重复。

今日已核实新增 **10/20**：公开6、待审3、正式接收1，缺10。另有 **Viesearch旧投稿补确认1份**，不计入今日新增。

当前主台账中有 **99条原CSV待恢复记录**；这不等于有99个可立即投稿的平台。原CSV371行已核查，未处理0；有些记录因账号、资料、规则或站点故障仍暂缓。

本轮实际处理：ChatFreeAI表单已恢复但须登录；Shipyard Google跳转已恢复但当前客户端无账号会话；ShareYourStartup字段全部有效但真人验证未完成；Viesearch旧投稿已正式加入免费审核队列；17项不同客户端网络复查未恢复；Discord/monday/RapidAPI按官方应用/API要求排除。全程没有操作UU。


最新合并：Amplibee本次协议许可已收到，实际Google400 Bad Request，尚未登录/投稿；不再归入等待用户同意。

## 分类总表

|卡点类型|条数|平台|
|---|---:|---|
|真人验证|4|shareyourstartup.com, app.kit.com, szotar.sztaki.hu, forum.watzatsong.com|
|历史回执不明，禁止盲重发|6|toolgpt.co, findaitools.net, lbbai.com, mogudh.com, aig123.com, iahunt.com|
|首次协议检查点|2|chatfreeai.com, canadawebdir.com|
|表单、后台或证据故障|4|amplibee.com, theseobacklink.com, seeyouguys.com, domains.tntcode.com|
|账号登录或本人注册步骤|12|watcha.cn, welcome.ai, ahhhhfs.com, band.us, shipyardhq.dev, fc2.com, vidu-studio.com, zumvu.com, my.ai.se, w2solo.com, naya.com.np, startupeurope.net|
|站点连接、停用或证书|35|hao.logosc.cn, openstartup.tm, hayoai.com, ais-hub.com, ziniao.ai, dailybaileyai.com, phpcms9.com, gooddesign.tools, m3elem.com, slant.co, producthub.com, smtoai.com, jyshare.com, sublov.com, topapps.ai, connectively.com, aiagentlink.ai, insanelycooltools.com, advertise.aitoptools.com, topal.tools, funfun.tools, toolspedia.ai, hiaix.cn, artai.tools, ybx.com, tools4.us, allaboutai.com, ainavnav.com, ainavpro.com, today.tools, nuoniphp.cn, toolroad.ai, climate.stripe.com, blogs.rufox.ru, motot.net|
|真实资料、资格或敏感权限|9|bbb.org, productradar.ru, aidirectory.org, hatena.ne.jp, airdrop.krain.ai, servicelist.io, xploredomains.com, trendaitools.com, trustmrr.com|
|代理取舍或资格判断|3|patreon.com, mwmbl.org, alternativeto.net|
|适用免费入口尚未核实|18|partnershare.cn, bolworld.com, yahoo.com, forbes.com, foxnews.com, cnn.com, qq.com, wsj.com, bbc.com, qwoted.com, free-ai.tools, news.ycombinator.com, ai-kit.cn, tktoc.com, aiappvn.com, gartner.com, generatecontent.ai, portalnet.cl|
|工具安全策略阻止|4|nytimes.com, 163.com, usatoday.com, aimojo.pro|
|用户本轮已选择跳过|2|exactseek.com, f6s.com|

## 真人验证

|平台|具体原因（最新台账）|下一步|
|---|---|---|
|shareyourstartup.com|Root在Mac后台ego-browser重新打开当前免费匿名表单，全部name/url/pitch/category/details/email正常填入，浏览器原生字段checkValidity全部true，可选营销未选。当前实际Turnstile已显示真人复选框但未完成，Post it保持disabled。没有点击挑战/强制启用/提交。此与旧Windows绿色验证后仍disabled是不同会话；不把旧验证完成沿用到当前。保留草稿字段记录，0新增。|普通字段全部有效；当前需本人在ego空间16的p3完成真人验证，正常解锁后才能提交，禁止强制启用按钮。|
|app.kit.com|Root于Mac后台ego-browser任务专属空间单次检查官方signup?plan=1k。实际Turnstile iframe可见且持续正在验证，未出现注册字段；未点击/解决挑战、填表、注册或投稿。与Windows旧缺控件记录区分：这次有可见验证iframe，仍未通过。0新增。|当前Turnstile仍未通过，无注册字段；保留为验证阻塞，不能靠已打开页面计数。|
|szotar.sztaki.hu|官方入口显示Anubis正在确认是否机器人；未获投稿页，未绕过安全验证。|当前尚未核实适用于本产品的投稿用途，先暂缓；不为通过验证码而投入本人操作。|
|forum.watzatsong.com|指定论坛显示Cloudflare整页安全验证，无投稿回执，未绕过。|当前尚未核实适用于本产品的投稿用途，先暂缓；不为通过验证码而投入本人操作。|

## 历史回执不明，禁止盲重发

|平台|具体原因（最新台账）|下一步|
|---|---|---|
|toolgpt.co|Nov19 visible authorized Gmail in:anywhere search across all seven exact sender domains yielded only one Viesearch email; no matching sender-domain email for other six. Public site-scoped Pettenderly searches yielded no verified product receipt; absence is not proof of no submission. Preserve historical single attempt, no resend/count.|已按授权邮箱核对相关发件域名；继续只查现有回执或公开页，不盲重投。|
|findaitools.net|Nov19 visible authorized Gmail in:anywhere search across all seven exact sender domains yielded only one Viesearch email; no matching sender-domain email for other six. Public site-scoped Pettenderly searches yielded no verified product receipt; absence is not proof of no submission. Preserve historical single attempt, no resend/count.|已按授权邮箱核对相关发件域名；继续只查现有回执或公开页，不盲重投。|
|lbbai.com|Nov19 visible authorized Gmail in:anywhere search across all seven exact sender domains yielded only one Viesearch email; no matching sender-domain email for other six. Public site-scoped Pettenderly searches yielded no verified product receipt; absence is not proof of no submission. Preserve historical single attempt, no resend/count.|已按授权邮箱核对相关发件域名；继续只查现有回执或公开页，不盲重投。|
|mogudh.com|Nov19 visible authorized Gmail in:anywhere search across all seven exact sender domains yielded only one Viesearch email; no matching sender-domain email for other six. Public site-scoped Pettenderly searches yielded no verified product receipt; absence is not proof of no submission. Preserve historical single attempt, no resend/count.|已按授权邮箱核对相关发件域名；继续只查现有回执或公开页，不盲重投。|
|aig123.com|Nov19 visible authorized Gmail in:anywhere search across all seven exact sender domains yielded only one Viesearch email; no matching sender-domain email for other six. Public site-scoped Pettenderly searches yielded no verified product receipt; absence is not proof of no submission. Preserve historical single attempt, no resend/count.|已按授权邮箱核对相关发件域名；继续只查现有回执或公开页，不盲重投。|
|iahunt.com|Nov19 visible authorized Gmail in:anywhere search across all seven exact sender domains yielded only one Viesearch email; no matching sender-domain email for other six. Public site-scoped Pettenderly searches yielded no verified product receipt; absence is not proof of no submission. Preserve historical single attempt, no resend/count.|已按授权邮箱核对相关发件域名；继续只查现有回执或公开页，不盲重投。|

## 首次协议检查点

|平台|具体原因（最新台账）|下一步|
|---|---|---|
|chatfreeai.com|Root后台ego-browser本次表单水合已恢复，实际可填name/tagline/description/url/category/email并选择Free（估计134天18小时，不付款）。历史无该站回执，单次正常Submit后官方明确Sign in to submit a tool，无保存/投稿回执。官方/login支持Google或邮箱magic link，但继续即接受新terms，已准备并只询问该具体新协议一次，待真实回复。原“缺表单”技术阻塞已解除，当前为新协议及登录检查点；0计数，不重复匿名Submit。|表单已恢复；本次条款确认后可走官方邮箱magic link，由授权Gmail收验证，再回原表单提交一次。|
|canadawebdir.com|Current normal free nonreciprocal form prepared,2-4months review. Requires image CAPTCHA and agree-rules; independent rules.php renders admin default placeholder instead of substantive rules. Disclosed this limitation and asked current user per-action confirmation or skip. No response yet, no CAPTCHA solved/agreement/submission. Public fields/screenshot saved canada-directory-fields.json and canada-directory-ready.jpg.|先取得明确规则正文；当前规则页是占位内容，另有图片验证码，不能替用户接受未知规则。|

## 表单、后台或证据故障

|平台|具体原因（最新台账）|下一步|
|---|---|---|
|amplibee.com|本次用户在具体条款隐私披露后明确同意Amplibee terms/privacy+指定Google免费投稿，许可已收到，不再待答。Windows在保留Tabbit Google弹窗162534102真实选[项目邮箱]一次后，官方Google返回400 Bad Request：The server cannot process the request because it is malformed. It should not be retried. 没有到继续分享确认/平台登录/投稿表提交；本次0新增。未重放同请求、未改OAuth参数/换凭据/新密码/重置/付款，不把注册许可算回执。证据amplibee-google-400.png。仅关闭本任务Google弹窗和Amplibee页，原用户其余Tabbit标签保留；fresh AX确认无Amplibee/Calameo任务页。Root/用户许可保持有效，后续只能有明确新正常恢复条件才继续，当前不是缺同意。|该站本次条款已同意；Google返回400 malformed且不要重试。不重放或篡改OAuth请求，只有明确新正常恢复条件才继续，不再询问同意。|
|theseobacklink.com|用户本次具体同意reCAPTCHA和免费宠物目录投稿。验证checked后提交一次，官方返回SQLSTATE42000/1142 INSERT command denied，数据库拒绝写入，无成功回执，不计数，不盲目重发。截图theseobacklink-server-error.jpg。|平台数据库曾拒绝INSERT；代理无法修其数据库，保留失败证据，禁止盲目重发。|
|seeyouguys.com|已运行公开官网技术检测并显示报告，但URL仍为根路径，无目标专属公开永久链接或投稿回执，不计数。报告流量收入为站点自动估算，不采用为业务事实。|没有目标专属公开永久页或回执，不能计数。|
|domains.tntcode.com|补充Root转交的Windows UU原生实际观察（非本代理扩展截图）：新标签打开https://domains.tntcode.com/，正确输入pettenderly.com并单击Search一次；等待80秒仍转圈且展示旧域名列表，无目标结果、资料页或官网链接。Root仅关闭此次新诊断页，保留其所述原两页；本代理没有操作或宣称关闭这些原页，当前活页清单未另行读取。此前扩展读取超时已由此次真实UI搜索挂起补证，不能再只写未原生核实。0投稿、0回执，不重复搜索、不判全网永久失效。所有真实用户协议答复仍pending，不接受或重问。|真实搜索一直转圈，无目标公开结果；不反复搜索或制造技术报告计数。|

## 账号登录或本人注册步骤

|平台|具体原因（最新台账）|下一步|
|---|---|---|
|watcha.cn|本轮真实点击发布→发布产品，弹出微信小程序扫码/中国大陆手机号短信/密码登录；注册登录需用户协议及隐私勾选，没有邮箱路线。无本用户可用手机号/微信登录态，不使用旧操作者账号。截图watcha-login-required.jpg，未投稿，不重复发常规问题。|需要本人微信或大陆手机号登录；本项目未有可用授权登录态。|
|welcome.ai|本轮不同Tabbit现有会话恢复，官方/auth仍显示Sign In邮箱密码，指定项目邮箱填入后密码为空、无现有自动填充值，没有magic link/Google；未提交空密码、未注册/重置/新密码。与之前Chrome独立检查区分，不把无历史邮件说成无账号。0新增。|先复用现有指定账号；无可用会话/凭据则需本人处理，不重置或沿用旧操作者账号。|
|ahhhhfs.com|Current official homepage 投稿 points to QQ feedback A姐分享投稿. Prepared accurate resource recommendation, selected 投稿反馈, clicked Publish once; redirected to QQ-only login requiring account plus terms/privacy checkbox. No post receipt or public content; no QQ account authorized or used, no terms accepted. Not counted.|只有QQ登录入口，当前无本用户已授权QQ会话。|
|band.us|Windows扩展实际首页恢复：免费团队社群，可公开帖子；官方/policy/operating允许公开社群曝光，但禁反复垃圾推广，商业交易须披露卖家资料。条款页初Loading后真实加载成功，纠正暂时加载故障。邮箱注册https://auth.band.us/email_sign_up需邮箱、新密码、姓名、出生日期，并注册即接受条款/隐私及服务活动提示；未填任何字段/未注册。缺真实身份与新凭据，按既有指示放置，不新增常规确认。证据band-registration-real-fields.jpg。|注册需真实姓名、生日及本人新密码；现有资料不足，不能复用前操作者账号。|
|shipyardhq.dev|Root后台ego-browser不同客户端单次正常Google按钮已成功导航到真实Google登录页，纠正旧永久login-flow-stalled；本环境没有现成指定Google会话，显示邮箱/电话号码登录字段，未填凭据、未新账号、未投稿。未用新身份绕障碍，不是站点不能登录。需已授权的指定账号会话后继续；0计数。|后台Google跳转已恢复；当前ego没有指定Google登录状态，需复用指定账号会话后继续。|
|fc2.com|Windows实际官方FC2 Blog明确10GB免费，展开真实注册模态：Email/Password/Blog ID/四数字验证码/Terms复选及Register；未注册未接受条款未解验证码。后续DOM另出现站方reCAPTCHA Enterprise免费配额已超，非用户未授权。新密码仍需本用户输入，按既有偏好先放置，不使用旧操作者凭据。官方https://help.fc2.com/blog/tos/en/有广泛内容使用许可、禁止重复spam/过量广告，非一概商业博客禁令；当前不请求多重低收益关卡。截图fc2-registration-checkpoint.jpg。0提交。|新密码须本人处理，且站方验证配额异常；未经实际修复不循环重试。|
|vidu-studio.com|本轮不同Tabbit现有会话检查仍GUEST；真实LOG IN用户名/邮箱+密码，指定项目邮箱填后密码空、无现有自动填充或magic link。未新密码/重置或空密码登录测试，未投稿。0新增。|先复用现有指定账号；无可用会话/凭据则需本人处理，不重置或沿用旧操作者账号。|
|zumvu.com|已检查Listing免费永久档及注册页；需要真实姓名、生日、账号凭据、算术人机验证与注册条款确认。本用户未提供这些注册资料，未采用前操作者账号，未创建账号或发送投稿。|注册需真实姓名、生日、新密码及验证；不得猜测生日或旧账号。|
|my.ai.se|公开社区可查看AI服务；注册必须真实名姓、密码、条款勾选与ALTCHA验证。未提供本用户姓名及凭据授权，未创建账号，未提交。|需真实姓名、本人新密码、条款及ALTCHA；不伪造身份。|
|w2solo.com|新主题入口要求登录；注册表需用户名、名字、邮箱及密码确认；本用户未授权具体新账号凭据，未沿用旧操作者凭据、未注册。|需真实注册资料及本人新密码步骤；当前无可复用账号。|
|naya.com.np|本轮不同Tabbit现有会话仍username/password+Forgot/Register，无magic link/Google；指定邮箱作标识填入后密码空，没有当前用户可用自动填充，未新建/重置/提交空密码。0新增。|先复用现有指定账号；无可用会话/凭据则需本人处理，不重置或沿用旧操作者账号。|
|startupeurope.net|免费目录入口需账号；注册表要求真实名姓、邮箱、密码确认。未获本用户新账号凭据与名姓，未注册；页面定位EU但现有条目含其他国家，地域资格仍需核实。|先核地域资格与真实姓名；另需本人新密码。|

## 站点连接、停用或证书

|平台|具体原因（最新台账）|下一步|
|---|---|---|
|hao.logosc.cn|Current Chrome official root CERT_DATE_INVALID. Closed only task-owned certificate error tab using supported management capability; user sessions preserved, no bypass/submission.|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|openstartup.tm|Current official page explicitly OpenStartup is currently paused, focusing on PayRequest. No submission service.|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|hayoai.com|Current official page This deployment is temporarily paused. No form or submission.|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|ais-hub.com|Root user-transferred UU native Chrome observation: exact www.ais-hub.com/submit returned ERR_CONNECTION_CLOSED. Windows extension URL confirms exact page; DOM read CDP focus error, screenshot saved ais-hub-connection-closed.jpg. No further retry. Root separate read-only root-domain research reports crypto investment service, not independently verified product directory. No registration or submission.|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|ziniao.ai|Windows扩展实际打开准确https://www.ziniao.ai/submit仍为ERR_EMPTY_RESPONSE、未发送任何数据；TLS通过不等于表单恢复。0投稿。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：RemoteDisconnected: Remote end closed connection without response。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|dailybaileyai.com|Root reports Windows UU native exact official URL ultimately ERR_CONNECTION_CLOSED; zero submission. Supersedes prior native-diagnosis-pending note. Not a claim domain globally dead. Read-only local DNS/TCP/TLS test: current system resolution in 198.18.10.*; TCP443 connects but TLS EOF (InsanelyCoolTools TLS timeout); Pettenderly control certificate-verified TLS1.3 succeeds. Mihomo DNS interface present; Windows manual proxy disabled and WinHTTP direct. Local path/upstream vs remote cause unresolved; no network/security settings changed. See network-readonly.json. Toolnest/Shipyard still not Root-native diagnosed. Nov19 user-requested single system DNS/TCP/verified TLS recheck: unchanged failure; Pettenderly control TLSv1.3 succeeds. No browser reopen, no new native navigation or submission. Evidence records/runs/2026-11-19-network-readonly-recheck.json. \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|phpcms9.com|Current official root shows Cloudflare521 Web server is down/Host Error; stopped same fault, no submission. \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLCertVerificationError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: certificate has expired (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|gooddesign.tools|Current Chrome official root SSL_VERSION_OR_CIPHER_MISMATCH. No security bypass or submission.|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|m3elem.com|Current direct official root ERR_CONNECTION_CLOSED. No form or submission; stopped same failure. \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|slant.co|Current official page Cloudflare526 Invalid SSL certificate/Host Error. No bypass or submission.|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|producthub.com|Current official root ERR_CONNECTION_CLOSED again; no form loaded or submission. Stopped repeated same connection failure. \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|smtoai.com|Fresh task tab official root CERT_DATE_INVALID. Closed only this task-owned error tab; no bypass/submission.|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|jyshare.com|Current official root CERT_COMMON_NAME_INVALID. Closed only task-owned error tab; no certificate bypass/submission.|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|sublov.com|Current official root HTTP_RESPONSE_CODE_FAILURE, no form or submission. Stopped same server fault. \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLCertVerificationError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: certificate has expired (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|topapps.ai|Windows恢复轮官网明确Site Currently Unavailable，要求站长联系托管商，未投稿。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|connectively.com|Current direct navigation timeout, URL remained prior CPHM domain. Target not loaded; no retry or submission. \| 2026-11-19只读单次传输诊断（非浏览器访问）：TimeoutError: _ssl.c:983: The handshake operation timed out；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|aiagentlink.ai|Root reports Windows UU native exact official URL ultimately ERR_CONNECTION_CLOSED; zero submission. Supersedes prior native-diagnosis-pending note. Not a claim domain globally dead. Read-only local DNS/TCP/TLS test: current system resolution in 198.18.10.*; TCP443 connects but TLS EOF (InsanelyCoolTools TLS timeout); Pettenderly control certificate-verified TLS1.3 succeeds. Mihomo DNS interface present; Windows manual proxy disabled and WinHTTP direct. Local path/upstream vs remote cause unresolved; no network/security settings changed. See network-readonly.json. Toolnest/Shipyard still not Root-native diagnosed. Nov19 user-requested single system DNS/TCP/verified TLS recheck: unchanged failure; Pettenderly control TLSv1.3 succeeds. No browser reopen, no new native navigation or submission. Evidence records/runs/2026-11-19-network-readonly-recheck.json. \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|insanelycooltools.com|Root reports Windows UU native exact official URL ultimately ERR_CONNECTION_CLOSED; zero submission. Supersedes prior native-diagnosis-pending note. Not a claim domain globally dead. Read-only local DNS/TCP/TLS test: current system resolution in 198.18.10.*; TCP443 connects but TLS EOF (InsanelyCoolTools TLS timeout); Pettenderly control certificate-verified TLS1.3 succeeds. Mihomo DNS interface present; Windows manual proxy disabled and WinHTTP direct. Local path/upstream vs remote cause unresolved; no network/security settings changed. See network-readonly.json. Toolnest/Shipyard still not Root-native diagnosed. Nov19 user-requested single system DNS/TCP/verified TLS recheck: unchanged failure; Pettenderly control TLSv1.3 succeeds. No browser reopen, no new native navigation or submission. Evidence records/runs/2026-11-19-network-readonly-recheck.json. \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error _ssl.c:1114: The handshake operation timed out>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|advertise.aitoptools.com|10am Windows recovery official advertising subdomain fails ERR_CONNECTION_CLOSED. No free submission verified or sent. \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|topal.tools|Windows恢复轮官网ERR_CONNECTION_CLOSED，未提交。 \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|funfun.tools|Windows恢复轮官网明确This deployment is temporarily paused，未提交。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|toolspedia.ai|Windows恢复轮官方入口仍报告ERR_CONNECTION_CLOSED，未提交。 \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|hiaix.cn|Root reports Windows UU native exact official URL ultimately ERR_CONNECTION_CLOSED; zero submission. Supersedes prior native-diagnosis-pending note. Not a claim domain globally dead. Read-only local DNS/TCP/TLS test: current system resolution in 198.18.10.*; TCP443 connects but TLS EOF (InsanelyCoolTools TLS timeout); Pettenderly control certificate-verified TLS1.3 succeeds. Mihomo DNS interface present; Windows manual proxy disabled and WinHTTP direct. Local path/upstream vs remote cause unresolved; no network/security settings changed. See network-readonly.json. Toolnest/Shipyard still not Root-native diagnosed. Nov19 user-requested single system DNS/TCP/verified TLS recheck: unchanged failure; Pettenderly control TLSv1.3 succeeds. No browser reopen, no new native navigation or submission. Evidence records/runs/2026-11-19-network-readonly-recheck.json. \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|artai.tools|Windows Chrome official root failed ERR_CONNECTION_CLOSED. No submission. \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|ybx.com|Official root fails SSL_UNRECOGNIZED_NAME_ALERT in Chrome. No certificate/security warning bypass, no submission.|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|tools4.us|Windows official homepage failed ERR_CONNECTION_CLOSED. No submission. \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|allaboutai.com|Official homepage Submit a Tool links to cloudwaysapps media-kit URL, which fails ERR_CONNECTION_CLOSED in Chrome. No verified free form or submission. \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：HTTPError: HTTP Error 403: Forbidden。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|ainavnav.com|Root reports Windows UU native exact official URL ultimately ERR_CONNECTION_CLOSED; zero submission. Supersedes prior native-diagnosis-pending note. Not a claim domain globally dead. Read-only local DNS/TCP/TLS test: current system resolution in 198.18.10.*; TCP443 connects but TLS EOF (InsanelyCoolTools TLS timeout); Pettenderly control certificate-verified TLS1.3 succeeds. Mihomo DNS interface present; Windows manual proxy disabled and WinHTTP direct. Local path/upstream vs remote cause unresolved; no network/security settings changed. See network-readonly.json. Toolnest/Shipyard still not Root-native diagnosed. Nov19 user-requested single system DNS/TCP/verified TLS recheck: unchanged failure; Pettenderly control TLSv1.3 succeeds. No browser reopen, no new native navigation or submission. Evidence records/runs/2026-11-19-network-readonly-recheck.json. \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|ainavpro.com|浏览器报告net::ERR_CERT_DATE_INVALID，未绕过证书警告，未提交；待站点修复证书。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|today.tools|投稿页在本机Chrome报告ERR_CONNECTION_CLOSED，站点意外终止连接，未提交。 \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|nuoniphp.cn|本机Chrome打开官方入口报告ERR_CONNECTION_CLOSED，未获得投稿页，未提交。 \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|toolroad.ai|本机Chrome打开指定提交入口报告ERR_CONNECTION_CLOSED，未获得表单、未提交；原清单亦注明域名识别待确认，不猜测替代域名。 \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。 \| 2026-11-19 Root Mac不同客户端正常证书校验HTTPS单次只读复核：URLError: <urlopen error EOF occurred in violation of protocol (_ssl.c:1131)>。没有恢复到可提交表单；未改网络/证书配置、无投稿。详records/runs/2026-11-19-root-mac-network-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|climate.stripe.com|指定官方根入口返回Stripe invalid_request_error/Unrecognized request URL，无可用产品投稿表，未进行财务操作。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|blogs.rufox.ru|本机Chrome报告ERR_CERT_DATE_INVALID，未绕过证书警告，未提交。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|
|motot.net|Chrome导航10秒超时，复核仍在上一站，未进入目标站，未提交。 \| 2026-11-19只读单次传输诊断（非浏览器访问）：SSLEOFError: [SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1000)；无HTTP/投稿/配置改动，未全网判死。详records/runs/2026-11-19-nov18-connection-readonly-recheck.json。|只作正常证书校验的复查；待站点恢复，不绕过证书/不改安全设置。|

## 真实资料、资格或敏感权限

|平台|具体原因（最新台账）|下一步|
|---|---|---|
|bbb.org|本轮官方Get Your Business Listed确有免费Business Profile申请，但先要求Find业务与Near所在地核对。当前没有本产品已确认实体经营地址/城市及对应商家主体资料；不使用站点按IP显示的Foy/Los Angeles作为用户地址，不虚构当地商家，不提交。不能写成收费。|需要真实商家主体、营业城市及地址；不能采用页面按IP显示的默认地点。|
|productradar.ru|官方说明与规则只读web核对：免费，面向俄语团队/创始人；规则第1条要求非匿名创始人资料完整，真实照片、介绍、Telegram联系。当前无本用户批准的公开创始人照片/Telegram，不编造，身份项按用户指示放置。修正旧中国国别即终态结论，尚未核实该背景可被接受；未新登录提交。|需真实创始人资料、照片、Telegram及地域/团队资格；不得编造。|
|aidirectory.org|Current official AI company form Phone Number marked mandatory plus reCAPTCHA. Prepared title,generative-AI category,brand,official URL,China,public support email and description; unknown street/city/phone blank. Asked current user for public business phone and this-site CAPTCHA consent or skip. No fabricated telephone/submission. Evidence aidirectory-fields.json and aidirectory-phone-required.jpg.|需要用户确认可公开的业务电话；再处理当前验证码与免费提交。|
|hatena.ne.jp|Windows实际Hatena注册页有ID/密码/邮箱/国家、reCAPTCHA和Google注册，无提交；官方commercial-guidelines只读web核对：个人/非公司团体可按个人商业规则发自己的服务文章，但法人媒体必须企业付费方案；其他Hatena服务商业使用仍受限。本产品legal_entity在档案null，不能冒称个人企业资格或选择公司付费；身份资格项先放置，不接受新条款/验证码，不计数。|个人商业发布与法人媒体规则不同；需确认实际发布主体资格，不擅自声称已满足。|
|airdrop.krain.ai|本次仅stage。Windows真实Submit App登录关卡，Continue with email正常显示无需钱包邮箱magic-link，已填指定项目邮箱但未点Send magic link。未连钱包/空投/代币/奖励。实际产品提交免费档条件仍需登录后核实，不能把无登录费用当正式收录免费证据。当前官方/legal/terms生效2026-09-09：非美国公民且不在禁辖区、18+、Independent contributor范围、Arizona AAA强制仲裁/集体诉讼放弃，页面仍留[DATE]和律师审核草稿提示。/legal/privacy生效2026-11-17：邮箱/用户名/设备使用数据、可选钱包/社交数据、运营方newsletter可退订；不出售个人数据，第三方服务商/法律披露。资格未知不能从产品China推断用户公民/居留；未接受。截图krain-current-email-terms-staged.jpg。|条款要求公民/辖区资格且有仲裁与占位草稿问题；需真实资格，不能由产品国家推断。|
|servicelist.io|Official Standard application is free but requires founder full name at step1 and says verifiable business, not a side project, delivering value to business buyers. No verified founder/legal business facts in product dossier; did not invent name or submit incomplete identity.|需要真实创始人及可验证的B2B业务资料，消费级宠物写真适配性仍待核。|
|xploredomains.com|Official Add Domain form available with name/email/domain. Name field explicitly requests full name; current product dossier founder_name null. No personal full name invented, no form sent.|需要确认真实联系人全名；Google展示名称不等于已确认的产品创始人身份。|
|trendaitools.com|Root official FAQ new evidence free basic route independently loaded Windows. Free review up to30days; no edits/support. Actual fields name/email/phone/country/tool/category/url/pricing/description required; DOM required=true confirms name and phone mandatory. No confirmed user phone; user holds identity fields, no fabrication. Prior paid terminal too broad, reopened deferred. trendai-free-phone-required.jpg. No submit/count.|姓名、电话均为必填，需真实公开联系方式；不使用旧操作者电话或虚构。|
|trustmrr.com|Add startup弹窗要求Stripe等支付商只读API密钥以公开验证营收，并接受条款；没有本用户财务数据授权，未创建或输入密钥，未提交。|要求支付商只读API密钥并公开营收；超出本次普通外链授权，不提供财务密钥。|

## 代理取舍或资格判断

|平台|具体原因（最新台账）|下一步|
|---|---|---|
|patreon.com|官方条款只读web核对，确有免费创作者内容发布，非简单不是目录排除。但License to your creations对发布内容授予永久、不可撤销、可再许可全球许可；将该永久许可视为本轮不优先接受的条件，是本代理的风险判断；不是用户明确拒绝，也不是用户声明的一概排除永久许可的偏好。本代理本轮延后这条低优先路线，不擅自接受、不把它记为用户明确拒绝；未创建创作者账号/会员/收款或帖子，0计数。|确有免费内容发布；永久不可撤销许可导致本轮代理延后，非用户拒绝。|
|mwmbl.org|Root execution decision defer this run because manual credential setup is low value for search indexing. User asked about downside but did not accept terms or explicitly instruct skip. Do not re-ask/register. No acceptance/new password/API/domain submission/count. Prepared page closed as this run deferred; not a dead opportunity or proof no official route.|本轮代理按手动注册成本与索引收益延后，非用户拒绝或没有入口。|
|alternativeto.net|本用户本次已明确同意披露条款/基本Google及Cloudflare。Root完成真人验证交回实际新页1919365932，旧5930已消失，Windows查真实标签后接管而非重开登录。单次选指定Google账号，Continue只姓名/头像/liu827274邮箱成功；品牌用户名pettenderly；可见官方Gmail当前[项目邮箱]确认邮件正常链接完成，官方Your e-mail is verified。当前站内搜索Pettenderly明确Sorry no apps was found；Nov8旧跨CSV无账号/无投稿历史保留。正式/manage-item/表单已读，未填产品/未Submit。其FAQ当前明确拒收thin wrapper around someone else model、headshot generators、general-purpose image/video/music generators及同质化/过饱和产品；Pettenderly宠物写真目前无足够依据证明满足差异化资格，本代理执行判断本轮不投，不是用户拒绝，也非官方逐字禁止全部宠物产品。不得绕到用户资料广告（FAQ明确禁止）。0新增/无回执/无付款，不补投旧记录。证据alternativeto-email-verified.jpg、alternativeto-current-ai-eligibility-rules.jpg、alternativeto-submission-form-not-sent.jpg；任务2页已关闭，Root其他ToolTrove页未碰。|账号已验证，但当前官方收录政策下产品差异化资格尚无足够证据，本轮代理选择不投。|

## 适用免费入口尚未核实

|平台|具体原因（最新台账）|下一步|
|---|---|---|
|partnershare.cn|Current Windows run read official navigation/footer. No submit/list/join product form; buttons Login/free trial lead affiliate-platform account service, not formal directory receipt. Contact buttons only. No account or unsolicited inquiry.|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|bolworld.com|官方公开主页只读web核对为stories/guides文章站，实际仅Topics/Latest/About/Contact及消息表单；未见正式第三方作者投稿、免费产品发布规则或接收路线。保留可能内容相关性，不因不是目录直接否定；不把普通合作询问当投稿，不发送消息。0提交。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|yahoo.com|本轮官方主页为新闻聚合、账户/天气等服务，页脚Advertise/AboutOurAds/Help/Feedback/ProductsServices；未见适配免费正式AI产品收录表。不创建账户反馈或购买广告冒充投稿。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|forbes.com|本轮官方主页可读，导航/页脚为新闻分类、Lists、Advertise with Forbes和Contact Us；未核实匿名免费普通产品目录入口。不把编辑新闻/广告与免费目录混为一谈，不付费、不发无关联系消息。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|foxnews.com|本轮官方主页→Contact，主要电话、FAQ及Fox Nation优惠/服务支持，非产品收录表。未找到适配免费正式推介入口，不发送客服工单或无关推广。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|cnn.com|本轮实际读取官方主页/页脚，为新闻/订阅/广告/帮助。弹出Legal Terms and Privacy要求Agree，未接受新协议；未核实适配免费产品收录入口，未提交、不订阅。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|qq.com|本轮腾讯门户官方主页可读，发布类入口为企鹅号用户认证，另有商务合作/客服/广告说明；未见无需创作者认证的免费普通产品目录投稿。未新建企鹅号或虚构认证身份，不把发新闻文章当目录回执。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|wsj.com|本轮官方主页可读，为新闻/专栏/订阅内容，未核实适配消费级AI产品的免费自助收录表。未购买订阅或提交无关新闻，保留入口未核实，不写成确认收费。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|bbc.com|本轮实际读取官方主页/页脚，入口为新闻频道、BBC账号、订阅、广告、客服Contact，没有核实到适配AI宠物写真工具的免费正式产品收录表。未发无关新闻线索、不注册订阅，不把未核实写成收费。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|qwoted.com|本轮Windows官网显示记者/专家及公关连接网络，未见适用于本产品的免费正式目录投稿入口；不虚构专家身份。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|free-ai.tools|本轮官网联系页找到正式Submit Your AI tool说明；Submit Now实际指向mayurit.solutions/2024/04/youtube-video-collaboration-packages.html商业视频合作套餐，目标实际访问ERR_CONNECTION_CLOSED，未核实免费正式表单。不发送联系邮件、不计数。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|news.ycombinator.com|本轮仅复核历史：原记录为ShowHN需开发者亲自分享答疑，尚无本用户已确认账号/发布身份，用户曾要求身份项先放着。未重新访问、注册或发帖，不伪造创始人经历，不当新浏览器检查。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|ai-kit.cn|Official about page says product listing/promotion requires contacting via WeChat QR. No anonymous free submission form or confirmed fee. No account or message sent.|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|tktoc.com|本轮继续核对官方完整导航、footer、About和加入我们。About定位跨境社媒卖家运营工具，加入我们实际招聘页，不是投稿。未发现产品收录/Add/Submit入口，商务合作仅二维码，无法确认免费正式收录，保留入口未核实，不记收费或成功，不投简历/无关消息。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|aiappvn.com|本轮继续核对官方导航/footer及Services。主页是编辑AI文章/工具资料和邮件订阅，Services实际按需付费图片视频制作目录，不是提交第三方AI产品。未发现可用正式产品收录表，不把newsletter或付费制作询价当投稿，不计数。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|gartner.com|当前官方主页为企业决策研究咨询；未核实适用于消费级宠物写真工具的免费产品自助投稿入口。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|generatecontent.ai|指定论坛线程当前只显示Community Feed空壳，Community按钮禁用，无帖子正文或可用正式投稿表，未评论。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|
|portalnet.cl|当前为西语综合讨论论坛，仅见登录注册与帖子，无已核实产品收录入口，未发表无关推广。|核实正式相关入口后才投稿；不发送客服、新闻线索或无关论坛广告。|

## 工具安全策略阻止

|平台|具体原因（最新台账）|下一步|
|---|---|---|
|nytimes.com|本轮真实浏览器官方URL被site-safety policy阻止观察。停止该站，未用其他工具/浏览器/间接访问绕过，无投稿。|停止该入口，不更换工具绕过明确安全限制。|
|163.com|本轮真实浏览器官方URL被site-safety policy阻止观察。停止该站，未用其他工具/浏览器/间接访问绕过，无投稿。|停止该入口，不更换工具绕过明确安全限制。|
|usatoday.com|本轮真实浏览器官方URL被site-safety policy阻止观察。停止该站，未用其他工具/浏览器/间接访问绕过，无投稿。|停止该入口，不更换工具绕过明确安全限制。|
|aimojo.pro|10am Windows scheduled recovery: official domain redirected to aimojo.io and browser site-safety gate denied observation. No alternate browser/tool or workaround used. No submission.|停止该入口，不更换工具绕过明确安全限制。|

## 用户本轮已选择跳过

|平台|具体原因（最新台账）|下一步|
|---|---|---|
|exactseek.com|用户本次采纳Root建议，明确本轮跳过ExactSeek；未接受此前披露协议、未提交，不再作为待答问题。保留免费Standard事实与旧stage证据，非站点不免费结论。|保持用户本轮选择，不重新询问或自动恢复。|
|f6s.com|用户本次采纳Root建议，明确本轮跳过F6S；未接受此前披露协议、未登录或提交，不再作为待答问题。保留此前free加入/身份字段待核的stage证据。|保持用户本轮选择，不重新询问或自动恢复。|

## 本轮已解决或明确排除

- Calaméo：Windows Tabbit已完成公开指南，今日第10份。https://www.calameo.com/read/008345597addc853eb14e
- Viesearch：Nov17旧投稿今日补确认，免费审核已接收；详情仅本人可见、PENDING，非公开外链。https://viesearch.com/2ay8g/pettenderly-ai-pet-portraits
- Discord、monday、RapidAPI：需其生态实际应用/集成/API，本产品当前没有，不再仅写页面加载失败。

## 执行边界

- UU操作0；不自动弹出任何远程窗口。
- 原CSV范围保持，既有免费/无强制反链条件保持；付费、强制徽章、无关推广与历史重复不计数。
- 已确认过的同一协议不重复询问；新协议仅保留当前工具必需的那一次确认。
- 相关邮箱可自动核对；验证码、本人新密码、未提供的真实资料与明确安全拦截不是可以凭空补齐的内容。


## Windows本轮具体复核：Blogarama、Naver（0新增）

- Blogarama：官方首页明确免费博客收录；add-a-site/跳转app.blogarama.com/members后Windows Tabbit实际ERR_TIMED_OUT，仅一次，不再重复。截图records/evidence/2026-11-19-windows/blogarama-free-route-timeout.png。旧非目录排除已纠正为导航故障待恢复，未注册/未提交。
- Naver：官方博客有宠物及产品评测类别，Google基本登录已推进真实注册ID页面；尚未Sign up或接受Naver协议。官方条款https://policy.naver.com/policy/service_en.html明确未经许可禁止自动化注册、登录及发帖，因此代理判断停止本轮，不归因于用户拒绝。隐私https://policy.naver.com/policy-mobile/privacy_en.html。未创建账号/发帖，0计数；任务页已关闭，用户Tabbit其他会话保留。
- Amplibee：用户最新明确本轮跳过；先前Google400真实错误保留，许可已收到，不再列待答。
- 今日仍10/20（公开6、待审3、接收1），缺10；没有新回执。全局707唯一key，原CSV371行覆盖；覆盖完不等于完成20。

本轮更新后原CSV deferred实际100条；此前99为上轮快照，非可操作名额。


## Windows本轮原CSV持续恢复批次（8项，0新增回执）

- 先核对b481af8、707唯一source_key及今日10/20；Shipyard精确key重开后resume_gate PASS，核实后已恢复deferred检查点，未留下unprocessed。
- CoderLegion原今日待审投稿已在未登录Tabbit实页确认完整公开，两个链接均准确https://pettenderly.com/；截图coderlegion-public-confirmed.png。仅状态升级，不新增计数：今日10/20＝公开7、待审2、接收1，缺10。
- AI Toolhouse实际submit→get-featured仍80美元；AIForEveryone实际submit-ai→submittool.ai/listing/aiforeveryone仍80/120美元，无免费档，未付款/提交。
- HDRobots官方正式页仍9美元，公开details表不等于免费；AI Tools Club官方Promotion仍790/1200/2100美元月费。这两站为官方公开网页只读复核，未假称Windows浏览器访问。
- AIG123真实站内搜索没有内容，不足证明旧发送失败；IAHunt真实Search AIs填产品名后要求登录，无法核对。两项继续unconfirmed，未重发，0新增。AIG123截图aig123-old-search-no-result.png。
- Shipyard主页明确免费产品收录，Tabbit正式入口正常到登录；新条款/隐私已读并集中提交一次实际确认，尚无真实答复，不接受、不注册、不计数。保留唯一Shipyard任务页，其他核对页已关闭。截图shipyard-tabbit-login-ready.png，精确恢复见2026-11-19-shipyard-current-terms-checkpoint.json。
- ChatFreeAI既有Root条款答复仍待，不另问；ShareYourStartup当前Root真人验证检查点与Windows旧故障区分。其余同故障、费用、徽章、身份缺失、工具安全阻止及旧不明回执不机械重试。原371行覆盖不等于达到20，未扩清单。
- 澄清：Blogarama仅后端ERR_TIMED_OUT，并无证据表明识别/拦截自动化；Naver停止是代理依据官方自动化禁令作出的判断。
