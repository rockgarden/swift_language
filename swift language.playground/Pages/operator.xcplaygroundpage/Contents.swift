//: [Previous](@previous)

struct Vial {
    var numberOfBacteria : Int
    init(_ n: Int) {
        self.numberOfBacteria = n
    }
}
func +(lhs:Vial, rhs:Vial) -> Vial {
    let total = lhs.numberOfBacteria + rhs.numberOfBacteria
    return Vial(total)
}
func +=(lhs:inout Vial, rhs:Vial) {
    let total = lhs.numberOfBacteria + rhs.numberOfBacteria
    lhs.numberOfBacteria = total
}
func ==(lhs:Vial, rhs:Vial) -> Bool {
    return lhs.numberOfBacteria == rhs.numberOfBacteria
}
extension Vial: Equatable{}

//: 中间运算符 infix
infix operator ^^
func ^^(lhs:Int, rhs:Int) -> Int {
    var result = lhs
    for _ in 1..<rhs {result *= lhs}
    return result
}
5^^6

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


//: 前置运算符 prefix

//: 后置运算符 postfix

//: [Next](@next)
