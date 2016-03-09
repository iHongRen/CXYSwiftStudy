//:### 枚举(Enumerations)
//:枚举定义了一个通用类型的一组相关值,使你可以在你的代码中以一种安全的方式来使用这些值。

import UIKit


//1.以下是指南针四个方向的一个例子
enum CompassPoint {
    case North
    case South
    case East
    case West
}

var directionToHead = CompassPoint.West
directionToHead = .East

switch directionToHead {
case .North:
    print("N")
case .South:
    print("S")
case .East:
    print("E")
case .West:
    print("W")
}

//2.多个成员值可以出现在同一行上,用逗号隔开
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}


//:**关联值**
//形状
enum Shape {
    case Rectangle(w: Int,h:Int)
    case Round(r: Int)
}
var round = Shape.Round(r: 5)

//使用case-let语句提取关联值作为一个常量/变量
switch round {
case .Round(let r):
    print("r=\(r)")
case let .Rectangle(w, h):
    print("w=\(w),h=\(h)")
}

//定义两种商品条码的枚举
enum Barcode {
    case UPCA(Int,Int,Int,Int)
    case QRCode(String)
}

var barcode = Barcode.UPCA(8, 2, 1, 3)
barcode = .QRCode("ABC")

//可以在 switch 的 case 分支代码中提取每个相关值作为一个常量(用 let 前缀)或者作为一个变量(用 var 前缀)来使用
switch barcode {
case .UPCA(let numberSystem, var manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}

//如果一个枚举成员的所有相关值被提取为常量,或者它们全部被提取为变量,为了简洁,你可以只放置一个 var 或者 let 标注在成员名称前
switch barcode {
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .QRCode(productCode):
    print("QR code: \(productCode).")
}


//:**原始值**

enum Role: Int {
    case Normal  = 0
    case Admin   = 1
    case Creator = 2
}

//获取原始值 使用rawValue
let rawValue = Role.Admin.rawValue

//这里是一个枚举成员存储 ASCII 码的例子
enum ASCIIControlCharacter: String {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}


//当使用整数作为原始值时,隐式赋值的值依次递增1。如果第一个值没有被赋初值,将会被自动置为0。
enum Planet1: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

//当使用字符串作为枚举类型的初值时,每个枚举成员的隐式初值则为该成员的名称。
enum CompassPoint1: String {
    case North, South, East, West
}
let sunsetDirection = CompassPoint1.West.rawValue // sunsetDirection 值为 "West"


//double
enum Constanst: Double {
    case π = 3.14159
    case e = 2.71828
    case φ = 1.61803398874
    case λ = 1.30357
}



//: 嵌套枚举(Nesting Enums)
enum Character {
    enum Weapon {
        case Bow
        case Sword
        case Lance
        case Dagger
    }
    
    enum Helmet {
        case Wooden
        case Iron
        case Diamond
    }
    
    case Thief
    case Warrior
    case Knight
}

let character = Character.Thief
let weapon = Character.Weapon.Bow
let helmet = Character.Helmet.Iron


//: 包含枚举(Containing Enums)
struct Character1 {
    enum CharacterType {
        case Thief
        case Warrior
        case Knight
    }
    enum Weapon {
        case Bow
        case Sword
        case Lance
        case Dagger
    }
    let type: CharacterType
    let weapon: Weapon
}

let warrior = Character1(type: .Warrior, weapon: .Sword)


//: 方法和属性(Methods and properties)
enum Wearable {
    enum Weight: Int {
        case Light = 1
    }
    
    enum Armor: Int {
        case Light = 2
    }
    
    case Helmet(weight: Weight, armor: Armor)
    
    func attributes() -> (weight: Int,armor: Int) {
        switch self {
        case .Helmet(let w, let a):
             return (weight: w.rawValue * 2, armor: a.rawValue * 4)
        }
    }
}

let woodenHelmetProps = Wearable.Helmet(weight: .Light, armor: .Light).attributes()
print(woodenHelmetProps)

//枚举中的方法为每一个enum case而“生”。所以倘若想要在特定情况执行特定代码的话，你需要分支处理或采用switch语句来明确正确的代码路径。

enum Device {
    case iPad, iPhone, AppleTV, AppleWatch
    func introduced() -> String {
        switch self {
        case AppleTV: return "\(self) was introduced 2006"
        case iPhone: return "\(self) was introduced 2007"
        case iPad: return "\(self) was introduced 2010"
        case AppleWatch: return "\(self) was introduced 2014"
        }
    }
}
print (Device.iPhone.introduced())
// prints: "iPhone was introduced 2007"


//: 属性(Properties)
//尽管增加一个存储属性到枚举中不被允许，但你依然能够创建计算属性。当然，计算属性的内容都是建立在枚举值下或者枚举关联值得到的。
enum Device1 {
    case iPad, iPhone
    var year: Int {
        switch self {
        case iPhone: return 2007
        case iPad: return 2010
        }
    }
}


//: 静态方法(Static Methods)
//你也能够为枚举创建一些静态方法(static methods)。换言之通过一个非枚举类型来创建一个枚举。在这个示例中,我们需要考虑用户有时将苹果设备叫错的情况(比如AppleWatch叫成iWatch)，需要返回一个合适的名称。
enum Device2 {
    case AppleWatch
    static func fromSlang(term: String) -> Device2? {
        if term == "iWatch" {
            return .AppleWatch
        }
        return nil
    }
}
print(Device2.fromSlang("iWatch"))


//: 可变方法(Mutating Methods)
//方法可以声明为mutating。这样就允许改变隐藏参数self的case值了
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight 现在等于.High
ovenLight.next()
// ovenLight 现在等于.Off



//:### OptionSetType
//在Swift中实现ObjC中的NS_OPTION不是通过enum，而是通过conform OptionSetType protocol的struct来实现的。

//7.定义一个表示方向的选项集合
//Swift版
struct Directions: OptionSetType {
    var rawValue:Int
    
    static let Up = Directions(rawValue: 1 << 0)
    static let Down = Directions(rawValue: 1 << 1)
    static let Left = Directions(rawValue: 1 << 2)
    static let Right = Directions(rawValue: 1 << 3)
    
    // ...
    static let LeftUp: Directions = [.Left, .Up]
    static let RightUp: Directions = [.Right, .Up]
    // ...
}

let direction: Directions = Directions.Left
if direction == Directions.Left {
    // ...
}

//同时支持两个方向
let leftUp: Directions = [.Left, .Up]
let leftUp1 :Directions = .LeftUp
if leftUp.contains(.Left) && leftUp.contains(.Up) {
    // ...
}


//8.[.CurveEaseIn, .CurveEaseInOut]
UIView.animateWithDuration(0.3, delay: 1.0, options: [.CurveEaseIn, .CurveEaseInOut], animations: { () -> Void in
    // ...
    }, completion: nil)



