//: 析构过程(Deinitialization)
//析构器只适用于类类型,当一个类的实例被释放之前,析构器会被立即调用。析构器用关键字 deinit 来标示,类 似于构造器要用 init 来标示。

import Foundation

//析构过程原理
//Swift 会自动释放不再需要的实例以释放资源。
//在类的定义中,每个类最多只能有一个析构器,而且析构器不带任何参数,如下所示:
class MyClass {
    //...
    
    deinit {
        // 执行析构过程
    }
}

//析构器是在实例释放发生前被自动调用。析构器是不允许被主动调用的。子类继承了父类的析构器,并且在子类析构器实现的最后,父类的析构器会被自动调用。即使子类没有提供自己的析构器,父类的析构器也同样会被调用。


