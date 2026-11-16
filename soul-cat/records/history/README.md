# Pettenderly 历史记录衔接

2026-11-06 从旧目录导入同一品牌的 40 条处理记录，供后续去重。原文件保持不变；本次只准备资料，没有新增提交。

| 原记录状态 | 条数 | 含义 |
|---|---:|---|
| `submitted` | 20 | 历史记录写明已提交；本次未重新核验公开状态。 |
| `skipped-sister-brand-batch` | 18 | 相同文章已用于相关品牌，保留跳过标记，避免重复联系或评论。 |
| `not-relevant` | 1 | 原记录判断不相关。 |
| `Duplicate` | 1 | 原记录标记重复。 |

[导入后的处理记录](../platform-progress.csv)保留原来源键和日期。回执 URL 已移除私有审核查询参数，备注改为不含凭据的状态摘要。移除审核参数后，链接可能只显示原文章，不能作为评论已经公开的证明。

来源为 `/Users/pgy/Documents/backlink-workspace/pettenderly/records/platform-progress.csv`；旧日志仍在 `pettenderly/records/daily/2026-11-05.md`。本目录没有复制账号文件、登录信息或原始私密回执。

来源与副本的 SHA-256、状态统计及最后一条历史来源键见 [import-2026-11-06.json](import-2026-11-06.json)。最后一条已处理来源键不等于下一条队列游标。

[公开外链库存](../backlinks.csv)目前只有表头，表示本次未重验公开链接，不表示此前没有提交。正式执行前应核对旧日志、处理记录和所选队列，计算真正未处理的下一行；不要从第一行重投。

## 当前资料目录切换

2026-11-06 应用户要求，当前资料直接维护于 `soul-cat/`。原 SoulPaw 记录保留在 `/Users/pgy/Documents/backlink-workspace/soul-cat/backups/soulpaw-before-pettenderly-20261106-094855/records/`，未改写品牌、旧目标网址或成功状态。本文中的旧 Pettenderly 路径是导入时来源记录；继续处理以本目录已导入的记录为准。平台 CSV 现已从工作区 `platforms-all/` 接入；具体来源见 [目录切换记录](domain-switch-2026-11-06.json)。
