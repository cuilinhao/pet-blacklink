# Pettenderly 投稿字段核对

核验日期：2026-11-06。本地一手来源：`/Users/pgy/Desktop/pettenderly`。资料范围为品牌介绍、公开功能、价格和公开素材；本次没有创建订单、付费生图、部署网站或对外投稿。

## 核实后的产品事实

| 字段 | 可以填写的事实 | 当前依据 |
|---|---|---|
| 名称、主页和联系邮箱 | Pettenderly · https://pettenderly.com/ · support@soulpaw.art | `README.md`、`PROJECT_STATUS.md`、`src/config/website.tsx`、`src/components/soulpaw/shell.tsx` |
| 受众与核心任务 | 宠物主人，用同一只宠物的照片制作可下载的 AI 数字写真。适用于猫狗写真、数字纪念照或数字礼物。 | `src/components/soulpaw/landing.tsx`、`portrait-studio.tsx` |
| 输入 | 标准写真 1–5 张同宠照片；JPG/PNG/WebP，每张最多 8 MB。 | `src/components/soulpaw/portrait-studio.tsx` 的上传区域与校验 |
| 风格 | 水彩、皇家肖像、影棚、窗边等当前可选风格。 | `src/lib/templates/presets.ts`、`vacation.ts`、`src/components/soulpaw/catalog.ts` |
| Beta 工具 | 人宠合影用分别上传的人物和宠物照片；照片清理允许文字描述修改。面部、花纹和细节可能变化。 | `src/components/soulpaw/landing.tsx` FAQ、`portrait-studio.tsx` |
| 价格 | Starter US$4.99/12 永久积分；Pro US$9.90/月或 US$79/年，两种订阅均每月发 40 点，余量不结转；年付分 12 个月度周期。 | `src/config/soulpaw-pricing.ts`、`README.md`、`PROJECT_STATUS.md`、首页 FAQ |
| 消耗 | 每张成功生成的图片 1 点，失败不消耗积分。 | 首页 FAQ、`src/lib/generation-credits.ts` |
| 免费限制 | 当前无免费方案；不能宣传免费试用、免费生图或 Freemium。 | `src/config/website.tsx` 中 free plan disabled；当前官网套餐与项目状态 |
| 账号 | Starter 可游客购买并通过邮件链接访问；Pro 订阅需要账号。支持邮箱登录与 Google 登录。 | 首页 FAQ、`src/lib/guest-access.ts`、`README.md`、`PROJECT_STATUS.md` |
| 语言 | 提供英文、简体中文、日文、韩文、法文、西班牙文语言选项，不保证所有页面完整本地化。 | `src/i18n/locales.ts`、`src/app/sitemap.ts` |

## 公开素材来源

- 当前品牌 Logo：`public/logo-pettenderly.svg`。官网 `src/config/website.tsx` 和页头引用此文件；不要误用旧 `public/logo-soulpaw.png`。
- 当前 OG 封面：`public/og-pettenderly.png`，1200 × 630 px。不要把旧 `public/og.png` 当新站封面。
- 皇家示例：`public/templates/pet-template-56.png`，1024 × 1536 px；官网风格库中的示例，并非本次新生成的客户作品。
- 水彩示例候选：`public/templates/pet-template-55.png`，1024 × 1536 px。
- 官网首页皇家示例原图：`public/images/v7/royal-original.png`；其它公开示例位于 `public/pinterest/`。这些图片只能按官网示例说明，不能杜撰真实客户身份或评价。
- 页面截图由主任务通过真实浏览器抓取。最终文件、尺寸和来源以 `assets/manifest.json` 为准。

## 现有资料的修正

1. `pettenderly/sites/PetTenderly.md` 原先引用的 `pettenderly-studio-en-1440x1000.png` 在该素材目录不存在；新包采用已约定的实际截图文件名，并交由最终素材检查确认。
2. 旧资料的核验来源提及私密配置文件；新包仅引用公开源码、官网和项目说明，不读取或复制私密配置。
3. `soul-cat` 的文案长度不能沿用，品牌替换会改变字数。新 `snippets.json` 和投稿文案由同一文本生成并按 Unicode 码点重新统计。
4. Pettenderly 公开品牌统一大小写；域名均用 pettenderly.com，客服邮箱 support@soulpaw.art 按用户要求保留。
5. 不能把 SoulPaw 的既有提交记录直接计为 Pettenderly 成功提交，也不能断言旧域名已完成 301。
6. 目录 GitHub 字段保持空：用户给定仓库可作开发来源记录，但公开宣传与开源属性未确认。公司身份、创始人、地址、手机、公司成立日期、团队人数、融资与公开产品版本保持空。用户于 2026-11-14 确认 Pettenderly 首次上线为 2026 年 10 月、国家为中国；具体上线日、城市和法律主体仍未确认。官方 X / Twitter 为 https://x.com/soulpaw_art，仅可填产品社交字段，不代表用户或创始人的个人账号；其它官方社交链接保持空。

## 宣传边界

- 数字图片下载，不宣传实物印刷或配送、固定生成时长、固定输出分辨率、完全保留相貌、无限生成或无条件退款。
- `You & your pet` 与照片清理保留 Beta 说明。AI 结果存在变化，官网样例不等于每位用户都可复现的结果。
- 模板数量可能变化，简介使用具体风格举例；不把目录中的旧模板或禁用模板算入宣传数量。
- 部署日期不能充当成立日期或首发日期。用户的其他项目资料不适用于本项目。
- `source_repository` 仅记录用户提供的开发仓库；未知 `business_facts` 以 JSON null 表示。

## 核验方式与限制

2026-11-06 已读取当前本地一手实现、README 和 PROJECT_STATUS，并在未登录浏览器核对首页、工作室和猫咪专题页。匿名 GET 检查的 14 个官网页面与 sitemap 均返回 HTTP 200，页面地址、规范链接与索引标记见 [live-site-check.json](evidence/live-site-check.json)。4 张真实截图的来源、日期、尺寸和校验值见 [素材清单](../assets/manifest.json)。

本次是资料核验，没有购买套餐、提交真实付款或生成付费图片；这些资料不宣称本次完成支付闭环测试。
