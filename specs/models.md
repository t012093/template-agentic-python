# Specification: `src/template_agentic_python/models.py`

## 概要
タスク管理システムのコアデータモデルおよび Pydantic v2 スキーマ定義。
ドメインモデル層として、サービスや外部レイヤーへの依存を持たない純粋なデータ契約を提供する。

## スキーマ定義
- `TaskCreateRequest`: タスク新規作成リクエスト
  - `title`: str (1〜200文字)
- `TaskItem`: 永続化されたタスクアイテム
  - `id`: str (UUID)
  - `title`: str
  - `completed`: bool
  - `created_at`: datetime (UTC)

## アーキテクチャ境界
- 依存禁止: `src/template_agentic_python/service.py`
