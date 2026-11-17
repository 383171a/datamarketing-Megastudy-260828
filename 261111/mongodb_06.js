// 지금 순서 이렇게 
// 데이터베이스, 컬렉션 생성, 삭제 
// 문서 내용 삽입 
// 조회구문
// 연산자 개념 
// 메서드 종류(limit, sort, count)

// ORDER BY : sort() : 1 오름차순 // -1 내림차순
db.users02.find(
  {address: "경기도"}
).sort({age: -1})

// SELECT COUNT(*) FROM users02;
db.users02.find().count()

/*
연산자
$gt : 초과
$gte : 이상
$lt : 미만
$lte : 이하
$eq : 같다
$ne : 다르다
$in : 여러개 중 하나
$nin : 특정요소가 아닌 여러개 중 하나
$or : 또는 
$and : 논리 연산자 중 and 연산자 = 좌항, 우항 모두 참(True) 
$not : 부정연산자 
$regex : 정규표현식
$exists : 존재여부를 true, false
$distinct
*/

db.users02.count(
  {address: {$exists: true}}
)

db.users02.find()

db.users02.find(
  {address: {$exists: true}}
).count()

db.users02.find(
  {address: {$exists: false}}
)

db.users02.distinct("address")

db.users02.distinct("address").length
