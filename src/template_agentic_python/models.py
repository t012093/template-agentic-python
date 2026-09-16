from datetime import UTC, datetime

from pydantic import BaseModel, Field


class TaskItem(BaseModel):
    id: str = Field(..., description="Unique task identifier")
    title: str = Field(..., min_length=1, max_length=200)
    completed: bool = False
    created_at: datetime = Field(default_factory=lambda: datetime.now(UTC))


class TaskCreateRequest(BaseModel):
    title: str = Field(..., min_length=1, max_length=200)
