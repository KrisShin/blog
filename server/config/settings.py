from dotenv import dotenv_values

env = dotenv_values('.env')

PG_HOST = env.get('PG_HOST')
PG_PORT = env.get('PG_PORT')
PG_USER = env.get('PG_USER')
PG_PASS = env.get('PG_PASS')
PG_DB = env.get('PG_DB')

REDIS_HOST = env.get('REDIS_HOST')
REDIS_PORT = env.get('REDIS_PORT')
REDIS_USER = env.get('REDIS_USER')
REDIS_PASS = env.get('REDIS_PASS')
REDIS_DB = env.get('REDIS_DB')

TORTOISE_ORM = {
    "connections": {
        "default": f"postgres://{PG_USER}:{PG_PASS}@{PG_HOST}:{PG_PORT}/{PG_DB}"
    },
    "apps": {
        "models": {
            "models": [
                'aerich.models',
                'common.models',
                'user.models',
                'article.models'
            ],
            "default_connection": "default",
        },
    },
}

# to get a string like this run:
# openssl rand -hex 32
SECRET_KEY = env.get('SECRET_KEY')
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_DAYS = 7

HTTP_ADDR = 'http://localhost'
HTTP_PORT = 9100
HTTP_SITE = f'{HTTP_ADDR}:{HTTP_PORT}'
DEFAULT_AVATAR = f'/static/avatar/default.jpg'