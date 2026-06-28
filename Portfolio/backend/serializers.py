from rest_framework import serializers
from .models import Project, NotebookCell

class NotebookCellSerializer(serializers.ModelSerializer):
    class Meta:
        model = NotebookCell
        fields = ["id", "cell_type", "content", "image", "order"]

class ProjectSerializer(serializers.ModelSerializer):
    cells = NotebookCellSerializer(many=True, read_only=True)

    class Meta:
        model = Project
        fields = ["id", "cell_type", "content", "image", "order"]
        