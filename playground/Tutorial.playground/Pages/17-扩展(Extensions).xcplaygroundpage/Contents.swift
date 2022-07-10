//: # 扩展(Extensions)
//: 扩展就是向一个已有的类、结构体、枚举类型或协议类型添加新功能。但是不能重写已有的功能。
import UIKit

/*
Swift 中的扩展可以:
• 添加计算型属性和计算型静态属性
• 定义实例方法和类型方法
• 提供新的构造器
• 定义下标
• 定义和使用新的嵌套类型
• 使一个已有类型符合某个协议
*/

//: 计算型属性(Computed Properties)
//1.下面的例子向 Swift 的内建 Double 类型添加了5个 计算型实例属性,从而提供与距离单位协作的基本支持:
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")


//注意: 扩展可以添加新的计算属性,但是不可以添加存储属性,也不可以向已有属性添加属性观测器(property observers)。


//: 构造器(Initializers)
//1.下面的例子定义了一个用于描述几何矩形的定制结构体 Rect
struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width:5.5, height:5.0))

//你可以提供一个额外的使用特殊中心点和大小的构造器来扩展 Rect 结构体:
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

//注意:如果你使用扩展提供了一个新的构造器,你依旧有责任保证构造过程能够让所有实例完全初始化。



//: 方法(Methods)
//1.下面的例子向 Int 类型添加一个名为 repetitions 的新实例方法:
extension Int {
    func repetitions(task:()->()) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions{
    print("Hello!")
}


//2.下面的例子向Swift的 Int 类型添加了一个新的名为 square 的修改方法,来实现一个原始值的平方计算:
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()


//3.这个例子向Swift内建类型 Int 添加了一个整型下标。该下标 [n] 返回十进制数字从右向左数的第n个数字
extension Int {
    subscript(digitIndex: Int)->Int {
        var decimalBase = 1
        var index = digitIndex
        while index > 0 {
            decimalBase *= 10
            index -= 1
        }
        print(decimalBase)
        return (self/decimalBase)%10
    }
}

746381295[0]  //returns 5
746381295[1]  //returns 9

//如果该 Int 值没有足够的位数,即下标越界,那么上述实现的下标会返回0,因为它会在数字左边自动补0:
746381295[9] //returns 0, 即等同于: 0746381295[9]



//: 嵌套类型(Nested Types)
//1.该例子向 Int 添加了新的嵌套枚举。这个名为 Kind 的枚举表示特定整数的类型。具体来说,就是表示整数是正数,零或者负数。
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

//现在,这个嵌套枚举可以和一个 Int 值联合使用了:
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("-",terminator: ",")
        case .Zero:
            print("0",terminator: ",")
        case .Positive:
            print("+",terminator: ",")
        }
    }
    print("")
}

printIntegerKinds([3,19,-27,0,-6,0,7])
//prints +,+,-,0,-,0,+,









