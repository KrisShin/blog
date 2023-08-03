from fastapi import APIRouter, Depends, status, HTTPException

from article.models import BlogArticle
from article.pydantics import ArticleCreatePydantic, ArticleDetailPydantic
from common.global_variable import PMResponse
from user.utils import validate_token

router = APIRouter()


@router.get("/list/", response_model=PMResponse)
async def get_article_list():
    return {'code': status.HTTP_200_OK, 'data': {}}


@router.get('/{article_id}/', response_model=PMResponse)
async def get_article_detail(article_id):
    try:
        article_obj: BlogArticle = await BlogArticle.get_or_none(id=article_id)
        if not article_obj:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail='article not exist.')
        response = ArticleCreatePydantic.from_orm(article_obj)
    except Exception:
        import traceback
        traceback.print_exc()
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="There is no article with this id",
        )
    return {'code': status.HTTP_200_OK, 'data': response}


@router.post('/post-article/', response_model=PMResponse)
async def post_new_article(article: ArticleCreatePydantic, user=Depends(validate_token)):
    article_obj = await BlogArticle.create(**article.dict(), author=user)
    response = ArticleDetailPydantic.from_orm(article_obj)
    return {'code': status.HTTP_200_OK, 'data': response}
