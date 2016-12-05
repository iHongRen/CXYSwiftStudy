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


//6. 检测 API 可用性
if #available(iOS 10, macOS 10.12, *) {
    // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
} else {
    // 使用先前版本的 iOS 和 macOS 的 API
}



public protocol Then {}

extension Then where Self: Any {
    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let label = UILabel().then {
    ///         $0.textAlignment = .Center
    ///         $0.textColor = UIColor.blackColor()
    ///         $0.text = "Hello, World!"
    ///     }
    public func then( block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}

extension Then where Self: AnyObject {
    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let label = UILabel().then {
    ///         $0.textAlignment = .Center
    ///         $0.textColor = UIColor.blackColor()
    ///         $0.text = "Hello, World!"
    ///     }
    public func then( block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}


let _ = UILabel().then{
    $0.textAlignment = .center
    $0.text = "hello"
    $0.textColor = UIColor.red
}















