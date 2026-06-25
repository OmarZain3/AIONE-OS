"""Project API serializers."""

from django.contrib.auth import get_user_model
from rest_framework import serializers

from apps.projects.models import Project, ProjectStatus

User = get_user_model()


class ProjectSerializer(serializers.ModelSerializer):
    created_by = serializers.UUIDField(source="created_by_id", read_only=True)

    class Meta:
        model = Project
        fields = (
            "id",
            "name",
            "description",
            "status",
            "color",
            "icon",
            "created_by",
            "created_at",
            "updated_at",
        )
        read_only_fields = ("id", "created_by", "created_at", "updated_at")

    def validate_status(self, value: str) -> str:
        valid = {choice.value for choice in ProjectStatus}
        if value not in valid:
            raise serializers.ValidationError(
                f"Invalid status. Choose from: {', '.join(sorted(valid))}."
            )
        return value

    def validate_color(self, value: str) -> str:
        normalized = value.strip().upper()
        if not normalized.startswith("#") or len(normalized) not in (4, 7):
            raise serializers.ValidationError(
                "Color must be a valid hex value (e.g. #6366F1)."
            )
        return normalized

    def validate_icon(self, value: str) -> str:
        icon = value.strip()
        if not icon:
            raise serializers.ValidationError("Icon is required.")
        return icon
