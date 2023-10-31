from datetime import datetime
from pydantic import BaseModel, field_serializer, Field
from tortoise.contrib.pydantic import pydantic_model_creator

from article.models import BlogArticle, Comment


class ArticleCreatePydantic(BaseModel):
    title: str
    content: str
    tag: list


ArticleDetailPydantic = pydantic_model_creator(
    BlogArticle,
    include=('id', 'title', 'content', 'tags', 'author', 'created_at'),
)


CommentPydantic = pydantic_model_creator(
    Comment,
    include=('id', 'user', 'context', 'created_at'),
)
