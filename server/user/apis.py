from fastapi import APIRouter, status

from common.global_variable import PMResponse
from user.models import User
from user.pydantics import UserPydantic

router = APIRouter()


@router.post('/register/', response_model=PMResponse)
async def post_register_user(user: UserPydantic):
    await User.create(**user)
    return {'code': status.HTTP_200_OK, 'data': user}
