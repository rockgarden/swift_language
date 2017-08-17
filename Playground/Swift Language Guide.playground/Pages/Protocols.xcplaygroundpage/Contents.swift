//: [Previous](@previous)
import UIKit
/*: 
 # Protocol
 灵活的提供Func或Var
 */
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
 A protocol can require any conforming type to provide an instance property or type property with a particular name and type. The protocol doesn’t specify whether the property should be a stored property or a computed property—it only specifies the required property name and type. The protocol also specifies whether each property must be gettable or gettable and settable. 协议可以要求任何一致的类型来提供具有特定名称和类型的实例属性或类型属性。 协议不指定属性是存储属性还是计算属性，它只指定必需的属性名称和类型。 该协议还规定了每个属性是否必须是gettable或gettable和可设置的。
 If a protocol requires a property to be gettable and settable, that property requirement cannot be fulfilled by a constant stored property or a read-only computed property. If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it is valid for the property to be also settable if this is useful for your own code. 如果一个协议需要一个属性来获取和设置属性，则该属性要求不能由常量存储属性或只读计算属性来实现。 如果协议只需要一个属性为gettable，则可以通过任何类型的属性来满足要求，如果对于您自己的代码有用，属性也可以设置。
 Property requirements are always declared as variable properties, prefixed with the var keyword. Gettable and settable properties are indicated by writing { get set } after their type declaration, and gettable properties are indicated by writing { get }. 属性要求始终声明为变量属性，前缀为var关键字。 Gettable和可设置的属性通过在类型声明之后编写{get set}来表示，gettable属性通过写{get}来表示。
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
 If you define a protocol instance method requirement that is intended to mutate instances of any type that adopts the protocol, mark the method with the mutating keyword as part of the protocol’s definition. This enables structures and enumerations to adopt the protocol and satisfy that method requirement. 如果您定义了一个协议实例方法要求，该要求旨在使采用协议的任何类型的实例变异，请使用mutating关键字将该方法标记为协议定义的一部分。 这使得结构和枚举能够采用协议并满足该方法的要求。
 - NOTE:
 If you mark a protocol instance method requirement as mutating, you do not need to write the mutating keyword when writing an implementation of that method for a class. The mutating keyword is only used by structures and enumerations. 
 在 class 中实现带有mutating方法的接口时, 不用mutating进行修饰, 因为对于class来说, 类的成员变量和方法都是透明的, 所以不必使用 mutating 来进行修饰
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
class OnOffClass: Togglable {

    enum OnOff {
        case off, on
    }

    var onOff: OnOff
    init(oo: OnOff) {
        self.onOff = oo
    }

    func toggle() {
        switch onOff {
        case .off:
            onOff = .on
        case .on:
            onOff = .off
        }
        print(onOff.hashValue)
    }
}
do {
    var lightSwitch = OnOffSwitch.Off
    var onOffClass = OnOffClass(oo: .off)
    lightSwitch.toggle()
    onOffClass.toggle()
}

//: # Initializer Requirements
protocol IR_SomeProtocol {
    init(someParameter: Int)
}
/*: 
 ## Class Implementations of Protocol Initializer Requirements
 You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier 您可以将一个符合类的协议初始化器要求实现为指定的初始化程序或方便的初始化程序。 在这两种情况下，您必须使用必需的修饰符标记初始化程序实现:
 */
class CIoPIR_SomeClass: IR_SomeProtocol {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}
//: The use of the required modifier ensures that you provide an explicit or inherited implementation of the initializer requirement on all subclasses of the conforming class, such that they also conform to the protocol.For more information on required initializers, 使用必需的修饰符确保您提供对符合类的所有子类的初始化程序要求的显式或继承的实现，以便它们也符合协议。有关所需初始化程序的更多信息, see https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID231.
final class SomeFinalClass: IR_SomeProtocol {
    init(someParameter: Int) {}
}
/*:
 - NOTE:
 You do not need to mark protocol initializer implementations with the required modifier on classes that are marked with the final modifier, because final classes cannot be subclassed. For more on the final modifier, 您不需要在标有最后修饰符的类上标记具有必需修饰符的协议初始化程序实现，因为最终类不能被子类化。 有关最终修饰符的更多信息, see https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Inheritance.html#//apple_ref/doc/uid/TP40014097-CH17-ID202.
 */
