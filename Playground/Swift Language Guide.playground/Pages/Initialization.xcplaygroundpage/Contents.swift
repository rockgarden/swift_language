//: [Previous](@previous)
import UIKit
import AVFoundation
/*: 
 # Initialization 初始化
 Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready for use.

 You implement this initialization process by defining initializers, which are like special methods that can be called to create a new instance of a particular type. Unlike Objective-C initializers, Swift initializers do not return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they are used for the first time.

 Instances of class types can also implement a deinitializer, which performs any custom cleanup just before an instance of that class is deallocated. For more information about deinitializers, see Deinitialization.
 */
/*
 # Setting Initial Values for Stored Properties

 Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties cannot be left in an indeterminate state.

 You can set an initial value for a stored property within an initializer, or by assigning a default property value as part of the property’s definition.

 - NOTE:
 When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
 */

/*
 ## Initializers

 Initializers are called to create a new instance of a particular type. In its simplest form, an initializer is like an instance method with no parameters, written using the init keyword.
 */
do {
    /// The structure defines a single initializer, init, with no parameters, which initializes the stored temperature with a value of 32.0 (the freezing point of water in degrees Fahrenheit).
    struct Fahrenheit {
        var temperature: Double
        init() {
            temperature = 32.0
        }
    }
    var f = Fahrenheit()
    print("The default temperature is \(f.temperature)° Fahrenheit")
}

/*:
 ## Default Property Values

 You can set the initial value of a stored property from within an initializer, as shown above. Alternatively, specify a default property value as part of the property’s declaration. You specify a default property value by assigning an initial value to the property when it is defined.

 - NOTE:
 If a property always takes the same initial value, provide a default value rather than setting a value within an initializer. The end result is the same, but the default value ties the property’s initialization more closely to its declaration. It makes for shorter, clearer initializers and enables you to infer the type of the property from its default value. The default value also makes it easier for you to take advantage of default initializers and initializer inheritance.
 如果属性始终采用相同的初始值，请提供默认值，而不是在初始化程序中设置值。 最终的结果是一样的，但是默认值会将属性的初始化与其声明密切相关。 它使更短，更清晰的初始化程序，使您能够从其默认值推断属性的类型。 默认值还使您更容易利用默认初始化和初始化器继承，如本章后面所述。
 */
do {
    struct Fahrenheit {
        var temperature = 32.0
    }
}

/*:
 # Customizing Initialization

 You can customize the initialization process with input parameters and optional property types, or by assigning constant properties during initialization, as described in the following sections.

 ## Initialization Parameters

 You can provide initialization parameters as part of an initializer’s definition, to define the types and names of values that customize the initialization process. Initialization parameters have the same capabilities and syntax as function and method parameters.
 */
do {
    /// The Celsius structure implements two custom initializers called init(fromFahrenheit:) and init(fromKelvin:), which initialize a new instance of the structure with a value from a different temperature scale:
    struct Celsius {
        var temperatureInCelsius: Double
        init(fromFahrenheit fahrenheit: Double) {
            temperatureInCelsius = (fahrenheit - 32.0) / 1.8
        }
        init(fromKelvin kelvin: Double) {
            temperatureInCelsius = kelvin - 273.15
        }
    }
    let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
    // boilingPointOfWater.temperatureInCelsius is 100.0
    let freezingPointOfWater = Celsius(fromKelvin: 273.15)
    // freezingPointOfWater.temperatureInCelsius is 0.0
}

/*:
 ## Parameter Names and Argument Labels

 As with function and method parameters, initialization parameters can have both a parameter name for use within the initializer’s body and an argument label for use when calling the initializer.

 However, initializers do not have an identifying function name before their parentheses in the way that functions and methods do. Therefore, the names and types of an initializer’s parameters play a particularly important role in identifying which initializer should be called. Because of this, Swift provides an automatic argument label for every parameter in an initializer if you don’t provide one.
 */
do {
    struct Color {
        let red, green, blue: Double
        init(red: Double, green: Double, blue: Double) {
            self.red   = red
            self.green = green
            self.blue  = blue
        }
        init(white: Double) {
            red   = white
            green = white
            blue  = white
        }
    }
    let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
    let halfGray = Color(white: 0.5)
    //let veryGreen = Color(0.0, 1.0, 0.0)
    // this reports a compile-time error - argument labels are required
}

