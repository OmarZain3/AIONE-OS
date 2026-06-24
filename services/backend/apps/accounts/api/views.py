"""Auth API transport layer."""

from drf_spectacular.utils import extend_schema
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenVerifyView,
)

from apps.accounts.api.serializers import (
    EmailTokenObtainPairSerializer,
    LogoutSerializer,
    UserSerializer,
)
from apps.accounts.services import auth_service
from apps.accounts.services.auth_service import LogoutError


class LoginView(TokenObtainPairView):
    """Issue JWT access and refresh tokens."""

    serializer_class = EmailTokenObtainPairSerializer

    @extend_schema(
        tags=["Authentication"],
        summary="Login",
        description="Authenticate with email and password to receive JWT tokens.",
    )
    def post(self, request: Request, *args, **kwargs) -> Response:
        return super().post(request, *args, **kwargs)


class RefreshTokenView(TokenRefreshView):
    """Rotate access token using a valid refresh token."""

    @extend_schema(
        tags=["Authentication"],
        summary="Refresh token",
        description="Exchange a refresh token for a new access token.",
    )
    def post(self, request: Request, *args, **kwargs) -> Response:
        return super().post(request, *args, **kwargs)


class VerifyTokenView(TokenVerifyView):
    """Validate a JWT access or refresh token."""

    @extend_schema(
        tags=["Authentication"],
        summary="Verify token",
        description="Verify that a JWT is valid and not expired.",
    )
    def post(self, request: Request, *args, **kwargs) -> Response:
        return super().post(request, *args, **kwargs)


class LogoutView(APIView):
    """Blacklist a refresh token to end the session."""

    permission_classes = [IsAuthenticated]

    @extend_schema(
        tags=["Authentication"],
        summary="Logout",
        description="Invalidate the provided refresh token.",
        request=LogoutSerializer,
        responses={204: None},
    )
    def post(self, request: Request) -> Response:
        serializer = LogoutSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            auth_service.blacklist_refresh_token(serializer.validated_data["refresh"])
        except LogoutError as exc:
            return Response({"detail": str(exc)}, status=status.HTTP_400_BAD_REQUEST)
        return Response(status=status.HTTP_204_NO_CONTENT)


class CurrentUserView(APIView):
    """Return the authenticated user's profile."""

    permission_classes = [IsAuthenticated]
    serializer_class = UserSerializer

    @extend_schema(
        tags=["Authentication"],
        summary="Current user",
        description="Return the profile of the authenticated user.",
        responses={200: UserSerializer},
    )
    def get(self, request: Request) -> Response:
        serializer = UserSerializer(request.user)
        return Response(serializer.data)
