# template-agentic-python

2026年水準のエージェント自律開発ハーネス（Agentic Harness）とモダン Python（uv / Ruff / Mypy / Pytest / CodSpeed）を統合した開発用リポジトリテンプレートです。

---

## 🌟 特徴と構成

### 1. エージェント自律ハーネス（Agentic Harness）
- **`AGENTS.md`**: 全エージェント共通の行動原則（推測の絶対禁止、シェル経由コード直渡し禁止、自律3回サーキットブレーカー、機械的DoD）。
- **`CLAUDE.md`**: AI Slop（自明なコメント・冗長なdocstring）の禁止および契約テストの義務化（Greptile/Veria AI 対策）。
- **`STATE.md` / `LOOP.md`**: Loop Engineering プロトコルに準拠したタスク状態管理および自律ループ設計。
- **`learnings.md`**: エージェント自身が遭遇したエラーや失敗の教訓を1行ルールとして蓄積・再発防止。

### 2. ガードレール & 決定論的スクリプト
- **`skills/`**: エージェントが自発的に参照・実行する標準作業手順書（SOP）。
- **`scripts/bootstrap.sh`**: 新規プロジェクト立ち上げ時の一括リネーム・再初期化スクリプト。
- **`scripts/run_checks.sh`**: Linter、フォーマッター、型チェック（Mypy Strict）、テストを一括実行する決定論的チェックツール。
- **`.spaghetti-guard/`**: アーキテクチャ境界とレイヤー依存方向の静的防御（Node.js CI 配線済み）。

### 3. CI / CD & 継続的品質保証（GitHub Actions）
- **`ci.yml`**: Spaghetti Guard 境界検証、`uv` による超高速依存関係解決、Ruff 静的解析、Mypy 厳格型チェック、Pytest テスト・カバレッジ計測（Codecov 連携）。
- **`codeql.yml`**: GitHub 公式 CodeQL による静的セキュリティ脆弱性検査。
- **`codspeed.yml`**: CodSpeed による変更ごとのミリ秒単位レイテンシ・性能回帰の検知。

---

## 🚀 クイックスタート

### 必須環境
- Python 3.12+
- [uv](https://docs.astral.sh/uv/) (`curl -LsSf https://astral.sh/uv/install.sh | sh`)
- Node.js 20+ (`npx` での Spaghetti Guard 実行用)

### 新規プロジェクト作成（リネーム）
```bash
# テンプレートから新しいリポジトリを作成後、プロジェクト名を一括設定
./scripts/bootstrap.sh my-new-project
```

### セットアップ & 検証
```bash
# 依存関係のインストール
uv sync

# 全チェックの一括実行 (Ruff, Format, Mypy, Pytest)
bash ./scripts/run_checks.sh
```

### 個別コマンド
```bash
# Linter / Formatter (Ruff)
uv run ruff check .
uv run ruff format .

# 厳格型チェック (Mypy)
uv run mypy src tests

# 通常テスト実行 (高速ループ: ベンチマーク除外)
uv run pytest --cov=template_agentic_python --cov-report=term-missing

# ベンチマーク実行 (pytest-codspeed)
uv run pytest tests/test_benchmark.py -m benchmark --codspeed

# アーキテクチャ境界チェック (Spaghetti Guard)
npx --yes @naoya.k/spaghetti-guard check
```

---

## 📐 設計方針・DoD (Definition of Done)

エージェントがコード変更や機能追加を行う際は、以下の条件をすべて満たして初めて「完了」と判定されます：

1. **静的解析 & 型整合性**: `uv run ruff check .` および `uv run mypy src tests` がエラー 0 であること。
2. **テスト全合格**: `uv run pytest` がすべて **Exit Code 0**（カバレッジ基準クリア）であること。
3. **境界防御**: `npx @naoya.k/spaghetti-guard check --staged` で境界違反がないこと。
4. **AI Slop ゼロ**: 自明な説明コメント（「タスクを完了する」「初期化する」等）を排除すること。
5. **知見の永続化**: エラー修正や試行錯誤があった場合、再発防止策を `learnings.md` に追記すること。
