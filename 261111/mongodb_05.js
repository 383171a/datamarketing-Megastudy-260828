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
*/

db.users02.find(
  {address: "서울시", age: 45}
)

db.users02.find(
  {$and: [{address: "서울시"}, {age: 45}]}
)


db.users02.find(
  {$or: [{address: "서울시"}, {age: 25}]}
)

db.users02.find(
  {age: {$not: {$eq: 45}}}
)

// MySQL : 정해진 문법 내에서만 움직임 -> 암기, 응용과 활용
// Python : 문법 무궁무진, 다재다능 -> 너무 많은 아이템
// MongoDB : Shema 존재 x -> 문서의 자유로움

// 정규표현식 
// 데이터를 다루는 영역 반드시 한 번은 넘어서야하는 분야
// 복잡한 구성의 문자열 속에서 특정 패턴을 가지고 있는 문자를 추출해낼 수 있는 방법으로 최고
// 정규표현식은 반드시 대.소문자를 가려사용! 
// /문자열/ : 내부에 입력한 문자열을 찾아오는 역할
db.users02.find(
  {name: /Lee/}
)

db.users02.find(
  {name: {$regex: /Lee/}}
)
db.users02.find(
  {name: {$regex: /^Da/}}
)



