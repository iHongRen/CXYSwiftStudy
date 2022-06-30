//: 数据类型

import Foundation

print("hello,swift")

var myBool: Bool = true

var myInt: Int = 10

var myFloat: Float = 6.18

var myDouble: Double = 10.1

var myString: String = "Swift"

var myOpt: Optional<Int> = 1

var myChar: Character = "C"

var myArray: Array<Int> = [1,2,3]

var myDict: Dictionary<String,Int> = ["id":1001, "status":200]

var myAny: Array<Any> = [1,"swift",true]

class MyClass {
}
var myAnyObject: AnyObject = MyClass()



//定义一个元组
var http404Error = (statusCode:404, statusMessage:"Not Found")

//通过元素命名访问元组
let code = http404Error.statusCode
let message = http404Error.statusMessage

//通过下标访问元组
let code1 = http404Error.0
let message1 = http404Error.1

//修改元组值
http404Error.statusMessage = "找不到服务器"
print(http404Error)   //打印： (404,"找不到服务器")


//比较元组   ps:元组元素个数不能大于6个
var http403Error = (statusCode:403, statusMessage:"Forbidden")
if http403Error == http404Error {
    print("==");
} else {
    print("!=");
}

//元组使用场景
let myArr = [10,20,30,40]

for (index, value) in myArr.enumerated() {
    print("\(index)=> \(value)")
}


func myFunc()->(Int,String) {
    //: TODO
    return (200,"success")
}


//元组迭代
//利用反射，遍历后类型都是 Any。需要自己转换和匹配类型：
let mirror = Mirror(reflecting: http404Error)
for (_, value) in mirror.children {

    print(value)
    switch value {
    case is Int:
        print("Int")
    case is String:
        print("String")
    default:()
    }
}

