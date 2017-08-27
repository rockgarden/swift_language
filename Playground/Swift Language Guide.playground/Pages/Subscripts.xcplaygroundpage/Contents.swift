//: [Previous](@previous)
import UIKit
/*: 
 # Subscripts
 Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence. You use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval. For example, you access elements in an Array instance as someArray[index] and elements in a Dictionary instance as someDictionary[key]. 类，结构和枚举可以定义下标，它们是访问集合，列表或序列的成员元素的快捷方式。 您可以使用下标通过索引设置和检索值，而不需要单独的设置和检索方法。 例如，您将数组实例中的元素作为someArray [index]和Dictionary实例中的元素访问为someDictionary [key]。

 You can define multiple subscripts for a single type, and the appropriate subscript overload to use is selected based on the type of index value you pass to the subscript. Subscripts are not limited to a single dimension, and you can define subscripts with multiple input parameters to suit your custom type’s needs. 您可以为单个类型定义多个下标，并根据您传递给下标的索引值的类型选择要使用的适当下标重载。 下标不限于单个维度，您可以使用多个输入参数定义下标以适合您的自定义类型的需求。

 # Subscript Syntax

 Subscripts enable you to query instances of a type by writing one or more values in square brackets after the instance name. Their syntax is similar to both instance method syntax and computed property syntax. You write subscript definitions with the subscript keyword, and specify one or more input parameters and a return type, in the same way as instance methods. Unlike instance methods, subscripts can be read-write or read-only. This behavior is communicated by a getter and setter in the same way as for computed properties: 下标允许您通过在实例名称后面的方括号中写入一个或多个值来查询类型的实例。 它们的语法类似于实例方法语法和计算属性语法。 您使用subscript关键字编写下标定义，并以与实例方法相同的方式指定一个或多个输入参数和返回类型。 与实例方法不同，下标可以是读写或只读。getter和setter通过与计算属性相同的方式传递此行为：
 
    subscript(index: Int) -> Int {
        get {
            // return an appropriate subscript value here
        }
        set(newValue) {
            // perform a suitable setting action here
        }
    }

 The type of newValue is the same as the return value of the subscript. As with computed properties, you can choose not to specify the setter’s (newValue) parameter. A default parameter called newValue is provided to your setter if you do not provide one yourself. newValue的类型与下标的返回值相同。 与计算的属性一样，您可以选择不指定setter（newValue）参数。 如果您不自己提供一个名为newValue的默认参数，则会向您的设置者提供。

 As with read-only computed properties, you can simplify the declaration of a read-only subscript by removing the get keyword and its braces: subcripts可被读写或只读 (read-only时不需要实现getters and setters)

    subscript(index: Int) -> Int {
        // return an appropriate subscript value here
    }
 */
do {
    struct TimesTable {
        let multiplier: Int
        subscript(index: Int) -> Int {
            return multiplier * index
        }
    }
    let threeTimesTable = TimesTable(multiplier: 3)
    print("six times three is \(threeTimesTable[6])")
    // Prints "six times three is 18"
}
/*:
 - NOTE:
 An n-times-table is based on a fixed mathematical rule. It is not appropriate to set threeTimesTable[someIndex] to a new value, and so the subscript for TimesTable is defined as a read-only subscript. n次表基于固定的数学规则。 将threeTimesTable [someIndex]设置为新值是不合适的，因此TimesTable的下标被定义为只读下标。
 */

/*:
 # Subscript Usage

 The exact meaning of “subscript” depends on the context in which it is used. Subscripts are typically used as a shortcut for accessing the member elements in a collection, list, or sequence. You are free to implement subscripts in the most appropriate way for your particular class or structure’s functionality.
 
 Swift’s Dictionary type implements a subscript to set and retrieve the values stored in a Dictionary instance. You can set a value in a dictionary by providing a key of the dictionary’s key type within subscript brackets, and assigning a value of the dictionary’s value type to the subscript.
 
 For more information about Dictionary subscripting, see Accessing and Modifying a Dictionary.
 */