//: If a subclass overrides a designated initializer from a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the required and override modifiers 如果一个子类覆盖了一个超类的指定的初始化器，并且还从一个协议中实现了一个匹配的初始化器要求，那么使用必需和覆盖修饰符来标记初始化器实现:
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
 - As a parameter type or return type in a function, method, or initializer 作为函数，方法或初始化程序中的参数类型或返回类型
 - As the type of a constant, variable, or property 作为常量，变量或属性的类型
 - As the type of items in an array, dictionary, or other container 作为数组，字典或其他容器中的项目类型
 - NOTE:
 Because protocols are types, begin their names with a capital letter (such as FullyNamed and RandomNumberGenerator) to match the names of other types in Swift (such as Int, String, and Double). 由于协议是类型，请使用大写字母（如FullyNamed和RandomNumberGenerator）开始其名称，以匹配Swift中其他类型的名称（如Int，String和Double）.
 */
class Dice {
    let sides: Int
    /// The generator property is of type RandomNumberGenerator. Therefore, you can set it to an instance of any type that adopts the RandomNumberGenerator protocol. Nothing else is required of the instance you assign to this property, except that the instance must adopt the RandomNumberGenerator protocol. generator属性的类型为RandomNumberGenerator。 因此，您可以将其设置为采用RandomNumberGenerator协议的任何类型的实例。 除了实例必须采用RandomNumberGenerator协议外，您不需要为此属性分配的实例。
    let generator: RandomNumberGenerator

    /// Dice also has an initializer, to set up its initial state. This initializer has a parameter called generator, which is also of type RandomNumberGenerator. You can pass a value of any conforming type in to this parameter when initializing a new Dice instance. 骰子还有一个初始化器，设置它的初始状态。 这个初始化器有一个叫做generator的参数，它也是RandomNumberGenerator类型。 在初始化新的Dice实例时，可以将任何符合类型的值传递给此参数。
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
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}
class SnakesAndLadders: DiceGame {
    let finalSquare = 25

    /// The dice property is declared as a constant property because it does not need to change after initialization, and the protocol only requires that it is gettable.
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]

    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }

    /// Because the delegate property is an optional DiceGameDelegate, the play() method uses optional chaining each time it calls a method on the delegate. If the delegate property is nil, these delegate calls fail gracefully and without error. If the delegate property is non-nil, the delegate methods are called, and are passed the SnakesAndLadders instance as a parameter(因为delegate属性是可选的DiceGameDelegate，所以play（）方法在每次调用委托方法时使用可选链接。 如果委托属性为nil，那么这些委托调用将以正常方式正常运行，而且没有错误。 如果委托属性不为零，则委托方法被调用，并将SnakesAndLadders实例作为参数传递). 影响ARC
    var delegate: DiceGameDelegate?

    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
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
        delegate?.gameDidEnd(self)
    }
}

/*:
 - Note:
 that the delegate property is defined as an optional DiceGameDelegate, because a delegate isn’t required in order to play the game. Because it is of an optional type, the delegate property is automatically set to an initial value of nil. Thereafter, the game instantiator has the option to set the property to a suitable delegate.
 */
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


/*: 
 # Adding Protocol Conformance with an Extension
 You can extend an existing type to adopt and conform to a new protocol, even if you do not have access to the source code for the existing type. Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand. 即使您无法访问现有类型的源代码，也可以扩展现有类型以采用并符合新协议。 扩展可以将新的属性，方法和下标添加到现有类型，因此能够添加协议可能需要的任何要求。
 - NOTE:
 Existing instances of a type automatically adopt and conform to a protocol when that conformance is added to the instance’s type in an extension. 当扩展中添加实例的类型时，类型的现有实例会自动采用并符合协议。
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

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
(game.textualDescription)

/*: 
 ## Declaring Protocol Adoption with an Extension
 */
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
simonTheHamster.textualDescription
/// Must explicitly declare their adoption of the protocol: 必须显式声明其采用的协议.
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
/*:
 - NOTE:
 Types do not automatically adopt a protocol just by satisfying its requirements. They must always explicitly declare their adoption of the protocol.
 */


//: # Collections of Protocol Types
let things: [TextRepresentable] = [game, d12, simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}
things[0].textualDescription
things[1].textualDescription


//: # Protocol Inheritance
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

/// This example defines a new protocol, PrettyTextRepresentable, which inherits from TextRepresentable. Anything that adopts PrettyTextRepresentable must satisfy all of the requirements enforced by TextRepresentable, plus the additional requirements enforced by PrettyTextRepresentable. In this example, PrettyTextRepresentable adds a single requirement to provide a gettable property called prettyTextualDescription that returns a String.
extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        /// Anything that is PrettyTextRepresentable must also be TextRepresentable, and so the implementation of prettyTextualDescription starts by accessing the textualDescription property from the TextRepresentable protocol to begin an output string.
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
do {
    print(game.prettyTextualDescription)
}


