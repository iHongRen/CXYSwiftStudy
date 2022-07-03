//: 字符串与字符

import Foundation

//初始化空字符串
var str = ""
var str1 = String()

//判空
if str.isEmpty {
}

//拼接
str += "123"
str.append("456")

//遍历
for c in str {
    print(c)
}

//插值 \()
str = "I am \(20)"


//多行表示 """
var quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.
"""

//如果想第一行和最后一行都换行，则加空行
quotation = """

The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"""

//扩展字符串分隔符(#),字符串中的特殊字符将会被直接包含而不会被转义
str = #"a \n b \0 \r \\%"#
print(str) // a \n b \0 \r \\%

//如果想要扩展字符串里的字符转义，则\后面加#
str = #"a \#n b \0 \r \\%"#
print(str)
// a
//  b \0 \r \\%

//索引 String.Index
var greeting = "Guten Tag!"
greeting[greeting.startIndex]
greeting[greeting.index(after: greeting.startIndex)]
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(greeting.startIndex, offsetBy: 2)]

greeting.insert("p", at: greeting.startIndex)
greeting.remove(at: greeting.index(before: greeting.endIndex))

//子串 Substring
let hi = "Hello, world!"
let index = hi.firstIndex(of: ",") ?? hi.endIndex
let beginning = hi[..<index]
// beginning 的值为 "Hello"
//beginning是Substring，与hi共享内存

// 把结果转化为 String 以便长期存储。
let newString = String(beginning)

//比较 ==、!=


//Unicode 标量表示
let dogString = "Dog‼🐶"
for scalar in dogString.unicodeScalars { 
    print("\(scalar.value) ", terminator: "")
}

