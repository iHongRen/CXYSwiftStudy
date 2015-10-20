//: ## Map

import UIKit


let arr = [1,2,3]

//1.转字符串1
let str1 = arr.map{String($0)}
print(str1)


//2.转字符串2
let str2 = arr.map{"\($0)"}
print(str2)


//3.2倍
let doubled = arr.map{
    $0 * 2
}
print(doubled)


//4.字典map，返回数组
let dict = ["key1": "value1","key2": "value2"]
print(dict)
let ret = dict.map({(key,value) in (key,value.uppercaseString)})
print(ret)


//5.用一个Int类型数组存储商品金额，想把每个金额后面添加一个字符“￥”，把数组转成字符串数组。如：[10,20,30,40] -> ["10￥","20￥","30￥","40￥"]
let moneyArray = [10,20,30,40]
let stringsArray = moneyArray.map{
    "\($0)￥"
}
print(stringsArray)

let digitNames = [
                  0: "Zero",1: "One", 2: "Two",3: "Three", 4: "Four",
                  5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
                 ]
let numbers = [16, 58, 510]

let strings = numbers.map{
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}
print(strings)


//6.函数对一个Int类型数组的元素进行2倍放大
func doubleArrayByTwo(xs:[Int])->[Int]{
    var result = [Int]()
    
    for x in xs{
        result.append(x * 2)
    }
    return result
}

let doubleArray = doubleArrayByTwo(arr)
print(doubleArray)



//7.函数对一个Int类型数组的元素进行f变换
func handleIntArray(xs:[Int],f:Int->Int)->[Int]{
    var result = [Int]()
    
    for x in xs {
        result.append(f(x))
    }
    
    return result
}

// y = x*2 + 3
func handleClosure(x:Int)->Int{
    return 2 * x + 3
}

let handledArray0 = handleIntArray(arr,f: handleClosure)
print(handledArray0)

// y = x*3 + 4 , 简化闭包写法
let handledArray1 = handleIntArray(arr){
    $0*3 + 4
}
print(handledArray1)


//8.bool
func handleBoolArray(xs:[Int],f:Int->Bool)->[Bool]{
    var result = [Bool]()
    for x in xs {
        result.append(f(x))
    }
    return result
}

//9.泛型
func genericComputeArray<U>(xs:[Int],f:Int->U)->[U]{
    var result = [U]()
    for x in xs {
        result.append(f(x))
    }
    return result
}

//10.自定义map
func myMap<T,U>(xs:[T],f:T->U)->[U]{
    var result = [U]()
    for x in xs{
        result.append(f(x))
    }
    return result
}
let myArr = myMap([1,2,3]){
    $0*2
}
print(myArr)
//输出 [2,4,6]


//11.optional map
let num1: Int? = 3
var result1: Int?
if let realNum = num1 {
    result1 = realNum * 2
} else {
    result1 = nil
}

let num2: Int? = 3
let result2 = num2.map{
    $0 * 2
}
// result2 为 {Some 6}
