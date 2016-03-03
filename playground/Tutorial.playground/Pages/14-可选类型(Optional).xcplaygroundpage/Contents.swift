//: Optional（可选类型）

import Foundation
import UIKit

//声明方式
var opt1: Optional<Int> //显式声明
var opt2: Int?          //与opt1 等价, 语法糖

var opt3: ImplicitlyUnwrappedOptional<Int> //隐式声明,自动解包
var opt4: Int!        //与opt3 等价

//解包方法
let op = Optional.Some(5) //直接赋值
let op1 = Optional(5) //构造方法
let opt: Int? = 5   //与上面等价

//1.强制解包
if opt != nil {
    print("1.强制解包 \(opt!)")
}

//2.可选绑定(if-let)
if let _opt = opt {    //先解包，后赋值. _opt作用域仅在if中
    print("2.可选绑定 \(_opt)")
}

func testGuard() {
    guard let _opt = opt else {
        return
    }
    print("2.guard-let.可选绑定 \(_opt)")  //_opt作用域在testGuard中
}
testGuard()

//3.??运算符解包
let _opt = opt ?? 1
print("3. ??解包 \(_opt)")

//4.enum匹配解包
if case .Some(let __opt) = opt {
    print("4.enum匹配 \(__opt)")
}

//5.可选模式匹配
if case let x? = opt {
    print("5.可选模式匹配 \(x)")
}


//6.map/flatmap方法
opt.map {
    print("6.map方法 \($0)")
}

opt.flatMap {
    print("6.flatmap方法 \($0)")
}


