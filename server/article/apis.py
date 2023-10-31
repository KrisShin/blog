from uuid import UUID
from fastapi import APIRouter, Depends

from article.models import BlogArticle, Comment
from article.pydantics import (
    ArticleCreatePydantic,
    ArticleDetailPydantic,
    CommentPydantic,
    CommentCreatePydantic,
)
from common.exceptions import BadRequest
from common.models import Tag
from common.pydantics import TagInPydantic
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
        TagInPydantic.model_validate(tag) for tag in await article_obj.tags.all()
    ]
    resp_data['comments'] = []
    for comment in await article_obj.comments.all():
        comment_data = CommentPydantic.model_validate(comment).model_dump()
        comment_data['user'] = UserInfoPydantic.model_validate(await comment.user)
        resp_data['comments'].append(comment_data)
    return resp_data


@router.post('/')
async def post_new_article(
    article: ArticleCreatePydantic, user=Depends(get_current_user_model)
):
    params = article.model_dump()
    tags = await Tag.filter(name__in=params.pop('tags'))
    blog = await BlogArticle.create(**params, author=user)
    [await blog.tags.add(tag) for tag in tags]
    return {'success'}


@router.put('/{article_id}/')
async def edit_article(
    article: ArticleCreatePydantic, user=Depends(get_current_user_model)
):
    # TODO
    return {'success'}


@router.delete('/{article_id}/')
async def delete_article(
    article: ArticleCreatePydantic, user=Depends(get_current_user_model)
):
    # TODO
    return {'success'}


@router.post('/comment/')
async def post_new_comment(
    comment: CommentCreatePydantic, user=Depends(get_current_user_model)
):
    params = comment.model_dump()
    article = await BlogArticle.get_or_none(id=params.pop('article_id'))
    if not article:
        raise BadRequest('Article not exist.')
    comment = await Comment.create(**params, article=article, user=user)
    return CommentPydantic.model_validate(comment)


@router.delete('/comment/{comment_id}/')
async def delete_comment(comment_id: str | UUID, user=Depends(get_current_user_model)):
    comment = await Comment.get_or_none(id=comment_id, user=user)
    if not comment:
        raise BadRequest('Comment not exist.')
    await comment.delete()
    return {'success'}
