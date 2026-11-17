// -> 단문 주석 show dbs : 로컬 컴퓨터 > db목록 보기
show dbs

/*
-> 복문 주석 여러 줄(행) 주석처리 할 수 있음
특정 데이터 베이스 선택 시, 사용 구문 
*/
use megastudy_261111

// 비관계형 데이터 베이스 : 데이터베이스 안에 컬렉션 한 개도 존재하지 않으면 자동 삭제 
// 특정 db안에 컬렉션 조회하기 

show collections

// SELECT * FROM test; 아래 구문과 동일
db.test.find()


// 데이터베이스의 메타데이터 조회 
db.stats()

// 데이터 베이스 삭제 쿼리 구문 
db.dropDatabase()

// 컬렉션 삭제 쿼리 구문
db.test.drop()

// 컬렉션 생성 쿼리 구문
db.createCollection("test")

// 5242880 = 5MB
// bit = 0, 1
// 8bits = 1byte = 2^8
// 1kb = 10 * byte = 2^10
//1mb = 5 * 2^10 * 2^10 = 5,242,880 
db.createCollection("log", {
    capped: true, size: 5242880, max: 5000}
    )

show collections

db.log.isCapped()

db.log.renameCollection("test")



























