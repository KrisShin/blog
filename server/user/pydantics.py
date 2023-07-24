from tortoise import Tortoise
from tortoise.contrib.pydantic import pydantic_model_creator
from pydantic import BaseModel
from user.models import User

Tortoise.init_models(['user.models'], app_label='user')

UserPydantic = pydantic_model_creator(User, name="User")


class UserLoginPydantic(BaseModel):
    username: str
    password: str


UserInfoPydantic = pydantic_model_creator(
    User,
    name="UserInfo",
    exclude=('password', 'last_login', 'created_at', 'updated_at', 'disabled', 'author'),
    computed=('roles',),
)
