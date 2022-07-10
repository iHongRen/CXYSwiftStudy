//: 类(Class)

import Foundation

/*
Swift 中类和结构体有很多共同点:
• 定义属性用于存储值
• 定义方法用于提供功能
• 定义附属脚本用于访问值
• 定义构造器用于生成初始化值
• 通过扩展以增加默认实现的功能
• 实现协议以提供某种标准功能


与结构体相比,类还有如下的附加功能:
• 继承允许一个类继承另一个类的特征
• 类型转换允许在运行时检查和解释一个类实例的类型
• 解构器允许一个类实例释放任何其所被分配的资源
• 引用计数允许对一个类的多次引用
*/


//定义
struct Resolution {
    var width = 0
    var height = 0
}


class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}


//实例
let someResolution = Resolution()
let someVideoMode = VideoMode()


//属性访问(点语法)
print("The width of someResolution is \(someResolution.width)")

someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")



//所有结构体都有一个自动生成的成员逐一构造器,用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中:
let vga = Resolution(width:640, height: 480)

//与结构体不同,类实例没有默认的成员逐一构造器。




//恒等运算符
//• 等价于 ( === )
//• 不等价于 ( !== )
//• “等价于”表示两个类类型(class type)的常量或者变量引用同一个类实例。
//• “等于”表示两个实例的值“相等”或“相同”,判定时要遵照类设计者定义定义的评判标准,因此相比 于“相等”,这是一种更加合适的叫法。



//类和结构体的选择
/*
按照通用的准则,当符合一条或多条以下条件时,请考虑构建结构体:
• 结构体的主要目的是用来封装少量相关简单数据值。
• 有理由预计一个结构体实例在赋值或传递时,封装的数据将会被拷贝而不是被引用。
• 任何在结构体中储存的值类型属性,也将会被拷贝,而不是被引用。
• 结构体不需要去继承另一个已存在类型的属性或者行为。
*/



//mutating
/*
结构体和枚举是值类型。一般情况下,值类型的属性不能在它的实例方法中被修改。
但是,如果你确实需要在某个具体的方法中修改结构体或者枚举的属性,你可以选择 变异(mutating) 这个方法,
然后方法就可以从方法内部改变它的属性;并且它做的任何改变在方法结束时还会保留在原始结构中。
方法 还可以给它隐含的 self 属性赋值一个全新的实例,这个新实例在方法结束后将替换原来的实例。
*/

struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// 打印输出: "The point is now at (3.0, 4.0)"


