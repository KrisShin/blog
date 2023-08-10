import uuid

from fastapi import APIRouter, Depends, status, HTTPException

from article.models import BlogArticle
from article.pydantics import ArticleCreatePydantic, ArticleDetailPydantic
from common.exceptions import BadRequest
from user.utils import get_current_user_model

router = APIRouter()


@router.get("/list/")
async def get_article_list():
    return []


@router.get('/{article_id}/')
async def get_article_detail(article_id):
    try:
        article_id = uuid.UUID(article_id)
    except ValueError:
        raise BadRequest(detail='badly formed hexadecimal UUID string.')
    article_obj: BlogArticle = await BlogArticle.get_or_none(id=article_id)
    if not article_obj:
        raise BadRequest(detail='article not exist.')
    return ArticleDetailPydantic.from_orm(article_obj)


@router.post('/post-article/')
async def post_new_article(article: ArticleCreatePydantic, user=Depends(get_current_user_model)):
    article_obj = await BlogArticle.create(**article.dict(), author=user)
    response = ArticleDetailPydantic.from_orm(article_obj)
    return response
