//: [Previous](@previous)
import UIKit
//: # Protocol Syntax
protocol SomeProtocol {
    // protocol definition goes here
}
protocol FirstProtocol {}
protocol AnotherProtocol {}

struct SomeStructure: FirstProtocol, AnotherProtocol {
    // structure definition goes here
}

class SomeSuperclass {}
//: 如果一个类有一个父类superclass，父类的名称列在任何协议的前，中间采用逗号分隔。
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // class definition goes here
}

/*: 
 # Property Requirements
 A protocol can require any conforming type to provide an instance property or type property with a particular name and type. The protocol doesn’t specify whether the property should be a stored property or a computed property—it only specifies the required property name and type. The protocol also specifies whether each property must be gettable or gettable and settable.
 If a protocol requires a property to be gettable and settable, that property requirement cannot be fulfilled by a constant stored property or a read-only computed property. If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it is valid for the property to be also settable if this is useful for your own code.
 Property requirements are always declared as variable properties, prefixed with the var keyword. Gettable and settable properties are indicated by writing { get set } after their type declaration, and gettable properties are indicated by writing { get }.
 */
protocol PR_SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol PR_AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol PR_FullyNamed {
    var fullName: String { get }
}

do {
    struct PR_Person: PR_FullyNamed {
        var fullName: String
    }
    let john = PR_Person(fullName: "John Appleseed")
    john.fullName
}

do {
    class Starship: PR_FullyNamed {
        var prefix: String?
        var name: String
        init(name: String, prefix: String? = nil) {
            self.name = name
            self.prefix = prefix
        }
        // 计算属性 Computed property.
        var fullName: String {
            return (prefix != nil ? prefix! + " " : "") + name
        }
    }
    var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
    var ncc1702 = Starship(name: "Enterprise")
    ncc1701.fullName
    ncc1702.fullName
}

//: # Method Requirements
protocol MR_SomeProtocol {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}

/// 线性同余产生器
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")

/*: 
 # Mutating Method Requirements
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html#//apple_ref/doc/uid/TP40014097-CH15-ID239
 If you define a protocol instance method requirement that is intended to mutate instances of any type that adopts the protocol, mark the method with the mutating keyword as part of the protocol’s definition. This enables structures and enumerations to adopt the protocol and satisfy that method requirement.
 - NOTE:
 If you mark a protocol instance method requirement as mutating, you do not need to write the mutating keyword when writing an implementation of that method for a class. The mutating keyword is only used by structures and enumerations.
 */
protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()

//: # Initializer Requirements
protocol IR_SomeProtocol {
    init(someParameter: Int)
}
/*: 
 ## Class Implementations of Protocol Initializer Requirements
 You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier:
 */
class CIoPIR_SomeClass: IR_SomeProtocol {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}
//: The use of the required modifier ensures that you provide an explicit or inherited implementation of the initializer requirement on all subclasses of the conforming class, such that they also conform to the protocol.For more information on required initializers, see https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID231.
final class SomeFinalClass: IR_SomeProtocol {
    init(someParameter: Int) {}
}
/*:
 - NOTE:
 You do not need to mark protocol initializer implementations with the required modifier on classes that are marked with the final modifier, because final classes cannot be subclassed. For more on the final modifier, see https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Inheritance.html#//apple_ref/doc/uid/TP40014097-CH17-ID202.
 */
//: If a subclass overrides a designated initializer from a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the required and override modifiers:
protocol ODI_SomeProtocol {
    init()
}
class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}
class SomeSubClass: SomeSuperClass, ODI_SomeProtocol {
    // "required" from ODI_SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}

/*: 
 ## Failable Initializer Requirements
 Protocols can define failable initializer requirements for conforming types, as defined in https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID224.
 A failable initializer requirement can be satisfied by a failable or nonfailable initializer on a conforming type. A nonfailable initializer requirement can be satisfied by a nonfailable initializer or an implicitly unwrapped failable initializer.
 */

/*:
 ## Protocols as Types
 Because it is a type, you can use a protocol in many places where other types are allowed, including:
 - As a parameter type or return type in a function, method, or initializer
 - As the type of a constant, variable, or property
 - As the type of items in an array, dictionary, or other container
 - NOTE:
 Because protocols are types, begin their names with a capital letter (such as FullyNamed and RandomNumberGenerator) to match the names of other types in Swift (such as Int, String, and Double).
 */
class Dice {
    let sides: Int
    /// The generator property is of type RandomNumberGenerator. Therefore, you can set it to an instance of any type that adopts the RandomNumberGenerator protocol. Nothing else is required of the instance you assign to this property, except that the instance must adopt the RandomNumberGenerator protocol.
    let generator: RandomNumberGenerator

