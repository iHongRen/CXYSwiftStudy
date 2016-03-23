//: ## 泛型(Generics)

import UIKit

//: 泛型所解决的问题
//1.这里是一个标准的,非泛型函数 swapTwoInts ,用来交换两个Int值
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}


//swapTwoInts(_:_:) 函数可以交换 b 的原始值到 a ,也可以交换a的原始值到 b ,你可以调用这个函数交换两 个 Int 变量值
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")


//swapTwoInts(_:_:) 函数是非常有用的,但是它只能交换 Int 值,如果你想要交换两个 String 或者 Doubl e ,就不得不写更多的函数,如 swapTwoStrings 和 swapTwoDoubles(_:_:) ,如同如下所示:
func swapTwoStrings(inout a: String, inout _ b: String) {
    let temporaryA = a
    a = b
    b = temporaryA
}
func swapTwoDoubles(inout a: Double, inout _ b: Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

/*

你可能注意到 swapTwoInts 、 swapTwoStrings 和 swapTwoDoubles(_:_:) 函数功能都是相同的,唯一不同
之处就在于传入的变量类型不同,分别是 Int 、 String 和 Double 。 但实际应用中通常需要一个用处更强大并且尽可能的考虑到更多的灵活性单个函数,可以用来交换两个任何类型
值,很幸运的是,泛型代码帮你解决了这种问题。(一个这种泛型函数后面已经定义好了。)

*/



//: 泛型函数
//2.泛型函数可以工作于任何类型,这里是一个上面 swapTwoInts(_:_:) 函数的泛型版本,用于交换两值:
func swapTwoValues<T>(inout a: T, inout _ b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//这个函数的泛型版本使用了占位类型名字(通常此情况下用字母 T 来表示)来代替实际类型名(如 ￼ 、或 ￼ )。占位类型名没有提示 必须是什么类型,但是它提示了 a 和 ￼ b 必须是同一类型 ￼T ,而不管表示什么类型。只有 swapTwoValues(_:,_:) 函数在每次调用时所传入的实际类型才能决定 ￼T 所代表的类型。



//: 泛型类型
//3.这里展示了如何写一个非泛型版本的栈, Int 值型的栈
struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//这里是一个相同代码的泛型版本:
struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}

//比如,要创建一个 string s 的栈,你可以写成 Stack<String>() :
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// 现在栈已经有4个string了

//从栈中 pop 并移除值"cuatro":
let fromTheTop = stackOfStrings.pop()
// fromTheTop 等于 "cuatro", 现在栈中还有3个string



//: 扩展一个泛型类型
//4.下面的例子扩展了泛型 Stack 类型,为其添加了一个名为 topItem 的只读计算属性,它将会返回当前栈顶端的元 素而不会将其从栈中移除。
extension Stack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
// 输出 "The top item on the stack is tres."



//: 类型约束语法
//5.可以写一个在一个类型参数名后面的类型约束,通过冒号分割,来作为类型参数链的一部分。这种作用于泛型函数的类型约束的基础语法如下所示(和泛型类型的语法相同):
class SomeClass {
    // 类的内容
}

protocol SomeProtocol {
    // 协议内容
}

func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // 这里是函数主体
}

//上面这个假定函数有两个类型参数。第一个类型参数 T ,有一个需要 T 必须是 SomeClass 子类的类型约 束;第二个类型参数 U ,有一个需要 U 必须遵循 SomeProtocol 协议的类型约束。


//: 类型约束行为
//6.这里有个名为 findStringIndex 的非泛型函数,该函数功能是去查找包含一给定 String 值的数组:
func findStringIndex(array: [String], _ valueToFind: String) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
    print("The index of llama is \(foundIndex)")
}
// 输出 "The index of llama is 2"

//这里展示如何写一个你或许期望的 findStringIndex 的泛型版本 findIndex:
func findIndex<T>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        /*
        if value == valueToFind { //不能通过编译,见下面解释
        return index
        }
        */
    }
    return nil
}
//注意：上面所写的函数不会编译。这个问题的位置在等式的检查上, “if value == valueToFind” 。不是所有的 Swift 中的类型都可以用等式符(==)进行比较。

//Swift 标准库中定义了一个 Equatable 协议,该协议要求任何遵循的Equatable 类型实现等式符(==)和不等符(!=)对任何两个该类型进行比较。所有的 Swift 标准类型自动支持 Equatable 协议。

//可以写一个 Equatable 类型约束作为类型参数定义的一部分:
func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
// doubleIndex is an optional Int with no value, because 9.3 is not in the array
let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")
// stringIndex is an optional Int containing a value of 2




//: 关联类型(Associated Types)
//7.这里是一个 Container 协议的例子,定义了一个 ItemType 关联类型:
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}
//￼Container 协议需要指定任何通过 append(_:)￼ 方法添加到容器里的值和容器里元素是相同类型,并且通过 容器下标返回的容器元素类型的值的类型是相同类型,为了达到此目的, Container 协议声明了一个 ItemType 的关联类型,写作 typealias ItemType 。


//这里是一个早前 IntStack 类型的非泛型版本,遵循 Container 协议:
struct IntStack1: Container {
    // IntStack的原始实现
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // 遵循Container协议的实现
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


//可以生成遵循 Container 协议的泛型 Stack 类型:
struct Stack1<T>: Container {
    // original Stack<T> implementation
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(item: T) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}
//这时，占位类型参数T被用作append(_:)方法的item参数和下标的返回类型。Swift 因此可以推断出被用作这个特定容器的ItemType的T的适合类型。


//: Where 语句
//8.下面的例子定义了一个名为 allItemsMatch￼ 的泛型函数,用来检查两个 Container 实例是否包含相同顺序的相同元素:
extension Array: Container {}

func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable> (
    someContainer: C1, anotherContainer: C2) -> Bool {
        // 检查两个Container的元素个数是否相同
        if someContainer.count != anotherContainer.count {
            return false
        }
        // 检查两个Container相应位置的元素彼此是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        // 如果所有元素检查都相同则返回true
        return true
}


//这里演示了 allItemsMatch(_:_:) 函数运算的过程:
var stackOfStrings1 = Stack1<String>()
stackOfStrings1.push("uno")
stackOfStrings1.push("dos")
stackOfStrings1.push("tres")
var arrayOfStrings = ["uno", "dos", "tres"]
if allItemsMatch(stackOfStrings1, anotherContainer: arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
// 输出 "All items match."

//即便栈和数组是不同的类型,但它们都遵循 Container 协 议,而且它们都包含同样的类型值。因此你可以调用 allItemsMatch(_:_:) 函数,用这两个容器作为它的参数。



