from typing import Optional
from fastapi import HTTPException, status
from fastapi.security.oauth2 import OAuth2PasswordBearer
from pydantic import BaseModel


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

credentials_exception = HTTPException(
    status_code=status.HTTP_401_UNAUTHORIZED,
    detail="Could not validate credentials",
    headers={"WWW-Authenticate": "Bearer"},
)


class PMResponse(BaseModel):
    """Reseponse standart formatter."""

    code: int
    data: Optional[dict | list | str | int | float | None]