    /// Dice also has an initializer, to set up its initial state. This initializer has a parameter called generator, which is also of type RandomNumberGenerator. You can pass a value of any conforming type in to this parameter when initializing a new Dice instance.
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }

    func roll() -> Int {
        return Int(generator.random()*Double(sides)) + 1
    }
}
// class support protocol is Protocol
// 10 以内的随机数
var d6 = Dice(sides: 10, generator: LinearCongruentialGenerator())
for _ in 0...9 {
    print("Random dice roll is \(d6.roll())")
}


//: # Delegation
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}
class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        print(board)
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(game:self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(game:self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(game:self)
    }
}

/*:
 - Note:
 that the delegate property is defined as an optional DiceGameDelegate, because a delegate isn’t required in order to play the game. Because it is of an optional type, the delegate property is automatically set to an initial value of nil. Thereafter, the game instantiator has the option to set the property to a suitable delegate.
 */
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            ("Started a new game of Snakes and Ladders")
        }
        ("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        ("Rolled a \(diceRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        ("The game lasted for \(numberOfTurns) turns")
    }
}
//: In action:
let tracker = DiceGameTracker() //new instance
let game = SnakesAndLadders()
game.delegate = tracker
game.play()







// just showing the notation
func f(f:protocol<CustomStringConvertible, CustomDebugStringConvertible>) {}







// system protocol
struct Nest : ExpressibleByIntegerLiteral {
    var eggCount : Int = 0
    init() {}
    init(integerLiteral val: Int) {
        self.eggCount = val
    }
}
func reportEggs(nest: Nest) {
    ("this nest contains \(nest.eggCount) eggs")
}
reportEggs(nest: 4)






/*: ## Adding Protocol Conformance with an Extension
 You can extend an existing type to adopt and conform to a new protocol, even if you do not have access to the source code for the existing type.
 Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand
 */
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
(d12.textualDescription)
/*: Declaring Protocol Adoption with an Extension */
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}
//: Protocols can also be added to collections
let simon = Hamster(name: "Simon")
let things: [TextRepresentable] = [d12, simon]

for thing in things {
    (thing.textualDescription)
}
things[0].textualDescription
things[1].textualDescription

//: ## Protocol Inheritance
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

/*:
 This example defines a new protocol, PrettyTextRepresentable, which inherits from TextRepresentable.
 Anything that adopts PrettyTextRepresentable must satisfy all of the requirements enforced by TextRepresentable,
 plus the additional requirements enforced by PrettyTextRepresentable.
 */


/*:
 ## Class-Only Protocols
 You can limit protocol adoption采用 to class types (and not structures or enumerations) by adding the class keyword to a protocol’s inheritance list. The class keyword must always appear first in a protocol’s inheritance list, before any inherited protocols
 */
protocol SomeInheritedProtocol {}
protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
    // class-only protocol definition goes here
}
/*:
 ## Protocol Composition
 It can be useful to require a type to conform to multiple protocols at once.
 You can combine multiple protocols into a single requirement with a protocol composition.
 Protocol compositions have the form protocol<SomeProtocol, AnotherProtocol>.
 You can list as many protocols within the pair of angle brackets (<>) as you need, separated by commas.
 */
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Personn: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    ("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}
let birthdayPerson = Personn(name: "Malcolm", age: 21)
wishHappyBirthday(celebrator:birthdayPerson) //输出wishHappyBirthday

/*:
 - NOTE:
 Protocol compositions do not define a new, permanent protocol type.
 Rather, they define a temporary local protocol that has the combined requirements of all protocols in the composition.
 */


/*:
 ## Checking for Protocol Conformance
 You can use the is and as operators described in Type Casting to check for protocol conformance,
 and to cast to a specific protocol. Checking for and casting to a protocol follows exactly the same syntax as checking for and casting to a type:
 - The is operator returns true if an instance conforms to a protocol and returns false if it does not.
 - The as? version of the downcast operator returns an optional value of the protocol’s type, and this value is nil if the instance does not conform to that protocol.
 - The as! version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast does not succeed.
 */


/*:
 ## Optional Protocol Requirements
 Optional requirements are prefixed by the optional modifier as part of the protocol’s definition.
 When you use a method or property in an optional requirement, its type automatically becomes an optional.
 For example, a method of type (Int) -> String becomes ((Int) -> String)?. Note that the entire function type is wrapped in the optional, not method’s the return value.
 You check for an implementation of an optional method by writing a question mark after the name of the method when it is called, such as someOptionalMethod?(someArgument).
 - NOTE:
 Optional protocol requirements can only be specified if your protocol is marked with the @objc attribute.
 This attribute indicates that the protocol should be exposed to Objective-C code and is described in
 Using Swift with Cocoa and Objective-C (Swift 2.1). Even if you are not interoperating with Objective-C,
 you need to mark your protocols with the @objc attribute if you want to specify optional requirements.
 Note also that @objc protocols can be adopted only by classes that inherit from
 Objective-C classes or other @objc classes. They can’t be adopted by structures or enumerations.
 */

@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}
/// 通过扩展实现optional
//protocol CDS {
//    func incrementForCount(count: Int) -> Int
//}
//extension CDS {
//    var fixedIncrement: Int { get }
//}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count:count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

