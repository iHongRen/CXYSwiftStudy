//:### 枚举(Enumerations)
//:枚举定义了一个通用类型的一组相关值,使你可以在你的代码中以一种安全的方式来使用这些值。

import UIKit


//1. 以下是指南针四个方向的一个例子
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

//2. 多个成员值可以出现在同一行上,用逗号隔开
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}


//:**关联值**
//3. 定义两种商品条码的枚举
enum Barcode {
    case UPCA(Int,Int,Int,Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
productBarcode = .QRCode("ABC")

//可以在 switch 的 case 分支代码中提取每个相关值作为一个常量(用 let 前缀)或者作为一个变 量(用 var 前缀)来使用
switch productBarcode {
case .UPCA(let numberSystem, var manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}

//如果一个枚举成员的所有相关值被提取为常量,或者它们全部被提取为变量,为了简洁,你可以只放置一个 var 或者 let 标注在成员名称前
switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .QRCode(productCode):
    print("QR code: \(productCode).")
}


//:**原始值**
//4. 这里是一个枚举成员存储 ASCII 码的例子
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}


//5. 当使用整数作为原始值时,隐式赋值的值依次递增1。如果第一个值没有被赋初值,将会被自动置为0。
enum Planet1: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}


//6. 当使用字符串作为枚举类型的初值时,每个枚举成员的隐式初值则为该成员的名称。
enum CompassPoint1: String {
    case North, South, East, West
}
let sunsetDirection = CompassPoint1.West.rawValue // sunsetDirection 值为 "West"


//:### OptionSetType
//在Swift中实现ObjC中的NS_OPTION不是通过enum，而是通过conform OptionSetType protocol的struct来实现的。

//7. 定义一个表示方向的选项集合
struct Directions: OptionSetType {
    var rawValue:Int
    
    static let Up: Directions = Directions(rawValue: 1 << 0)
    static let Down: Directions = Directions(rawValue: 1 << 1)
    static let Left: Directions = Directions(rawValue: 1 << 2)
    static let Right: Directions = Directions(rawValue: 1 << 3)
    
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


//8. [.CurveEaseIn, .CurveEaseInOut]  
UIView.animateWithDuration(0.3, delay: 1.0, options: [.CurveEaseIn, .CurveEaseInOut], animations: { () -> Void in
    // ...
}, completion: nil)
