//: [Previous](@previous)

import Foundation
//: # Protocol

/// class关键字用来限制该协议只能应用在类上
protocol GameMode: class{
    var userInterface: String! {get}
    func gameplay()
}
/*:
 ### mutating
 */
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class"
    var anotherProperty: Int = 110
    /// 在 class 中实现带有mutating方法的接口时,不用mutating进行修饰, 因为对于class来说, 类的成员变量和方法都是透明的, 所以不必使用 mutating 来进行修饰
    func adjust() {
        simpleDescription += " Now 100% adjusted"
    }
}
do {
    var a = SimpleClass()
    a.adjust()
    let aDescription = a.simpleDescription
}
struct SimpleStruct: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += "(adjusted)"
    }
}
enum SimpleEnum: ExampleProtocol {
    case First, Second, Third
    var simpleDescription: String {
        get {
            switch self {
            case .First:
                return "first"
            case .Second:
                return "second"
            case .Third:
                return "third"
            }
        }
        set {
            simpleDescription = newValue
        }
    }
    mutating func adjust() {
    }
}
//: [Next](@next)
