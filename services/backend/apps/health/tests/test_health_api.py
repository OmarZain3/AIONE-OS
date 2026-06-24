"""Health endpoint tests."""

from django.test import TestCase
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient


class HealthEndpointTests(TestCase):
    def setUp(self) -> None:
        self.client = APIClient()

    def test_health_endpoint_returns_ok(self) -> None:
        response = self.client.get(reverse("health-check"))

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["status"], "ok")
        self.assertEqual(response.data["service"], "aione-backend")
        self.assertIn("version", response.data)
        self.assertIn("environment", response.data)

    def test_health_endpoint_is_public(self) -> None:
        response = self.client.get("/api/health/")

        self.assertEqual(response.status_code, status.HTTP_200_OK)
