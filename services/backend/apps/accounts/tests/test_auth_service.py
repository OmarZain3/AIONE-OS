"""Unit tests for authentication services."""

from django.contrib.auth import get_user_model
from django.test import TestCase
from rest_framework_simplejwt.tokens import RefreshToken

from apps.accounts.services import auth_service
from apps.accounts.services.auth_service import AuthenticationError, LogoutError

User = get_user_model()


class AuthServiceTests(TestCase):
    def setUp(self) -> None:
        self.user = User.objects.create_user(
            email="founder@aione.test",
            password="secure-pass-123",
            first_name="Ada",
            last_name="Founder",
        )

    def test_authenticate_user_with_valid_credentials(self) -> None:
        user = auth_service.authenticate_user("founder@aione.test", "secure-pass-123")

        self.assertEqual(user.email, self.user.email)

    def test_authenticate_user_with_invalid_password_raises(self) -> None:
        with self.assertRaises(AuthenticationError):
            auth_service.authenticate_user("founder@aione.test", "wrong-password")

    def test_authenticate_inactive_user_raises(self) -> None:
        self.user.is_active = False
        self.user.save(update_fields=["is_active"])

        with self.assertRaises(AuthenticationError):
            auth_service.authenticate_user("founder@aione.test", "secure-pass-123")

    def test_build_token_pair_returns_access_and_refresh(self) -> None:
        tokens = auth_service.build_token_pair(self.user)

        self.assertIn("access", tokens)
        self.assertIn("refresh", tokens)
        self.assertTrue(tokens["access"])
        self.assertTrue(tokens["refresh"])

    def test_serialize_user_includes_profile_fields(self) -> None:
        payload = auth_service.serialize_user(self.user)

        self.assertEqual(payload["email"], "founder@aione.test")
        self.assertEqual(payload["full_name"], "Ada Founder")
        self.assertTrue(payload["is_active"])
        self.assertIn("date_joined", payload)

    def test_blacklist_refresh_token_invalidates_token(self) -> None:
        refresh = str(RefreshToken.for_user(self.user))

        auth_service.blacklist_refresh_token(refresh)

        with self.assertRaises(LogoutError):
            auth_service.blacklist_refresh_token(refresh)
