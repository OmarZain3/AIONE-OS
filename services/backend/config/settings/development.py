"""Development settings."""

import re

from .base import *  # noqa: F403

DEBUG = True

INSTALLED_APPS = [
    *INSTALLED_APPS,  # noqa: F405
    "corsheaders",
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "corsheaders.middleware.CorsMiddleware",
    *MIDDLEWARE[1:],  # noqa: F405
]

# CORS — Flutter web (arbitrary localhost ports) and Chrome debug tooling.
# Production uses production.py and does not load these settings.
CORS_ALLOWED_ORIGIN_REGEXES = [
    re.compile(r"^http://localhost(:\d+)?$"),
    re.compile(r"^http://127\.0\.0\.1(:\d+)?$"),
]

CORS_ALLOW_METHODS = [
    "DELETE",
    "GET",
    "OPTIONS",
    "PATCH",
    "POST",
    "PUT",
]

CORS_ALLOW_HEADERS = [
    "accept",
    "accept-encoding",
    "authorization",
    "content-type",
    "origin",
    "user-agent",
    "x-requested-with",
]

# JWT auth uses Authorization headers, not cookies — keep credentials off.
CORS_ALLOW_CREDENTIALS = False
