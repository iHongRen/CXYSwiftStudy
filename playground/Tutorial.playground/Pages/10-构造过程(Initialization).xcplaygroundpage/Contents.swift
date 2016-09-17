//: ###构造过程(Initialization)
/*
构造过程是为了使用某个类、结构体或枚举类型的实例而进行的准备过程。这个过程包含了为实例中的每个存储
型属性设置初始值和为其执行必要的准备和初始化任务。

构造过程是通过定义构造器( Initializers )来实现的,这些构造器可以看做是用来创建特定类型实例的特殊方法。
与 Objective-C 中的构造器不同,Swift 的构造器无需返回值,它们的主要任务是保证新实例在第一次使用前完成正
确的初始化。
*/

import Foundation


//: 存储型属性的初始赋值
//类和结构体在实例创建时,必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
//你可以在构造器中为存储型属性赋初值,也可以在定义属性时为其设置默认值。

//ps: 当你为存储型属性设置默认值或者在构造器中为其赋值时,它们的值是被直接设置的,不会触发任何属性观测器( property observers )。


//构造器
//构造器在创建某特定类型的新实例时调用。它的最简形式类似于一个不带任何参数的实例方法,以关键字 init 命 名。

/*
init() {
    // 在此处执行构造过程
}
*/

//下面例子中定义了一个用来保存华氏温度的结构体Fahrenheit,它拥有一个Double类型的存储型属性temperature :
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// 输出 "The default temperature is 32.0° Fahrenheit”


//默认属性值
//如果一个属性总是使用同一个初始值,可以为其设置一个默认值。
struct Fahrenheit1 {
    var temperature = 32.0
}




//: 自定义构造过程
//你可以通过输入参数和可选属性类型来定义构造过程,也可以在构造过程中修改常量属性。

//构造参数
//你可以在定义构造器时提供构造参数,为其提供自定义构造所需值的类型和名字。构造器参数的功能和语法跟函数和方法参数相同。

//下面例子中定义了一个包含摄氏度温度的结构体 Celsius 。它定义了两个不同的构造器: init(fromFahrenhei t:) 和 init(fromKelvin:) ,二者分别通过接受不同刻度表示的温度值来创建新的实例:
struct Celsius {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0)/1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0) //水的沸点
let boilingPoint = boilingPointOfWater.temperatureInCelsius

let freezingPointOfWater = Celsius(fromKelvin: 273.15)   //水的凝固点
let freezingPoint = freezingPointOfWater.temperatureInCelsius



//参数的内部名称和外部名称
//如果你在定义构造器时没有提供参数的外部名 字,Swift 会为每个构造器的参数自动生成一个跟内部名字相同的外部名,就相当于在每个构造参数之前加了一个哈希符号。

//Color 提供了一个构造器,其中包含三个 Double 类型的构造参数。 Color 也可以提供第二个构造器,它只包含 Double 类型名叫 white 的参数,它被用于给上述三个构造参数赋予同样的值。
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)



//不带外部名的构造器参数
//如果你不希望为构造器的某个参数提供外部名字,你可以使用下划线(_)来显示描述它的外部名




//可选属性类型
//可选类型的属性将自动初始化为空 nil ,表示这个属性是故意在初始化时设置为空的。

//下面例子中定义了类 SurveyQuestion ,它包含一个可选字符串属性 response :
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."



//构造过程中常量属性的修改
//只要在构造过程结束前常量的值能确定,你可以在构造过程中的任意时间点修改常量属性的值。

//ps: 对某个类实例来说,它的常量属性只能在定义它的类的构造过程中修改;不能在子类中修改。





//默认构造器
//Swift 将为所有属性已提供默认值的且自身没有定义任何构造器的结构体或基类,提供一个默认的构造器。这个默认构造器将简单的创建一个所有属性值都设置为默认值的实例。

//下面例子中创建了一个类 ShoppingListItem:
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
//由于 ShoppingListItem 类中的所有属性都有默认值,且它是没有父类的基类,它将自动获得一个可以为所有属性设置默认值的默认构造器



//结构体的逐一成员构造器
//如果结构体对所有存储型属性提供了默认值且自身没有提供定制的构造器,它们能自动获得一个逐一成员构造器。
//下面例子中定义了一个结构体 Size :
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)




