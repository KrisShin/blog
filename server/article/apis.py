from fastapi import APIRouter, Depends

from article.models import BlogArticle
from article.pydantics import (
    ArticleCreatePydantic,
    ArticleDetailPydantic,
    CommentPydantic,
)
from common.exceptions import BadRequest
from common.pydantics import TagPydantic
from common.utils import validate_uuid
from user.pydantics import UserInfoPydantic
from user.utils import get_current_user_model

router = APIRouter()


@router.get("/list/")
async def get_article_list():
    all_articles = await BlogArticle.all().limit(10)
    return [ArticleDetailPydantic.model_validate(blog) for blog in all_articles]


@router.get('/{article_id}/')
async def get_article_detail(article_id: str):
    article_id = validate_uuid(article_id)
    article_obj: BlogArticle = await BlogArticle.get_or_none(id=article_id)
    if not article_obj:
        raise BadRequest(detail='article not exist.')
    resp_data = ArticleDetailPydantic.model_validate(article_obj).model_dump()
    resp_data['author'] = UserInfoPydantic.model_validate(
        await article_obj.author
    ).model_dump()
    resp_data['tags'] = [
        TagPydantic.model_validate(tag) for tag in await article_obj.tags.all()
    ]
    resp_data['comments'] = []
    for comment in await article_obj.comments.all():
        comment_data = CommentPydantic.model_validate(comment)
        comment_data['user'] = UserInfoPydantic.model_validate(await comment.user)
        resp_data['comments'].append(comment_data)
    return resp_data


@router.post('/post-article/')
async def post_new_article(
    article: ArticleCreatePydantic, user=Depends(get_current_user_model)
):
    await BlogArticle.create(**article.model_dump(), author=user)
    return {'success'}
