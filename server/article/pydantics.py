from datetime import datetime
from uuid import UUID

from pydantic import BaseModel


class ArticleDetailPydantic(BaseModel):
    title: str
    context: str
    created_at: datetime
    author_id: UUID

    @property
    def author(self):
        return self.author.username
