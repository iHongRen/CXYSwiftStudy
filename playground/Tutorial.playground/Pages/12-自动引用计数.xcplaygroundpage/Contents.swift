//: # 自动引用计数
//: 引用计数仅仅应用于类的实例。结构体和枚举类型是值类型,不是引用类型,也不是通过引用的方式存储和传 递。
import UIKit

//: 类实例之间的循环强引用
//1.下面展示了一个不经意产生循环强引用的例子。例子定义了两个类: Person 和 Apartment ,用来建模公寓和它其中的居民:
class Person {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let number: String
    init(number: String) {
        self.number = number
    }
    var tenant: Person?
    deinit {
        print("Apartment #\(number) is being deinitialized")
    }
}

//接下来的代码片段定义了两个可选类型的变量 john 和 unit4A ,并分别被设定为下面的 Apartment 和 Person 的实例。这两个变量都被初始化为 nil ,这正是可选的优点:
var john: Person?
var unit4A: Apartment?

//现在你可以创建特定的 Person 和 Apartment 实例并将赋值给 john 和 unit4A 变量:
john = Person(name: "John Appleseed")
unit4A = Apartment(number: "4A")

//在两个实例被创建和赋值后,下图表现了强引用的关系。变量 john 现在有一个指向 Person 实例的强引用,而 变量 unit4A 有一个指向 Apartment 实例的强引用:
// //: ![image](1.png)
// var image = UIImage(named: "1")
[#Image(imageLiteral: "1.png")#].imageWithRenderingMode(.Automatic)

//现在你能够将这两个实例关联在一起,这样人就能有公寓住了,而公寓也有了房客。注意感叹号是用来展开和访问可选变量 john 和 unit4A 中的实例,这样实例的属性才能被赋值:
john!.apartment = unit4A
unit4A!.tenant = john
//在将两个实例联系在一起之后,强引用的关系如图所示:
// //: ![image](2.png)
// image = UIImage(named: "2")
[#Image(imageLiteral: "2.png")#].imageWithRenderingMode(.Automatic)
//不幸的是,这两个实例关联后会产生一个循环强引用。Persion实例现在有了一个指向Apartment 实例的强引用,而Apartment实例也有了一个指向Persion实例的强引用。因此,当你断开john 和 unit4A 变量所持有的强引用时,引用计数并不会降为0,实例也不会被ARC销毁:
john = nil
unit4A = nil

//循环强引用会一直阻止Persion 和 Apartment类实例的销毁,这就在你的应用程序中造成了内存泄漏。强引用关系如下图:
// //: ![image](3.png)
// image = UIImage(named: "3")
[#Image(imageLiteral: "3.png")#].imageWithRenderingMode(.Automatic)

//Person和Apartment实例之间的强引用关系保留了下来并且不会被断开。

//: 解决实例之间的循环强引用,Swift提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题:弱引用(weak reference)和无主引用(unowned reference)。
//: 对于生命周期中会变为 nil 的实例使用弱引用。相反地,对于初始化赋值后再也不会被赋值为 nil的实例,使用无主引用。
/**
*  弱引用
弱引用不会对其引用的实例保持强引用,因而不会阻止ARC销毁被引用的实例。这个特性阻止了引用变为循环强引用。声明属性或者变量时,在前面加上 weak 关键字表明这是一个弱引用。
弱引用必须被声明为变量,表明其值能在运行时被修改。弱引用不能被声明为常量。
因为弱引用可以没有值,你必须将每一个弱引用声明为可选类型。在 Swift 中,推荐使用可选类型描述可能没有值的类型。
因为弱引用不会保持所引用的实例,即使引用存在,实例也有可能被销毁。因此,ARC会在引用的实例被销毁后自动将其赋值为nil。你可以像其他可选值一样,检查弱引用的值是否存在,你将永远不会访问已销毁的实例的引用。
*/

//2.下面的例子跟上面 Person 和 Apartment 的例子一致,但是有一个重要的区别。这一次, Apartment 的 tenant 属性被声明为弱引用:
class Person1 {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment1?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment1 {
    let number: String
    init(number: String) {
        self.number = number
    }
    weak var tenant: Person1?
    deinit {
        print("Apartment #\(number) is being deinitialized")
    }
}

//然后跟之前一样,建立两个变量( john1 和 unit4A1 )之间的强引用,并关联两个实例:
var john1: Person1?
var unit4A1: Apartment1?

john1 = Person1(name: "John1")
unit4A1 = Apartment1(number: "4A")

john1!.apartment = unit4A1
unit4A1!.tenant = john1

//现在,两个关联在一起的实例的引用关系如下图所示:
// //: ![image](4.png)
// image = UIImage(named: "4")
[#Image(imageLiteral: "4.png")#].imageWithRenderingMode(.Automatic)

//Person1 实例依然保持对 Apartment1 实例的强引用,但是 Apartment1 实例只是对 Person1 实例的弱引用。这意 味着当你断开 john1 变量所保持的强引用时,再也没有指向 Person1 实例的强引用了:
// //: ![image](5.png)
// image = UIImage(named: "5")
[#Image(imageLiteral: "5.png")#].imageWithRenderingMode(.Automatic)
//由于再也没有指向 Person1 实例的强引用,该实例会被销毁:
john1 = nil
// prints "John Appleseed is being deinitialized"

//唯一剩下的指向 Apartment 实例的强引用来自于变量 unit4A1 。如果你断开这个强引用,再也没有指向 Apartment 实例的强引用了:
// //: ![image](6.png)
// image = UIImage(named: "6")
[#Image(imageLiteral: "6.png")#].imageWithRenderingMode(.Automatic)
//由于再也没有指向 Apartment 实例的强引用,该实例也会被销毁:
unit4A1 = nil
// prints "Apartment #731 is being deinitialized"

//上面的两段代码展示了变量 john1 和 unit4A1 在被赋值为 nil 后, Person1 实例和 Apartment1 实例的析构函数都打印出“销毁”的信息。这证明了引用循环被打破了。


/**
*  无主引用
和弱引用类似,无主引用不会牢牢保持住引用的实例。和弱引用不同的是,无主引用是永远有值的。因此,无主引用总是被定义为非可选类型(non-optional type)。你可以在声明属性或者变量时,在前面加上关键字 unowned 表示这是一个无主引用。

由于无主引用是非可选类型,你不需要在使用它的时候将它展开。无主引用总是可以被直接访问。不过 ARC 无法在实例被销毁后将无主引用设为 nil ,因为非可选类型的变量不允许被赋值为 nil 。

注意: 如果你试图在实例被销毁后,访问该实例的无主引用,会触发运行时错误。使用无主引用,你必须确保引用始终指向一个未销毁的实例。
还需要注意的是如果你试图访问实例已经被销毁的无主引用,Swift 确保程序会直接崩溃,而不会发生无法预期的行为。所以你应当避免这样的事情发生。

*/

//3.下面的例子定义了两个类, Customer 和 CreditCard ,模拟了银行客户和客户的信用卡。在这个数据模型中,一个客户可能有或者没有信用卡,但是一张信用卡总是关联着一个客户。为了表示这种关系, Customer 类有一个可选类型的 card 属性,但是 CreditCard 类有一个非可选类型的 customer 属性。
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var john2: Customer?
john2 = Customer(name: "John Appleseed")
john2!.card = CreditCard(number: 1234_5678_9012_3456, customer: john2!)

//在你关联两个实例后,它们的引用关系如下图所示:
// //: ![image](7.png)
// image = UIImage(named: "7")

[#Image(imageLiteral: "7.png")#].imageWithRenderingMode(.Automatic)

//Customer 实例持有对 CreditCard 实例的强引用,而 CreditCard 实例持有对 Customer 实例的无主引用。当你断开 john2 变量持有的强引用时,再也没有指向 Customer 实例的强引用了:
// //: ![image](8.png)
// image = UIImage(named: "8")

[#Image(imageLiteral: "8.png")#].imageWithRenderingMode(.Automatic)

//由于再也没有指向 Customer 实例的强引用,该实例被销毁了。其后,再也没有指向 CreditCard 实例的强引用,该实例也随之被销毁了:
john2 = nil
// prints "John Appleseed is being deinitialized"
// prints "Card #1234567890123456 is being deinitialized"


//: 无主引用以及隐式解析可选属性
/**
*  Person 和 Apartment 的例子展示了两个属性的值都允许为 nil ,并会潜在的产生循环强引用。这种场景最适合 用弱引用来解决。
Customer 和 CreditCard 的例子展示了一个属性的值允许为 nil ,而另一个属性的值不允许为 nil ,这也可能会 产生循环强引用。这种场景最适合通过无主引用来解决。
然而,存在着第三种场景,在这种场景中,两个属性都必须有值,并且初始化完成后永远不会为 nil 。在这种场景 中,需要一个类使用无主属性,而另外一个类使用隐式解析可选属性。
*/

//4.下面的例子定义了两个类, Country 和 City ,每个类将另外一个类的实例保存为属性。在这个模型中,每个国家必须有首都,每个城市必须属于一个国家。为了实现这种关系, Country 类拥有一个 capitalCity 属性,而 City 类有一个 country 属性:
class Country {
    let name: String
    var capitalCity: City!
    init(name: String,capitalName: String) {
        self.name = name
        self.capitalCity = City(name:capitalName,country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
// prints "Canada's capital city is called Ottawa"

//在上面的例子中,使用隐式解析可选值的意义在于满足了两个类构造函数的需求。 capitalCity 属性在初始化完成后,能像非可选值一样使用和存取同时还避免了循环强引用。


//: 闭包引起的循环强引用
//: 循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性,并且这个闭包体中又使用了这个类实例。这个闭包体中可能访问了实例的某个属性,例如 self.someProperty ,或者闭包中调用了实例的某个方法,例如 self.someMethod 。这两种情况都导致了闭包 “捕获" self ,从而产生了循环强引用。
/**
*  循环强引用的产生,是因为闭包和类相似,都是引用类型。当你把一个闭包赋值给某个属性时,你也把一个引用赋值给了这个闭包。实质上,这跟之前的问题是一样的-两个强引用让彼此一直有效。但是,和两个类实例不同,这次一个是类实例,另一个是闭包。

Swift 提供了一种优雅的方法来解决这个问题,称之为闭包捕获列表(closuer capture list)。
*/

//5.下面的例子为你展示了当一个闭包引用了 self 后是如何产生一个循环强引用的。例子中定义了一个叫 HTMLElement 的类,用一种简单的模型表示 HTML 中的一个单独的元素:
class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

//下面的代码展示了如何用 HTMLElement 类创建实例并打印消息:
var paragraph: HTMLElement? = HTMLElement(name: "p",text: "hello,world")
print(paragraph!.asHTML())
// prints"<p>hello,world</p>"

//不幸的是,上面写的 HTMLElement 类产生了类实例和 asHTML 默认值的闭包之间的循环强引用。循环强引用,如下图所示:
// //: ![image](9.png)
// image = UIImage(named: "9")
[#Image(imageLiteral: "9.png")#].imageWithRenderingMode(.Automatic)
//实例的 asHTML 属性持有闭包的强引用。但是,闭包在其闭包体内使用了 self (引用了 self.name 和 self.text ),因此闭包捕获了 self ,这意味着闭包又反过来持有了 HTMLElement 实例的强引用。这样两个对象就产生了循环强引用。

//注意:虽然闭包多次使用了 self ,它只捕获 HTMLElement 实例的一个强引用。


//如果设置 paragraph 变量为 nil ,打破它持有的 HTMLElement 实例的强引用, HTMLElement 实例和它的闭包都不会被销毁,也是因为循环强引用:
paragraph = nil


//: 解决闭包引起的循环强引用
//: 在定义闭包时同时定义捕获列表作为闭包的一部分,通过这种方式可以解决闭包和类实例之间的循环强引用。

/**
*  捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样,声明每个捕获的引用为弱引用或无主引用,而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。

注意:Swift有如下要求:只要在闭包内使用 self 的成员,就要用 self.someProperty 或者 self.someMethod (而不只是 someProperty 或 someMethod )。这提醒你可能会一不小心就捕获了self 。
如果在闭包参数上使用了@noescape，可以屏蔽闭包中对self.的需求。
*/


//定义捕获列表
/**
*  捕获列表中的每一项都由一对元素组成,一个元素是 weak 或 unowned 关键字,另一个元素是类实例的引用(如 self )或初始化过的变量(如 delegate = self.delegate! )。这些项在方括号中用逗号分开。
*/

//如果闭包有参数列表和返回类型,把捕获列表放在它们前面:
/*
lazy var someClosure: (Int, String) -> String = {
[unowned self, weak delegate = self.delegate!](index: Int, stringToProcess: String) -> String in
//closure body goes here
}
*/


//弱引用和无主引用
/**
*  在闭包和捕获的实例总是互相引用时并且总是同时销毁时,将闭包内的捕获定义为无主引用。
相反的,在被捕获的引用可能会变为 nil 时,将闭包内的捕获定义为弱引用。
*/

//前面的 HTMLElement 例子中,无主引用是正确的解决循环强引用的方法。这样编写 HTMLElement 类来避免循环强引用:
class HTMLElement1 {
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String?) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

//这里,捕获列表是 [unowned self] ,表示“用无主引用而不是强引用来捕获 self ”。
//和之前一样,我们可以创建并打印 HTMLElement 实例:
var paragraph1: HTMLElement1? = HTMLElement1(name: "p", text: "hello, world")
print(paragraph1!.asHTML())
// prints "<p>hello, world</p>"

//使用捕获列表后引用关系如下图所示:
// //: ![image](10.png)
// image = UIImage(named: "10")
[#Image(imageLiteral: "10.png")#].imageWithRenderingMode(.Automatic)

//这一次,闭包以无主引用的形式捕获 self ,并不会持有 HTMLElement 实例的强引用。如果将 paragraph 赋值为 nil , HTMLElement 实例将会被销毁,并能看到它的析构函数打印出的消息。
paragraph1 = nil
// prints "p is being deinitialized"

















