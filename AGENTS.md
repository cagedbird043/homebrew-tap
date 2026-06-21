# homebrew-tap — Agent 运作规则

## 路由
所有 Agent-native 技能和文档入口，请参阅 [README.md](README.md) 的 `## Agent-native Skills` 章节。

## 关键路径与约束
- 只能通过修改 `Formula/` 目录下的 `.rb` 文件来发布、更新或移除包（Formula）。
- 禁止修改、创建或删除任何非 Homebrew tap 相关的文件。
- 发布/更新新版本时，必须同时更新 `version`、`url`、`sha256` 三个字段。
- 修改后，本地运行 `ruby -c Formula/<formula>.rb` 进行语法检查。

## 禁止事项
- 绝不要尝试将此个人 tap 中的 Forked/Binary Formula 提交推送到官方的 `homebrew/core`。
