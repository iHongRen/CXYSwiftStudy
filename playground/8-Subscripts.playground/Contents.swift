//: # 下标脚本(Subscripts)
//: 下标脚本允许你通过在实例后面的方括号中传入一个或者多个的索引值来对实例进行访问和赋值。语法类似于实 例方法和计算型属性的混合。


import UIKit

/* 下标脚本语法
subscript(index: Int) -> Int { 
    get {
        // 返回与入参匹配的Int类型的值
    }
    set(newValue) { 
        // 执行赋值操作
    }
}
*/

//1.下面代码演示了一个在 TimesTable 结构体中使用只读下标脚本的用法
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("3的6倍是\(threeTimesTable[6])")
// 输出 "3的6倍是18"


//一个类或结构体可以根据自身需要提供多个下标脚本实现,在定义下标脚本时通过入参个类型进行区分,使用下标脚本时会自动匹配合适的下标脚本实现运行,这就是下标脚本的重载。


//2.下例定义了一个 Matrix 结构体,将呈现一个 Double 类型的二维矩阵。 Matrix 结构体的下标脚本需要两个整型参数:
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

//let someValue = matrix[2, 2]
// 断言将会触发,因为 [2, 2] 已经超过了matrix的最大长度



//注意：swift中字典通过下标访问得到的结果是一个optional值。


//3.实现一个接受数组作为下标输入的读取方法，用于一次性取出某几个特定位置的元素。
extension Array {
    subscript(input:[Int])->ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "Index out of range")
                result.append(self[i])
            }
            return result
        }
        set {
            for (index,i) in input.enumerate() {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

var arr = [1,2,3,4,5]
arr[[0,2,3]]
arr[[0,2,3]] = [-1,-3,-4]
arr

//以上方法存在一个问题，当只有一个输入参数的时候参数列表会导致和现有的定义冲突。如果要避免这个冲突，可以使用至少带两个参数的参数形式。定义形如：subscript(frist: Int, second: Int, others: Int…)




