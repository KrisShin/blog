from tortoise import BaseDBAsyncClient


async def upgrade(db: BaseDBAsyncClient) -> str:
    return """
        CREATE TABLE IF NOT EXISTS "aerich" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "version" VARCHAR(255) NOT NULL,
    "app" VARCHAR(100) NOT NULL,
    "content" JSONB NOT NULL
);
CREATE TABLE IF NOT EXISTS "tb_tag" (
    "id" UUID NOT NULL  PRIMARY KEY,
    "created_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "name" VARCHAR(128) NOT NULL UNIQUE
);
COMMENT ON TABLE "tb_tag" IS 'The Tag model';
CREATE TABLE IF NOT EXISTS "tb_user" (
    "id" UUID NOT NULL  PRIMARY KEY,
    "created_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "username" VARCHAR(32),
    "phone" VARCHAR(13),
    "password" VARCHAR(256) NOT NULL,
    "introduction" VARCHAR(512),
    "avatar" VARCHAR(50),
    "email" VARCHAR(128)  UNIQUE,
    "last_login" TIMESTAMPTZ   DEFAULT CURRENT_TIMESTAMP,
    "disabled" BOOL NOT NULL  DEFAULT False
);
COMMENT ON TABLE "tb_user" IS 'The User model';
CREATE TABLE IF NOT EXISTS "tb_article" (
    "id" UUID NOT NULL  PRIMARY KEY,
    "created_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "title" VARCHAR(1024) NOT NULL,
    "content" TEXT NOT NULL,
    "author_id" UUID REFERENCES "tb_user" ("id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "rs_user_tag" (
    "tb_user_id" UUID NOT NULL REFERENCES "tb_user" ("id") ON DELETE SET NULL,
    "tag_id" UUID NOT NULL REFERENCES "tb_tag" ("id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "rs_article_tag" (
    "tb_article_id" UUID NOT NULL REFERENCES "tb_article" ("id") ON DELETE SET NULL,
    "tag_id" UUID NOT NULL REFERENCES "tb_tag" ("id") ON DELETE SET NULL
);"""


async def downgrade(db: BaseDBAsyncClient) -> str:
    return """
        """
