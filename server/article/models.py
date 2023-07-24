from tortoise import fields
from common.models import BaseModel


class BlogArticle(BaseModel):
    title = fields.CharField(max_length=1024)
    content = fields.TextField()
    author = fields.ForeignKeyField(
        'models.User',
        related_name='articles',
        null=True,
        on_delete=fields.SET_NULL
    )

    tags = fields.ManyToManyField(
        'models.Tag',
        related_name='articles',
        through='rs_article_tag',
        null=True,
        on_delete=fields.SET_NULL,
    )

    @property
    def introduction(self):
        return self.content[:20]

    class Meta:
        table = 'tb_article'
