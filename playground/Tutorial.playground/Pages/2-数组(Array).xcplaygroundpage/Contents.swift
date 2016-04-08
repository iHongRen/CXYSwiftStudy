//: 数组

import Foundation

//空数组
var eArr = [Int]()
var eArr1 = Array<Int>()


//赋值
var array = Array(1...5)
eArr = [1,2,3,4]
eArr.append(5)
eArr += [6,7]


//NSArray
let cArr: NSArray = [1,2,2,4]
var dArr: NSMutableArray = [1,3,3,5]
dArr.addObject(6)


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
for (index, value) in zip(range, arr[range]) {
    
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


