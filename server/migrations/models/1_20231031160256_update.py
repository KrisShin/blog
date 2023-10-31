from tortoise import BaseDBAsyncClient


async def upgrade(db: BaseDBAsyncClient) -> str:
    return """
        ALTER TABLE "tb_tag" ADD "user_id" UUID;
        ALTER TABLE "tb_tag" ADD CONSTRAINT "fk_tb_tag_tb_user_34e7a09b" FOREIGN KEY ("user_id") REFERENCES "tb_user" ("id") ON DELETE SET NULL;"""


async def downgrade(db: BaseDBAsyncClient) -> str:
    return """
        ALTER TABLE "tb_tag" DROP CONSTRAINT "fk_tb_tag_tb_user_34e7a09b";
        ALTER TABLE "tb_tag" DROP COLUMN "user_id";"""
