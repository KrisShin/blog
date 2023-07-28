from tortoise.contrib.pydantic import pydantic_model_creator
from pydantic import BaseModel
from user.models import User


class UserLoginPydantic(BaseModel):
    username: str
    password: str


UserPydantic = pydantic_model_creator(User, name="User")

UserInfoPydantic = pydantic_model_creator(
    User,
    name="UserInfo",
    exclude=('password', 'last_login', 'created_at', 'updated_at', 'disabled'),
)
