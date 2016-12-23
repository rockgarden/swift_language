//: [Previous](@previous)

import UIKit

class Dog {
    var name = ""
    var whatADogSays = "woof"
    func bark() {
        (self.whatADogSays)
    }
    func speak() {
        self.bark()
    }
}

class Dog2 { func bark() { print("woof") }}

extension Int {
    func sayHello() {
        ("Hello, I'm \(self)")
    }
}

func go() {
    let one = 1
    var two = 2
    two = one
    let _ = (one,two)
}

func doGo() {
    go()
}

// let class = 1 // Keyword 'repeat' cannot be used as an identifier
// func if() { } // Expected identifier in function declaration
class `func` {
    func `if`() {
        let `class` = 1
        _ = `class`
    }
}

func silly() {
    if true {
        class Cat {}
        var one = 1
        one = one + 1
    }
}

do {
    let sum = 1 + 2
    let s = 1.description

    _ = sum
    _ = s

    // the magic word "self"
    1.sayHello() // outputs: "Hello, I'm 1"

    let one = 1
    var two = 2
    two = one
    // one = two // compile error
    // two = "hello" // compile error

    let three = 3

    let _ = (one, two, three)

    let fido = Dog()
    fido.bark()

    let rover = Dog.init() // I noticed this in Swift 1.2, definitely permitted in Swift 2.0
    // I'm betting that some day the Dog() syntax will be deprecated
    rover.bark()

    let dog1 = Dog()
    dog1.name = "Fido"
    var dog2 = Dog()
    dog2.name = "Rover"
    (dog1.name) // "Fido"
    (dog2.name) // "Rover"
    dog2 = dog1
    (dog2.name) // "Fido"

    dog1.bark()
    dog1.speak()
}

//: [Next](@next)
