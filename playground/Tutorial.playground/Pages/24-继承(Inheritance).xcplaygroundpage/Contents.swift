//: [Previous](@previous)

import Foundation


//:  定义一个基类(Defining a Base Class)
//Swift 中的类并不是从一个通用的基类继承而来。如果你不为你定义的类指定一个超类的话，这个类就自动成为 基类。
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // 什么也不做-因为车辆不一定会有噪音
    }
}
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")
// Vehicle: traveling at 0.0 miles per hour

//: 子类生成(Subclassing)
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
// Bicycle: traveling at 15.0 miles per hour

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// Tandem: traveling at 22.0 miles per hour


//: 重写(Overriding)
//子类可以为继承来的实例方法(instance method)，类方法(class method)，实例属性(instance propert y)，或下标(subscript)提供自己定制的实现(implementation)。重写定义的前面加上 overriding 关键字
//overriding 关键字会提醒 Swift 编译器去检查该类的超类(或其中一个父类)是否有匹配重写版本的声明。这个 检查可以确保你的重写定义是正确的。

//: 访问超类的方法，属性及下标
/*
你可以通过使用 super 前缀来访问超类版本的方法，属性或下标:
• 在方法 someMethod() 的重写实现中，可以通过 super.someMethod() 来调用超类版本的 someMethod() 方法。
• 在属性 someProperty 的 getter 或 setter 的重写实现中，可以通过 super.someProperty 来访问超类版本的 someProperty 属性。
• 在下标的重写实现中，可以通过 super[someIndex] 来访问超类版本中的相同下标。
*/


//重写方法
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()
// 打印 "Choo Choo"

//重写属性
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// Car: traveling at 25.0 miles per hour in gear 3


//重写属性观察器(Property Observer)
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
// AutomaticCar: traveling at 35.0 miles per hour in gear 4


//: 防止重写
//把方法，属性或下标标记为 final 来防止它们被重写，只需要在声明关键字前加上   修饰符即可(例如: final var，final func ，final class func ，以及 final subscript)。
//通过在关键字 class 前添加 final 修饰符(final class)来将整个类标记为 final 的。




