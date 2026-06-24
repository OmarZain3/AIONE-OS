"""Project API transport layer."""

from drf_spectacular.utils import extend_schema, extend_schema_view
from rest_framework import status, viewsets
from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response

from apps.projects.api.filters import ProjectFilter
from apps.projects.api.serializers import ProjectSerializer
from apps.projects.services import project_service
from apps.projects.services.project_service import ProjectNotFoundError, ProjectValidationError


@extend_schema_view(
    list=extend_schema(tags=["Projects"], summary="List projects"),
    retrieve=extend_schema(tags=["Projects"], summary="Retrieve project"),
    create=extend_schema(tags=["Projects"], summary="Create project"),
    update=extend_schema(tags=["Projects"], summary="Update project"),
    partial_update=extend_schema(tags=["Projects"], summary="Partially update project"),
    destroy=extend_schema(tags=["Projects"], summary="Delete project"),
)
class ProjectViewSet(viewsets.ModelViewSet):
    """CRUD API for founder projects."""

    serializer_class = ProjectSerializer
    permission_classes = [IsAuthenticated]
    filterset_class = ProjectFilter
    search_fields = ("name", "description")
    ordering_fields = ("name", "status", "created_at", "updated_at")
    ordering = ("-updated_at",)
    http_method_names = ["get", "post", "put", "patch", "delete", "head", "options"]

    def get_queryset(self):
        return project_service.list_projects_for_user(self.request.user)

    def create(self, request: Request, *args, **kwargs) -> Response:
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            project = project_service.create_project(
                user=request.user,
                data=serializer.validated_data,
            )
        except ProjectValidationError as exc:
            return Response({"detail": str(exc)}, status=status.HTTP_400_BAD_REQUEST)
        output = self.get_serializer(project)
        return Response(output.data, status=status.HTTP_201_CREATED)

    def update(self, request: Request, *args, **kwargs) -> Response:
        partial = kwargs.pop("partial", False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        try:
            project = project_service.update_project(
                user=request.user,
                project_id=str(instance.id),
                data=serializer.validated_data,
            )
        except ProjectValidationError as exc:
            return Response({"detail": str(exc)}, status=status.HTTP_400_BAD_REQUEST)
        output = self.get_serializer(project)
        return Response(output.data)

    def destroy(self, request: Request, *args, **kwargs) -> Response:
        instance = self.get_object()
        project_service.delete_project(user=request.user, project_id=str(instance.id))
        return Response(status=status.HTTP_204_NO_CONTENT)

    def get_object(self):
        try:
            return project_service.get_project_for_user(
                user=self.request.user,
                project_id=str(self.kwargs["pk"]),
            )
        except ProjectNotFoundError as exc:
            from rest_framework.exceptions import NotFound

            raise NotFound(str(exc)) from exc
