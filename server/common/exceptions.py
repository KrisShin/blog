from fastapi import HTTPException, status

CredentialsException = HTTPException(
    status_code=status.HTTP_401_UNAUTHORIZED,
    detail="Could not validate credentials",
    headers={"WWW-Authenticate": "Bearer"},
)


class BadRequest(HTTPException):
    status_code = status.HTTP_400_BAD_REQUEST
    detail = ''

    def __init__(self, detail):
        self.detail = detail


class AuthenticationFailed(HTTPException):
    status_code = status.HTTP_401_UNAUTHORIZED
    detail = ''

    def __init__(self, detail):
        self.detail = detail
