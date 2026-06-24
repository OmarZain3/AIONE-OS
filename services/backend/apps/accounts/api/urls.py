"""Auth API routes."""

from django.urls import path

from apps.accounts.api.views import (
    CurrentUserView,
    LoginView,
    LogoutView,
    RefreshTokenView,
    VerifyTokenView,
)

urlpatterns = [
    path("login/", LoginView.as_view(), name="auth-login"),
    path("refresh/", RefreshTokenView.as_view(), name="auth-refresh"),
    path("verify/", VerifyTokenView.as_view(), name="auth-verify"),
    path("logout/", LogoutView.as_view(), name="auth-logout"),
    path("me/", CurrentUserView.as_view(), name="auth-me"),
]
