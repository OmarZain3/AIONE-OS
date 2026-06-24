"""Health API transport layer."""

from rest_framework.permissions import AllowAny
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from apps.health.api.serializers import HealthSerializer
from apps.health.services.health_service import get_health_status


class HealthCheckView(APIView):
    """Read-only health endpoint for orchestration and monitoring."""

    authentication_classes: list = []
    permission_classes = [AllowAny]
    serializer_class = HealthSerializer

    def get(self, request: Request) -> Response:
        return Response(get_health_status())
