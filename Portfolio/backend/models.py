from django.db import models

class Project(models.Model):
    title = models.CharField(max_length=200)
    slug = models.SlugField(unique=True)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

class NotebookCell(models.Model):
    CELL_TYPES = [
        ("markdown", "Markdown"),
        ("code", "Code"),
        ("output", "Output"),
        ("image", "Image"),
        ("table", "Table"),
    ]

    project = models.ForeignKey(
        Project,
        on_delete=models.CASCADE,
        related_name="cells"
    )
    cell_type = models.CharField(max_length=20, choices=CELL_TYPES)
    content = models.TextField(blank=True)
    image = models.ImageField(upload_to="notebook_outputs/", blank=True, null=True)
    order = models.PositiveBigIntegerField(default=0)

    class Meta:
        ordering = ["order"]
    
    def __str__(self):
        return f"{self.project.title} - {self.cell_type}"
    