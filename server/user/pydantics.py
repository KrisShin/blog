from typing import Any

from tortoise.contrib.pydantic import pydantic_model_creator
from pydantic import BaseModel
from user.models import User


class UserLoginPydantic(BaseModel):
    username: str
    password: str


UserPydantic = pydantic_model_creator(User, name="UserPydantic")

UserInfoPydantic = pydantic_model_creator(
    User,
    name="UserInfo",
    exclude=('password', 'last_login', 'created_at', 'updated_at', 'disabled', 'phone'),
)


class TokenPydantic(BaseModel):
    access_token: str
    token_type: str = 'Bearer'