/*:
 ## Initializer Parameters Without Argument Labels

 If you do not want to use an argument label for an initializer parameter, write an underscore (_) instead of an explicit argument label for that parameter to override the default behavior.
 */
do {
    struct Celsius {
        var temperatureInCelsius: Double
        init(_ celsius: Double) {
            temperatureInCelsius = celsius
        }
    }
    let bodyTemperature = Celsius(37.0)
    // bodyTemperature.temperatureInCelsius is 37.0
}

/*:
 ## Optional Property Types

 If your custom type has a stored property that is logically allowed to have “no value”—perhaps because its value cannot be set during initialization, or because it is allowed to have “no value” at some later point—declare the property with an optional type. Properties of optional type are automatically initialized with a value of nil, indicating that the property is deliberately intended to have “no value yet” during initialization.
 
 如果您的自定义类型具有在逻辑上允许具有“no value”的存储属性 - 或许是因为在初始化期间无法设置其值，或者因为允许在稍后的某个时间点具有“no value” 可选类型。 可选类型的属性将自动初始化为nil值，表示该属性在初始化期间故意打算“没有值”。
 */
do {
    class SurveyQuestion {
        var text: String
        var response: String?
        init(text: String) {
            self.text = text
        }
        func ask() {
            print(text)
        }
    }
    let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
    cheeseQuestion.ask()
    // Prints "Do you like cheese?"
    cheeseQuestion.response = "Yes, I do like cheese."
}

/*:
 ## Assigning Constant Properties During Initialization
 初始化期间分配常量属性
 
 You can assign a value to a constant property at any point during initialization, as long as it is set to a definite value by the time initialization finishes. Once a constant property is assigned a value, it can’t be further modified.

 只要在初始化完成时将其设置为一个确定的值，您可以在初始化期间的任意时间为一个常量属性赋值。 一旦一个常量属性被分配一个值，就不能进一步修改。

 - NOTE:
 For class instances, a constant property can be modified during initialization only by the class that introduces it. It cannot be modified by a subclass.
 
 对于类实例，常量属性可以在初始化期间被引入它的类修改。 它不能被子类修改。
 */
do {
    class SurveyQuestion {
        let text: String
        var response: String?
        init(text: String) {
            self.text = text
        }
        func ask() {
            print(text)
        }
    }
    let beetsQuestion = SurveyQuestion(text: "How about beets?")
    beetsQuestion.ask()
    // Prints "How about beets?"
    beetsQuestion.response = "I also like beets. (But not with cheese.)"
}

/*:
 # Default Initializers

 Swift provides a default initializer for any structure or class that provides default values for all of its properties and does not provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.
 
 Swift为任何为其所有属性提供默认值的结构或类提供了一个默认的初始化程序，并且不提供至少一个初始化程序本身。 默认的初始化程序只需创建一个新的实例，将其所有属性设置为其默认值。
 */
do {
    class ShoppingListItem {
        var name: String?
        var quantity = 1
        var purchased = false
    }
    var item = ShoppingListItem()
}

/*:
 ## Memberwise Initializers for Structure Types
 成员初始化器结构类型

 Structure types automatically receive a memberwise initializer if they do not define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that do not have default values.
 
 如果结构类型没有定义任何自己的自定义初始值设置，它们将自动接收成员初始值。 与默认初始化程序不同，即使存储的属性没有默认值，该结构也会接收成员初始值。

 The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.
 
 成员初始化器是初始化新结构实例的成员属性的简写方式。 可以通过名称将新实例的属性的初始值传递给成员初始化器。
 */
do {
    /// default values 被覆盖
    struct Size {
        var width = 0.0, height = 0.0
    }
    let twoByTwo = Size(width: 2.0, height: 2.0)
    print(twoByTwo)
}

