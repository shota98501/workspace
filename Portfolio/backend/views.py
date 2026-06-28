from rest_frame.generics import RetrieveAPIView
from .models import Project
from .serializers import ProjectSerializer

class ProjectDetailView(RetrieveAPIView):
    queryset = Project.objects.all()
    serializer_class = ProjectSerializer
    lookup_field = "slug"

