//: 数组

import Foundation

//空数组
var eArr = [Int]()
var eArr1 = Array<Int>()


//赋值
eArr = [1,2,3,4]
eArr.append(5)
eArr += [6,7]


//NSArray
let cArr: NSArray = [1,2,2,4]
var dArr: NSMutableArray = [1,3,3,5]
dArr.addObject(6)


//: 遍历数组
let arr = [10,20,30,40]

//1. for-condition-increment(条件递增)
for var i = 0; i < arr.count; ++i {
    print("for-increment:  \(arr[i])")
}

//2. for-in
for a in arr {
    print("for-in 1: \(a)")
}

for i in 0..<arr.count {
    print("for-in 2: \(arr[i])")
}

//3.forEach
arr.forEach {
    print("forEach: \($0)")
}

let range = 0..<arr.count
zip(range, arr[range]).forEach {
    (index, value) -> () in
    print("zip \(value)")
}

//4. map
arr.map {
    print("map: \($0)")
}

//5.enumerate
let nsArr: NSArray = ["a","b","c","d"]
nsArr.enumerateObjectsUsingBlock { (obj, index, stop) -> Void in
    print("enumerate :\(obj)")
}
