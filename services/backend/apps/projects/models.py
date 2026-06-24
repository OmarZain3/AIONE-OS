"""Project persistence models."""

import uuid

from django.conf import settings
from django.db import models


class ProjectStatus(models.TextChoices):
    """Lifecycle status for a venture project."""

    DRAFT = "draft", "Draft"
    ACTIVE = "active", "Active"
    ON_HOLD = "on_hold", "On Hold"
    ARCHIVED = "archived", "Archived"


class Project(models.Model):
    """Founder venture project."""

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    status = models.CharField(
        max_length=20,
        choices=ProjectStatus.choices,
        default=ProjectStatus.DRAFT,
    )
    color = models.CharField(max_length=7, default="#6366F1")
    icon = models.CharField(max_length=64, default="rocket_launch")
    created_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="projects",
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["-updated_at"]
        indexes = [
            models.Index(fields=["created_by", "-updated_at"]),
            models.Index(fields=["status"]),
        ]

    def __str__(self) -> str:
        return self.name
