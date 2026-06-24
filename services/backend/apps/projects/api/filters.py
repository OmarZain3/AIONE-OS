"""Project API filters."""

import django_filters

from apps.projects.models import Project, ProjectStatus


class ProjectFilter(django_filters.FilterSet):
    status = django_filters.ChoiceFilter(choices=ProjectStatus.choices)

    class Meta:
        model = Project
        fields = ["status"]
