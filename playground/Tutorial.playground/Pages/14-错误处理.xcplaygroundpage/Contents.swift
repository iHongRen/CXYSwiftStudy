//: # 错误处理
//: 错误处理是响应错误以及从错误中返回的过程。swift提供第一类错误支持,包括在运行时抛出,捕获,传送和控制可回收错误。
import UIKit

//1.在Swift中,错误用符合 ErrorType 协议的值表示。比如说,你可以这样表示操作自动贩卖机会出现的错误:
enum VendingMachineError: Error {
    case InvalidSelection
    case InsufficientFunds(required: Double)
    case OutOfStock
}


//2.在下面的例子中,如果请求的物品不存在,或者卖完了,或者超出投入金额, vend(itemNamed:) 函数会抛出一个错误:
struct Item {
    var price: Double
    var count: Int
}

var inventory = [
    "Candy Bar": Item(price: 1.25, count: 7),
    "Chips": Item(price: 1.00, count: 4),
    "Pretzels": Item(price: 0.75, count: 11)
]

var amountDeposited = 1.00

func vend(itemNamed name: String) throws {
    guard var item = inventory[name] else {
        throw VendingMachineError.InvalidSelection
    }
    
    guard item.count > 0 else {
        throw VendingMachineError.OutOfStock
    }
    
    if amountDeposited >= item.price {
        //Dispense the snack
        amountDeposited -= item.price
        item.count -= 1
        inventory[name] = item
    } else {
        let amountRequired = item.price - amountDeposited
        throw VendingMachineError.InsufficientFunds(required: amountRequired)
    }
}


//当调用一个抛出函数的时候,在调用前面加上 try 。这个关键字表明函数可以抛出错误,而且在 try 后面代码将 不会执行。
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels"
]

func buyFavoriteSnack(persion: String) throws {
    let snackName = favoriteSnacks[persion] ?? "Candy Bar"
    try vend(itemNamed: snackName)
}


//使用do-catch语句来就捕获和处理错误
do {
    try vend(itemNamed: "Candy Bar")
    //Enjoy delicious snack
} catch VendingMachineError.InvalidSelection {
    print("invalid Selection")
} catch VendingMachineError.OutOfStock {
    print("out of stock")
} catch VendingMachineError.InsufficientFunds(let amountRequired) {
    print("Insufficient funds. Please insert an additional $\(amountRequired).")
}



//3.禁止错误传播 通过 try! 来调用抛出函数或方法禁止了错误传送,并且把调用包装在运行时断言,这样就不会抛出错误。如果错误真的抛出了,会触发运行时错误。
func willOnlyThrowlfTrue(_ value: Bool) throws {
    if value {
        //throw someError
    }
}

do {
    try willOnlyThrowlfTrue(false)
} catch {
    //handle error
}

try! willOnlyThrowlfTrue(false)



//4.收尾操作 defer 语句把执行推迟到退出当前域的时候
/*
func processFile(filename: String) throws {
if exists(filename) {
let file = open(filename)
defer {
close(file)
}

while let line = try file.readline() {
//work with the file.
}

//close(file) is called here,at the end of the scope.
}
}
*/






