from datetime import datetime
from pydantic import BaseModel, field_serializer, Field
from tortoise.contrib.pydantic import pydantic_model_creator

from article.models import BlogArticle, Comment
from common.pydantics import TagPydantic
from user.models import User
from user.pydantics import UserInfoPydantic


class ArticleCreatePydantic(BaseModel):
    title: str
    content: str


class ArticleListItemPydantic(BaseModel):
    title: str
    introduction: str = Field(..., alias='content')
    created_at: datetime

    @field_serializer('introduction')
    def serialize_introduction(self, v):
        return v[:10]

    # @field_serializer('author')
    # def serialize_author(self, v) -> UserInfoPydantic:
    #     print(v)
    #     return UserInfoPydantic.model_dump(v)

    # @field_serializer('tags')
    # def serialize_tags(self, v) -> list[TagPydantic]:
    #     return [TagPydantic.model_validate(item) for item in v]

    class Config:
        from_attributes = False


ArticleDetailPydantic = pydantic_model_creator(
    BlogArticle,
    include=('id', 'title', 'content', 'tags', 'author', 'created_at'),
)


CommentPydantic = pydantic_model_creator(
    Comment,
    include=('id', 'user', 'context', 'created_at'),
)