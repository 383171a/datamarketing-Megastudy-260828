import os
# import mysql.connector -> 이제 커넥터 안쓰니까 지우기
from fastapi import FastAPI
from dotenv import load_dotenv

from sqlalchemy import create_engine, text, Integer, String # -> 중요 중요
from sqlalchemy.orm import DeclarativeBase, sessionmaker, Mapped, mapped_column

# sqlalchemy : engine, session, model
# engine : 데이터 입.출력 관리하는 물리적인 역할 담당
# session : engine이 문제 없이 설정되었다는 전제, 실제 데이터 입.출력 역할
# model : 실제 값 적용 시, 타입 및 포맷에 맞춰서 입.출력 될 수 있도록 지원

load_dotenv()

app = FastAPI(
  title="Wconcept MySQL API",
  description="FastAPI와 MySQL 직접 연결",
  version="1.0.0"
)
# 엔진을 만들었으니 지워도 됨
# def get_db_connection() :

#   return mysql.connector.connect(
#     host=os.getenv("DB_HOST"),
#     user=os.getenv("DB_USER"),
#     password=os.getenv("DB_PASSWORD"),
#     database=os.getenv("DB_NAME")
#   )

# mysql + mysqlconnector://root:anna123@localhost/api_db
DATABASE_URL = (
  f"mysql+mysqlconnector://"
  f"{os.getenv('DB_USER')}:"
  f"{os.getenv('DB_PASSWORD')}@"
  f"{os.getenv('DB_HOST')}/"
  f"{os.getenv('DB_NAME')}"
)

engine = create_engine(DATABASE_URL)

# 메모리 누수 방지 with 절
# with engine.connect() as connection :
#   result = connection.execute(
#     text("SELECT 1")
#   )
#   print(result.fetchone())

# 터미널에 python main.py -> 1이 출력 되는지 확인 정상적으로 나온다면 engine이 잘 설치되었고 정상 작동 중

SessionLocal = sessionmaker(
    bind=engine
)



class Base(DeclarativeBase):
  pass 


class Product(Base):
  __tablename__ = "api_products"

  product_id: Mapped[int] = mapped_column(Integer, primary_key=True) 

  brand_name: Mapped[str] = mapped_column(String(100))

  product_name: Mapped[str] = mapped_column(String(255))

  price: Mapped[int] = mapped_column(Integer)

@app.get("/products")
def get_products():

  db = SessionLocal()

  products = db.query(Product).all()

  db.close()

  return products
