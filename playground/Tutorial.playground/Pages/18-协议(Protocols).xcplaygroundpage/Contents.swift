//: Protocol 规定了用来实现某一特定工作或者功能所必需的方法和属性。类,结构体或枚举类型都可以遵循协议,并提供具体实现来完成协议定义的方法和功能。

import UIKit

//: 对属性的规定

//1. { set get } 来表示属性是可读可写的,只读属性则用 { get } 来表示
protocol SomeProtocol {
    var mustBeSettable : Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

//2. 类属性使用 static 关键字作为前缀。
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}


//3. 一个遵循 FullyNamed 协议的简单结构体
protocol FullyNamed {
    var fullName: String {get}
}

struct Person: FullyNamed{
    var fullName: String
}
var john = Person(fullName: "John Appleseed") //john.fullName 为 "John Appleseed"


//: 对方法的规定

//1. 类方法使用 static 关键字作为前缀
protocol SomeTypeProtocol {
    static func someTypeMethod()
}


//2. 一个实例方法的协议
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))

        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// 输出 : "Here's a random number: 0.37464991998171" print("And another one: \(generator.random())")
// 输出 : "And another one: 0.729023776863283"


//: 对Mutating方法的规定
//: 将￼￼mutating关键字作为函数的前缀,写在func之前,表示可以在该方法中修改它所属的实例及其实例属性的值。
//1. Togglable协议含有名为toggle的实例方法,toggle()方法将通过改变实例属性,来切换遵循该协议的实例的状态。
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
//lightSwitch 现在的值为 .On


//: 对构造器的规定

//1. 必须给构造器实现标上"required"修饰符
protocol SomeInitProtocol {
    init(someParameter: Int)
}

class SomeClass: SomeInitProtocol {
    required init(someParameter: Int) {
        //构造器实现
    }
}

// 使用 required 修饰符可以保证:所有的遵循该协议的子类,同样能为构造器规定提供一个显式的实现或继承实现。

//2. 如果一个子类重写了父类的指定构造器,并且该构造器遵循了某个协议的规定,那么该构造器的实现需要被同时标示 required 和 override 修饰符
protocol SomeSubProtocol {
    init()
}
class SomeSuperClass {
    init() {
        // 构造器的实现
    }
}
class SomeSubClass: SomeSuperClass, SomeSubProtocol {
    // 因为遵循协议,需要加上"required"; 因为继承自父类,需要加上"override"
    required override init() {
        // 构造器实现
    }
}


//: 协议类型
/*
• 作为函数、方法或构造器中的参数类型或返回值类型
• 作为常量、变量或属性的类型
• 作为数组、字典或其他容器中的元素类型
*/

//1. 使用 LinearCongruentialGenerator 的实例作为随机数生成器创建一个六面骰子
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}


//: 委托(代理)模式

//1. 下面的例子是两个基于骰子游戏的协议
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(_ game: DiceGame)
}

//该类遵循了 DiceGame 协议
class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self,didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

//DiceGameTracker 遵循了 DiceGameDelegate 协议
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

//DiceGameTracker 的运行情况
let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()



//: 在扩展中添加协议成员

//1. 通过扩展为已存在的类型遵循协议时,该类型的所有实例也会随之添加协议中的方法
protocol TextRepresentable {
    func asText() -> String
}

//通过扩展使得类型遵循了一个新的协议,这和类型在定义的时候声明为遵循协议的效果相同
extension Dice: TextRepresentable {
    func asText() -> String {
        return "A \(sides)-sided dice"
    }
}

//现在所有Dice的实例都遵循了TextRepresentable协议:
let d12 = Dice(sides: 12,generator: LinearCongruentialGenerator())
print(d12.asText())
// 输出 "A 12-sided dice"


//2 .同样 SnakesAndLadders 类也可以通过 扩展 的方式来遵循 TextRepresentable 协议:
extension SnakesAndLadders: TextRepresentable {
    func asText() -> String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.asText())
// 输出 "A game of Snakes and Ladders with 25 squares"



//: 通过扩展补充协议声明

//1. 当一个类型已经实现了协议中的所有要求,却没有声明为遵循该协议时,可以通过扩展(空的扩展体)来补充协议声明:
struct Hamster {
    var name: String
    func asText() -> String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

//从现在起, Hamster 的实例可以作为 TextRepresentable 类型使用
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.asText())
// 输出 "A hamster named Simon"