do {
    var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
    numberOfLegs["bird"] = 2
}
/*:
 - NOTE:
 Swift’s Dictionary type implements its key-value subscripting as a subscript that takes and returns an optional type. For the numberOfLegs dictionary above, the key-value subscript takes and returns a value of type Int?, or “optional int”. The Dictionary type uses an optional subscript type to model the fact that not every key will have a value, and to give a way to delete a value for a key by assigning a nil value for that key. Swift's Dictionary类型将其键值下标实现为下标，并返回可选类型。对于上面的numberOfLegs字典，键值下标将返回一个类型为Int ?,或“可选int”的值。字典类型使用可选的下标类型来模拟不是每个键都具有值的事实，并且通过为该键分配一个零值来给出一种方法来删除键的值。
 */

/*:
 # Subscript Options

 Subscripts can take any number of input parameters, and these input parameters can be of any type. Subscripts can also return any type. Subscripts can use variadic parameters, but they can’t use in-out parameters or provide default parameter values. 下标可以采用任意数量的输入参数，这些输入参数可以是任何类型的。 下标也可以返回任何类型。 下标可以使用可变参数，但不能使用输入参数或提供默认参数值。

 A class or structure can provide as many subscript implementations as it needs, and the appropriate subscript to be used will be inferred based on the types of the value or values that are contained within the subscript brackets at the point that the subscript is used. This definition of multiple subscripts is known as subscript overloading. 类或结构可以根据需要提供尽可能多的下标实现，并且将基于使用下标点的下标括号中包含的值或值的类型来推断要使用的适当下标。 多个下标的定义称为下标重载。
 */
do {
    struct Matrix {
        let rows: Int, columns: Int
        var grid: [Double]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeating: 0.0, count: rows * columns)
        }
        func indexIsValid(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }
        subscript(row: Int, column: Int) -> Double {
            get {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                /// 默认提供newValue, but you can change the name of the received value.
                assert(indexIsValid(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }

    var matrix = Matrix(rows: 2, columns: 2)
    matrix[0, 1] = 1.5
    matrix[1, 0] = 3.2

    //let someValue = matrix[2, 2]
    // this triggers an assert, because [2, 2] is outside of the matrix bounds
}

//: # Example 
/// 扩展添加下标
extension String {
    /// 返回指字符串指定位置的字符
    subscript(idx: Int) -> String {
        get {
            if idx > -1 && idx < self.characters.count {
                var count = 0
                var result = ""
                for ch in self.characters{
                    if count == idx {
                        result = "\(ch)"
                    }
                    count += 1
                }
                return result
            } else {
                return ""
            }
        }
        set {
            var result = ""
            var count = 0
            for ch in self.characters{
                if count == idx {
                    result += newValue
                } else {
                    result += "\(ch)"
                }
                count += 1
            }
            self = result
        }
    }

    subscript(start: Int, end: Int) -> String {
        if start > -1 && start < self.characters.count && end > -1 && end <= self.characters.count && start < end {
            var result = ""
            var count = 0
            for ch in self.characters{
                if count >= start && count < end {
                    result.append(ch)
                }
                count += 1
            }
            return result
        } else {
            return ""
        }
    }
}
do {
    var strSubscript = "long long code is trouble"
    strSubscript[15]
    strSubscript[0] = "w"
    strSubscript[6] = "k"
    strSubscript[0,10]
}

do {
    struct Digit {
        var number : Int
        init(_ n:Int) {
            self.number = n
        }
        // 定义下标: 实现通过下标访问Int
        subscript(ix: Int) -> Int {
            get {
                let s = String(self.number)
                return Int(String(s[s.index(s.startIndex, offsetBy: ix)]))!
            }
            set {
                let s = String(self.number)
                let i = s.index(s.startIndex, offsetBy: ix)
                //s.replaceRange(i...i, with: String(newValue))
                self.number = Int(s)!
            }
        }
    }
    var d = Digit(1234)
    let aDigit = d[1] // 2
    d[0] = 2 // now d.number is 2234
    d.number
}

//: [Next](@next)
