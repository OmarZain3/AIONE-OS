"""Authentication business logic."""

from typing import Any

from django.contrib.auth import authenticate
from rest_framework_simplejwt.exceptions import TokenError
from rest_framework_simplejwt.tokens import RefreshToken

from apps.accounts.models import User


class AuthenticationError(Exception):
    """Raised when credentials are invalid or the account is inactive."""


class LogoutError(Exception):
    """Raised when a refresh token cannot be blacklisted."""


def authenticate_user(email: str, password: str) -> User:
    """Validate credentials and return the authenticated user."""
    user = authenticate(username=email, password=password)
    if user is None:
        raise AuthenticationError("Invalid email or password.")
    if not user.is_active:
        raise AuthenticationError("Account is inactive.")
    return user


def build_token_pair(user: User) -> dict[str, str]:
    """Issue access and refresh tokens for an authenticated user."""
    refresh = RefreshToken.for_user(user)
    return {
        "access": str(refresh.access_token),
        "refresh": str(refresh),
    }


def serialize_user(user: User) -> dict[str, Any]:
    """Return a transport-safe user payload."""
    return {
        "id": str(user.id),
        "email": user.email,
        "first_name": user.first_name,
        "last_name": user.last_name,
        "full_name": user.full_name,
        "is_active": user.is_active,
        "date_joined": user.date_joined.isoformat(),
    }


def blacklist_refresh_token(refresh_token: str) -> None:
    """Invalidate a refresh token."""
    try:
        token = RefreshToken(refresh_token)
        token.blacklist()
    except TokenError as exc:
        raise LogoutError("Invalid or expired refresh token.") from exc
