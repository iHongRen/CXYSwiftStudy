//: Snippets

import UIKit

//1.获取当前类名的字符串
class MyClass {
    func myFunc() {}
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

let className1 = String(describing: MyClass.self)
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



//3.debug时打印
func printLog<T>(message: T,file: String = #file,
                   method: String = #function,
                   line: Int = #line)
{
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(#line)], \(#function): \(message)")
    #endif
}


//4. 使用闭包，避免NSTimer造成引用循环
extension Timer {
    typealias TimerClosure = @convention(block)(Timer) -> Void
    
    class func scheduledTimerWithTimeInterval(ti: TimeInterval, repeats yesOrNo: Bool, closure aClosure: TimerClosure) -> Timer {
        let timer = Timer.scheduledTimer(timeInterval: ti, target: self, selector: #selector(Timer.timerClosure(_:)), userInfo: unsafeBitCast(aClosure,to: AnyObject.self), repeats: yesOrNo)
        return timer
    }
    
    class func timerClosure(_ timer: Timer) -> Void {
        let closure = unsafeBitCast(timer.userInfo, to: TimerClosure.self)
        closure(timer)
    }
}


//5.- Selector Extension
private extension Selector {
    //static let xxxFunc = #selector(xxxClass.xxxFunc)
}

//example
//Selector.xxxFunc


























