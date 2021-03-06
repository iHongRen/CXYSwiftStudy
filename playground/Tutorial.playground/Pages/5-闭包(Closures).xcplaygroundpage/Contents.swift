/*: 
## 闭包（Closures）
闭包是自包含的函数代码块,可以在代码中被传递和使用。 Swift 中的闭包与 C 和 Objective-C 中的代码块(blocks)以及其他一些编程语言中的 lambdas 函数比较相似。
 
闭包可以捕获和存储其所在上下文中任意常量和变量的引用。这就是所谓的闭合并包裹着这些常量和变量,俗称闭包。Swift 会为您管理在捕获过程中涉及到的所有内存操作。

全局和嵌套函数实际上也是特殊的闭包,闭包采取如下三种形式之一:
* 全局函数是一个有名字但不会捕获任何值的闭包
* 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
* 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包

Swift 的闭包表达式拥有简洁的风格,并鼓励在常见场景中进行语法优化,主要优化如下:
* 利用上下文推断参数和返回值类型
* 隐式返回单表达式闭包,即单表达式闭包可以省略 return 关键字 • 参数名称缩写
* 尾随(Trailing)闭包语法 
*/

import Foundation
//: **闭包表达式(Closure Expressions)**
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed = names.sorted(by: backwards)

//内联闭包表达式中,函数和返回值类型都写在大括号内,而不是大括号外。闭包的函数体部分由关键字 in 引入。 该关键字表示闭包的参数和返回值类型定义已经完成,闭包函数体即将开始。

reversed = names.sorted(by: {(s1: String, s2: String)-> Bool in return s1 > s2})

//根据上下文推断类型(Inferring Type From Context)
// sorted 期望参数是类型为 (String, String) -> Bool 的函数,因此实际上 String , String 和 Bool 类型并不需要作为闭包表达式定义中的一部分。 因为所有的类型都可以被正确推断,返回箭头 ( -> ) 和围绕在参数周围的括号也可以 被省略:
reversed = names.sorted(by: {s1,s2 in return s1 > s2})

//实际上任何情况下,通过内联闭包表达式构造的闭包作为参数传递给函数时,都可以推断出闭包的参数和返回值类型,这意味着您几乎不需要利用完整格式构造任何内联闭包。


//单表达式闭包隐式返回(Implicit Return From Single-Expression Clossures)
//**单行**表达式闭包可以通过隐藏 return 关键字来隐式返回单行表达式的结果
reversed = names.sorted(by: {s1,s2 in s1 > s2})


//参数名称缩写(Shorthand Argument Names)
//Swift 自动为内联函数提供了参数名称缩写功能,您可以直接通过 $0 , $1 , $2 来顺序调用闭包的参数。 in 关键字也同样可以被省略,因为此时闭包表达式完全由闭包函数体构成:
reversed = names.sorted(by: {$0 > $1})


//运算符函数(Operator Functions)  ---- 运算符也是一种函数
// Swift 的 String 类型定义了关于大于号 ( > ) 的 字符串实现,其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。 而这正好与 sort(_:) 方法的 第二个参数需要的函数类型相符合。 因此,您可以简单地传递一个大于号,Swift可以自动推断出您想使用大于号 的字符串函数实现:
reversed = names.sorted(by: >)




//: 尾随闭包(Trailing Closures)
//如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数,可以使用尾随闭包来增强函数的可读性。 尾随闭包是一个书写在函数括号之后的闭包表达式,函数支持将其作为最后一个参数调用。

func trailingClosure(_ closure: () -> Void) {
    // 函数体部分
}

// 以下是不使用尾随闭包进行函数调用 
trailingClosure({
// 闭包主体部分 
})

// 以下是使用尾随闭包进行函数调用
trailingClosure() {
// 闭包主体部分
}

//当函数只有一个闭包参数，可以省去()
trailingClosure {
    // 闭包主体部分
}


/*: 
**捕获值(Capturing Values)**
 
闭包可以在其定义的上下文中捕获常量或变量。即使定义这些常量和变量的原域已经不存在,闭包仍然可以在闭 包函数体内引用和修改这些值。
 
Swift最简单的闭包形式是嵌套函数,也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所 有的参数以及定义的常量和变量。
*/
func makeIncrementor(forIncrement amount: Int)->(()->Int) {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)
incrementByTen() // 返回的值为10 
incrementByTen() // 返回的值为20 
incrementByTen() // 返回的值为30



//: 闭包是引用类型(Closures Are Reference Types)
//无论您将函数/闭包赋值给一个常量还是变量,您实际上都是将常量/变量的值设置为对应函数/闭包的引用。 上面 的例子中, incrementByTen 指向闭包的引用是一个常量,而并非闭包内容本身。
//这也意味着如果您将闭包赋值给了两个不同的常量/变量,两个值都会指向同一个闭包:

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen() // 返回的值为40


//: 逃逸闭包(Escaping Closures)
//当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。@escaping。

//一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

//将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self 。
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 } //需要显式调用
        someFunctionWithNonescapingClosure { x = 200 }
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)
// 打印出 "200"
completionHandlers.first?()
print(instance.x)
// 打印出 "100"

//: 自动闭包(Autoclosures)
//自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
//自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// 打印出 "5"
let customerProvider = {
    customersInLine.remove(at: 0)
}
print(customersInLine.count)
// 打印出 "5"
print("Now serving \(customerProvider())!") // Prints "Now serving Chris!" print(customersInLine.count)
// 打印出 "4"

//将闭包作为参数传递给函数时，你能获得同样的延时求值行为。
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } ) // 打印出 "Now serving Alex!"

//下面这个版本的 serve(customer:) 完成了相同的操作，不过它并没有接受一个显式的闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭包。
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve1(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve1(customer: customersInLine.remove(at: 0)) // 打印出 "Now serving Ewa!"

//如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。

//@autoclosure 能够把表达式自动的封装成闭包，要注意的是@autoclosure只能用在（）->T这样无参数的闭包中。

func logIfTrue(predicate: () -> Bool) {
    if predicate() {
        print("true")
    }
}

logIfTrue{2 > 1}

//在参数名前加上@autoclosure
func logIfTure1( predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("ture")
    }
}

logIfTure1(predicate: 2 > 1)

//swift将会把 2 > 1 这个表达式自动转换为 () -> Bool。






