from collections.abc import Callable
from typing import Any

import pytest

from template_agentic_python.models import TaskCreateRequest
from template_agentic_python.service import TaskService


@pytest.mark.benchmark
def test_benchmark_task_lifecycle(benchmark: Callable[[Callable[[], None]], Any]) -> None:
    service = TaskService()
    request = TaskCreateRequest(title="Benchmark task payload")

    def run_lifecycle() -> None:
        task = service.create_task(request)
        service.get_task(task.id)
        service.complete_task(task.id)

    benchmark(run_lifecycle)
