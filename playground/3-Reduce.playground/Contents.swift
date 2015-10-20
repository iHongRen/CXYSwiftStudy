//: reduce方法把数组元素组合计算为一个值。

import UIKit



//1.求和,乘积
let sumArray = [1,2,3,4]
let sum = sumArray.reduce(0, combine: +)
let multiply = sumArray.reduce(1, combine: *)


//2.用函数实现 +
func sum(xs:[Int])->Int {
    var result:Int = 0
    for x in xs{
        result += x
    }
    return result
}
let sum1 = sum(sumArray)//print 10



//3.自定义reduce
let newArray = ["hello","world","say","By","optional"]

func myReduce<T,U>(arr:[T],initialValue:U,combine:(U,T)->U)->U {
    var result = initialValue //赋值初始值 类型为U 并且是作为结果值返回的
    for elem in arr{
        result = combine(result,elem)   //注意右侧是传入的闭包 该闭包类型为(U,T)->U,即把上一次的结果值依次和数组元素做拼接处理，该处理可在闭包中实现，取决于你
    }
    return result
}
let s = myReduce(newArray, initialValue: "整合后的字符串为："){
    result , x in //注意result ,x 于combine(result,elem)相对应
    return result + "-" + x //注意这里return 其实是可以省略的！
}


//4.对sum函数进行改写，使用前面自定义的myReduce函数封装
func sumUsingReduce(xs:[Int])->Int {
    return myReduce(xs,initialValue: 0,combine: +)
}


//5.用reduce来改写map函数
func mapUsingReduce<T,U>(xs:[T],f:T->U)->[U] {
    return xs.reduce([]){result,x in result + [f(x)]}//使用了系统API 尝试用自定义的
}


//6.用myReduce来改写map函数
func mapUsingMyReduce<T,U>(xs:[T],f:T->U)->[U] {
    return myReduce(xs, initialValue: []) {
        result , x in
        result + [f(x)]
    }
}
let testMap = mapUsingMyReduce(sumArray){
    $0 * 2
}


//7.用reduce来改写filter函数
func filterUsingReduce<T>(xs:[T],check:T->Bool)->[T] {
    return xs.reduce([]){
        result,x in
        return check(x) ? result + [x] : result //使用了系统API 尝试用自定义的
    }
}


//8.用myReduce来改写filter函数
func filterUsingMyReduce<T>(xs:[T],check:T->Bool)->[T] {
    return myReduce(xs, initialValue: []) {
        result,x in
        return check(x) ? result + [x] : result
    }
}
let testFilter = filterUsingMyReduce(sumArray) {
    $0 > 1
}


