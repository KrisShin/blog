from tortoise.contrib.pydantic import pydantic_model_creator

from common.models import Tag


TagInPydantic = pydantic_model_creator(
    Tag, name="TagIn", exclude_readonly=True, include={"name"}
)
