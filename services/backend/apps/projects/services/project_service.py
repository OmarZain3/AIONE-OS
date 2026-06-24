"""Project business logic."""

from typing import Any

from django.contrib.auth import get_user_model
from django.db.models import QuerySet

from apps.projects.models import Project, ProjectStatus

User = get_user_model()


class ProjectNotFoundError(Exception):
    """Raised when a project does not exist or is not owned by the user."""


class ProjectValidationError(Exception):
    """Raised when project input fails validation."""


def list_projects_for_user(user: User) -> QuerySet[Project]:
    """Return projects owned by the given user."""
    return Project.objects.filter(created_by=user)


def get_project_for_user(user: User, project_id: str) -> Project:
    """Return a single project owned by the user."""
    try:
        return Project.objects.get(id=project_id, created_by=user)
    except Project.DoesNotExist as exc:
        raise ProjectNotFoundError("Project not found.") from exc


def create_project(user: User, data: dict[str, Any]) -> Project:
    """Create a project for the authenticated user."""
    name = (data.get("name") or "").strip()
    if not name:
        raise ProjectValidationError("Project name is required.")

    return Project.objects.create(
        name=name,
        description=(data.get("description") or "").strip(),
        status=data.get("status", ProjectStatus.DRAFT),
        color=_normalize_color(data.get("color", "#6366F1")),
        icon=(data.get("icon") or "rocket_launch").strip() or "rocket_launch",
        created_by=user,
    )


def update_project(user: User, project_id: str, data: dict[str, Any]) -> Project:
    """Update fields on an owned project."""
    project = get_project_for_user(user, project_id)
    update_fields: list[str] = []

    if "name" in data:
        name = (data["name"] or "").strip()
        if not name:
            raise ProjectValidationError("Project name is required.")
        project.name = name
        update_fields.append("name")

    if "description" in data:
        project.description = (data["description"] or "").strip()
        update_fields.append("description")

    if "status" in data:
        project.status = data["status"]
        update_fields.append("status")

    if "color" in data:
        project.color = _normalize_color(data["color"])
        update_fields.append("color")

    if "icon" in data:
        icon = (data["icon"] or "").strip()
        if not icon:
            raise ProjectValidationError("Project icon is required.")
        project.icon = icon
        update_fields.append("icon")

    if update_fields:
        update_fields.append("updated_at")
        project.save(update_fields=update_fields)

    return project


def delete_project(user: User, project_id: str) -> None:
    """Delete an owned project."""
    project = get_project_for_user(user, project_id)
    project.delete()


def _normalize_color(color: str) -> str:
    value = (color or "#6366F1").strip()
    if not value.startswith("#") or len(value) not in (4, 7):
        raise ProjectValidationError("Color must be a valid hex value (e.g. #6366F1).")
    return value.upper()
