from tortoise import Tortoise
from tortoise.contrib.pydantic import pydantic_model_creator

from common.models import Tag

Tortoise.init_models(['common.models'], 'models')

Tag_Pydantic = pydantic_model_creator(
    Tag,
    name="TagPydantic",
    computed=('key',)
)
TagIn_Pydantic = pydantic_model_creator(Tag, name="TagIn", exclude_readonly=True)
