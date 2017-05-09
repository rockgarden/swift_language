//: [Previous](@previous)
import UIKit

/*:
 # Methods
 Methods are functions that are associated with a particular type. Classes, structures, and enumerations can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type. Classes, structures, and enumerations can also define type methods, which are associated with the type itself. Type methods are similar to class methods in Objective-C.
 方法是与特定类型相关联的函数。 类，结构和枚举都可以定义实例方法，它封装了用于处理给定类型的实例的特定任务和功能。 类，结构和枚举也可以定义类型方法，它们与类型本身相关联。 类型方法类似于Objective-C中的类方法。
 The fact that structures and enumerations can define methods in Swift is a major difference from C and Objective-C. In Objective-C, classes are the only types that can define methods. In Swift, you can choose whether to define a class, structure, or enumeration, and still have the flexibility to define methods on the type you create.
 */

/*:
 # Instance Methods
 实例方法
 Instance methods are functions that belong to instances of a particular class, structure, or enumeration. They support the functionality of those instances, either by providing ways to access and modify instance properties, or by providing functionality related to the instance’s purpose. Instance methods have exactly the same syntax as functions.
 You write an instance method within the opening and closing braces of the type it belongs to. An instance method has implicit access to all other instance methods and properties of that type. An instance method can be called only on a specific instance of the type it belongs to. It cannot be called in isolation without an existing instance.
 */
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
do {
    let counter = Counter()
    // the initial counter value is 0
    counter.increment()
    // the counter's value is now 1
    counter.increment(by: 5)
    // the counter's value is now 6
    counter.reset()
    // the counter's value is now 0
}

/*:
 ## The self Property
 Every instance of a type has an implicit property called self, which is exactly equivalent to the instance itself. You use the self property to refer to the current instance within its own instance methods.
 In practice, you don’t need to write self in your code very often. If you don’t explicitly write self, Swift assumes that you are referring to a property or method of the current instance whenever you use a known property or method name within a method.
 The main exception to this rule occurs when a parameter name for an instance method has the same name as a property of that instance. In this situation, the parameter name takes precedence, and it becomes necessary to refer to the property in a more qualified way. You use the self property to distinguish between the parameter name and the property name.
 */
class CounterSelf: Counter {
    override func increment() {
        self.count += 1
    }
}

struct Point {
    var x = 0.0, y = 0.0
    static var xy = 0.0

    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }

    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY

        /// Reassigning self is also possible because of the mutating prefix. Note that this is only possible for value types
        self = Point(x: x + deltaX, y: y + deltaY)
    }

    //This is a type method.
    static func unlockLevel(level: Double) {
        if xy > level { xy = level }
    }
}
do {
    let somePoint = Point(x: 4.0, y: 5.0)
    if somePoint.isToTheRightOf(x: 1.0) {
        print("This point is to the right of the line where x == 1.0")
    }
    // Prints "This point is to the right of the line where x == 1.0"
}

/*:
 ## Modifying Value Types from Within Instance Methods
 Structures and enumerations are value types. By default, the properties of a value type cannot be modified from within its instance methods.
 结构和枚举是值类型。 默认情况下，不能在其实例方法内修改值类型的属性。
 However, if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to mutating behavior for that method. The method can then mutate (that is, change) its properties from within the method, and any changes that it makes are written back to the original structure when the method ends. The method can also assign a completely new instance to its implicit self property, and this new instance will replace the existing one when the method ends.
 但是，如果您需要修改特定方法中的结构或枚举的属性，则可以选择对该方法进行突变行为。 然后，该方法可以在方法内改变（即改变）其属性，并且当该方法结束时，它所做的任何改变被写回到原始结构。 该方法还可以为其隐式自我属性分配一个完全新的实例，并且当该方法结束时，这个新实例将替换现有实例。
 */
