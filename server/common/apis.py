from fastapi import APIRouter
from common.models import Tag
from common.pydantics import TagInPydantic


router = APIRouter()


@router.get('/list/{query}')
async def get_tag_list(query: str = None):
    """
    get or query tag list
    """
    return [
        TagInPydantic.model_validate(tag)
        for tag in await Tag.filter(name__icontains=query)
    ]


@router.post('/create/')
async def create_tag(tag: TagInPydantic):
    Tag.create(**tag.dict(exclude_unset=True))
    return {'status': 'ok'}
