import pytest

from template_agentic_python.models import TaskCreateRequest
from template_agentic_python.service import TaskService


def test_create_task_assigns_uuid_and_persists():
    service = TaskService()
    task = service.create_task(TaskCreateRequest(title="Write architecture tests"))

    assert len(task.id) == 36
    assert task.title == "Write architecture tests"
    assert not task.completed
    assert service.get_task(task.id) == task


def test_complete_task_updates_status():
    service = TaskService()
    task = service.create_task(TaskCreateRequest(title="Configure CI"))

    updated = service.complete_task(task.id)
    assert updated.completed is True
    assert service.get_task(task.id).completed is True


def test_complete_task_missing_id_raises_keyerror():
    service = TaskService()
    with pytest.raises(KeyError, match="Task with ID 'non-existent' not found"):
        service.complete_task("non-existent")


def test_list_tasks_returns_all_entries():
    service = TaskService()
    t1 = service.create_task(TaskCreateRequest(title="Item 1"))
    t2 = service.create_task(TaskCreateRequest(title="Item 2"))

    tasks = service.list_tasks()
    assert len(tasks) == 2
    assert {t.id for t in tasks} == {t1.id, t2.id}