do {
    struct Point {
        var x = 0.0, y = 0.0

        /// This is a mutating method. Allows for modifying value types, the properties will be replaced with new values, thanks to the mutating prefix
        mutating func moveBy(x deltaX: Double, y deltaY: Double) {
            x += deltaX
            y += deltaY
        }
    }
    var somePoint = Point(x: 1.0, y: 1.0)
    somePoint.moveBy(x: 2.0, y: 3.0)
    print("The point is now at (\(somePoint.x), \(somePoint.y))")
    // Prints "The point is now at (3.0, 4.0)"

    /// Note that you cannot call a mutating method on a constant of structure type, because its properties cannot be changed, even if they are variable properties, as described in Stored Properties of https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-ID256:
    let fixedPoint = Point(x: 3.0, y: 3.0)
    //fixedPoint.moveBy(x: 2.0, y: 3.0)
    // this will report an error
}


/*:
 ## Assigning to self Within a Mutating Method
 Mutating methods can assign an entirely new instance to the implicit self property.
 */
do {
    struct Point {
        var x = 0.0, y = 0.0
        mutating func moveBy(x deltaX: Double, y deltaY: Double) {
            /// Reassigning self is also possible because of the mutating prefix. Note that this is only possible for value types
            self = Point(x: x + deltaX, y: y + deltaY)
        }
    }
    
}
//: Mutating methods for enumerations can set the implicit self parameter to be a different case from the same enumeration:
do {
    enum TriStateSwitch {
        case off, low, high
        mutating func next() {
            switch self {
            case .off:
                self = .low
            case .low:
                self = .high
            case .high:
                self = .off
            }
        }
    }
    var ovenLight = TriStateSwitch.low
    ovenLight.next()
    // ovenLight is now equal to .high
    ovenLight.next()
    // ovenLight is now equal to .off
}


/*:
 ## Type Methods
 Instance methods, as described above, are methods that are called on an instance of a particular type. You can also define methods that are called on the type itself. These kinds of methods are called type methods. You indicate type methods by writing the static keyword before the method’s func keyword. Classes may also use the class keyword to allow subclasses to override the superclass’s implementation of that method.
 如上所述，实例方法是在特定类型的实例上调用的方法。 您还可以定义在类型本身上调用的方法。 这些类型的方法称为类型方法。 通过在方法的func关键字之前写入static关键字来指示类型方法。 类也可以使用class关键字来允许子类重写超类的方法实现。
 - NOTE:
 In Objective-C, you can define type-level methods only for Objective-C classes. In Swift, you can define type-level methods for all classes, structures, and enumerations. Each type method is explicitly scoped to the type it supports.
 */
class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()
/*:
 Within the body of a type method, the implicit self property refers to the type itself, rather than an instance of that type. This means that you can use self to disambiguate between type properties and type method parameters, just as you do for instance properties and instance method parameters.
 在类型方法的主体中，implicit self属性引用类型本身，而不是该类型的实例。这意味着您可以使用self消除类型属性和类型方法参数之间的歧义，就像对实例属性和实例方法参数一样。
 More generally, any unqualified method and property names that you use within the body of a type method will refer to other type-level methods and properties. A type method can call another type method with the other method’s name, without needing to prefix it with the type name. Similarly, type methods on structures and enumerations can access type properties by using the type property’s name without a type name prefix.
 更一般地说，在类型方法的主体中使用的任何非限定方法和属性名将引用其他类型级方法和属性。类型方法可以使用另一个方法的名称调用另一个类型方法，而无需使用类型名称作为前缀。类似地，对结构和枚举的类型方法可以通过使用type属性的名称而没有类型名称前缀来访问类型属性。
 */
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1

    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }

    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}
do {
    var player = Player(name: "Argyrios")
    player.complete(level: 1)
    print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
    // Prints "highest unlocked level is now 2"
    player = Player(name: "Beto")
    if player.tracker.advance(to: 6) {
        print("player is now on level 6")
    } else {
        print("level 6 has not yet been unlocked")
    }
    // Prints "level 6 has not yet been unlocked"
}


//: # Example
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
    func say(_ s: String, times: Int) {
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
