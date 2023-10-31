from fastapi import APIRouter, Depends
from common.exceptions import BadRequest
from common.models import Tag
from common.pydantics import TagInPydantic
from user.utils import get_current_user_model


router = APIRouter()


@router.get('/list/')
async def get_tag_list(query: str = ''):
    """
    get or query tag list
    """
    return [
        TagInPydantic.model_validate(tag)
        for tag in await Tag.filter(name__icontains=query)
    ]


@router.post('/create/')
async def create_tag(tag: TagInPydantic, user=Depends(get_current_user_model)):
    is_exist = await Tag.filter(name__icontains=tag.name)
    if is_exist:
        raise BadRequest('Tag already exist')
    await Tag.create(**tag.dict(exclude_unset=True), user=user)
    return {'status': 'ok'}
