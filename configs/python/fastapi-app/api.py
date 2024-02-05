from app.utils import *
from app.config import *
from app.schemas import *
from app.models import *
from fastapi import APIRouter


router = APIRouter(
    prefix=PREFIX,
)