/*:
 # Initializer Delegation for Value Types
 值类型的初始化器委派

 Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.
 
 初始化器可以调用其他初始化器来执行实例初始化的一部分。这个称为初始化器委派的过程避免了跨多个初始化器复制代码。

 The rules for how initializer delegation works, and for what forms of delegation are allowed, are different for value types and class types. Value types (structures and enumerations) do not support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves. Classes, however, can inherit from other classes, as described in Inheritance. This means that classes have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization. These responsibilities are described in Class Inheritance and Initialization below.
 
 对于类型和类类型，初始化器委派的工作原理以及允许的委托形式的规则是不同的。值类型（结构和枚举）不支持继承，因此它们的初始化器委派过程相对简单，因为它们只能委托给他们自己提供的另一个初始化器。但是，类可以继承自其他类，如继承中所述。这意味着类有额外的责任，确保在继承的所有存储的属性在初始化期间被赋予合适的值。这些职责在下面的类继承和初始化中描述。

 For value types, you use self.init to refer to other initializers from the same value type when writing your own custom initializers. You can call self.init only from within an initializer.
 
 对于值类型，在编写自己的自定义初始化器时，您可以使用self.init引用来自相同值类型的其他初始化器。您只能从初始化程序中调用self.init。

 Note that if you define a custom initializer for a value type, you will no longer have access to the default initializer (or the memberwise initializer, if it is a structure) for that type. This constraint prevents a situation in which additional essential setup provided in a more complex initializer is accidentally circumvented by someone using one of the automatic initializers.
 
 请注意，如果为值类型定义自定义初始值设置，那么您将无法再访问该类型的默认初始化程序（或成员初始化程序，如果是结构体）。该约束防止了使用其中一个自动初始化器的人意外避开在更复杂的初始化器中提供的附加基本设置的情况。

 - NOTE:
 If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation. For more information, see Extensions.
 
 如果您希望使用默认的初始化程序和成员初始化程序以及自己的自定义初始化程序来初始化自定义值类型，请在扩展中编写自定义初始值设置，而不是值类型的原始实现的一部分。
 */
do {
    struct Size {
        var width = 0.0, height = 0.0
    }
    struct Point {
        var x = 0.0, y = 0.0
    }
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
    let basicRect = Rect()
    // basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)
    let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))
    // originRect's origin is (2.0, 2.0) and its size is (5.0, 5.0)
    let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                          size: Size(width: 3.0, height: 3.0))
    // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
}
/*:
 - NOTE:
 For an alternative way to write this example without defining the init() and init(origin:size:) initializers yourself, see Extensions.
 */

/*:
 # Class Inheritance and Initialization

 All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.

 Swift defines two kinds of initializers for class types to help ensure all stored properties receive an initial value. These are known as designated initializers and convenience initializers.

 ## Designated Initializers and Convenience Initializers

 Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.

 Classes tend to have very few designated initializers, and it is quite common for a class to have only one. Designated initializers are “funnel” points through which initialization takes place, and through which the initialization process continues up the superclass chain.

 Every class must have at least one designated initializer. In some cases, this requirement is satisfied by inheriting one or more designated initializers from a superclass, as described in Automatic Initializer Inheritance below.

 Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.

 You do not have to provide convenience initializers if your class does not require them. Create convenience initializers whenever a shortcut to a common initialization pattern will save time or make initialization of the class clearer in intent.
 */

