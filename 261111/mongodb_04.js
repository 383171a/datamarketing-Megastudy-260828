// 특정 컬렉션 데이터 조회구문 (생략버전)
// SELECT name, address FROM users02 WHERE customer_id = 2;
db.user02.find()

//컬렉션 조회구문 (정석버전) 
// find() : 검색.조회 메서드 
// 첫번째 인자값 : 조건을 의미하는 객체 = query criteria 
// 두번째 인자값 : 출력하고자 하는 컬럼 = projection
// _id라는 컬럼이 무조건 생성되는 것까지는 이해함!
// 특정상황에서는 출력하고 싶지 않은 경우!

// SELECT name, address FROM users02 WHERE age > 18;
db.users02.find(
  {age: {$gt: 18}},
  {_id: 0, name: 1, address: 1}
)

// method chaning 기법 : 메서드들이 체인처럼 연이어 붙는다 LIMIT 2
db.users02.find(
  {age: {$gt: 18}},
  {_id: 0, name: 1, address: 1}
).limit(2)

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
*/

db.users02.find(
  {name: "DaveLee"},
  {name: 1, age: 1, address: 1, _id:0}
)

db.users02.find(
  {age: {$gt: 25}}
)

db.users02.find(
  {age: {$lt: 50, $lte: 25}}
)
// mysql ~이거나, 혹은 ~이면 다 허용
// in () WHERE age IN (45, 50)
db.users02.find(
  {age: {$in: [45, 50]}}
)

// $or : 또는 
// $eq : 같다 
db.users02.find({
      $or: [  
    {age: {$eq: 45}},
    {age: {$eq: 50}}
    ]
  }
)
// 이거 아닌거
db.users02.find(
  {age: {$ne: 25}}
)
// 잘못된 문법
db.users02.find(
  {age: {$ne: 25, $ne: 50}}
)
//이것들 중에 이거 이거 아닌거
db.users02.find(
  {age: {$nin: [25, 45]}}
)





