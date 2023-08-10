from fastapi import APIRouter, status

from common.utils import get_cache, set_cache

router = APIRouter()


@router.get('/get/')
def test_get_method():
    return {'code': status.HTTP_200_OK, 'data': {'message': 'test get method OK.'}}


@router.get('/redis/get/{key}')
async def test_redis_get(key: str):
    return await get_cache(key)


@router.get('/redis/set/{key}')
async def test_redis_set(key: str, value: str):
    await set_cache(key, value)
    return await get_cache(key)
