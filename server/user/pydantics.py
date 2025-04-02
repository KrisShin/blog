from typing import Any

from tortoise.contrib.pydantic import pydantic_model_creator
from pydantic import BaseModel
from user.models import User
from datetime import datetime


class UserLoginPydantic(BaseModel):
    username: str
    password: str


class UserPydantic(BaseModel):
    username: str
    phone: str
    introduction: str
    avatar: str
    email: str
    last_login: datetime
    disabled: bool
    tags: Any


class UserInfoPydantic(BaseModel):
    username: str
    introduction: str
    avatar: str
    email: str
    tags: Any


class TokenPydantic(BaseModel):
    access_token: str
    token_type: str = 'Bearer'
