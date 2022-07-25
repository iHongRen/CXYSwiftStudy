//: 数组(Array)

import Foundation

//空数组
var eArr = [Int]()
var eArr1 = Array<Int>()
var eArr2: [Int] = []


//赋值
var array = Array(1...5)
eArr = []
eArr = [1,2,3,4]
eArr += [6,7]

eArr.append(5)
eArr.insert(8, at: 0)
let ret = eArr.remove(at: 2)

//访问
let e = eArr[1]


//NSArray
let cArr: NSArray = [1,2,2,4]
var dArr: NSMutableArray = [1,3,3,5]

dArr.add(6)
dArr.insert(8, at: 0)
dArr.remove(3)


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
for (_,value) in nsArr.enumerated() {
    let v = value as! String
    str += v
    if v == "c" {
        break
    }
}
print("str = \(str)")


str = ""
nsArr.enumerateObjects({ (obj, index, stop) -> Void in
    print("enumerate :\((obj, index, stop.pointee))")
    let v = obj as! String
    str += v
    if v == "c" {
        stop.pointee = true
    }
})
print("str = \(str)")


//循环
print("从0开始每次加2输出")
for i in stride(from:0, to: 10, by: 2) {
    print(i)
}

print("从10开始，每次减1输出")
for i in stride(from:10, through: 0, by: -1) {
    print(i)
}

print("逆序输出")
for i in (0...10).reversed() {
    print(i)
}

//5.从非零下标开始遍历
(3..<arr.count).forEach {
    print("forEach: \($0)")
}


for index in 3..<arr.count {
   print(arr[index])
}



for (_, _) in arr[3..<arr.count].enumerated() {
    
}



let range1 = 3..<arr.count
for (_, _) in zip(range1, arr[range1]) {
    
}



let range2 = 3..<arr.count
zip(range2, arr[range2]).forEach {
    index, value in
    
}



let results: [()] = arr[range2].map{
    print("\($0)")
}



for _ in arr.dropFirst(3) {
    
}

//删除
array.removeFirst()
array.removeLast()
array.remove(at: 1)
array.removeAll()



//: 字典(Dictionary)
//字典的 Key 类型必须遵循 Hashable 协议

//空字典
var dict = [String : Int]()
var dict1 = Dictionary<String,Int>()
var dict2: [String: Int] = [:]

//赋值
dict = ["age" : 25, "num": 123]
dict = [:] //赋值为空字典
dict["num"] = 1234

//访问
let value = dict["age"]

//字典合并
//方法1：自定义+=运算符
func +=<K, V> ( left: inout [K : V], right: [K : V]) {
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

dict.addDictionary(other: ["id":123])


//方法3：转化为NSMutableDictionary
var mDict = NSMutableDictionary(dictionary: dict)
mDict.addEntries(from: ["code" : 89757])
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
dict["id"] = nil
dict.removeValue(forKey: "code")
dict.removeAll()



//: 集合(Set)

//元素类型必须遵循 Hashable 协议

//1.空集合，没有简化形式
var aSet = Set<Int>()


//2.用数组字面量创建集合
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

//3.方法
if favoriteGenres.isEmpty {
    print("空集合")
} else {
    print("不是空集合")
}

if favoriteGenres.contains("Rock") {
    print("包含Rock")
} else {
    print("不包含Rock")
}

favoriteGenres.insert("cxy")
favoriteGenres.remove("Rock")

//4.遍历
for item in favoriteGenres {
    print(item)
}

// Set类型是无序的，可以使用 sorted() 方法，返回有序数组后遍历
for item in favoriteGenres.sorted() {
    print(item)
}

//5.操作
let ASet: Set = [1,2,3,4,5]
let BSet: Set = [3,4,5,6,7]

//交集
ASet.intersection(BSet)

//并集
ASet.union(BSet)

//对称差集
ASet.symmetricDifference(BSet)

//A差B
ASet.subtracting(BSet)


//6.关系
//相等
ASet == BSet

//子集
ASet.isSubset(of: BSet)

//严格的子集，子集且A不等于B
ASet.isStrictSubset(of: BSet)

//超集
ASet.isSuperset(of: BSet)

//严格的超集，超集且A不等于B
ASet.isStrictSuperset(of: BSet)

//是否没有交集
ASet.isDisjoint(with: BSet)


