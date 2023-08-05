from datetime import timedelta

from fastapi import APIRouter, status, HTTPException, Request, Depends
from fastapi.security import OAuth2PasswordRequestForm

from common.utils import set_cache, get_cache
from config.settings import ACCESS_TOKEN_EXPIRE_DAYS
from user.models import User
from user.pydantics import UserLoginPydantic, UserInfoPydantic
from user.utils import get_password_hash, verify_password, create_access_token, validate_token

router = APIRouter()


@router.post('/register/')
async def post_register_user(user: UserLoginPydantic):
    password_hash = get_password_hash(user.password)
    user_obj = await User.get_or_none(username=user.username)
    if not user_obj:
        user_obj = await User.create(username=user.username, password=password_hash)
        response_data = UserInfoPydantic.from_orm(user_obj)
        return response_data
    raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail='username exist.')


@router.post('/token/')
async def post_user_token(request: Request, user: OAuth2PasswordRequestForm = Depends()):
    user_obj = await User.get_or_none(username=user.username)
    if not user_obj or (user and user_obj.disabled):
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail='username exist.')
    if not verify_password(user.password, user_obj.password):
        return HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail='Wrong password.')
    access_token_expires = timedelta(days=ACCESS_TOKEN_EXPIRE_DAYS)
    token = create_access_token(user_id=user_obj.id, expires_delta=access_token_expires)
    await set_cache(token, str(user_obj.id), access_token_expires)
    return token


@router.get('/me/')
async def get_me_detail(user: User = Depends(validate_token)):
    response = UserInfoPydantic.from_orm(user)
    return response