/*:
 ## Syntax for Designated and Convenience Initializers

 Designated initializers for classes are written in the same way as simple initializers for value types:

 init(parameters) {statements}

 Convenience initializers are written in the same style, but with the convenience modifier placed before the init keyword, separated by a space:

 convenience init(parameters) {statements}
 ## Initializer Delegation for Class Types

 To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:

 Rule 1
 A designated initializer must call a designated initializer from its immediate superclass.指定的初始化程序必须从其直接超类调用指定的初始化程序。

 Rule 2
 A convenience initializer must call another initializer from the same class.一个方便的初始化器必须从同一个类调用另一个初始化器。

 Rule 3
 A convenience initializer must ultimately call a designated initializer.一个方便的初始化器必须最终调用指定的初始化器。

 A simple way to remember this is:

 Designated initializers must always delegate up. 向上委托
 Convenience initializers must always delegate across. 横向委托
 
 These rules are illustrated in the figure below: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/initializerDelegation01_2x.png
 
 Here, the superclass has a single designated initializer and two convenience initializers. One convenience initializer calls another convenience initializer, which in turn calls the single designated initializer. This satisfies rules 2 and 3 from above. The superclass does not itself have a further superclass, and so rule 1 does not apply.

 The subclass in this figure has two designated initializers and one convenience initializer. The convenience initializer must call one of the two designated initializers, because it can only call another initializer from the same class. This satisfies rules 2 and 3 from above. Both designated initializers must call the single designated initializer from the superclass, to satisfy rule 1 from above.

 - NOTE:
 These rules don’t affect how users of your classes create instances of each class. Any initializer in the diagram above can be used to create a fully-initialized instance of the class they belong to. The rules only affect how you write the implementation of the class’s initializers.

 The figure below shows a more complex class hierarchy for four classes. It illustrates how the designated initializers in this hierarchy act as “funnel” points for class initialization, simplifying the interrelationships among classes in the chain: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/initializerDelegation02_2x.png
 */



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
do {
    class Human {
        var gender: String
        init() {
            self.gender = "Female"
        }
    }
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
    do {
        let h1 = Human()
        let h2 = Human.init() //definitely permitted in Swift 2.0
        h1.self
        let person = Person(fullName: "John")
        (person.name)
    }
}

//: convenience init 参数不同
do {
    class Dog6 {
        var name: String
        var license: Int
        init(name: String, license: Int) {
            self.name = name
            self.license = license
        }
        convenience init(license: Int) {
            self.init(name: "Fido", license: license)
        }
    }
    class NoisyDog6: Dog6 {
        convenience init(name: String) {
            self.init(name: name, license: 1)
        }
    }
}

do {
    class Dog7 {
        var name: String
        var license: Int
        init(name: String, license: Int) {
            self.name = name
            self.license = license
        }
        convenience init(license: Int) {
            self.init(name: "Fido", license: license)
        }
    }
    class NoisyDog7: Dog7 {
        init(name: String) {
            super.init(name: name, license: 1)
        }
    }
    do {
        let nd1 = NoisyDog7(name: "Rover")
        // let nd2 = NoisyDog7(name:"Fido", license:1) // compile error
        // let nd3 = NoisyDog7(license:2) // compile error
    }
}

do {
    class Dog8 {
        var name : String
        var license : Int
        init(name: String, license: Int) {
            self.name = name
            self.license = license
        }
        convenience init(license: Int) {
            self.init(name: "Fido", license: license)
        }
    }
    class NoisyDog8 : Dog8 {
        override init(name:String, license:Int) {
            super.init(name: name, license: license)
        }
    }
    do {
        let nd1 = NoisyDog8(name: "Rover", license: 1)
        let nd2 = NoisyDog8(license: 2)
    }
}
//: required init
do {
    class Dog {
        var name: String
        required init(name: String) {
            self.name = name
        }
    }
    class NoisyDog: Dog {
        var obedient = false
        init(obedient: Bool) {
            self.obedient = obedient
            super.init(name: "Fido")
        }
        // without this override, NoisyDog won't compile
        required init(name: String) {
            super.init(name: name)
        }
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
do {
    class Dog9 {
        var name: String
        var license: Int
        init(name: String, license: Int) {
            self.name = name
            self.license = license
        }
    }
    class NoisyDog9: Dog9 {
        convenience init?() {
            return nil //legal
        }
        init?(ok: Bool) {
            if !ok { return nil }
            // used to give compile error: "all stored properties... must be initialized..."
            // now legal starting in Swift 2.2
            super.init(name: "Fido", license: 123)
        }
        // illegal: init? cannot override init
        // override init?(name:String, license:Int) {
        // super.init(name:name, license:license)
        // }
        override init(name: String, license: Int) {
            super.init(name: name, license: license)
        }
    }
    class ObnoxiousDog9: NoisyDog9 {
        // legal, init can override init?
        override init(ok: Bool) {
            super.init(name: "Fido", license: 123)
        }
    }
    class CrazyDog9: NoisyDog9 {
        override init(ok: Bool) {
            super.init(ok: ok)! // legal: call super's designated init? without ? and by adding !
        }
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
let opts : UIViewAnimationOptions = [.autoreverse, .repeat]
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
        bti = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(bti)
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
