from passlib.context import CryptContext
from datetime import timedelta, datetime
from typing import Optional
from uuid import UUID
from fastapi import Depends, HTTPException, Request
from jose import jwt, JWTError

from common.exceptions import CredentialsException
from common.utils import get_cache
from user.pydantics import UserPydantic
from common.global_variable import oauth2_scheme
from user.models import User

from config.settings import ALGORITHM, ACCESS_TOKEN_EXPIRE_DAYS, SECRET_KEY

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def verify_password(plain_password, hashed_password):
    """Check plain password whether right or not"""
    return pwd_context.verify(plain_password, hashed_password)


def get_password_hash(password):
    """Generate password hashed value."""
    return pwd_context.hash(password)


def create_access_token(user_id: UUID, expires_delta: Optional[timedelta] = None):
    """create user access token"""
    to_encode = {'user_id': str(user_id)}
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(days=ACCESS_TOKEN_EXPIRE_DAYS)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


async def validate_token(token: str = Depends(oauth2_scheme)) -> str | bool:
    """if validate return user_id otherwise return False"""
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id: str = payload.get("user_id")
        expire_time: float = payload.get('exp')
        saved_token = await get_cache(user_id)
        if (user_id is None) or (
                datetime.fromtimestamp(expire_time) < datetime.utcnow()
        ) or (saved_token != token):
            return False
    except JWTError:
        return False
    return user_id


async def get_current_user_model(user_id: str = Depends(validate_token)):
    """return user orm"""
    if user_id is False:
        raise CredentialsException

    user = await User.get_or_none(id=user_id, disabled=False)
    return user
