from typing import Union

from fastapi import FastAPI
from enum import Enum


class EnumModel(str, Enum):
    option_a = 'a'
    option_b = 'b'
    option_c = 'c'


blog = FastAPI()


@blog.get("/")
async def root():
    return {"message": "Hello World"}


@blog.get("/enum/test/{option}")
async def get_option(option: EnumModel):
    if option is EnumModel.option_a:
        return {'a': option}
    if option is EnumModel.option_b:
        return {'b': option}
    if option is EnumModel.option_c:
        return {'c': option}


@blog.get("/items/{item_id}")
async def read_item(item_id: str, q: Union[str, None] = None, short: bool = False):
    item = {"item_id": item_id}
    if q:
        item.update({"q": q})
    if not short:
        item.update(
            {"description": "This is an amazing item that has a long description"}
        )
    return item
