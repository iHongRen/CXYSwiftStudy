//: 模式(Patterns)
//模式(pattern)代表了单个值或者复合值的结构。

import Foundation

//swift语言中模式有2个基本的分类:一类能成功和任何值的类型相匹配,另一类在运行(runtime)和某特定值匹配时可能会失败。

//第一类模式用于解构简单变量,常量和可选绑定中的值。
/*
通配符模式
标识符模式 
值绑定模式
元祖模式
*/


//第二类模式用于全模式匹配,这种情况下你用来相比较的值在运行时可能还不存在。
/*
枚举用例模式
可选模式
表达式模式
类型转换模式
*/



//: 1.通配符模式(Wildcard Pattern)
//通配符模式由一个下划线(_)构成,且匹配并忽略任何值。
for _ in 1...3 {
    // Do something three times.
}



//: 2.标识符模式(Identifier Pattern)
//标识符模式匹配任何值,并将匹配的值和一个变量或常量绑定起来。
let someValue = 42    //someValue 是一个标识符模式

switch 5 {
case 5: print("5")
}


//: 3.值绑定模式(Value-Binding Pattern)
//值绑定模式把匹配到的值绑定给一个变量或常量名。
switch (4, 5) {
case let (x, y): print("\(x) \(y)")
}



//: 4.元组模式(Tuple Pattern)
//元组模式匹配相应元组类型的值。
let points = [(0, 0), (1, 0), (1, 1)]
for (x, y) in points {
    /* ... */
}


let age = 23
let job: String? = "Operator"
let payload: AnyObject = NSDictionary()

switch (age, job, payload) {
case (let age, _?, _ as NSDictionary) where age < 30:
    print(age)
default: ()
}




//: 5.枚举用例模式(Enumeration Case Pattern)
//一个枚举用例模式匹配现有的某个枚举类型的某个用例(case)。
enum Shape {
    case Rectangle(w: Int,h:Int)
    case Round(r: Int)
}
var round = Shape.Round(r: 5)

switch round {
case let .Round(r):
    print("r=\(r)")
case let .Rectangle(w, h):
    print("w=\(w),h=\(h)")
}


//: 6.可选模式(Optional Pattern)
//可选模式与封装在一个 Optional(T) 或者一个 ExplicitlyUnwrappedOptional(T) 枚举中的 Some(T) 用例相匹配。
let someOptional: Int? = 42
if case let x? = someOptional {
    print(x)
}



//: 7.类型转换模式(Type-Casting Patterns)
//有两种类型转换模式,is模式和as模式。这两种模式只出现在switch语句中的case标签中。is模式和as模式有以下形式:
/*
is type
pattern as type
*/

//is模式仅当一个值的类型在运行时(runtime)和is模式右边的指定类型一致 - 或者是该类型的子类 - 的情况下,才会匹配这个值。is模式和is操作符有相似表现,它们都进行类型转换,却舍弃返回的类型。


//as模式仅当一个值的类型在运行时(runtime)和as模式右边的指定类型一致 - 或者是该类型的子类 - 的情况下,才会匹配这个值。如果匹配成功,被匹配的值的类型被转换成as模式左边指定的模式。

var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    default:
        print("something else")
    }
}


//: 8.表达式模式(Expression Pattern)
//一个表达式模式代表了一个表达式的值。表达式模式只出现在 switch 语句中的 case 标签中。
switch 5 {
case 0...10: print("In range 0-10")
default: print("Not in range 0-10")
}



