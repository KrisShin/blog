from uuid import UUID
from pydantic import BaseModel
from tortoise.contrib.pydantic import pydantic_model_creator

from article.models import BlogArticle, Comment


class ArticleCreatePydantic(BaseModel):
    title: str
    content: str
    tags: list[str]


class CommentCreatePydantic(BaseModel):
    context: str
    aritcle_id: UUID | str


ArticleDetailPydantic = pydantic_model_creator(
    BlogArticle,
    include=('id', 'title', 'content', 'tags', 'author', 'created_at'),
)


CommentPydantic = pydantic_model_creator(
    Comment,
    include=('id', 'user', 'context', 'created_at'),
)
