# template-agentic-python

2026年水準のエージェント自律開発ハーネス（Agentic Harness）とモダン Python（uv / Ruff / Pytest / CodSpeed）を統合した開発用リポジトリテンプレートです。

---

## 🌟 特徴と構成

### 1. エージェント自律ハーネス（Agentic Harness）
- **`AGENTS.md`**: 全エージェント共通の行動原則（推測の絶対禁止、シェル経由コード直渡し禁止、自律3回サーキットブレーカー、機械的DoD）。
- **`CLAUDE.md`**: AI Slop（自明なコメント・冗長なdocstring）の禁止および契約テストの義務化（Greptile/Veria AI 対策）。
- **`STATE.md` / `LOOP.md`**: Loop Engineering プロトコルに準拠したタスク状態管理および自律ループ設計。
- **`learnings.md`**: エージェント自身が遭遇したエラーや失敗の教訓を1行ルールとして蓄積・再発防止。

### 2. ガードレール & 決定論的スクリプト
- **`skills/`**: エージェントが自発的に参照・実行する標準作業手順書（SOP）。
- **`scripts/run_checks.sh`**: Linter、フォーマッター、型チェック、テストを一括実行する決定論的チェックツール。
- **`.spaghetti-guard/`**: アーキテクチャ境界とレイヤー依存方向の静的防御。

### 3. CI / CD & 継続的品質保証（GitHub Actions）
- **`ci.yml`**: `uv` による超高速依存関係解決、Ruff 静的解析、Pytest テスト・カバレッジ計測（Codecov 連携）。
- **`codeql.yml`**: GitHub 公式 CodeQL による静的セキュリティ脆弱性検査。
- **`codspeed.yml`**: CodSpeed による変更ごとのミリ秒単位レイテンシ・性能回帰の検知。

---

## 🚀 クイックスタート

### 必須環境
- Python 3.12+
- [uv](https://docs.astral.sh/uv/) (`curl -LsSf https://astral.sh/uv/install.sh | sh`)

### セットアップ
```bash
# 依存関係のインストール (開発・テスト含む)
uv sync --dev

# 全チェックの一括実行
./scripts/run_checks.sh
```

### 個別コマンド
```bash
# Linter / Formatter (Ruff)
uv run ruff check .
uv run ruff format .

# テスト実行 & カバレッジ計測
uv run pytest --cov=template_agentic_python --cov-report=term-missing

# ベンチマーク実行 (pytest-codspeed)
uv run pytest tests/test_benchmark.py --codspeed
```

---

## 📐 設計方針・DoD (Definition of Done)

エージェントがコード変更や機能追加を行う際は、以下の条件をすべて満たして初めて「完了」と判定されます：

1. **テスト & 型整合性**: `uv run ruff check .` および `uv run pytest` が **Exit Code 0** で終了すること。
2. **境界防御**: レイヤー規則（`models` は外部や `service` を参照しない等）を遵守すること。
3. **AI Slop ゼロ**: 自明な説明コメント（「タスクを完了する」「初期化する」等）を排除すること。
4. **知見の永続化**: エラー修正や試行錯誤があった場合、再発防止策を `learnings.md` に追記すること。
