from fastapi import APIRouter, Depends, status, HTTPException

from article.models import BlogArticle
from article.pydantics import ArticleDetailPydantic
from common.global_variable import PMResponse

router = APIRouter()


@router.get("/list/", response_model=PMResponse)
async def get_article_list():
    return {'code': status.HTTP_200_OK, 'data': {}}


@router.get('/{article_id}/', response_model=PMResponse)
async def get_article_detail(article_id):
    try:
        article_obj: BlogArticle = await BlogArticle.get(id=article_id)
        from tortoise.contrib.pydantic import pydantic_model_creator
        from user.models import User
        article_pydantic = pydantic_model_creator(User)
        response = await article_pydantic.from_tortoise_orm(article_obj)
    except Exception:
        import traceback
        traceback.print_exc()
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="There is no article with this id",
        )
    return {'code': status.HTTP_200_OK, 'data': response}
