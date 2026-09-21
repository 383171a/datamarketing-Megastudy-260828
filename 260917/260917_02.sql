# DDL : CREATE, DROP, ALTER
# DML : INSERT, UPDATE, DELETE, SELECT

CREATE DATABASE IF NOT EXISTS school;

USE school;

SHOW DATABASES;

CREATE TABLE IF NOT EXISTS students (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age TINYINT UNSIGNED,
    grade VARCHAR(10)
);

SHOW TABLES;

DESC students;

# SELECT FROM 절
SELECT * FROM students; # * => all이라는 의미

# AI(AUTO INCREMENT)를 사용하려면=> id 컬럼을 제외한 나머지 컬럼을 명시할 때만
INSERT INTO students VALUES(1, "강백호", 16, "1학년");
 INSERT INTO students (name, age, grade) 
 VALUES("서태웅",  16, "1학년"); 
 
 INSERT INTO students (name, age, grade)
 VALUES
	("송태섭", 17, "2학년"),
    ("정대만", 18, "3학년"),
    ("채치수", 18, "3학년");
    
SET SQL_SAFE_UPDATES = 1;
    
UPDATE students SET grade = "2학년"
WHERE name = "서태웅"; # WHERE => 조건절

UPDATE students SET grade = "1학년"
WHERE id = 2;

# 컴퓨터 안에 어떤 값을 변경.조작 -> 뒤로 가기 (ctrl + z)
# mysql > 뒤로 가기가 없다
# 100만개의 데이터, 서태웅 100명일 때 딱, 1명의 서태웅만 바꾸고 싶은데
# 식별자가 아니면, 함부로 데이터를 update하지 못하도록 safe mode가 기본적으로 설정 되어있다.
/*
Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
*/

SELECT
	name, grade 
FROM students 
WHERE age NOT IN (16, 17); # IN : OR의 역할, ~ 중 하나! // NOT IN : 하나라도 아닌

SELECT
	name, grade 
FROM students 
WHERE age NOT IN (16, 17) OR name = "정대만";

SELECT
	name, grade 
FROM students 
WHERE name LIKE "%태%";

SELECT
	name, grade 
FROM students 
WHERE name LIKE "강__";
# 좋% -> 사용자 리뷰가 긍정적인 부분을 찾아올 수 있다.

# WHERE 조건절 SELECT, FROM 구문과 많이 사용!
# 조건을 설정하려면 필연적으로 연산자가 많이 사용되어짐 대표적으로 비교 연산자가 많이 사용
# =(같다) !=(같지 않다, 현업에서마니씀) <>(같지 않다, MySQL에서 마니씀) < > <= >=

# 비교연산자가 유일하게 비교하지 못하는 대상
# NULL (결측치)
# age != NULL (이건 안됨) age <> NULL(이것도 안됨)
# IS NULL | IS NOT NULL 

# 비교연산자 
# 직접비교연산 / NULL / 여러개 중 하나 찾기

# 비교연산자를 여러번 사용!
# 논리연산자 : A AND B / A OR B  

# WHERE 조건절
# 1) 비교연산자
# 2) 논리연산자 
# 3) 문자열연산자 : %, _
# - % : 특정 공간에 0개 또는 그 이상의 요소(대상)가 있음을 의미
# _ : 반드시 특정 공간에 1개의 요소가 존재해야함


DELETE FROM students; # 데이터의 컨텐츠 = 아이템만 없앰, 스키마 = 속성값들은 존재

SET SQL_SAFE_UPDATES = 0;

SELECT * FROM students;

DESC students;

DROP TABLE students; # 데이터의 물리적인 존재 자체를 없애버리는 역할(터를 없애)