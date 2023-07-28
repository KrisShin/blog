from tortoise import fields
from common.models import BaseModel


class User(BaseModel):
    """
    The User model
    """

    username = fields.CharField(max_length=32, null=True, index=True)
    phone = fields.CharField(max_length=13, null=True, unique=False, index=True)
    password = fields.CharField(max_length=256, null=False)
    introduction = fields.CharField(max_length=512, null=True)
    avatar = fields.CharField(max_length=50, null=True)
    email = fields.CharField(max_length=128, null=True, unique=True, index=True)
    last_login = fields.DatetimeField(null=True, auto_now=True)
    disabled = fields.BooleanField(default=False, index=True)

    tags = fields.ManyToManyField(
        'models.Tag',
        related_name='users',
        through='rs_user_tag',
        null=True,
        on_delete=fields.SET_NULL,
    )

    class Meta:
        table = "tb_user"
