//: 属性 (Properties)
//属性将值跟特定的类、结构或枚举关联。

import Foundation

//: 存储属性
//一个存储属性就是存储在特定类或结构体的实例里的一个常量或变量。存储属性只能用于类和结构体。
//可以在定义存储属性的时候指定默认值。也可以在构造过程中设置或修改存储属性的值,甚至修改常量存储属性的值,

//下面的例子定义了一个名为 FixedLengthRange 的结构体,它描述了一个在创建后无法修改值域宽度的区间:
struct FixedLengthRange {
    var fisrtValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(fisrtValue: 0, length: 3)
// 该区间表示整数0,1,2

rangeOfThreeItems.fisrtValue = 6
// 该区间现在表示整数6,7,8

//FixedLengthRange 的实例包含一个名为 firstValue 的变量存储属性和一个名为 length 的常量存储属性。在上面的例子中, length 在创建实例的时候被初始化,因为它是一个常量存储属性,所以之后无法修改它的值。


//常量结构体的存储属性
//无法修改常量结构体实例的任何属性,即使定义了变量存储属性



//延迟存储属性
//延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存储 属性。必须将延迟存储属性声明成变量(使用 var 关键字)。

//下面的例子使用了延迟存储属性来避免复杂类中不必要的初始化。例子中定义了 DataImporter 和 DataManager 两个类,下面是部分代码:
class DataImporter {
    /*
    DataImporter 是一个将外部文件中的数据导入的类。 这个类的初始化会消耗不少时间。
    */
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // 这是提供数据管理功能
}

let manager = DataManager()
manager.data.append("some data")
manager.data.append("some more data")
// DataImporter 实例的 importer 属性还没有被创建


//由于使用了 lazy , importer 属性只有在第一次被访问的时候才被创建
print(manager.importer.fileName)
// DataImporter 实例的 importer 属性现在被创建了 // 输出 "data.txt”



//: 计算属性
//计算属性不直接存储值,而是提供一个 getter 和一个可选的 setter,来间接获取和设置其他属性或变量的值。计算属性可以用于类、结构体和枚举.
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.height/2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width/2)
            origin.y = newCenter.y - (size.height/2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// 输出 "square.origin is now at (10.0, 10.0)”


//ps: 便捷 setter 声明, 如果计算属性的 setter 没有定义表示新值的参数名,则可以使用默认名称 newValue
/*
set {
    origin.x = newValue.x - (size.width/2)
    origin.y = newValue.y - (size.height/2)
}
*/



//只读计算属性
//只有 getter 没有 setter 的计算属性就是只读计算属性。只读计算属性总是返回一个值,可以通过点运算符访问,但不能设置新的值。

//ps: 必须使用 var 关键字定义计算属性,包括只读计算属性,因为它们的值不是固定的。

//只读计算属性的声明可以去掉 get 关键字和花括号:
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// 输出 "the volume of fourByFiveByTwo is 40.0"

// Cuboid 提供一个只读计算属性来让外部用户直接获取体积。




//属性观察器
//属性观察器监控和响应属性值的变化,每次属性被设置值的时候都会调用属性观察器,甚至新的值和现在的值相同的时候也不例外。
//可以为除了延迟存储属性之外的其他存储属性添加属性观察器,也可以通过重载属性的方式为继承的属性(包括 存储属性和计算属性)添加属性观察器。

//ps: 不需要为非重载的计算属性添加属性观察器,因为可以通过它的 setter 直接监控和响应值的变化。


/*
可以为属性添加如下的一个或全部观察器:
• willSet 在新的值被设置之前调用
• didSet 在新的值被设置之后立即调用

willSet 观察器会将新的属性值作为常量参数传入,在 willSet 的实现代码中可以为这个参数指定一个名称,如果
不指定则参数仍然可用,这时使用默认名称 newValue 表示。
类似地, didSet 观察器会将旧的属性值作为参数传入,可以为该参数命名或者使用默认参数名 oldValue 。

ps: 父类的属性在子类的构造器中被赋值时,它在父类中的 willSet 和 didSet 观察器会被调用。
*/

//StepCounter用来统计当人步行时的总步数:
class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
           print("About to set totalSteps to \(newValue)")
        }
        
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200 
// Added 200 steps

stepCounter.totalSteps = 360
// About to set totalSteps to 360 
// Added 160 steps

stepCounter.totalSteps = 896
// About to set totalSteps to 896 
// Added 536 steps

//ps: 如果在一个属性的 didSet 观察器里为它赋值,这个值会替换该观察器之前设置的值。




//全局变量和局部变量
//计算属性和属性观察器所描述的模式也可以用于全局变量和局部变量
//全局或局部变量都属于存储型变量,跟存储属性类似,它提供特定类型的存储空间,并允许读取和写入。
//另外,在全局或局部范围都可以定义计算型变量和为存储型变量定义观察器。计算型变量跟计算属性一样,返回一个计算的值而不是存储值,声明格式也完全一样。

//ps: 全局的常量或变量都是延迟计算的,跟延迟存储属性相似,不同的地方在于,全局的常量或变量不需要标记 lazy 特性。局部范围的常量或变量不会延迟计算。




//类型属性
//类型本身定义属性,不管类型有多少个实例,这些属性都只有唯一一份。这种属性就是类型属性。
//类型属性用于定义特定类型所有实例共享的数据,比如所有实例都能用的一个常量(就像 C 语言中的静态常量),或者所有实例都能访问的一个变量(就像 C 语言中的静态变量)。

//ps: 跟实例的存储属性不同,必须给存储型类型属性指定默认值,因为类型本身无法在初始化过程中使用构造器给类型属性赋值。

//使用关键字 static 来定义类型属性。在为类(class)定义计算型类型属性时,可以使用关键字 class 来支持子类对父类的实现进行重写。

//下面的例子演示了存储型和计算型类型属性的语法:
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypePropert: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 2
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 3
    }
    
    class var overrideableComputedTypeProperty: Int {
        return 4
    }
}



//获取和设置类型属性的值
print(SomeStructure.storedTypeProperty)
// 输出 "Some value." 

SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// 输出 "Another value.”