/*:
 # Class-Only Protocols
 You can limit protocol adoption to class types (and not structures or enumerations) by adding the class keyword to a protocol’s inheritance list. The class keyword must always appear first in a protocol’s inheritance list, before any inherited protocols
 class关键字用来限制的协议只能应用在类上
 */
protocol SomeInheritedProtocol {}
protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
    // class-only protocol definition goes here
}


/*:
 # Protocol Composition
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
do {
    func wishHappyBirthday(to celebrator: protocol<Named, Aged>) {
        print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
    }
    do {
        func wishHappyBirthday(to celebrator: Named & Aged) { }
    }
    let birthdayPerson = Personn(name: "Malcolm", age: 21)
    wishHappyBirthday(to:birthdayPerson)
}
/*:
 - NOTE:
 Protocol compositions do not define a new, permanent protocol type.Rather, they define a temporary local protocol that has the combined requirements of all protocols in the composition.
 协议组成不定义新的永久协议类型。 相反，它们定义了具有组合中所有协议的组合要求的临时本地协议。
 */


/*:
 # Checking for Protocol Conformance
 检查协议一致性
 You can use the is and as operators described in Type Casting to check for protocol conformance,
 and to cast to a specific protocol. Checking for and casting to a protocol follows exactly the same syntax as checking for and casting to a type:
 - The is operator returns true if an instance conforms to a protocol and returns false if it does not.
 - The as? version of the downcast operator returns an optional value of the protocol’s type, and this value is nil if the instance does not conform to that protocol.
 - The as! version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast does not succeed.
 */
protocol HasArea {
    var area: Double { get }
}
class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}
do {
    /// The Circle, Country and Animal classes do not have a shared base class. Nonetheless, they are all classes, and so instances of all three types can be used to initialize an array that stores values of type AnyObject.
    let objects: [AnyObject] = [
        Circle(radius: 2.0),
        Country(area: 243_610),
        Animal(legs: 4)
    ]
    for object in objects {
        if let objectWithArea = object as? HasArea {
            print("Area is \(objectWithArea.area)")
        } else {
            print("Something that doesn't have an area")
        }
    }
}


/*:
 # Optional Protocol Requirements
 You can define optional requirements for protocols, These requirements do not have to be implemented by types that conform to the protocol. Optional requirements are prefixed by the optional modifier as part of the protocol’s definition. Optional requirements are available so that you can write code that interoperates with Objective-C. Both the protocol and the optional requirement must be marked with the @objc attribute. Note that @objc protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes. They can’t be adopted by structures or enumerations.
 您可以为协议定义可选的要求，这些要求不必由符合协议的类型实现。可选要求作为协议定义的一部分由可选修饰符作为前缀。提供了可选的要求，以便您可以编写与Objective-C互操作的代码。协议和可选要求都必须用@objc属性标记。注意，@objc协议只能通过继承Objective-C类或其他@objc类的类来采用。它们不能被结构或枚举采用。
 When you use a method or property in an optional requirement, its type automatically becomes an optional. For example, a method of type (Int) -> String becomes ((Int) -> String)?. Note that the entire function type is wrapped in the optional, not the method’s return value.
 当在可选需求中使用方法或属性时，其类型将自动变为可选。例如，类型（Int） - > String的方法变成（（Int） - > String）？。注意，整个函数类型都是可选的，而不是方法的返回值。
 An optional protocol requirement can be called with optional chaining, to account for the possibility that the requirement was not implemented by a type that conforms to the protocol. You check for an implementation of an optional method by writing a question mark after the name of the method when it is called, such as someOptionalMethod?(someArgument).
 可选的协议需求可以使用可选的链接来调用，以说明需求不是由符合协议的类型实现的可能性。通过在调用方法的名称之后写一个问号，例如someOptionalMethod？（someArgument），可以检查可选方法的实现。有关可选链接的信息，请参阅可选链接。
 */
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}
/* 
 - NOTE:
 Strictly speaking, you can write a custom class that conforms to CounterDataSource without implementing either protocol requirement. They are both optional, after all. Although technically allowed, this wouldn’t make for a very good data source.
 */
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        /// First, it is possible that dataSource may be nil, and so dataSource has a question mark after its name to indicate that increment(forCount:) should be called only if dataSource isn’t nil. Second, even if dataSource does exist, there is no guarantee that it implements increment(forCount:), because it is an optional requirement.
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

