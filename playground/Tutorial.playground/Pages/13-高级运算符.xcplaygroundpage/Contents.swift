//: # 高级运算符

import UIKit

//: 按位取反运算符( bitwise NOT operator )
//按位取反运算符( ~ ) 可以对一个数值的全部位进行取反:
[#Image(imageLiteral: "1.png")#].imageWithRenderingMode(.Automatic)

let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits //0b111100000

//: 按位与运算符(Bitwise AND Operator)
//按位与运算符( & )可以对两个数的比特位进行合并。它返回一个新的数,只有当两个操作数的对应位都为 1 的时候,该数的对应位才为 1 。
[#Image(imageLiteral: "2.png")#].imageWithRenderingMode(.Automatic)

let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits //0b00111100

//: 按位或运算符(Bitwise OR Operator)
//按位或运算符( | )可以对两个数的比特位进行比较。它返回一个新的数,只要两个操作数的对应位中有任意一个为 1 时,该数的对应位就为 1 。
[#Image(imageLiteral: "3.png")#].imageWithRenderingMode(.Automatic)

let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combineBits = someBits | moreBits //0b11111110

//: 按位异或运算符(Bitwise XOR Opoerator)
//按位异或运算符( ^ )可以对两个数的比特位进行比较。它返回一个新的数,当两个操作数的对应位不相同时,该数的对应位就为 1 。
[#Image(imageLiteral: "4.png")#].imageWithRenderingMode(.Automatic)

let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits //0b00010001

//: 按位左移/右移运算符
//按位左移运算符( << )和按位右移运算符( >> )可以对一个数进行指定位数的左移和右移,但是需要遵守下面定义的规则。
//对一个数进行按位左移或按位右移,相当于对这个数进行乘以 2 或除以 2 的运算。将一个整数左移一位,等价于将这个数乘以 2,同样地,将一个整数右移一位,等价于将这个数除以 2。

//无符号整型的移位操作
/*
对无符号整型进行移位的规则如下:
1. 已经存在的比特位按指定的位数进行左移和右移。
2. 任何移动超出整型存储边界的位都会被丢弃。
3. 用 0 来填充移动后产生的空白位。
这种方法称为逻辑移位( logical shift )。
*/

//以下这张图展示了 11111111 << 1 (即把 11111111 向左移动 1 位),和 11111111 >> 1 (即把 11111111 向右移动 1 位) 的结果。蓝色的部分是被移位的,灰色的部分是被抛弃的,橙色的部分则是被填充进来的。
[#Image(imageLiteral: "5.png")#].imageWithRenderingMode(.Automatic)

let shiftBits: UInt8 = 4 //即二进制的0b00000100
shiftBits << 1  //0b00001000
shiftBits << 2  //0b00010000
shiftBits << 5  //0b10000000
shiftBits << 6  //0b00000000
shiftBits >> 2  //0b00000001

//可以使用移位操作对其他的数据类型进行编码和解码:
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16 // redComponent 是 0xCC, 即 204 
let greenComponent = (pink & 0x00FF00) >> 8 // greenComponent 是 0x66, 即 102 
let blueComponent = pink & 0x0000FF // blueComponent 是 0x99, 即 153


//有符号整型的移位操作
//有符号整数使用第 1 个比特位(通常被称为符号位)来表示这个数的正负。符号位为 0 代表正数,为 1 代表负数。
//其余的比特位(通常被称为数值位)存储了这个数的真实值。有符号正整数和无符号数的存储方式是一样的,都是从 0 开始算起。这是值为 4 的 Int8 型整数的二进制位表现形式:
[#Image(imageLiteral: "6.png")#].imageWithRenderingMode(.Automatic)

//符号位为 0 ,说明这是一个正数,另外 7 位则代表了十进制数值 4 的二进制表示。

//负数的存储方式略有不同。它存储的是 2 的 n 次方减去它的真实值绝对值,这里的 n 为数值位的位数。一个 8 位的数有 7 个数值位,所以是 2 的 7 次方,即 128。

//这是值为 -4 的 Int8 型整数的二进制位表现形式:
[#Image(imageLiteral: "7.png")#].imageWithRenderingMode(.Automatic)

//这次的符号位为 1 ,说明这是一个负数,另外 7 个位则代表了数值 124 (即 128 - 4 ) 的二进制表示。

//负数的表示通常被称为二进制补码( two's complement )表示法。用这种方法来表示负数乍看起来有点奇怪,但它有几个优点。
//首先,如果想对 -1 和 -4 进行加法操作,我们只需要将这两个数的全部 8 个比特位进行相加,并且将计算结果中超出 8 位的数值丢弃:
[#Image(imageLiteral: "8.png")#].imageWithRenderingMode(.Automatic)

//其次,使用二进制补码可以使负数的按位左移和右移操作得到跟正数同样的效果,即每向左移一位就将自身的数值乘以 2,每向右一位就将自身的数值除以 2。要达到此目的,对有符号整数的右移有一个额外的规则:

//• 当对正整数进行按位右移操作时,遵循与无符号整数相同的规则,但是对于移位产生的空白位使用符号位进行填充,而不是用 0。
[#Image(imageLiteral: "9.png")#].imageWithRenderingMode(.Automatic)

//这个行为可以确保有符号整数的符号位不会因为右移操作而改变,这通常被称为算术移位( arithmetic shift )。
//由于正数和负数的特殊存储方式,在对它们进行右移的时候,会使它们越来越接近 0。在移位的过程中保持符号位不变,意味着负整数在接近 0 的过程中会一直保持为负。


//: 溢出运算符
//在默认情况下,当向一个整数赋超过它容量的值时,Swift默认会报错,而不是生成一个无效的数。

//例如, Int16 型整数能容纳的有符号整数范围是 -32768 到 32767 ,当为一个 Int16 型变量赋的值超过这个范围时,系统就会报错:
var potentialOverflow = Int16.max
// potentialOverflow 的值是 32767, 这是 Int16 能容纳的最大整数

//potentialOverflow += 1
// 这里会报错

//然而,也可以选择让系统在数值溢出的时候采取截断操作,而非报错。可以使用 Swift 提供的三个溢出操作符来让系统支持整数溢出运算。这些操作符都是以 & 开头的:
/*
• 溢出加法 &+
• 溢出减法 &-
• 溢出乘法 &*
*/

//: 数值溢出
//数值有可能出现上溢或者下溢。
//这个示例演示了当我们对一个无符号整数使用溢出加法( &+ )进行上溢运算时会发生什么:
var unsignedOverflow = UInt8.max
// unsignedOverflow 等于 UInt8 所能容纳的最大整数 255
unsignedOverflow = unsignedOverflow &+ 1 // 此时 unsignedOverflow 等于 0
[#Image(imageLiteral: "10.png")#].imageWithRenderingMode(.Automatic)

//同样地,当我们对一个无符号整数使用溢出减法( &- )进行下溢运算时也会产生类似的现象:
var unsignedOverflow1 = UInt8.min
// unsignedOverflow 等于 UInt8 所能容纳的最小整数 0
unsignedOverflow1 = unsignedOverflow1 &- 1 // 此时 unsignedOverflow 等于 255

//UInt8 型整数能容纳的最小值是 0,以二进制表示即 00000000 。当使用溢出减法运算符对其进行减 1 操作时,数值会产生下溢并被截断为 11111111 , 也就是十进制数值的 255。
[#Image(imageLiteral: "11.png")#].imageWithRenderingMode(.Automatic)


//溢出也会发生在有符号整型数值上。在对有符号整型数值进行溢出加法或溢出减法运算时,符号位也需要参与计算,正如按位左移/右移运算符所描述的。
var signedOverflow = Int8.min
// signedOverflow 等于 Int8 所能容纳的最小整数 -128
signedOverflow = signedOverflow &- 1 // 此时 signedOverflow 等于 127

//Int8 型整数能容纳的最小值是 -128,以二进制表示即 10000000 。当使用溢出减法操作符对其进行减 1 操作 时,符号位被翻转,得到二进制数值 01111111 ,也就是十进制数值的 127 ,这个值也是 Int8 型整数所能容纳 的最大值。
[#Image(imageLiteral: "12.png")#].imageWithRenderingMode(.Automatic)



//: 运算符函数
//类和结构可以为现有的操作符提供自定义的实现,这通常被称为运算符重载( overloading )。

//中缀( infix )运算符
//1.下面的例子展示了如何为自定义的结构实现加法操作符( + ),定义了一个名为 Vector2D 的结构体用来表示二维坐标向量 (x, y) ,紧接着定义了一个可以对两个 or2D 结构体进行相加的运算符函数( operator function ):
struct Vector2D {
    var x = 0.0, y = 0.0
}

func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
// combinedVector 是一个新的Vector2D, 值为 (5.0, 5.0)


//前缀和后缀运算符
//要实现前缀或者后缀运算符,需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 限定 符:
prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
// negative 是一个值为 (-3.0, -4.0) 的 Vector2D 实例
let alsoPositive = -negative
// alsoPositive 是一个值为 (3.0, 4.0) 的 Vector2D 实例


//复合赋值运算符
//复合赋值运算符( Compound assignment operators )将赋值运算符( = )与其它运算符进行结合。比如,将加法 与赋值结合成加法赋值运算符( += )。在实现的时候,需要把运算符的左参数设置成 inout 类型,因为这个参数 的值会在运算符函数内直接被修改。
func += (inout left: Vector2D, right: Vector2D) {
    left = left + right
}

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
// original 的值现在为 (4.0, 6.0)


//还可以将赋值与 prefix 或 postfix 限定符结合起来,下面的代码为 Vector2D 实例实现了前缀自增运算 符( ++a ):
prefix func ++ (inout vector: Vector2D) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}

var toIncrement = Vector2D(x: 3.0, y: 4.0)
let afterIncrement = ++toIncrement
// toIncrement 的值现在为 (4.0, 5.0)
// afterIncrement 的值同样为 (4.0, 5.0)


//: 注意: 不能对默认的赋值运算符( = )进行重载。只有组合赋值符可以被重载。同样地,也无法对三目条件运算符 a ? b : c 进行重载。


//等价操作符
func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}

func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
}
// prints "These two vectors are equivalent."


//自定义运算符
//新的运算符要在全局作用域内,使用 operator 关键字进行声明,同时还要指定 prefix 、 infix 或者 postfix 限定符:
prefix operator +++ {}

prefix func +++ (inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled 现在的值为 (2.0, 8.0)
// afterDoubling 现在的值也为 (2.0, 8.0)


//自定义中缀运算符的优先级和结合性
//结合性( associativity )可取的值有 left , right 和 none 。结合性( associativity )的默认值是 none ,优先级( precedence )如果没有指定,则默认为 100 。

//以下例子定义了一个新的中缀运算符 +- ,此操作符是左结合的,并且它的优先级为 140 :
infix operator +- {
    associativity left precedence 140
}

func +- (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
}

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
// plusMinusVector 是一个 Vector2D 类型,并且它的值为 (4.0, -2.0)




