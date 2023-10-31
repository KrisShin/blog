from tortoise import Tortoise

from article.apis import router as article_router
from user.apis import router as user_router
from common.test_apis import router as test_router
from common.apis import router as tag_router


def register_router(app):
    """
    register router to app
    """

    Tortoise.init_models(['common.models', 'user.models', 'article.models'], 'models')

    app.include_router(
        test_router,
        tags=['test'],
        responses={404: {'description': 'Not Found'}},
        prefix="/api/test",
    )
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
        tag_router,
        tags=['tag'],
        responses={404: {'description': 'Not Found'}},
        prefix="/api/tag",
    )
