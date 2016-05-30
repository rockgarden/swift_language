//: [Previous](@previous)

import UIKit

struct DateIndex {
    let date: NSDate
}

extension Int {
    func times(closure:(() -> ())?) {
        if self >= 0 {
            for _ in 0..<self {
                closure?()
            }
        }
    }
}

5.times{(print("swift"))}

/// protocol extension
extension CustomStringConvertible {
    var upperDescription: String {
        return self.description.uppercaseString
    }
}
["key":"value"].upperDescription

//: [Next](@next)
