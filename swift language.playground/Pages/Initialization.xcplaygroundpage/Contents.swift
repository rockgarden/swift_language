//: [Previous](@previous)
//: # Initialization 初始化
import UIKit
import AVFoundation
//: ## struct
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

/*
 For the struct, a memberwise initializer is provided. This means that stored properties don't
 necessarily need to have an initial value. A default initializer is created for all of them.
 */
struct Other {
    var temp: Double
    var otherProp: Int = 10
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

/*:
 In this case, the second initializer performs delegation, which is
 calling another initializer within the struct. This is only valid for
 value types, and not classes!
 */
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

/*: 
 ## class
 For a class, every stored property must have an initial value, or have a value assigned to it inside the initializer.
 This reference image explains the relationship between designated initializers and convenience initializers.
 https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Art/initializerDelegation01_2x.png
 - Rule 1: A designated initializer must call a designated initializer from its immediate superclass.
 - Rule 2: convenience initializer must call another initializer from the same class.
 - Rule 3: convenience initializer must ultimately call a designated initializer.
 A simple way to remember this is:
 - Designated initializers must always delegate up.
 - Convenience initializers must always delegate across.
 • Phase 1
 - A designated or convenience initializer is called on a class.
 - Memory for a new instance of that class is allocated. The memory is not yet initialized.
 - A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
 - The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
 - This continues up the class inheritance chain until the top of the chain is reached.
 - Once the top of the chain is reached, and the final class in the chain has ensured that all of its store
 properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
 • Phase 2
 - Working back down from the top of the chain, each designated initializer in the chain has the option to
 customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
 - Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.
 Also, keep in mind that:
 - Rule 1:If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
 - Rule 2:If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as
 per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.
 - NOTE: A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2.
 */
class Human {
    var gender: String
    init() {
        self.gender = "Female"
    }
}
let h1 = Human()
let h2 = Human.init() //definitely permitted in Swift 2.0
h1.self

class Person: Human {
    var name: String
    init(fullName name: String){
        //Phase 1: Initialize class-defined properties and call the superclass initializer.
        self.name = name
        super.init()
        //Phase 2: Further customization of local and inherited properties.
        self.gender = "Male"
    }
    convenience init(partialName name: String){
        //Phase 1: Call designated initializer
        let newName = "\(name) Karmy"
        self.init(fullName: newName)
        //Phase 2: Access to self and properties
        self.name = "John Karmy"
    }
}

/*:
 Failable initializers allow us to return nil during initialization in case there was a problem.
 The object being initalized is treated as an optional.
 You can also define a failable initializer that returns an implicitly unwrapped optional instance by writing init!
 - For enums, nil can be returned at any point of initalizations
 */
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
//: - For class instances, nil can only be returned after initalizing all properties.
class Product {
    let name: String!
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}
/*:
 You can pre-initialize properties by running code inside a closure. Since the execution happens before all other properties are initialized,
 you can't access other properties nor call self inside the closure.
 */
struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }() //Note that these parenthesis indicate that you want to run the closure immediately.
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}

let bodyTemperature = Celsius(37.0)
((bodyTemperature.temperatureInCelsius))
let person = Person(fullName: "John")
(person.name)
let other = Other(temp: 20, otherProp: 10)
(other.otherProp)
if let product = Product(name: "Apple"){
    ("Product is not nil. Names \(product.name)")
}
//: ### Example
struct DigitFailable {
    var number : Int
    var meaningOfLife : Bool
    init?(number:Int) {
        if number != 42 {
            return nil // early exit is legal for a struct in Swift 2.0
        }
        self.number = number
        self.meaningOfLife = false
    }
}
//: ## conditional Initialization
// showing that Swift no longer warns when AnyObject is implicitly assigned
let arr = [1 as AnyObject, "howdy" as AnyObject]
let thing = arr[0] // in Swift 1.2 and before we'd get a warning here
_ = thing

// var opts = [.Autoreverse, .Repeat] // compile error
let opts : UIViewAnimationOptions = [.Autoreverse, .Repeat]
_ = opts
var dothis = false
if dothis {
    let asset = AVAsset()
    let track = asset.tracks[0]
    let duration : CMTime = track.timeRange.duration
    _ = duration
}

// wrapped in a function so that `val` is unknown to the compiler
func conditionalInitializationExample(val:Int) {
    let timed : Bool
    if val == 1 {
        timed = true
    } else {
        timed = false
    }
    _ = timed
}

// but in that case I would rather use a computed initializer:
func computedInitializerExample(val:Int) {
    let timed : Bool = {
        if val == 1 {
            return true
        } else {
            return false
        }
    }()
    _ = timed
}

func btiExample() {
    /*
     do {
     let bti = UIApplication.sharedApplication()
     .beginBackgroundTaskWithExpirationHandler({
     UIApplication.sharedApplication().endBackgroundTask(bti)
     }) // error: variable used within its own initial value
     }
     */
    /*
     do {
     var bti : UIBackgroundTaskIdentifier
     bti = UIApplication.sharedApplication()
     .beginBackgroundTaskWithExpirationHandler({
     UIApplication.sharedApplication().endBackgroundTask(bti)
     }) // error: variable captured by a closure before being initialized
     }
     */
    do {
        var bti : UIBackgroundTaskIdentifier = 0
        bti = UIApplication.sharedApplication()
            .beginBackgroundTaskWithExpirationHandler({
                UIApplication.sharedApplication().endBackgroundTask(bti)
            })
    }
}

//: ### Example
class Dog {
}

class Dog2 {
    var name = ""
    var license = 0
    init() {
    }
    init(name:String) {
        self.name = name
    }
    init(license:Int) {
        self.license = license
    }
    init(name:String, license:Int) {
        self.name = name
        self.license = license
    }
}

class Dog4 {
//    var name = ""
//    var license = 0
    var name : String // no default value!
    var license : Int // no default value!
    init(name:String = "", license:Int = 0) {
        self.name = name
        self.license = license
    }
}

//Error: initalizer without initializing all stored properties
// class Dog5not {
// var name : String
// var license : Int
// init(name:String = "") {
// self.name = name  }
// }

class DogReal {
    let name : String
    let license : Int
    init(name:String, license:Int) {
        self.name = name
        self.license = license
    }
}


struct Cat {
    var name : String
    var license : Int
    init(name:String, license:Int) {
        self.name = name
        // meow() // too soon - compile error
        self.license = license
    }
    func meow() {
        print("meow")
    }
}

struct Digit {
    var number : Int
    var meaningOfLife : Bool
    // let meaningOfLife : Bool // would be legal but delegating initializer cannot set it
    init(number:Int) {
        self.number = number
        self.meaningOfLife = false
    }
    init() { // delegating initializer
        self.init(number:42)
        self.meaningOfLife = true
    }
}

struct Digit2 { // I regard the legality of this as a compiler bug
    var number : Int = 100
    init(value:Int) {
        self.init(number:value)
    }
    init(number:Int) {
        self.init(value:number)
    }
}

class DogFailable {
    let name : String
    let license : Int
    init!(name:String, license:Int) {
        if name.isEmpty {
            return nil // early exit is legal for a class in Swift 2.2
        }
        if license <= 0 {
            return nil
        }
        self.name = name
        self.license = license
    }
}

/*:
 ***
 [Next](@next)
 */