//: 值类型的构造器代理
//构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理,它能减少多个构造器间的代码重复。
//构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型(结构体和枚举类型)不支持继承,所以构 造器代理的过程相对简单,因为它们只能代理给本身提供的其它构造器。类则不同,它可以继承自其它类(请参 考继承),这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。

//对于值类型,你可以使用 self.init 在自定义的构造器中引用其它的属于相同值类型的构造器。并且你只能在构造器内部调用 self.init 。
//如果你为某个值类型定义了一个定制的构造器,你将无法访问到默认构造器.

//ps: 假如你想通过默认构造器、逐一对象构造器以及你自己定制的构造器为值类型创建实例,我们建议你将自己定制的构造器写到扩展( extension )中,而不是跟值类型定义混在一起。


//下面例子将定义一个结构体 Rect ,用来代表几何矩形。这个例子需要两个辅助的结构体 Size 和 Point:
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init(){}
    init(origin: Point,size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//第一个 Rect 构造器 init() ,在功能上跟没有自定义构造器时自动获得的默认构造器是一样的:
let basicRect = Rect()

//第二个 Rect 构造器 init(origin:size:) ,在功能上跟结构体在没有自定义构造器时获得的逐一成员构造器是一样的:
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

//第三个 Rect 构造器 init(center:size:), 先通过 center 和 size 的值计算出 origin 的坐标。然后再调用(或代理给) init(origin:size:) 构造器来将新的 origin 和 size 值赋值到对应的属性中:
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 5.0, height: 5.0))




//: 类的继承和构造过程
//类里面的所有存储型属性--包括所有继承自父类的属性--都必须在构造过程中设置初始值。
//Swift 提供了两种类型的类构造器来确保所有类实例中存储型属性都能获得初始值,它们分别是指定构造器和便利构造器。


//指定构造器和便利构造器
//一个指定构造器将初始化类中提供的所有属性,并根据父类链往上调用父类的构造器来实现父类的初始化。
//每一个类都必须拥有至少一个指定构造器。在某些情况下,许多类通过继承了父类中的指定构造器而满足了这个条件。

//便利构造器是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器,并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入的实例。



//指定构造器的语法
/*
init(parameters) 
{ 
    statements
}
*/

//便利构造器的语法,  需要在 init 关键字之前放置 convenience 关键字
/*
convenience init(parameters) 
{ 
    statements
}
*/



//类的构造器代理规则
//为了简化指定构造器和便利构造器之间的调用关系,Swift 采用以下三条规则来限制构造器之间的代理调用:

/*
规则1 指定构造器必须调用其直接父类的的指定构造器。
规则2 便利构造器必须调用同一类中定义的其它构造器。
规则3 便利构造器必须最终以调用一个指定构造器结束。

一个更方便记忆的方法是:
• 指定构造器必须总是向上代理
• 便利构造器必须总是横向代理
*/



//两段式构造过程
/*
Swift 中类的构造过程包含两个阶段。第一个阶段,每个存储型属性通过引入它们的类的构造器来设置初始值。当每一个
存储型属性值被确定后,第二阶段开始,它给每个类一次机会在新实例准备使用之前进一步定制它们的存储型属性。

两段式构造过程的使用让构造过程更安全,同时在整个类层级结构中给予了每个类完全的灵活性。
两段式构造过程可以防止属性值在初始化之前被访问;也可以防止属性被另外一个构造器意外地赋予不同的值。
*/


/*
Swift 编译器将执行 4 种有效的安全检查,以确保两段式构造过程能顺利完成:

安全检查1 指定构造器必须保证它所在类引入的所有属性都必须先初始化完成,之后才能将其它构造任务向上代理给父类中 的构造器。
如上所述,一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则,指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化。

安全检查2 指定构造器必须先向上代理调用父类构造器,然后再为继承的属性设置新值。如果没这么做,指定构造器赋予的 新值将被父类中的构造器所覆盖。

安全检查3 便利构造器必须先代理调用同一类中的其它构造器,然后再为任意属性赋新值。如果没这么做,便利构造器赋予 的新值将被同一类中其它指定构造器所覆盖。

安全检查4 构造器在第一阶段构造完成之前,不能调用任何实例方法、不能读取任何实例属性的值, self 的值不能被引用。类实例在第一阶段结束以前并不是完全有效,仅能访问属性和调用方法,一旦完成第一阶段,该实例才会声明为
有效实例。
*/


