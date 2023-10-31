from tortoise.contrib.pydantic import pydantic_model_creator

from common.models import Tag


TagPydantic = pydantic_model_creator(Tag, name="TagPydantic", computed=('key',))
TagInPydantic = pydantic_model_creator(Tag, name="TagIn", exclude_readonly=True)
