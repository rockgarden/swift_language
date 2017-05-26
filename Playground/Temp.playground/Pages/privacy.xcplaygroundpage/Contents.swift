//: [Previous](@previous)
//: playground 无法测 fileprivate 因为在 sources 中引入的方法、参数 必须为 public
import Foundation
import UIKit

extension CGAffineTransform : CustomStringConvertible {
    public var description : String {
        return NSStringFromCGAffineTransform(self)
    }
}

class Cat {
    fileprivate var secretName : String?
}

public class Cat2 {
    fileprivate var secretName : String?
}

public class Dog {
    public var name = ""
    fileprivate var whatADogSays = "woof"
    func bark() {
        (self.whatADogSays)
    }
    func nameCat(_ cat: Cat) {
        cat.secretName = "Lazybones" // legal: same file
    }
    func nameCat2(_ cat: Cat2) {
        // cat.secretName = "Lazybones" // illegal: different file
    }
}

struct Dog2: CustomStringConvertible {
    var name = "Fido"
    var license = 1
    public var description: String {
        var desc = "Dog ("
        let mirror = Mirror(reflecting: self)
        for (k,v) in mirror.children {
            desc.append("\(k!): \(v), ")
        }
        let c = desc.characters.count
        return String(desc.characters.prefix(c-2)) + ")"
    }
}

struct Dog3: CustomReflectable {
    var name = "Fido"
    var license = 1
    public var customMirror: Mirror {
        let children : [Mirror.Child] = [
            ("ineffable name", self.name),
            ("license to kill", self.license)
        ]
        let m = Mirror(self, children:children)
        return m
    }
}

let d = Dog()
d.name // legal, it's visible from another file
// d.whatADogSays // compile error, it's private
d.bark()
(d)

let d2 = Dog2()
// testing difference circumstances under which we might see our custom output
("\(d2)")
(d2)
(d2)
("\(d2)")

let d3 = Dog3()
(d3) // breakpoint this line and `po d3` to see our custom property names

// just making sure the initializer visibility bug is fixed
let _ = Cat()
let _ = Cat2()

//: [Next](@next)
