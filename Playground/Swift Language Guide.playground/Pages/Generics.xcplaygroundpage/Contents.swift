//: [Previous](@previous)
//: # 范型
//: http://docs.scala-lang.org/tutorials/tour/abstract-types.html
import Foundation
//: 带范型的类
class Wat<T> {}
//: 带范型的结构体
struct WatWat<T> {}
//: 带范型的枚举
enum GoodDaySir<T> {}
/*: 
 带范型的协议 == No Support
 protocol 不支持范型类型参数。在 Swift 用 关联类型，代替支持抽象类型成员。
 - 参见 ["关联类型"](Associated%20Types)
 */
//protocol WellINever {
//    typealias T
//}
//: [Next](@next)
