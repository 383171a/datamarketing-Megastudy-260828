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
$all : 배열 형태의 자료구조 속에서 특정 조건에 모두 충족되는 값을 찾을 때 
$set : update 기능을 사용할 때, 특정 값을 세팅하도록 해주는 연산자
$inc : 특정 숫자 값을 증가 및 감소시킬 때
$unset : 특정 필드를 제거할 때 
$push : 특정 문서 내 값이 배열인 경우, 해당 배열 내 값을 추가
$pull : $push와 반대 개념, 배열 내 값 제거 
*/

use megastudy_261111

db.users02.find()

db.users02.insertMany([
  {name: "유진", age: 25, hobbies: ["독서", "영화", "요리"]},
  {name: "동현", age: 30, hobbies: ["축구", "음악", "영화"]},
  {name: "혜진", age: 35, hobbies: ["요리", "여행", "독서"]}
])

db.users02.find()

db.users02.find({hobbies: {$all: ["축구", "음악"]}})

db.users02.find(
  {hobbies: {$in: ["축구", "요리"]}}
)

db.users02.find(
  {hobbies: {$nin: ["축구", "요리"]}}
)

// 지금까지의 내용은 CRUD : C + R

db.users02.find()

db.users02.updateMany(
  {age: {$gt: 25}},
  {$set:{address: "서울시"}}
)
// $로 시작하는 연산자의 위치, 순서 어떤 법칙으로 입력되는지?

db.users02.find({address: "서울시"})

db.users02.updateMany(
  {address: "서울시"},
  {$inc: {age: 3}}
)

db.users02.updateMany(
  {address: "서울시"},
  {$inc: {age: -3}}
)


// $add : 지금 단계에서 사용하지 않음
// mongodb 기본문법 // aggregation framework 문법
// .js = javascript 프로그래밍 언어 
// 최초에 언어 탄생한 이후 매체가 발달되며 사용자의 의식이 변화
// 과거에는 사용자들이 웹사이트 방문해서 롤링되는 배너 수동 조회
// 현재는 해당 배너에 마우스를 오버, 클릭 -> 팝업. 모달 오픈 
// 기존 언어 체계 유지 + 새로운 기능 업데이트 -> 라이브러리
// 기존 언어 체계 참조 + 새로운 신규 문법 도입 -> 프레임워크  

db.users02.updateMany(
  {age: {$gt: 40}},
  {$set: {address: "수원시"}}
)

db.users02.updateOne(
  {name: "유진"},
  {$set: {age: 26}}
)

db.users02.find()

db.users02.updateOne(
  {name: "동현"},
  {$set: {name: "동현2세", age: 31, hobbies: ["축구", "야구", "농구"]}}
)

db.users02.updateOne(
  {name: "유진"},
  {$set: {age: 26}}
)

// 1, 0 숫자 자주 나온다
// mongodb => binary + json 문서구조를 반영한 DBMS
// 참 : 1, 거짓 : 0 

// matched, modified, upsert 
// 존재하지 않는 값을 수정해라!
// insert + update = upsert

db.users02.updateOne(
  {name: "민준"},
  {$set: {name: "민준", age: 22, hobbies: ["음악", "여행"]}},
  {upsert: true}
)

db.users02.updateOne(
  {name: "유진"},
  {$push: {hobbies: "요가"}}
)

db.users02.find({name: "유진"})

db.users02.updateOne(
  {name: "유진"},
  {$pull: {hobbies: "야구"}}
)

db.users02.find()

// db, collection : C
// collection : R
// collection : U (이름, 값 전체/일부 수정)
// collection : D

//insert, update, delete

db.users02.deleteMany(
  {address: "서울시"}
)

db.users02.find(
  {},
  {}
)
// 전체 데이터 지우기
db.users02.deleteMany({})




