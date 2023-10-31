from datetime import timedelta

from fastapi import APIRouter, status, HTTPException, Request, Depends
from fastapi.security import OAuth2PasswordRequestForm

from common.utils import set_cache, del_cache
from config.settings import ACCESS_TOKEN_EXPIRE_DAYS, DEFAULT_AVATAR
from user.models import User
from user.pydantics import UserLoginPydantic, UserInfoPydantic, TokenPydantic
from user.utils import (
    get_password_hash,
    verify_password,
    create_access_token,
    get_current_user_model,
)

router = APIRouter()


@router.post('/register/')
async def post_register_user(user: UserLoginPydantic):
    password_hash = get_password_hash(user.password)
    user_obj = await User.get_or_none(username=user.username)
    if not user_obj:
        user_obj = await User.create(
            username=user.username, password=password_hash, avatar=DEFAULT_AVATAR
        )
        response_data = UserInfoPydantic.model_dump(user_obj)
        return response_data
    raise HTTPException(
        status_code=status.HTTP_400_BAD_REQUEST, detail='username exist.'
    )


@router.post('/reset_password/')
async def post_reset_password(username):
    user_obj = await User.get_or_none(username=username)
    if user_obj:
        password_hash = get_password_hash('test')
        user_obj.password = password_hash
        await user_obj.save()
        return TokenPydantic(access_token=create_access_token(user_obj.id))
    raise HTTPException(
        status_code=status.HTTP_400_BAD_REQUEST, detail='username not exist.'
    )


@router.post('/token/', response_model=TokenPydantic)
async def post_user_token(
    request: Request, user: OAuth2PasswordRequestForm = Depends()
):
    user_obj = await User.get_or_none(username=user.username)
    if not user_obj or (user and user_obj.disabled):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, detail='username exist.'
        )
    if not verify_password(user.password, user_obj.password):
        return HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail='Wrong password.'
        )
    access_token_expires = timedelta(days=ACCESS_TOKEN_EXPIRE_DAYS)
    token = create_access_token(user_id=user_obj.id, expires_delta=access_token_expires)
    await del_cache(str(user_obj.id))
    await set_cache(str(user_obj.id), token, access_token_expires)
    resp = TokenPydantic(access_token=token)
    return resp


@router.get('/me/')
async def get_me_detail(user: User = Depends(get_current_user_model)):
    return UserInfoPydantic.model_dump(user)
