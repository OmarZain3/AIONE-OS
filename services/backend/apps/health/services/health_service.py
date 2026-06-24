"""Health check business logic."""

from django.conf import settings

from apps.core.version import PLATFORM_VERSION


def get_health_status() -> dict[str, str]:
    """Return platform health metadata."""
    return {
        "status": "ok",
        "service": "aione-backend",
        "version": PLATFORM_VERSION,
        "environment": getattr(settings, "APP_ENV", "unknown"),
    }
