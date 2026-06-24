"""API permission enforcement middleware."""

import re
from collections.abc import Callable

from django.http import HttpRequest, HttpResponse, JsonResponse
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework_simplejwt.exceptions import InvalidToken


class PermissionMiddleware:
    """Require JWT authentication for protected API routes."""

    PUBLIC_PATH_PATTERNS: tuple[re.Pattern[str], ...] = (
        re.compile(r"^/api/health/"),
        re.compile(r"^/api/auth/login/"),
        re.compile(r"^/api/auth/refresh/"),
        re.compile(r"^/api/auth/verify/"),
        re.compile(r"^/api/schema/"),
        re.compile(r"^/api/docs/"),
        re.compile(r"^/admin/"),
    )

    def __init__(self, get_response: Callable[[HttpRequest], HttpResponse]) -> None:
        self.get_response = get_response
        self._jwt_auth = JWTAuthentication()

    def __call__(self, request: HttpRequest) -> HttpResponse:
        if self._requires_authentication(request.path):
            try:
                auth_result = self._jwt_auth.authenticate(request)
            except InvalidToken:
                return JsonResponse(
                    {"detail": "Invalid or expired token."},
                    status=401,
                )
            if auth_result is None:
                return JsonResponse(
                    {"detail": "Authentication credentials were not provided."},
                    status=401,
                )
            user, token = auth_result
            request.user = user
            request.auth = token

        return self.get_response(request)

    def _requires_authentication(self, path: str) -> bool:
        if not path.startswith("/api/"):
            return False
        return not any(pattern.match(path) for pattern in self.PUBLIC_PATH_PATTERNS)
