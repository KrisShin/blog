import os

import redis.asyncio as redis
from tortoise import Tortoise
from tortoise.contrib.fastapi import register_tortoise
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles

from config.settings import REDIS_URL, TORTOISE_ORM, BASE_DIR
from article.apis import router as article_router
from user.apis import router as user_router
from common.apis import router as test_router


def register_redis(app: FastAPI):
    """
    register redis to app
    """
    @app.on_event("startup")
    async def startup_event():
        app.redis = await redis.from_url(REDIS_URL, decode_responses=True, encoding="utf8", )

    # @app.on_event("shutdown")
    # async def shutdown_event():
    #     app.redis.close()


def init_db(app):
    """
    initialise database
    """
    register_tortoise(
        app,
        config=TORTOISE_ORM,
        add_exception_handlers=True,
    )


def register_router(app):
    """
    register router to app
    """
    Tortoise.init_models(['common.models', 'user.models', 'article.models'], 'models')

    app.include_router(
        article_router,
        tags=['article'],
        responses={404: {'description': 'Not Found'}},
        prefix='/api/article',
    )
    app.include_router(
        user_router,
        tags=['user'],
        responses={404: {'description': 'Not Found'}},
        prefix='/api/user',
    )
    app.include_router(
        test_router,
        tags=['test'],
        responses={404: {'description': 'Not Found'}},
        prefix="/api/test",
    )


def create_app():
    app = FastAPI()
    app.mount(
        "/static",
        StaticFiles(directory=os.path.join(BASE_DIR, "statics")),
        name="static",
    )
    origins = [
        "http://localhost",
        "http://localhost:19988",
    ]

    app.add_middleware(
        CORSMiddleware,
        allow_origins=origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
        expose_headers=["*"],
    )
    init_db(app)

    register_router(app)

    register_redis(app)

    return app
