from tortoise import fields
from common.models import BaseModel


class BlogArticle(BaseModel):
    title = fields.CharField(max_length=1024, index=True)
    content = fields.TextField()
    author = fields.ForeignKeyField(
        'models.User',
        related_name='author_articles',
        null=True,
        on_delete=fields.SET_NULL
    )

    tags = fields.ManyToManyField(
        'models.Tag',
        related_name='tag_articles',
        through='rs_article_tag',
        null=True,
        on_delete=fields.SET_NULL,
    )

    def introduction(self) -> str:
        return self.content[:20]

    def author_name(self) -> str:
        return self.author.username

    class Meta:
        table = 'tb_article'


class Comment(BaseModel):
    article = fields.ForeignKeyField('models.BlogArticle', related_name='comments')
    user = fields.ForeignKeyField(
        'models.User',
        related_name='comments',
        null=True,
        on_delete=fields.SET_NULL
    )
    context = fields.TextField()

    class Meta:
        table = 'tb_comment'
