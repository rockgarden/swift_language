//: [Previous](@previous)

/*:
 # instance methods and type (class) methods
 实例方法和类型(类)方法
 */

import UIKit

struct Point {
    var x = 0.0, y = 0.0
    static var xy = 0.0
    
    //变异的方法
    //This is a mutating method. Allows for modifying value types
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        //Here, the properties will be replaced with new values, thanks to the mutating prefix
        x += deltaX
        y += deltaY
        
        //Reassigning self is also possible because of the mutating prefix. Note that this is only possible for value types
        self = Point(x: x + deltaX, y: y + deltaY)
    }
    
    //This is a type method.
    static func unlockLevel(level: Double) {
        if xy > level { xy = level }
    }
}

class ViewController: UIViewController {
    var count = 0
    //This is an instance method
    func increment() {
        count += 1
    }
    //This is a class method.
    class func someTypeMethod() {
        print("Class Method")
    }
}

class Dog {
    let name: String
    let license: Int
    let whatDogsSay = "Woof"
    init(name: String, license: Int) {
        self.name = name
        self.license = license
    }
    func bark() {
        print(self.whatDogsSay)
    }
    func speak() {
        self.bark()
        print("I'm \(self.name)")
    }
    func speak2() { // legal, but I never intentionally write code like this
        bark()
        print("I'm \(name)")
    }
    func say(s: String, times: Int) {
        for _ in 1...times {
            print(s)
        }
    }
}

struct Greeting {
    static let friendly = "hello there"
    static let hostile = "go away"
    static var ambivalent: String {
        return self.friendly + " but " + self.hostile
    }
    static func beFriendly() {
        print(self.friendly)
    }
}

class Dog3 {
    static var whatDogsSay = "Woof"
    func bark() {
        print(Dog3.whatDogsSay)
    }
}

let fido = Dog(name:"Fido", license:1234)
fido.speak() // Woof I'm Fido
fido.say("woof", times:3)

Greeting.beFriendly() // hello there

let fido3 = Dog3()
fido3.bark() // Woof

//: ### Example 2
class MyClass {
    var s = ""
    func store(s: String) {
        self.s = s
    }
}
let m = MyClass()
let f = MyClass.store(m) // what just happened!?
print(m.s)
f("howdy")
(m.s) // howdy

//: [Next](@next)
