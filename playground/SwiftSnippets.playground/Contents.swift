//: Snippets

import UIKit

//1.当前类名的字符串
class MyClass {
}

extension MyClass {
    class func myClassName() -> String {
        return "\(self)"
    }
    func getMyClassName() -> String {
        return "\(self)"
    }
}

let className0 = "\(MyClass.self)"
print(className0)

let className1 = String(MyClass)
print(className1)

let className2 = MyClass.myClassName()
print(className2)

let my = MyClass()
let className3 = my.getMyClassName()
print(className3)




//2.单例的正确写法
class MySingleton {
    static let sharedInstance = MySingleton()
    private init() {} //保证编译器在某个类尝试使用()来初始化MySingleton时，抛出错误.
}