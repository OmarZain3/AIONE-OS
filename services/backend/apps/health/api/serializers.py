"""Health API serializers."""

from rest_framework import serializers


class HealthSerializer(serializers.Serializer):
    status = serializers.CharField()
    service = serializers.CharField()
    version = serializers.CharField()
    environment = serializers.CharField()
