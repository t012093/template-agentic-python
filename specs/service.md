# Specification: `src/template_agentic_python/service.py`

## 概要
タスクのライフサイクル（作成、取得、完了、一覧取得）を管理するビジネスサービス層。

## 公開インターフェース
- `create_task(request: TaskCreateRequest) -> TaskItem`: UUID を自動採番してインメモリに保存。
- `get_task(task_id: str) -> TaskItem | None`: ID でタスクを検索。
- `complete_task(task_id: str) -> TaskItem`: タスクを完了状態に更新。存在しない場合は KeyError を送出。
- `list_tasks() -> list[TaskItem]`: 全タスクをリスト返却。
