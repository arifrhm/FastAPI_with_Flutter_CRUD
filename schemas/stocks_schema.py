from pydantic import BaseModel
from pyparsing import Optional

class Stocks(BaseModel):
    barang_id : Optional[int]
    nama_barang : Optional[str]
    stock : int