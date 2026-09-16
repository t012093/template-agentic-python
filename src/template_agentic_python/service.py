import uuid

from template_agentic_python.models import TaskCreateRequest, TaskItem


class TaskService:
    def __init__(self) -> None:
        self._tasks: dict[str, TaskItem] = {}

    def create_task(self, request: TaskCreateRequest) -> TaskItem:
        task_id = str(uuid.uuid4())
        task = TaskItem(id=task_id, title=request.title)
        self._tasks[task_id] = task
        return task

    def get_task(self, task_id: str) -> TaskItem | None:
        return self._tasks.get(task_id)

    def complete_task(self, task_id: str) -> TaskItem:
        task = self._tasks.get(task_id)
        if task is None:
            raise KeyError(f"Task with ID '{task_id}' not found")
        task.completed = True
        return task

    def list_tasks(self) -> list[TaskItem]:
        return list(self._tasks.values())