do {
    class ThreeSource: NSObject, CounterDataSource {
        let fixedIncrement = 3
    }
    var counter = Counter()
    counter.dataSource = ThreeSource()
    for _ in 1...4 {
        counter.increment()
        print(counter.count)
    }
}

@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}
do {
    var counter = Counter()
    counter.count = -4
    counter.dataSource = TowardsZeroSource()
    for _ in 1...5 {
        counter.increment()
        print(counter.count)
    }
}

/// 通过扩展实现optional
//protocol CDS {
//    func incrementForCount(count: Int) -> Int
//}
//extension CDS {
//    var fixedIncrement: Int { get }
//}


/*:
 # Protocol Extensions
 Protocols can be extended to provide method and property implementations to conforming types. This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.
 */
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
do {
    let generator = LinearCongruentialGenerator()
    print("Here's a random number: \(generator.random())")
    print("And here's a random Boolean: \(generator.randomBool())")
}

/*: 
 ## Providing Default Implementations
 You can use protocol extensions to provide a default implementation to any method or computed property requirement of that protocol. If a conforming type provides its own implementation of a required method or property, that implementation will be used instead of the one provided by the extension.
 - NOTE:
 Protocol requirements with default implementations provided by extensions are distinct from optional protocol requirements. Although conforming types don’t have to provide their own implementation of either, requirements with default implementations can be called without optional chaining.
 */
extension PrettyTextRepresentable  {
    var default_prettyTextualDescription: String {
        return textualDescription
    }
}

/*:
 ## Adding Constraints to Protocol Extensions
 向协议扩展添加约束
 When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available. You write these constraints after the name of the protocol you’re extending using a generic where clause, as described in https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID192.
 */
extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator:", ") + "]"
    }
}
do {
    let murrayTheHamster = Hamster(name: "Murray")
    let morganTheHamster = Hamster(name: "Morgan")
    let mauriceTheHamster = Hamster(name: "Maurice")
    let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
    //: Because Array conforms to CollectionType and the array’s elements conform to the TextRepresentable protocol, the array can use the textualDescription property to get a textual representation of its contents.
    (hamsters.textualDescription)
}
/*:
 - NOTE:
 If a conforming type satisfies the requirements for multiple constrained extensions that provide implementations for the same method or property, Swift will use the implementation corresponding to the most specialized constraints.
 如果符合类型满足为同一方法或属性提供实现的多个约束扩展的要求，Swift将使用与最专用约束相对应的实现。
 */



//: # Example

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
do {
    func reportEggs(nest: Nest) {
        ("this nest contains \(nest.eggCount) eggs")
    }
    reportEggs(nest: 4)
}


protocol Strokable {
    var strokeWidth: Double {get set}
}
enum Color { //fullColor协议属性的类型定义
    case red, green, blue, yellow, cyan
}
protocol Fullable {
    var fullColor: Color? {get set}
}
protocol DrawArea: Fullable, Strokable { //协议多继承
    var area: Double {get}
}

protocol Mathable {
    static var pi: Double {get}
    static var e: Double {get}
}
struct Rect: DrawArea, Mathable {
    var width: Double
    var height: Double
    init(width: Double, height: Double){
        self.width = width
        self.height = height
    }
    var fullColor: Color?
    var strokeWidth: Double = 0.0
    var area: Double {
        get{
            return width * height
        }
    }
    static var pi: Double = 3.14159535
    static var e: Double = 2.71828
}


protocol Flier {
    func fly()
}
struct Bird: Flier {
    func fly() {}
    func getWorm() {}
}
struct Bee {
    func fly() {}
}
enum Filter: String, CustomStringConvertible {
    case Albums = "Albums"
    case Playlists = "Playlists"
    case Podcasts = "Podcasts"
    case Books = "Audiobooks"
    var description: String { return self.rawValue }
}
struct Insect: Flier {
    func fly() {}
}
do {
    func isBird(_ f: Flier) -> Bool {
        return f is Bird
    }
    func tellGetWorm(_ f: Flier) {
        (f as? Bird)?.getWorm()
    }
    func tellToFly(_ f: Flier) {
        f.fly()
    }
    let b = Bird()
    tellToFly(b)
    let b2 = Bee()
    // tellToFly(b2) //compile error
    let type = Filter.Albums
    "It is \(type)"
    let ok = isBird(Bird())
    let ok2 = isBird(Insect())
}


//: [Next](@next)
