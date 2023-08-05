import uvicorn

from config.init_blog import app, init_db, register_redis
from config.routers import register_router

init_db(app)

register_router(app)

register_redis(app)

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=19988)
