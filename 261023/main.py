from itertools import product
import os
# import mysql.connector -> 이제 커넥터 안쓰니까 지우기
from datetime import datetime

from fastapi import FastAPI, HTTPException, status
from dotenv import load_dotenv

from sqlalchemy import create_engine, Integer, String, DateTime, text # -> 중요 중요
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
  __tablename__ = "products"

  product_id: Mapped[str] = mapped_column(String(50), primary_key=True) 

  brand_id: Mapped[int] = mapped_column(Integer)

  product_name: Mapped[str] = mapped_column(String(500))

  product_url: Mapped[str] = mapped_column(String(700))

class Brand(Base):
  __tablename__ = "brands"

  brand_id: Mapped[int] = mapped_column(Integer, primary_key=True) 

  brand_name: Mapped[str] = mapped_column(String(255))

  created_at: Mapped[datetime] = mapped_column(DateTime, server_default=text("CURRENT_TIMETAMP"))

  updated_at: Mapped[datetime] = mapped_column(DateTime, server_default=text("CURRENT_TIMETAMP"))



@app.get("/products")
def get_products(limit: int = 10):

  db = SessionLocal()

  # products = db.query(Product).all()

  products = db.query(Product).limit(limit).all()

  db.close()

  return products

@app.get("/products/{product_id}")
def get_product(product_id):

  db = SessionLocal()

  product = db.query(Product).filter(Product.product_id == product_id).first()

  db.close()

  if product is None:
    raise HTTPException(
      status_code=404,
      detail="상품을 찾을 수 없습니다."
    )

  return product

@app.put("/products/{product_id}")
def update_product(product_id: str, product: dict):

  db = SessionLocal()

  db_product = db.query(Product).filter(Product.product_id == product_id).first()
  
  if db_product is None :
    db.close()

    raise HTTPException(
      status_code=404,
      detail="상품을 찾을 수 없습니다."
    )

  db_product.brand_id = product["brand_id"]
  db_product.product_name = product["product_name"]
  db_product.product_url = product["product_url"]

  db.commit()

  db.refresh(db_product)

  db.close()

  return db_product


@app.get("/brands")
def get_brands():

  db = SessionLocal()

  brands = db.query(Brand).all()

  db.close()

  return brands

@app.post("/brands", status_code=201)
def create_brand(brand: dict):

  db = SessionLocal()

  new_brand = Brand(brand_name = brand["brand_name"])
  db.add(new_brand)

  db.commit()

  # 위의 것 만으로는 생성된 시간을 알 수 없다, autoincrement도 알수 없으니 아래가 추가

  db.refresh(new_brand)

  db.close()

  return new_brand