//注意: 即使满足了协议的所有要求,类型也不会自动转变,因此你必须为它做出显式的协议声明



//: 集合中的协议类型

//1. 协议类型可以在集合使用,表示集合中的元素均为协议类型,下面的例子创建了一个类型为TextRepresentable的数组:
let things: [TextRepresentable] = [game,d12,simonTheHamster]

for thing in things {
    print(thing.asText())
}
// thing 被当做是 TextRepresentable 类型而不是 Dice , DiceGame , Hamster 等类型。因此能且仅能调用 asText 方法



//: 协议的继承

//1. 协议的继承语法与类的继承相似,多个被继承的协议间用逗号分隔:
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 协议定义
}

//2. PrettyTextRepresentable 协议继承了 TextRepresentable 协议
protocol PrettyTextRepresentable: TextRepresentable {
    func asPrettyText() -> String
}

//3. 扩展 SnakesAndLadders ,让其遵循 PrettyTextRepresentable 协议
extension SnakesAndLadders: PrettyTextRepresentable {
    func asPrettyText() -> String {
        var output = asText() + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}



// :类专属协议

//1. 通过添加 AnyObject 关键字,限制协议只能适配到类(class)类型。(结构体或枚举不能 遵循该协议)
protocol SomeClassOnlyProtocol: AnyObject, InheritingProtocol {
    // class-only protocol definition goes here
}



//: 协议组合
// 有时需要同时遵循多个协议，可以使用协议组合来复合多个协议
// 协议组合使用 SomeProtocol & AnotherProtocol的形式

//1. 将 Named 和 Aged 两个协议按照上述的语法组合成一个协议
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}

struct Person1: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(_ celebrator: Named & Aged) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!") }

let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)
// 输出 "Happy birthday Malcolm - you're 21!

//注意:协议合成 并不会生成一个新协议类型,而是将多个协议合成为一个临时的协议,超出范围后立即失效。



//: 检验协议的一致性

//你可以使用 is 和 as 操作符来检查是否遵循某一协议或强制转化为某一类型
/*
• is 操作符用来检查实例是否遵循了某个协议
• as? 返回一个可选值,当实例遵循协议时,返回该协议类型;否则返回 nil
• as 用以强制向下转型,如果强转失败,会引起运行时错误。
*/

//1. 是否遵循了HasArea协议
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

//对迭代出的每一个元素进行检查
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
// Area is 12.5663708
// Area is 243610.0
// Something that doesn't have an area



//: 对可选协议的规定

/*
注意
可选协议只能在含有 @objc 前缀的协议中生效。且 @objc 的协议只能被类遵循，这个前缀表示协议将暴露给Objective-C代码,详情参见 Using Swift with Cocoa and Objective-C 。即使你不打算和Objective-C有什么交互,如果你想要指明协议包含可选属性,那么还是要加上 @obj 前缀

*/

//1. 协议中使用 ￼optional 关键字作为前缀来定义可选成员
@objc protocol CounterDataSource {
    @objc optional func incrementFor(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementFor?(count: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: CounterDataSource {
    @objc let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}


//2. 下面是一个更为复杂的数据源 TowardsZeroSource ,它将使得最后的值变为0
class TowardsZeroSource: CounterDataSource {
    @objc func incrementFor(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
        
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}



//: 协议扩展

//1. 通过扩展协议,所有协议的遵循者,在不用任何修改的情况下,都自动得到了这个扩展所增加的方法。
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator1 = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And here's a random Boolean: \(generator1.randomBool())")

//2. 可以通过协议扩展的方式来为协议规定的属性和方法提供默认的实现。如果协议的遵循者对规定的属性和方法提供了自己的实现,那么遵循者提供的实现将被使用。
extension PrettyTextRepresentable {
    func asPrettyText() -> String {
        return asText()
    }
}

//3. 可以扩展￼CollectionType协议,但是只适用于元素遵循TextRepresentable的情况,使用 where 关键字
extension Collection where Iterator.Element : TextRepresentable {
    func asList() -> String {
        return "(" + ", " + "\(map({$0.asText()}))" + ")"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

//因为 ￼￼￼Array 遵循 CollectionType 协议,数组的元素又遵循TextRepresentable￼ 协议,所以数组可以使用 asList()方法得到数组内容的文本表示:
print(hamsters.asList())


//注意:如果有多个协议扩展,而一个协议的遵循者又同时满足它们的限制,那么将会使用所满足限制最多的那个扩展。


