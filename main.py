from unicodedata import name
from fastapi import FastAPI
from routes.users import user
from routes.log_orders import log_orders
from fastapi.middleware.cors import CORSMiddleware
import logging.config

# setup loggers
logging.config.fileConfig("./logging.conf", disable_existing_loggers=False)

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(user,prefix="/users",tags=["Users"] )
app.include_router(log_orders,prefix="/log_orders",tags=["Log Orders"])
