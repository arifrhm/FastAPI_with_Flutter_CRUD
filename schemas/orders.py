from pydantic import BaseModel

class Orders(BaseModel):
    name: str
    email: str
    password: str
    nama_barang : str
    stok : int     
    jumlah_terjual : int
    jenis_barang : str