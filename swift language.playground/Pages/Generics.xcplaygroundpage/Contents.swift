//: [Previous](@previous)

import UIKit

var str = "Hello, playground"

var red:CGFloat = 0.0,green:CGFloat=0.0,blue:CGFloat=0.0,alpha:CGFloat=0.0
UIColor.redColor().getRed(&red, green: &green, blue: &blue, alpha: &alpha)
red
green
blue
alpha

// Swift 泛型 T必须是同类型 Swift 的数组和字典类型都是泛型集
var num1 = 4.0, num2 = 5.0
func swapValue<T>(inout num1:T,inout num2:T){
    (num1,num2)=(num2,num1)
}
swapValue(&num1, num2: &num2)

// 异常Catch
//enum Error:ErrorType {
//    case WrongJSON
//}
//func testTry() {
//    do {
//        try NSJSONSerialization.JSONObjectWithData(NSData(), options: .AllowFragments)
//    } catch {
//        throw Error.WrongJSON
//    }
//}
//do {
//    try testTry()
//} catch Error.WrongJSON {
//
//}


//: [Next](@next)
