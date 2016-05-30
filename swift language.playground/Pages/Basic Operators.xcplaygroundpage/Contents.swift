//: [Previous](@previous)

// BASIC OPERATORS

import UIKit

let (x, y) = (1, 2)

//Addition is also available for strings
let string = "hello, " + "world"

//Nil Coalescing Operator
//It's equivalent to (a ? b : c), but for optionals
//空合并运算符
//(a ?? b)对a进行空判断,若a有值就解封,否则返回b
/* 表达式a必是可选类型 默认值b的类型必须要和a存储的类型保持一致 */
let word="hello"
var say:String?
var content = say ?? word

var optional: String? //Currently nil
// optional = "Some Value"
// Uncomment/comment this line and observe what values get printed below
var value = optional ?? "Value when `optional` is nil"

// above statement is equivalent to below
if optional != nil {
    value = optional! //Unwrapped value
} else {
    value = "Value when `optional` is nil"
}

//Range operators
//闭区间运算符 a...b
for index in 1...5 {
    print(index, terminator: "")//It will iterate 5 times.
}
//半开区间运算符 a..<b
var array = [1,2,3]
for index in 0..<array.count{
    print(index, terminator: "")//It will iterate (array.count - 1) times.
}

//枚举Enumerate array with index and value, C loop will be removed soon
for (index, value) in array.enumerate() {
    print("value \(value) at index \(index)")
}


//: [Next](@next)
