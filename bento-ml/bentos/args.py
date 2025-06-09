from pydantic import BaseModel


class BentoArgs(BaseModel):
    model_uri: str
