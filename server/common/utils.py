import json
from fastapi import Request
from datetime import timedelta


async def set_cache(request: Request, key: str, value, ex: timedelta) -> bool:
    # if not all((request, key, value)):
    #     return False
    #
    # params = {'name': key, 'value': value}
    # if ex:
    #     params['ex'] = ex
    #
    # if isinstance(value, int | float | str):
    #     return await request.app.state.redis.set(**params)
    # else:
    #     try:
    #         params['value'] = json.dumps(value)
    #         return await request.app.state.redis.set(**params)
    #     except json.JSONDecodeError:
    #         return False
    ...


async def get_cache(request: Request, key: str) -> str:
    # return await request.app.state.redis.get(key)
    ...


async def del_cache(request: Request, key: str) -> str:
    # return await request.app.state.redis.delete(key)
    ...
