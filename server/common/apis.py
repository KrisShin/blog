from fastapi import APIRouter, status

from common.global_variable import PMResponse

from common.pydantics import Tag_Pydantic

router = APIRouter()


@router.get('/get/', response_model=PMResponse)
def test_get_method():
    return {'code': status.HTTP_200_OK, 'data': {'message': 'test get method OK.'}}