/*:
 Because the call to incrementForCount(_:) can fail for either of these two reasons,
 the call returns an optional Int value. This is true even though incrementForCount(_:)
 is defined as returning a nonoptional Int value in the definition of CounterDataSource.
 */
/*:
 ## Protocol Extensions
 */

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

//: By creating an extension on the protocol, all conforming types automatically gain this method implementation without any additional modification.

let PE_generator = LinearCongruentialGenerator()
("Here's a random number: \(PE_generator.random())")
("And here's a random Boolean: \(PE_generator.randomBool())")


/*:
 You can use protocol extensions to provide a default implementation to any method or property requirement of that protocol.
 If a conforming type provides its own implementation of a required method or property, that implementation will be used instead of the one provided by the extension.
 - NOTE:
 Protocol requirements with default implementations provided by extensions are distinct from optional protocol requirements.
 Although conforming types don’t have to provide their own implementation of either, requirements with default implementations can be called without optional chaining.
 */

/*:
 When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available. You write these constraints after the name of the protocol you’re extending using a where clause.
 */

extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator:", ") + "]"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

//: Because Array conforms to CollectionType and the array’s elements conform to the TextRepresentable protocol, the array can use the textualDescription property to get a textual representation of its contents.
(hamsters.textualDescription)
/*:
 - NOTE:
 If a conforming type satisfies the requirements for multiple constrained extensions that provide implementations for the same method or property, Swift will use the implementation corresponding to the most specialized constraints.
 */

////: ## Protocol Example
////: ### Example 1
//protocol Strokable {
//    var strokeWidth: Double {get set}
//}
//
//protocol Fullable {
//    var fullColor: Color? {get set}
//}
//
//enum Color { //fullColor协议属性的类型定义
//    case red, green, blue, yellow, cyan
//}
//
//protocol HasArea: Fullable, Strokable { //协议多继承
//    var area: Double {get}
//}
//
//protocol Mathable {
//    static var pi: Double {get}
//    static var e: Double {get}
//}
//
//struct Rect: HasArea, Mathable {
//    var width: Double
//    var height: Double
//    init(width: Double, height: Double){
//        self.width = width
//        self.height = height
//    }
//    var fullColor: Color?
//    var strokeWidth: Double = 0.0
//    var area: Double {
//        get{
//            return width * height
//        }
//    }
//    static var pi: Double = 3.14159535
//    static var e: Double = 2.71828
//}

//protocol Flier {
//    func fly()
//}
//struct Bird: Flier {
//    func fly() {
//    }
//    func getWorm() {
//    }
//}
//struct Bee {
//    func fly() {
//    }
//}
//func tellToFly(f: Flier) {
//    f.fly()
//}
//enum Filter: String, CustomStringConvertible {
//    case Albums = "Albums"
//    case Playlists = "Playlists"
//    case Podcasts = "Podcasts"
//    case Books = "Audiobooks"
//    var description: String { return self.rawValue }
//}
//func isBird(f: Flier) -> Bool {
//    return f is Bird
//}
//func tellGetWorm(f: Flier) {
//    (f as? Bird)?.getWorm()
//}
//struct Insect: Flier {
//    func fly() {
//    }
//}
//
//let b = Bird()
//tellToFly(b)
//let b2 = Bee()
//// tellToFly(b2) //compile error
//let type = Filter.Albums
//"It is \(type)"
//let ok = isBird(Bird())
//let ok2 = isBird(Insect())
//_ = b2

//: [Next](@next)
