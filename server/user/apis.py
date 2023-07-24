from datetime import timedelta
from fastapi import APIRouter, Depends, HTTPException, Request, status
from user.pydantics import (
    UserPydantic,
    UserLoginPydantic,
    UserInfoPydantic,
)
from common.global_variable import PMResponse, oauth2_scheme
from common.utils import del_cache, set_cache

from user.models import User
from user.utils import (
    get_current_user_model,
    get_password_hash,
    validate_token,
    verify_password,
    create_access_token,
)
from config.settings import (
    ACCESS_TOKEN_EXPIRE_DAYS,
    DEFAULT_AVATAR,
    HTTP_SITE,
)

router = APIRouter()


async def register_user(user: UserLoginPydantic):
    user.password = get_password_hash(user.password)
    user_obj = await User.create(
        **user.dict(exclude_unset=True), avatar=DEFAULT_AVATAR
    )
    return await UserPydantic.from_tortoise_orm(user_obj)


async def authenticate_user(username: str, password: str, create: bool = False):
    """
    if user not exist, register user
    """
    user = await User.filter(username=username).first()

    if not user:
        if not create:
            return False
        return await register_user(
            UserLoginPydantic(username=username, password=password)
        )
    if not verify_password(password, user.password):
        return False
    return user


@router.post("/token/", response_model=PMResponse)
async def login_for_access_token(form_data: UserLoginPydantic, request: Request):
    user = await authenticate_user(form_data.username, form_data.password, create=True)
    if (not user) or user.disabled:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="User cannot login",
        )
    access_token_expires = timedelta(days=ACCESS_TOKEN_EXPIRE_DAYS)
    token = create_access_token(user_id=user.id, expires_delta=access_token_expires)
    await set_cache(request, str(user.id), token, access_token_expires)
    return {'code': status.HTTP_200_OK, 'data': {"token": token}}


@router.get("/me/", response_model=PMResponse)
async def read_users_me(
        current_user: User = Depends(get_current_user_model),
):
    user_info = await UserLoginPydantic.from_tortoise_orm(current_user)
    user_info.role = None
    user_info.avatar = f'{HTTP_SITE}{user_info.avatar}'
    return {'code': status.HTTP_200_OK, 'data': user_info}


@router.post("/logout/", response_model=PMResponse)
async def user_logout(request: Request, token: str = Depends(oauth2_scheme)):
    await del_cache(request, token)
    return {'code': status.HTTP_200_OK}
