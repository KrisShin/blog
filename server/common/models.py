from tortoise import fields, models


class BaseModel(models.Model):
    """
    The Base model
    """

    id = fields.UUIDField(pk=True)
    created_at = fields.DatetimeField(auto_now_add=True)
    updated_at = fields.DatetimeField(auto_now=True)

    class Meta:
        abstract = True


class Tag(BaseModel):
    """
    The Tag model
    """

    name = fields.CharField(max_length=128, null=False, unique=True, index=True)
    user = fields.ForeignKeyField(
        'models.User', related_name='created_tags', null=True, on_delete=fields.SET_NULL
    )

    class Meta:
        table = "tb_tag"
        from_attributes = True
        ordering = ["name"]

    def key(self) -> str:
        return self.name
