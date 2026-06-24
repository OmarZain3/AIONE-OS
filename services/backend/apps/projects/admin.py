"""Django admin for projects."""

from django.contrib import admin

from apps.projects.models import Project


@admin.register(Project)
class ProjectAdmin(admin.ModelAdmin):
    list_display = ("name", "status", "created_by", "updated_at")
    list_filter = ("status",)
    search_fields = ("name", "description")
    readonly_fields = ("id", "created_at", "updated_at")
