# SQL 

# DDL, DML, DCL, TCL 
# DML > 
# SELECT~FROM, WHERE, AS, LIMIT, DISTINCT,GROUP BY, ORDER BY
# wconcept의 경우 데이터 출처가 3개의 경우로 발생
# 1) Best Ranking 200 상품 정보
# 2) 각 상품별 리뷰 정보
# 3) 각 브랜드별 블로그 컨텐츠정보

# 상품의 리뷰값을 보면서 상품 브랜드의 블로그 컨텐츠를 보고 싶다.
# 1) 애초에 출처가 서로 다른 데이터를 1개의 테이블 안에 모두 저장하는 방법
# > 컬럼(열)이 굉장히 길어지겠지?
# > 데이터의 중복이 발생할 것 같아.

CREATE DATABASE IF NOT EXISTS sqlDB;

SHOW DATABASES;

USE sqlDB;

CREATE TABLE IF NOT EXISTS userTbl (
	userID TINYINT UNSIGNED NOT NULL PRIMARY KEY,
    name VARCHAR(10) UNIQUE NOT NULL, # 하나의 값을 유지하겠다.
    birthYear INT NOT NULL,
    address VARCHAR(50) NOT NULL, # 인자값으로 입력된 숫자만큼 문자열을 사용하겠다는 선언이지만 해당 숫자만큼 사용하지 않았다면 사용하지 않은만큼의 메모리를 로컬에 반환
    mobile1 CHAR(3), # 숫자만큼 사용하겠다!, 그 숫자만큼 사용을 하지 않았어도 그만큼의 메모리를 씀    
    mobile2 CHAR(8),
    height TINYINT UNSIGNED,
    mDate DATE, 
    INDEX idx_userTbl_name (name), # 보다 빠른 속도로 뭔가 하려고 할 때(복수 가능)
    INDEX idx_userTbl_address (address)
    
);

SHOW TABLES;

DESC userTbl;

CREATE TABLE IF NOT EXISTS buyTbl (
	no INT UNSIGNED NOT NULL,
    userID TINYINT UNSIGNED NOT NULL, 
    product_name VARCHAR(20),
    category_name VARCHAR(20),
    price INT NOT NULL,
    amount TINYINT NOT NULL,
    FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

# 기본키 = PRIMARY KEY(주요한) : 
# 외래키 = FOREIGN KEY(외부) : 현재 우리의 테이블을 외부의 테이블과 연결하려고할 때, 그 연결고리의 역할을 맡을 키


SHOW TABLES;

DESC buyTbl;
DESC userTbl;

INSERT INTO userTbl (
no, userID, name, birthYear, address, mobile1, mobile2, height, mDate)
VALUES(1, "아이유", 1993, "서울시", "010", "12345678", 163, "2026-9-18");

SELECT * FROM userTbl;

INSERT INTO buyTbl (
no, userID, product_name, category_name, price, amount)
VALUES(1, 1, "나이키운동화", "신발잡화", 30000, 2);

SELECT *
FROM userTbl U
JOIN buyTbl B ON B.userID = U.userID;

SELECT name, product_name, price, amount
FROM userTbl U
JOIN buyTbl B ON B.userID = U.userID;

/* Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
(`sqldb`.`buytbl`, CONSTRAINT `buytbl_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `usertbl` (`userID`))
쉽게 말하면 부모 요소와 자식 요소의 테이블 관계 성립이 되었다. 
userTbl(부모), buyTbl(자식) 그러므로 부모가 생성이 안되었는데 왜 자식이 나왓?alter
> 복수의 테이블을 생성하고 관리하려면(이유.목적.명분)
> 외래키를 생성하고 관리를 해야하는데 제약 요소가 많다. 1) 반드시 부모 요소의 생성 후 자식 요소가 생성될 수 있다. 2) 반드시 자녀 삭제 후 부모 요소 삭제
*/

USE sqldb;

DELETE FROM userTbl WHERE userID = 1; # 2) 반드시 자녀 삭제 후 부모 요소 삭제

