//: [Previous](@previous)

import UIKit

let MaxValue = 99
let MinValue = -99
var number = 0 {
willSet{
    print("from \(number) to \(newValue)")
}
didSet {
    if number > MaxValue {
        number = MaxValue
    } else if number < MinValue {
        number = MinValue
    }
    print("from \(oldValue) to \(number)")
}
}
number = 1000
number

//: [Next](@next)
