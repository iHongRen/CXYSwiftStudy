//: 数组(Array)

import Foundation

//空数组
var eArr = [Int]()
var eArr1 = Array<Int>()


//赋值
var array = Array(1...5)
eArr = []
eArr = [1,2,3,4]
eArr.append(5)
eArr += [6,7]

//访问
let e = eArr[1]


//NSArray
let cArr: NSArray = [1,2,2,4]
var dArr: NSMutableArray = [1,3,3,5]
dArr.addObject(6)


//判空
if array.isEmpty {
    
}

if array.count == 0 {
    
}

//: 遍历数组
let arr = [10,20,30,40,50,60]

//1. for-in
for a in arr {
    print("for-in 1: \(a)")
}

for i in 0..<arr.count {
    print("for-in 2: \(arr[i])")
}

//2.forEach
arr.forEach {
    print("forEach: \($0)")
}

let range = 0..<arr.count
zip(range, arr[range]).forEach {
    (index, value) -> () in
    print("zip \(value)")
}

//3. map
arr.map {
    print("map: \($0)")
}

//4.enumerate
let nsArr: NSArray = ["a","b","c","d"]

var str = ""
for (index,value) in nsArr.enumerate() {
    let v = value as! String
    str += v
    if v == "c" {
        break
    }
}
print("str = \(str)")


str = ""
nsArr.enumerateObjectsUsingBlock { (obj, index, stop) -> Void in
    print("enumerate :\((obj, index, stop.memory))")
    let v = obj as! String
    str += v
    if v == "c" {
        stop.memory = true
    }
}
print("str = \(str)")


//循环
for i in 0.stride(to: 10, by: 2) {
    print(i)
}

for i in 10.stride (through: 0, by: -1) {
    print(i)
}

for i in (0...10).reverse() {
    print(i)
}

//5.从非零下标开始遍历
(3..<arr.count).forEach {
    print("forEach: \($0)")
}


for index in 3..<arr.count {
   print(arr[index])
}



for (index, value) in arr[3..<arr.count].enumerate() {
    
}



let range1 = 3..<arr.count
for (index, value) in zip(range1, arr[range1]) {
    
}



let range2 = 3..<arr.count
zip(range2, arr[range2]).forEach {
    index, value in
    
}



let results = arr[range2].map{
    print("\($0)")
}



for value in arr.dropFirst(3) {
    
}

//删除
array.removeFirst()
array.removeLast()
array.removeAtIndex(1)
array.removeAll()



//: 字典(Dictionary)
//字典的 Key 类型必须遵循 Hashable 协议

//空字典
var dict = [String : Int]()
var dict1 = Dictionary<String,Int>()

//赋值
dict = ["age" : 25]
dict = [:] //赋值为空字典
dict["num"] = 1234

//访问
let value = dict["age"]

//字典合并
//方法1：自定义+=运算符
func +=<K, V> (inout left: [K : V], right: [K : V]) {
    for (k, v) in right {
        left[k] = v
    }
}
dict += ["err":404]


//方法2：字典扩展
extension Dictionary {
    mutating func addDictionary(other:Dictionary) {
        for (key,value) in other {
            self[key] = value
        }
    }
}

dict.addDictionary(["id":123])


//方法3：转化为NSMutableDictionary
var mDict = NSMutableDictionary(dictionary: dict)
mDict.addEntriesFromDictionary(["code" : 89757])
dict = mDict as NSDictionary as! Dictionary


//判空
if dict.isEmpty {
    
}

if dict.count == 0 {
    
}

//字典遍历
for (key, value) in dict {
    print("k:\(key), v:\(value)")
}


for key in dict.keys {
    print(key)
}

for value in dict.values {
    print(value)
}


//删除
dict.removeValueForKey("code")
dict.removeAll()