/*
以下是两段式构造过程中基于上述安全检查的构造流程展示:

阶段 1
• 某个指定构造器或便利构造器被调用;
• 完成新实例内存的分配,但此时内存还没有被初始化;
• 指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化;
• 指定构造器将调用父类的构造器,完成父类属性的初始化;
• 这个调用父类构造器的过程沿着构造器链一直往上执行,直到到达构造器链的最顶部;
• 当到达了构造器链最顶部,且已确保所有实例包含的存储型属性都已经赋值,这个实例的内存被认为已经完全初始化。此时阶段1完成。

阶段 2
• 从顶部构造器链一直往下,每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问 self 、修改它的属性并调用实例方法等等。
• 最终,任意构造器链中的便利构造器可以有机会定制实例和使用 self 。

*/




//: 可失败构造器
//如果一个类,结构体或枚举类型的对象,在构造自身的过程中有可能失败,则为其定义一个可失败构造器,是非常有必要的。这里所指的“失败”是指,如给构造器传入无效的参数值,或缺少某种所需的外部资源,又或是不满足某种必要的条件等。

//其语法为在 init 关键字后面加添问号 (init?) 。

//ps: 可失败构造器的参数名和参数类型,不能与其它非可失败构造器的参数名,及其类型相同.

//可失败构造器,在构建对象的过程中,创建一个其自身类型为可选类型的对象。你通过 return nil 语句,来表明可失败构造器在何种情况下“失败”。

//注意: 严格来说,构造器都不支持返回值。因为构造器本身的作用,只是为了能确保对象自身能被正确构建。所以即使你在表明可失败构造器,失败的这种情况下,用到了 return nil 。也不要在表明可失败构造器成功的这种情况下,使用关键字 return 。

//下例中,定义了一个名为 Animal 的结构体,该结构体还定义了一个,带一个 String 类型参数 species 的,可失败构造器。
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

//你可以通过该可失败构造器来构建一个Animal的对象,并检查其构建过程是否成功:
let someCreature = Animal(species: "Giraffe")
// someCreature 的类型是 Animal? 而不是 Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

//如果你给该可失败构造器传入一个空字符串作为其参数,则该可失败构造器失败:
let anonymousCreature = Animal(species: "")
// anonymousCreature 的类型是 Animal?, 而不是 Animal
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}
//ps: 空字符串( "" )和一个值为 nil 的可选类型的字符串是两个完全不同的概念。



//枚举类型的可失败构造器
//你可以通过构造一个带一个或多个参数的可失败构造器来获取枚举类型中特定的枚举成员。还能在参数不满足你所期望的条件时,导致构造失败。

//下例中,定义了一个名为TemperatureUnit的枚举类型。
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

//当参数的值不能与任意一枚举成员相匹配时,该枚举类型的构建过程失败:
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("initialization failed.")
}




//带原始值的枚举类型的可失败构造器
//带原始值的枚举类型会自带一个可失败构造器 init?(rawValue:) ,该可失败构造器有一个名为 rawValue 的默认参数,其类型和枚举类型的原始值类型一致,如果该参数的值能够和枚举类型成员所带的原始值匹配,则该构造器构造一个带此原始值的枚举成员,否则构造失败。

//因此上面的 TemperatureUnit的例子可以重写为:
enum TemperatureUnit1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit1 = TemperatureUnit1(rawValue: "F")
if fahrenheitUnit1 != nil {
    print("initialization succeeded.")
}

let unknownUnit1 = TemperatureUnit1(rawValue: "X")
if unknownUnit1 == nil {
    print("initialization failed.")
}




//类的可失败构造器
//值类型(如结构体或枚举类型)的可失败构造器,对何时何地触发构造失败这个行为没有任何的限制。
//类的可失败构造器只能在所有的类属性被初始化后和所有类之间的构造器之间的代理调用发生完后触发失败行为。
class Product {
    let name: String
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}

//因为 name 属性是一个常量,所以一旦 Product 类构造成功, name 属性肯定有一个非 nil 的值,不用考虑去检查 name 属性是否有值.
if let bowTie = Product(name: "bow tie") {
    //不需要检查 bowTie.name == nil
    print("The product's name is \(bowTie.name)")
}




