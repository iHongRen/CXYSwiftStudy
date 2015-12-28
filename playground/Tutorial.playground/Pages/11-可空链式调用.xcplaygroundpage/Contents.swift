//: # 可空链式调用
//: 可空链式调用(Optional Chaining)是一种可以请求和调用属性、方法及下标的过程,它的可空性体现于请求或 调用的目标当前可能为空(nil)。
import UIKit

//1.下面几段代码将解释可空链式调用和强制展开的不同。 首先定义两个类 Person 和 Residence
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

//如果创建一个新的 Person 实例,因为它的 residence 属性是可空的, john 属性将初始化为 nil :
let john = Person()

//如果使用叹号(!)强制展开获得这个 john 的 residence 属性中的 numberOfRooms 值,会触发运行时错 误,因为这时没有可以展开的 residence :
//let roomCount = john.residence!.numberOfRooms
// this triggers a runtime error

//可空链式调用提供了另一种访问 numberOfRooms 的方法,使用问号(?)来代替原来叹号(!)的位置:
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

//通过赋给 john.residence 一个 Residence 的实例变量:
john.residence = Residence()

//这样 john.residence 不为 nil 了。现在就可以正常访问 john.residence.numberOfRooms ,其值为默认的1,类型为Int?
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}



//2.下面这段代码定义了四个模型类,这些例子包括多层可空链式调用
class Person1 {
    var residence: Residence1?
}

class Residence1 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int)-> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}

//下面的代码创建了一个 Person1 实例,然后访问 numberOfRooms 属性:
let john1 = Person1()
if let roomCount = john1.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
//因为 john1.residence 为 nil ,所以毫无疑问这个可空链式调用失败。


//通过可空链式调用来设定属性值:
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john1.residence?.address = someAddress
//在这个例子中,通过 john.residence 来设定 address 属性也是不行的,因为 john1.residence 为 nil 。


//可以通过可空链式调用来调用方法,并判断是否调用成功,即使这个方法没有返回值。通过返回值是否为 nil 可以判断调用是否成功:
if john1.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

//同样的,可以判断通过可空链式调用来给属性赋值是否成功:
if (john1.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}


//通过可空链式调用,我们可以用下标来对可空值进行读取或写入,并且判断下标调用是否成功。
//下面这个例子用下标访问 john1.residence 中 rooms 数组中第一个房间的名称,因为 john.residence 为 nil ,所 以下标调用毫无疑问失败了:
if let firstRoomName = john1.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}


//如果你创建一个 Residence1 实例,添加一些 Room 实例并赋值给 john1.residence ,那就可以通过可选链和下标来访问数组中的元素:
let johnsHouse = Residence1()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john1.residence = johnsHouse

if let firstRoomName = john1.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}


//3.如果下标返回可空类型值,比如Swift中 Dictionary 的 key 下标。可以在下标的闭合括号后面放一个问号来链接下标的可空返回值:
var testScores = ["Dave":[86,82,84],"Bev":[79,94,81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]++
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
//key“Brian”在 字典中不存在,所以第三个调用失败。



//4.下面的例子访问 john1 中的 residence 中的 address 中的 street 属性。这里使用了两层可空链式调用, residence 以及 address ,这两个都是可空值。
if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
//john1.residence 包含 Residence 实例,但是 john1.residence.address 为 nil 。因此,不能访问 john1.residence?.address?.street 。


//如果把 john.residence.address 指向一个实例,并且为 address 中的 street 属性赋值,我们就能过通过可空链 式调用来访问 street 属性。
let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john1.residence?.address = johnsAddress

if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}



//5.在下面的例子中,通过可空链式调用来调用 Address 的 buildingIdentifier() 方法。这个方法返回 String? 类 型。正如上面所说,通过可空链式调用的方法的最终返回值还是 String? :
if let buildingIdentifier = john1.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}

//如果要进一步对方法的返回值进行可空链式调用,在方法 buildingIdentifier() 的圆括号后面加上问号:
if let beginsWithThe = john1.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}


//注意: 在上面的例子中在,在方法的圆括号后面加上问号是因为 buildingIdentifier() 的返回值是可空值,而不 是方法本身是可空的。








