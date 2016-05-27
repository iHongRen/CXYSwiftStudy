//: filter 用于选择数组元素中满足某种条件的元素

import UIKit

//1.用Filter函数筛选出String数组中后缀是.swift的文件
let filesNeedToFilter = ["ViewController.swift","HelloWorld.c","Web.java","Person.swift","Main.c"]

//输出["ViewController.swift","Person.swift"]
let filtered = filesNeedToFilter.filter {
    $0.hasSuffix(".swift")//注意suffix是后缀的意思
}
print(filtered)


//2.选出大于30的
let moneyArray = [10,40,60]
let filetedArray = moneyArray.filter {
    $0 > 30
}
print(filetedArray)

//3.用函数实现filter 功能
func getFilesByCondition(files:[String],f:String->Bool)->[String] {
    var result = [String]()
    for file in files{
        if f(file){
            result.append(file)
        }
    }
    return result
}
//不妨来试试 采用closure的尾包形式
let filteredC = getFilesByCondition(filesNeedToFilter) {
    
    $0.hasSuffix(".c")//返回["HelloWorld.c", "Main.c"]
}

//4.自定义filter
func myFilter<T>(xs:[T],check:T->Bool)->[T] {
    var result = [T]()
    for x in xs{
        //必须经过条件判断才可以
        if check(x){
            result.append(x)
        }
    }
    return result
}

let myFiltedMoney = myFilter(moneyArray) {
    $0 > 30
}
print(myFiltedMoney)


//5.使用组合
let filetedMapArray = moneyArray.filter{$0 > 30}.map{$0+100}
print(filetedMapArray)
