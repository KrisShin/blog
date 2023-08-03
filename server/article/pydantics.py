from pydantic import BaseModel
from tortoise.contrib.pydantic import pydantic_model_creator

from article.models import BlogArticle


class ArticleCreatePydantic(BaseModel):
    title: str
    content: str


ArticleDetailPydantic = pydantic_model_creator(
    BlogArticle,
    include=('id', 'title', 'content'),
    computed=('author_name',)
)
