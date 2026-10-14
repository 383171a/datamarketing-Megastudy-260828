# 인덱스 = Index
# 사전 => 영어사전, 국어사전
# 찾고자 하는 단어 [단어] : 발음 : 단어활용 문장 예시 
# apple이란 단어를 찾는다면?
# a ~ z : 영단어가 오름차순
# b라는 알파벳으로 시작하는 단어보다는 문조건 앞쪽에 있다라는 생각
# 인덱싱 // 규칙을 가지고 있는 저장소에서 어떤 값을 찾는 행위
# 인덱스 // 해당 저장소가 가지고 있는 규칙 -> 인덱스가 있어야 인덱싱을 할 수 있다.
# Excel로 데이터를 저장할 수 있다. 하지만 MySQL을 쓰는 이유는 인덱싱 형태로 방대한 데이터를 다루기 위해 필요하다.

CREATE DATABASE IF NOT EXISTS sqlDB;
DROP DATABASE sqlDB;
SHOW DATABASES;

USE sqlDB;

SELECT * FROM userTbl;
DESC userTbl;


# 특정 테이블 안에 인덱스 값을 조회해서 나에게 보여줘
SHOW INDEX FROM userTbl;
DROP TABLE userTbl;

CREATE TABLE userTbl(
    userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr VARCHAR(4) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(8),
    height SMALLINT,
    mDATE DATE
);
ALTER TABLE userTbl MODIFY COLUMN userID VARCHAR(8); # 속성값 바꾸기 
ALTER TABLE userTbl CHANGE CULUMN name userName VARCHAR(10) NOT NULL; # 이름까지 바꾸기 

# Non_unique : 중복값 허용 여부 : 0 = 중복불가 선언

# 인덱스가 무엇인가?
# 인덱스를 왜 사용하는가?
# 식별키 = PRIMARY KEY = INDEX 조건
# 복합 인덱스 = 어떤 값을 조회, 조건 WHERE age = 16 AND grade 1학년 => 꼭 이 조건으로 찾아와야 할 때가 있어
# 이왕이면 인덱스 설정, 단일값 = 유저아이디 하나만 인덱스
# age, grade = 한번에 묶어서 결합해서 인덱스 
# 만약, 16살이면서 3학년의 조건을 찾아야 한다면 한 번에 찾는게 효율적
# Collation = 정렬 = Ascending 
# BTREE = Balanced Tree (mySQL 기본값)

CREATE TABLE buyTbl(
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userID CHAR(8) NOT NULL,
    productName CHAR(4),
    groupName CHAR(4),
    price INT NOT NULL,
    amount SMALLINT NOT NULL,
    FOREIGN KEY (userID) REFERENCES userTbl(userID)
);


SHOW INDEX FROM buyTbl; # Non_uique -> 0  유니크해야함 / Non_uique -> 1  유니크안해야함 사는건 몇번 살 수 잇지 => 유니크를 갖느냐 갖지 못하느냐는 인덱스의 자격 요건이 먼저 충족
# userID 컬럼을 기준으로 2개의 테이블은 서로 연결할 수 있는 상태 
# userTbl : 사용자의 정보 존재 : A,B,C,D
# buyTbl : 특정 사용자가 상품을 구매할 때마다 값이 생성되는 테이블 : 
# A : 001 / 003 / 004 / 007 ...  한사람이 여러번 구매할 수 있지

# 클러스터 인덱스 : 클러스터 = 부동산 시장 = 군집, 변경이 불가한 인덱스, 무조건 하나!

# PRIMARY KEY => 테이블 안에 어떤 값이 삽입되던지 무조건 해당 테이블 내 값을 식별할 수 있도록 태생부터 인덱스의 역할 부여

# 보조 인덱스 => 테이블 내 클러스터 인덱스 외에 추가적으로 인덱스의 역할을 부여받은 요소, 테이블이 생성된 이후에도 가능

DESC userTbl;
# 이미 완성된 테이블 안에 속성(인덱스)값을 수정할 때(1. 유니크라는 속성을 부여)
ALTER TABLE userTbl ADD CONSTRAINT TESTDate UNIQUE(mDate); # => 유니크를 갖느냐 갖지 못하느냐는 인덱스의 자격이 되어야 판단 가능 // 회수하기 위해 이름도 붙여주기(TESTDate) 제약 요소로서(CONSTRAINT)
# 너 인덱스해랏! 4) 인덱스 키 적용하는 방법
SHOW INDEX FROM userTbl;

CREATE INDEX idx_name ON userTbl(name);

# 인덱스를 부여하는 방법
# 1) 프라이머리 키 적용 : PRIMARY KEY
# 2) 외래키 적용 : FORIEGN KEY
# 3) 유니크 값을 적용 : ALTER TABLE ADD CONSTRAINT UNIQUE()
# 4) 인덱스 키 생성하는방법 : CREATE INDEX 
# 5) 인덱스 키 적용하는방법 : ALTER TABLE ADD INDEX

ALTER TABLE userTbl ADD INDEX idx_addr(addr);
# 인덱스가 나름 중요 : 체감은 안됨 최소한 50만개 이상의 데이터일 때 빠르다 느낌

# 초기 테이블 생성 코드
CREATE TABLE userTbl(
    userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr VARCHAR(4) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(8),
    height SMALLINT,
    mDATE DATE
);
# 인덱스 생성용 테이블 코드 
CREATE TABLE userTbl(
    userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr VARCHAR(4) NOT NULL,
    mobile1 CHAR(3),
    mobile2 CHAR(8),
    height SMALLINT,
    mDATE DATE,
    UNIQUE INDEX idx_userTbl_name(name),
    INDEX idx_userTbl_addr (addr) 
);

ALTER TABLE userTbl DROP INDEX idx_userTbl_name;
ALTER TABLE userTbl DROP INDEX idx_userTbl_addr;
SHOW INDEX FROM userTbl;

# 1) 지금까지의 SQL 문법 기초
# DDL
# DML
# DCL
# INDEX

# 2) 데이터 수집 + 저장
# Python + MySQL 연습 + 실전
# Modeling

# 3) SQL 고급 문법
# window 함, with, view 가상쿼리, LAG 

# 4) Oracle
# 통한 표준 SQL문법 10%정도

# 5) NoSQL 
# 비관계형 DBMS 
# MongoDB > Studio 3T 

# 6) MySQL + MongoDB
# Cloud : Railway, AWS EC2 (동시 접속 환경 만들기)

# 7) 대용량 데이터 수집 저장
# Scrapy 기법 + API + FastAPI + Server 배포

# 8) 메인 스트림은 wconcept 활용해서 

CREATE DATABASE IF NOT EXISTS ecommerce;

USE ecommerce;
SHOW TABLES;

SHOW INDEX FROM product;
DESC product;
SELECT COUNT(*) product_count FROM product;

SELECT * FROM product;

# DECIMAL : 몇자리수 포함 할거냐
ALTER TABLE product MODIFY discount_percent DECIMAL(10, 2);

# 특정 컬럼이 인덱스의 속성을 가지고 있다면, 
# 해당 인덱스를 조건값으로 사용할 수 있으므로 해당 인덱스를 찾아서 값을 변경/수정/업데이트 할 수 있다는 말 






