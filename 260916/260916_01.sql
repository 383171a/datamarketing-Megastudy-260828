#  (단문)주석처리 : 코드에 영향을 주지는 않는다. 
-- (단문)이것도 주석 처리다, 
/*
(복문) 주석처리
*/

# 지금까지 수집한 데이터를 저장하는데 있어서 반드시 알고 있어야 하는 기본 개념
# Data = Python으로 Crawling한 Data
# RDBMS = 데이터베이스를 관리하는 시스템이 관계성을 중요하게 판단하는 경우
# NoSQL = Not Only SQL 

# DataBase = DB = Data가 모여있는 저장소(공간)
# Table = Data가 최초로 저장될 공간 (행.열 기반으로 구성) 
# Column = Table 내 열 
# Row = Table 내 행 
# schema = 스키마 = 약속(특정 컬럼안에 입력가능한 데이터 포맷) 
# A라는 열 = brand 열 = 문자열, 숫자x, customer_price = 정수, 문자x  


# python = 프로그래밍을 위한 언어
# SQL(Structured Query Language) = 언어를 알자!! 쿼리 문법을 사용하기 위한 언어

# DDL : Data Definition Language = 데이터 정의 언어 
# 데이터를 생성.변경.삭제 -> CREATE, DROP, ALTER(MODIFY, CHANGE) 

# DML : Data Manipulation Language = 데이터 처리 언어
# 생성된 구조 안에 데이터 삽입하거나 업데이트 하거나 삭제 또는 조회 -> INSERT, UPDATE, DELETE, SELECT
 
# DCL : Data Control Language = 데이터 제어 언어
# 누가 데이터 생성.조회.삭제 등을 관리할 수 있게 할 것인지를 제어 -> 권한 GRANT, REVOKE

# TCL : Transaction Control Language = 처리 제어 언어
# 데이터 삭제.수정 등을 되돌아 갈 수 있도록 제어 -> COMMIT, ROLLBACK, SAVEPOINT 