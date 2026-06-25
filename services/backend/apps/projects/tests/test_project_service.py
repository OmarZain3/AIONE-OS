"""Unit tests for project services."""

from django.contrib.auth import get_user_model
from django.test import TestCase

from apps.projects.models import ProjectStatus
from apps.projects.services import project_service
from apps.projects.services.project_service import (
    ProjectNotFoundError,
    ProjectValidationError,
)

User = get_user_model()


class ProjectServiceTests(TestCase):
    def setUp(self) -> None:
        self.user = User.objects.create_user(
            email="founder@aione.test",
            password="secure-pass-123",
        )
        self.other_user = User.objects.create_user(
            email="other@aione.test",
            password="secure-pass-123",
        )

    def test_create_project_sets_owner(self) -> None:
        project = project_service.create_project(
            self.user,
            {"name": "AIONE Labs", "description": "Core venture"},
        )

        self.assertEqual(project.name, "AIONE Labs")
        self.assertEqual(project.created_by, self.user)
        self.assertEqual(project.status, ProjectStatus.DRAFT)

    def test_create_project_requires_name(self) -> None:
        with self.assertRaises(ProjectValidationError):
            project_service.create_project(self.user, {"name": "   "})

    def test_list_projects_scoped_to_user(self) -> None:
        project_service.create_project(self.user, {"name": "Mine"})
        project_service.create_project(self.other_user, {"name": "Theirs"})

        projects = list(project_service.list_projects_for_user(self.user))

        self.assertEqual(len(projects), 1)
        self.assertEqual(projects[0].name, "Mine")

    def test_get_project_for_user_returns_owned_project(self) -> None:
        project = project_service.create_project(self.user, {"name": "Mine"})

        fetched = project_service.get_project_for_user(self.user, str(project.id))

        self.assertEqual(fetched.id, project.id)

    def test_get_project_for_user_raises_for_other_users_project(self) -> None:
        project = project_service.create_project(self.other_user, {"name": "Theirs"})

        with self.assertRaises(ProjectNotFoundError):
            project_service.get_project_for_user(self.user, str(project.id))

    def test_update_project_changes_fields(self) -> None:
        project = project_service.create_project(self.user, {"name": "Old"})

        updated = project_service.update_project(
            self.user,
            str(project.id),
            {"name": "New", "status": ProjectStatus.ACTIVE},
        )

        self.assertEqual(updated.name, "New")
        self.assertEqual(updated.status, ProjectStatus.ACTIVE)

    def test_delete_project_removes_record(self) -> None:
        project = project_service.create_project(self.user, {"name": "Temp"})
        project_id = str(project.id)

        project_service.delete_project(self.user, project_id)

        with self.assertRaises(ProjectNotFoundError):
            project_service.get_project_for_user(self.user, project_id)

    def test_normalize_color_rejects_invalid_value(self) -> None:
        with self.assertRaises(ProjectValidationError):
            project_service.create_project(
                self.user,
                {"name": "Bad color", "color": "red"},
            )
