//: [Previous](@previous)
import UIKit
//: # BASIC OPERATORS
let hello = "Hola, qué tal"
var word = "world"
let (x, y) = (1, 2)
//: ## 运算符
var c1 = 19/4
var ww = 4.0/0.0
var fff = 0.0/0.0 //非数

var g = -5.2
var h = -3.1
var mod = g%h //求余结果正负取决于被除数

var a111 = 5
var b111 = a111++ + 6 //先计算再自增
var c111 = ++a111 + 6 //自增再计算

//: ## 溢出运算符 &+,&-,&*,&/,&%
var cmin = UInt8.min
//var f = cmin-1 //error
cmin = cmin &- 1 //下溢

//: ## 浮点数求余
var rem=10%2.3

/*: 
 ## 特征运算符
 - 等价于 ( === )
 - 不等价于 ( !== )
 */
//var c = (a === b) //ab指向的类型实例相同时c为ture

/*
 ## 字符串拼接
 strings can be achieved by "sum" or by \()
 */
(hello + " " + word)
("\(hello) \(word)")
//: ### 字符串String插值
var apples = 10
var oranges = 4
("I have \(apples + oranges) fruits") //自动转型

//: 字符串NSString连接
var i = 200
var strI = "Hello Swift" as NSString //转成Foundation
strI = "\(strI),\(i)"
strI.substringWithRange(NSRange(location: 0, length: 5)) //可用NSString的相关方法
//: ## 三目(元)运算符
let name = "uraimo"
var happyStr = ""
(1...4).forEach{ happyStr = ("Happy Birthday " + (($0 == 1) ? "dear \(name)":"to You"))}
happyStr
//var ab = a>b ? "a>b":"a<b"
/*:
 Nil Coalescing Operator
 - It's equivalent to (a ? b : c), but for optionals
 - 空合并运算符 (a ?? b)对a进行空判断,若a有值就解封,否则返回b
 - 表达式a必是可选类型 默认值b的类型必须要和a存储的类型保持一致
 */
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
    //It will iterate 5 times.
}
//半开区间运算符 a..<b
var array = [1,2,3]
for index in 1..<array.count{
    //It will iterate (array.count - 1) times.
}

//枚举Enumerate array with index and value, C loop will be removed soon
for (index, value) in array.enumerate() {
    ("value \(value) at index \(index)")
}

var image = UIImage(named: "1")

//: ## Operator Overloading
// 运算符重载函数
func * (lhs: String, rhs: Int) -> String {
    var result = lhs
    for _ in 2...rhs {
        result += lhs
    }
    return result
}
let u = "abc"
let v = u * 5

// 定义Type协议
protocol Type {
    func += (inout lhs: Self, rhs: Self)
}
// 扩展支持Type协议
extension String: Type {}
extension Int: Type {}
extension Double: Type {}
extension Float: Type {}
// 泛型函数实现运算符重载
func *<T: Type>(lhs: T, rhs: Int) -> T {
    var result = lhs
    for _ in 2...rhs {
        result += lhs
    }
    return result
}
let x1 = "abc"
let y1 = x1 * 5
let a = 2
let b = a * 5
let c = 3.14
let d = c * 5
let e: Float = 4.56
let f = e * 5
//???: 这是什么
infix operator ** {associativity left precedence 150}

func **<T: Type>(lhs: T, rhs: Int) -> T {
    var result = lhs
    for _ in 2...rhs {
        result += lhs
    }
    return result
}
let g1 = "abc"
let h1 = g1 ** 5
let i1 = 2
let j = i1 ** 5
let k = 3.14
let l = k ** 5
let m: Float = 4.56
let n = m ** 5

infix operator **= {associativity left precedence 150}
func **=<T: Type>(inout lhs: T, rhs: Int) {
    lhs = lhs ** rhs
}
var o = "abc"
o **= 5
var q = 2
q **= 5
var s = 3.14
s **= 5
var w: Float = 4.56
w **= 5

let t = 1.successor()

//: [Next](@next)
