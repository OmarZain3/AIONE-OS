"""Integration tests for authentication API."""

from django.contrib.auth import get_user_model
from django.test import TestCase
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient

User = get_user_model()


class AuthApiIntegrationTests(TestCase):
    def setUp(self) -> None:
        self.client = APIClient()
        self.user = User.objects.create_user(
            email="founder@aione.test",
            password="secure-pass-123",
            first_name="Ada",
            last_name="Founder",
        )
        self.password = "secure-pass-123"

    def _login(self) -> dict:
        response = self.client.post(
            reverse("auth-login"),
            {"email": self.user.email, "password": self.password},
            format="json",
        )
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        return response.data

    def test_login_returns_token_pair(self) -> None:
        tokens = self._login()

        self.assertIn("access", tokens)
        self.assertIn("refresh", tokens)

    def test_login_with_invalid_credentials_returns_401(self) -> None:
        response = self.client.post(
            reverse("auth-login"),
            {"email": self.user.email, "password": "wrong"},
            format="json",
        )

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_current_user_requires_authentication(self) -> None:
        response = self.client.get(reverse("auth-me"))

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_current_user_returns_profile(self) -> None:
        tokens = self._login()
        self.client.credentials(HTTP_AUTHORIZATION=f"Bearer {tokens['access']}")

        response = self.client.get(reverse("auth-me"))

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["email"], self.user.email)
        self.assertEqual(response.data["full_name"], "Ada Founder")

    def test_refresh_token_returns_new_access_token(self) -> None:
        tokens = self._login()

        response = self.client.post(
            reverse("auth-refresh"),
            {"refresh": tokens["refresh"]},
            format="json",
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn("access", response.data)

    def test_verify_token_accepts_valid_access_token(self) -> None:
        tokens = self._login()

        response = self.client.post(
            reverse("auth-verify"),
            {"token": tokens["access"]},
            format="json",
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_verify_token_rejects_invalid_token(self) -> None:
        response = self.client.post(
            reverse("auth-verify"),
            {"token": "not-a-valid-token"},
            format="json",
        )

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_logout_blacklists_refresh_token(self) -> None:
        tokens = self._login()
        self.client.credentials(HTTP_AUTHORIZATION=f"Bearer {tokens['access']}")

        response = self.client.post(
            reverse("auth-logout"),
            {"refresh": tokens["refresh"]},
            format="json",
        )

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        refresh_response = self.client.post(
            reverse("auth-refresh"),
            {"refresh": tokens["refresh"]},
            format="json",
        )
        self.assertEqual(refresh_response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_permission_middleware_blocks_unauthenticated_api_access(self) -> None:
        response = self.client.get(reverse("auth-me"))

        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
        self.assertIn("detail", response.json())