//构造失败的传递
//可失败构造器同样满足在构造器链 (页 0)中所描述的构造规则。其允许在同一类,结构体和枚举中横向代理其他的可失败构造器。类似的,子类的可失败构造器也能向上代理基类的可失败构造器。

//无论是向上代理还是横向代理,如果你代理的可失败构造器,在构造过程中触发了构造失败的行为,整个构造过程都将被立即终止,接下来任何的构造代码都将不会被执行。




//重写一个可失败构造器
//就如同其它构造器一样,你也可以用子类的可失败构造器重写基类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个基类的可失败构造器。
//ps:你可以用一个非可失败构造器重写一个可失败构造器,但反过来却行不通。
class Document {
    var name: String?
    init() {}
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

//AutomaticallyNamedDocument 用一个非可失败构造器 init(name:) ,重写了基类的可失败构造器 init?(nam e:) 。因为子类用不同的方法处理了 name 属性的值为一个空字符串的这种情况。所以子类将不再需要一个可失败的构造器。




//可失败构造器 init!
//通常来说我们通过在 init 关键字后添加问号的方式来定义一个可失败构造器,但你也可以使用通过在 init 后面添 加惊叹号的方式来定义一个可失败构造器 (init!) ,该可失败构造器将会构建一个特定类型的隐式解析可选类型的 对象。

//你可以在 init? 构造器中代理调用 init! 构造器,反之亦然。 你也可以用 init? 重写 init! ,反之亦然。 你还可以用 init 代理调用 init! ,但这会触发一个断言:是否 init! 构造器会触发构造失败?






//: 必要构造器
//在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器:
class SomeClass {
    required init() {
        // 在这里添加该必要构造器的实现代码
    }
}

//当子类重写基类的必要构造器时,必须在子类的构造器前同样添加 required 修饰符以确保当其它类继承该子类时,该构造器同为必要构造器。在重写基类的必要构造器时,不需要添加 override 修饰符:
class ComeSubclass: SomeClass {
    required init() {
        // 在这里添加子类必要构造器的实现代码
    }
}

//ps: 如果子类继承的构造器能满足必要构造器的需求,则你无需显式的在子类中提供必要构造器的实现。





//: 通过闭包和函数来设置属性的默认值
//如果某个存储型属性的默认值需要特别的定制或准备,你就可以使用闭包或全局函数来为其属性提供定制的默认值。每当某个属性所属的新类型实例创建时,对应的闭包或函数会被调用,而它们的返回值会当做默认值赋值给这个属性。

//这种类型的闭包或函数一般会创建一个跟属性类型相同的临时变量,然后修改它的值以满足预期的初始状态,最后将这个临时变量的值作为属性的默认值进行返回。

//下面列举了闭包如何提供默认值的代码概要:
class SomeMyClass {
    let someProperty: String = {
        // 在这个闭包中给 someProperty 创建一个默认值 
        // someValue 必须和 SomeType 类型相同
        return "someValue"
    }()
}
//注意闭包结尾的大括号后面接了一对空的小括号。这是用来告诉 Swift 需要立刻执行此闭包。如果你忽略了这对括号,相当于是将闭包本身作为值赋值给了属性,而不是将闭包的返回值赋值给属性。


//ps: 如果你使用闭包来初始化属性的值,请记住在闭包执行时,实例的其它部分都还没有初始化。这意味着你不能够在闭包里访问其它的属性,就算这个属性有默认值也不允许。同样,你也不能使用隐式的 self 属性,或者调用其它的实例方法。


//下面例子中定义了一个结构体 Checkerboard ,它构建了西洋跳棋游戏的棋盘。boardColor数组是通过一个闭包来初始化和组装颜色值的:
struct CheckerBoard {
    let boardColors: [Bool] = {
        var tempBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                tempBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return tempBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}

//每当一个新的 Checkerboard 实例创建时,对应的赋值闭包会执行,一系列颜色值会被计算出来作为默认值赋值给 boardColors 
let board = CheckerBoard()
print(board.squareIsBlackAt(row:0, column: 1))
// 输出 "true" 
print(board.squareIsBlackAt(row:9, column: 9))
// 输出 "false"















