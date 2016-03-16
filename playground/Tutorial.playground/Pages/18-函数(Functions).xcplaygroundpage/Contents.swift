//: # 函数
//: 函数是用来完成特定任务的独立的代码块。

import Foundation

//1. 定义与声明
func functionName(param: String) -> String {
    return "hello," + param
}

//调用
functionName("Swift")


//2. 函数参数名称
//函数参数都有一个外部参数名(external parameter name)和一个本地参数名(local parameter name).
//外部参数名: 参数说明, 使得函数体内部可读,能表达出函数的明确意图.
//本地参数名: 真实的参数

func setSize(width w: Int, height h: Int) {
    
}
setSize(width: 1, height: 2)


//第一个外部参数名可忽略， 后续的参数设置参数名,可用一个下划线(_)代替一个明确地参数名.
func setSize1(width: Int, _ height: Int) {
    
}
setSize1(1, 2)

//如果不写外部参数， 默认内部参数 = 外部参数
func setSize2(width: Int, height: Int) {
    
}
setSize2(1, height: 2)


//3.默认参数值(Default Parameter Values)
//ps: 默认参数虚放在参数列表最后
func defaultParams(word : String, symbol: String = "?") -> String {
    return word + " " + symbol
}

defaultParams("hello， my name is swift")
defaultParams("hello， my name is swift", symbol: "。")


//4.可变参数(Variadic Parameters)
//通过在变量类型名后面加入 (...) 的方式来定义可变参数 , 此时这个参数是一个数组
func getSum(myNum: Int = 1, numbers :Int...) -> Int {
    var sum = myNum
    for number in numbers {
        sum += number
    }
    return sum
}
getSum(numbers: 10,20,30,40)
getSum(2,numbers: 10,20,30,40)

//如果函数有一个或多个带默认值的参数,而且还有一个可变参数,那么把可变参数放在参数表的最后。



//5.常量参数和变量参数(Constant and Variable Parameters)
//函数参数默认是常量。
//通过在参数名前加关键字 var 来定义变量参数:

func myWord(var word: String) -> String {
    word = word + "。"
    return word
}
myWord("hi")
//注意: 对变量参数所进行的修改在函数调用结束后便消失了,并且对于函数体外是不可见的。变量参数仅仅存 在于函数调用的生命周期中。



//6.输入输出参数(In-Out Parameters)
//变量参数,仅仅能在函数体内被更改。如果你想要一个函数可以修改参数的值,并且想要在这些修改在函数调用结束后仍然存在,那么就应该把这个参数定义为输入输出参数(In-Out Parameters)。
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
//someInt = 107,  anotherInt = 3

//你只能将变量作为输入输出参数。你不能传入常量或者字面量(literal value),因为这些量是不能被修改的。当传入的参数作为输入输出参数时,需要在参数前加 & 符,表示这个值可以被函数修改。




//: 函数类型(Function Types)

//1.函数类型: 由函数的参数类型和返回类型组成。
func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}
//上面函数的类型为 (Int, Int) -> Int

func printHelloWorld() {
    print("hello, world")
}
//上面函数的类型为 () -> void


//2.使用函数类型(Using Function Types)
//使用函数类型就像使用其他类型一样
var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(2, 3))")

//可以类型推断
let anotherMathFunction = addTwoInts


//3.函数类型作为参数类型(Function Types as Parameter Types)
func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)


//4.函数类型作为返回类型(Function Type as Return Types)
func stepAdd(input: Int) -> Int {
    return input + 1
}
func stepSub(input: Int) -> Int {
    return input - 1
}

func chooseStep(step: Bool) -> ((Int) -> Int) {
    return step ? stepAdd : stepSub
}

let myStep = chooseStep(true)
let step = myStep(2)



//5.嵌套函数(Nested Functions)
//把函数定义在别的函数体中,称作嵌套函数(nested functions)。
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()






