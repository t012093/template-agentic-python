# LOOP.md - Loop Engineering Protocol

本リポジトリは `@cobusgreyling/loop` 設計規約に準拠した自律ループ運用を採用しています。

## コマンド一覧
- **環境監査**: `npx @cobusgreyling/loop audit .`
- **状態初期化**: `npx @cobusgreyling/loop init .`

## ライフサイクル
1. **Context Load**: `STATE.md` と `learnings.md` をロードして前提を把握。
2. **Execution**: 最小限の差分で実装。
3. **Verify (DoD)**: テスト & 型チェック & Spaghetti Guard で自動判定。
4. **Reflection**: 学びを `learnings.md` に追記し、`STATE.md` を完了に更新。
