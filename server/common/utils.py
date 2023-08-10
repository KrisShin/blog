import json

from datetime import timedelta

from config.init_blog import app


async def set_cache(key: str, value, ex: timedelta = None) -> bool:
    if not all((key, value)):
        return False

    params = {'name': 'blog.cache.' + key, 'value': value}
    if ex:
        params['ex'] = ex

    if isinstance(value, int | float | str):
        return await app.redis.set(**params)
    else:
        try:
            params['value'] = json.dumps(value)
            return await app.redis.set(**params)
        except json.JSONDecodeError:
            return False


async def get_cache(key: str) -> str:
    return await app.redis.get('blog.cache.' + key)


async def del_cache(key: str) -> str:
    return await app.redis.delete('blog.cache.' + key)
