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
extension NSTimer {
    typealias TimerClosure = @convention(block)(NSTimer) -> Void
    
    class func scheduledTimerWithTimeInterval(ti: NSTimeInterval, repeats yesOrNo: Bool, closure aClosure: TimerClosure) -> NSTimer {
        let timer = NSTimer.scheduledTimerWithTimeInterval(ti, target: self, selector: #selector(NSTimer.timerClosure(_:)), userInfo: unsafeBitCast(aClosure,AnyObject.self), repeats: yesOrNo)
        return timer
    }
    
    class func timerClosure(timer: NSTimer) -> Void {
        let closure = unsafeBitCast(timer.userInfo, TimerClosure.self)
        closure(timer)
    }
}


//5.- Selector Extension
private extension Selector {
    //static let xxxFunc = #selector(xxxClass.xxxFunc)
}

//example
//Selector.xxxFunc



//6. 闭包动画代理
class CXYAnimationClosureDelegate: NSObject {
    
    var animationStart:(()->Void)?
    var animationStop:((Bool)->Void)?
    
    class func animationDelegateWithStart(start:(()->Void)? ,animationStop stop: ((Bool)->Void)?) -> CXYAnimationClosureDelegate {
        let animationClosureDelegate :CXYAnimationClosureDelegate = CXYAnimationClosureDelegate()
        animationClosureDelegate.animationStart = start
        animationClosureDelegate.animationStop = stop
        return animationClosureDelegate
    }
    
    override func animationDidStart(anim: CAAnimation) {
        self.animationStart?()
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.animationStop?(flag)
    }
}
//example
/*
animation.delegate = CXYAnimationClosureDelegate.animationDelegateWithStart({

}, animationStop: { (Bool) in
    
})
*/






















