from sqlalchemy import create_engine, MetaData

engine = create_engine('mysql+asyncmy://root:@localhost:3306/test_fastapi_database')

meta = MetaData()

conn = engine.connect()