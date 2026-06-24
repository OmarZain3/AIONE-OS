"""Integration tests for project API."""

from django.contrib.auth import get_user_model
from django.test import TestCase
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient

from apps.projects.models import ProjectStatus
from apps.projects.services import project_service

User = get_user_model()


class ProjectApiIntegrationTests(TestCase):
    def setUp(self) -> None:
        self.client = APIClient()
        self.user = User.objects.create_user(
            email="founder@aione.test",
            password="secure-pass-123",
        )
        self.other_user = User.objects.create_user(
            email="other@aione.test",
            password="secure-pass-123",
        )
        self.password = "secure-pass-123"
        self.list_url = reverse("project-list")

    def _login(self, email: str | None = None, password: str | None = None) -> dict:
        response = self.client.post(
            reverse("auth-login"),
            {
                "email": email or self.user.email,
                "password": password or self.password,
            },
            format="json",
        )
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        return response.data

    def _authenticate(self) -> dict:
        tokens = self._login()
        self.client.credentials(HTTP_AUTHORIZATION=f"Bearer {tokens['access']}")
        return tokens

    def test_list_projects_requires_authentication(self) -> None:
        response = self.client.get(self.list_url)

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_create_and_list_projects(self) -> None:
        self._authenticate()

        create_response = self.client.post(
            self.list_url,
            {
                "name": "Venture Alpha",
                "description": "First venture",
                "status": ProjectStatus.ACTIVE,
                "color": "#FF5733",
                "icon": "rocket_launch",
            },
            format="json",
        )

        self.assertEqual(create_response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(create_response.data["name"], "Venture Alpha")
        self.assertEqual(create_response.data["created_by"], str(self.user.id))

        list_response = self.client.get(self.list_url)

        self.assertEqual(list_response.status_code, status.HTTP_200_OK)
        self.assertEqual(list_response.data["count"], 1)
        self.assertEqual(list_response.data["results"][0]["name"], "Venture Alpha")

    def test_retrieve_update_delete_project(self) -> None:
        self._authenticate()
        project = project_service.create_project(self.user, {"name": "To mutate"})
        detail_url = reverse("project-detail", kwargs={"pk": project.id})

        retrieve_response = self.client.get(detail_url)
        self.assertEqual(retrieve_response.status_code, status.HTTP_200_OK)

        update_response = self.client.patch(
            detail_url,
            {"name": "Updated", "status": ProjectStatus.ON_HOLD},
            format="json",
        )
        self.assertEqual(update_response.status_code, status.HTTP_200_OK)
        self.assertEqual(update_response.data["name"], "Updated")

        delete_response = self.client.delete(detail_url)
        self.assertEqual(delete_response.status_code, status.HTTP_204_NO_CONTENT)

        missing_response = self.client.get(detail_url)
        self.assertEqual(missing_response.status_code, status.HTTP_404_NOT_FOUND)

    def test_user_cannot_access_other_users_project(self) -> None:
        project = project_service.create_project(self.other_user, {"name": "Private"})
        detail_url = reverse("project-detail", kwargs={"pk": project.id})

        self._authenticate()
        response = self.client.get(detail_url)

        self.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)

    def test_search_projects_by_name(self) -> None:
        self._authenticate()
        project_service.create_project(self.user, {"name": "Alpha Venture"})
        project_service.create_project(self.user, {"name": "Beta Platform"})

        response = self.client.get(self.list_url, {"search": "Alpha"})

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["count"], 1)
        self.assertEqual(response.data["results"][0]["name"], "Alpha Venture")

    def test_filter_projects_by_status(self) -> None:
        self._authenticate()
        project_service.create_project(
            self.user,
            {"name": "Active one", "status": ProjectStatus.ACTIVE},
        )
        project_service.create_project(
            self.user,
            {"name": "Draft one", "status": ProjectStatus.DRAFT},
        )

        response = self.client.get(self.list_url, {"status": ProjectStatus.ACTIVE})

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["count"], 1)
        self.assertEqual(response.data["results"][0]["status"], ProjectStatus.ACTIVE)

    def test_pagination_returns_page_metadata(self) -> None:
        self._authenticate()
        for index in range(25):
            project_service.create_project(self.user, {"name": f"Project {index}"})

        response = self.client.get(self.list_url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["count"], 25)
        self.assertEqual(len(response.data["results"]), 20)
        self.assertIsNotNone(response.data["next"])
