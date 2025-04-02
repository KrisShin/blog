from uuid import UUID
from pydantic import BaseModel
from datetime import datetime
from typing import List, Any

from article.models import BlogArticle, Comment


class ArticleCreatePydantic(BaseModel):
    title: str
    content: str
    tags: list[str]


class CommentCreatePydantic(BaseModel):
    context: str
    article_id: UUID | str


class ArticleDetailPydantic(BaseModel):
    id: int
    title: str
    content: str
    tags: Any
    author: Any
    created_at: datetime


class CommentPydantic(BaseModel):
    id: int
    user: Any
    context: str
    created_at: datetime
