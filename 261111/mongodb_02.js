/*
db > collection > 입력자료형
> mysql schema : int, varchar, string, boolean, float, date
> mongodb : integer, string, boolean, double, arrays, object, null, objectId, date
*/

db.createCollection("users", {
    capped: true, size: 5242880, max: 5000}
    )
    
show collections

// table > schema > int 
// insert into (collumn name) (value)
// db > collection > document (일정한 규칙을 갖고 있지 않아도 됨, 단 객체형태 유지)

db.users.insertOne(
    {subject: "coding", author: "david", views: 50}
)

db.users.find()

db.users.insertMany(
    [
        {subject: "coffee", author: "xyz", views: 50},
        {subject: "coffee shopping", author: "xyz", views: 5},
        {subject: "baking a cake", author: "xyz", views: 90},
        {subject: "baking", author: "xyz", views: 100},
        {subject: "cafe con leche", author: "xyz", views: 200},
        {subject: "coffee and cream", author: "xyz", views: 80},
        {subject: "cafe con leche", author: "xyz", views: 10},
        {subject: "coffees", author: "xyz", views: 10},
        {subject: "coffee1", author: "xyz", views: 10}
    ]    
)


db.createCollection("users02", {
    capped: true, size: 5242880, max: 5000}
    )
    
db.users02.insertMany(
    [
        {name: "David", age: 45, address: "서울시"},
        {name: "DaveLee", age: 25, address: "경기도"},
        {name: "Andy", age: 50, hobby: "골프", address: "경기도"},
        {name: "Kate", age: 35, address: "수원시"},
        {name: "Brown", age: 8}
        
    ]
)

db.users02.find()

