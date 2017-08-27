//: [Previous](@previous)
import UIKit
import AVFoundation
import MediaPlayer
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

    /// For the struct, a memberwise initializer is provided. This means that stored properties don't necessarily need to have an initial value. A default initializer is created for all of them.
    struct Other {
        var temp: Double
        var otherProp: Int = 10
    }
}


/*:
 # Initializer Delegation for Value Types
 值类型的初始化器委派

 Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.
 
 初始化器可以调用其他初始化器来执行实例初始化的一部分。这个称为初始化器委派的过程避免了跨多个初始化器复制代码。

 The rules for how initializer delegation works, and for what forms of delegation are allowed, are different for value types and class types. Value types (structures and enumerations) do not support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves. Classes, however, can inherit from other classes, as described in Inheritance. This means that classes have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization. These responsibilities are described in Class Inheritance and Initialization below.
 
 对于类型和类类型，初始化器委派的工作原理以及允许的委托形式的规则是不同的。值类型（结构和枚举）不支持继承，因此它们的初始化器委派过程相对简单，因为它们只能委托给他们自己提供的另一个初始化器。但是，类可以继承自其他类，如继承中所述。这意味着类有额外的责任，确保在继承的所有存储的属性在初始化期间被赋予合适的值。这些职责在下面的类继承和初始化中描述。

 For value types, you use self.init to refer to other initializers from the same value type when writing your own custom initializers. You can call self.init only from within an initializer. 对于值类型，在编写自己的自定义初始化器时，您可以使用self.init引用来自相同值类型的其他初始化器。您只能从初始化程序中调用self.init。

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

    /// In this case, the second initializer performs delegation, which is calling another initializer within the struct. This is only valid for value types, and not classes, in class must use convenience init!
    struct Rect {
        var origin = Point()
        var size = Size()
        init() {}

        init(origin: Point, size: Size) {
            self.origin = origin
            self.size = size
        }

        /// delegating initializer
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
do {
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
}

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

/*:
 ## Two-Phase Initialization

 Class initialization in Swift is a two-phase process. In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.
 
 Swift中的类初始化是一个两阶段的过程。在第一阶段，每个存储的属性由引入它的类分配一个初始值。一旦确定了每个存储的属性的初始状态，则开始第二阶段，并且在新实例被考虑准备使用之前，给予每个类进一步定制其存储属性的机会。

 The use of a two-phase initialization process makes initialization safe, while still giving complete flexibility to each class in a class hierarchy. Two-phase initialization prevents property values from being accessed before they are initialized, and prevents property values from being set to a different value by another initializer unexpectedly.
 
 使用两阶段初始化过程使初始化安全，同时仍然为类层次结构中的每个类提供完全的灵活性。两阶段初始化可防止在初始化之前访问属性值，并防止属性值由另一个初始值设置意外地设置为不同的值。

 - NOTE:
 Swift’s two-phase initialization process is similar to initialization in Objective-C. The main difference is that during phase 1, Objective-C assigns zero or null values (such as 0 or nil) to every property. Swift’s initialization flow is more flexible in that it lets you set custom initial values, and can cope with types for which 0 or nil is not a valid default value.
 
 Swift的两阶段初始化过程与Objective-C中的初始化相似。主要区别在于，在阶段1中，Objective-C为每个属性分配零个或零个值（如0或nil）。 Swift的初始化流程更灵活，它允许您设置自定义初始值，并且可以处理0或nil不是有效默认值的类型。

 Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:
 
 Swift的编译器执行四个有用的安全检查，以确保两相初始化完成没有错误：

 Safety check 1
 A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer. 指定的初始化程序必须确保其所引用的所有属性在委派为超类初始化程序之前被初始化。

 As mentioned above, the memory for an object is only considered fully initialized once the initial state of all of its stored properties is known. In order for this rule to be satisfied, a designated initializer must make sure that all of its own properties are initialized before it hands off up the chain. 如上所述，只要所有存储的属性的初始状态都已知，对象的存储器才被视为完全初始化。为了使此规则得到满足，指定的初始化程序必须确保其所有的属性都被初始化，然后才能将其链接起来。

 Safety check 2
 A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization. 在将值分配给继承属性之前，指定的初始化程序必须委托给超类初始化程序。如果没有，指定的初始化程序分配的新值将被超类覆盖，作为其自身初始化的一部分。

 Safety check 3
 A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer. 在将值分配给任何属性（包括由同一类定义的属性）之前，方便的初始化程序必须委派给另一个初始化程序。如果没有，便利初始化程序分配的新值将被其自己的类的指定的初始化程序覆盖。

 Safety check 4
 An initializer cannot call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete. 初始化程序不能调用任何实例方法，读取任何实例属性的值，或者将self引用为值，直到初始化的第一阶段完成为止。

 The class instance is not fully valid until the first phase ends. Properties can only be accessed, and methods can only be called, once the class instance is known to be valid at the end of the first phase. 类实例在第一阶段结束之前是不完全有效的。只有在第一阶段结束时，类实例被认为有效才能访问属性，只能调用方法。

 Here’s how two-phase initialization plays out, based on the four safety checks above:
 
 Phase 1

 - A designated or convenience initializer is called on a class.在类上调用指定的或方便的初始化器。
 - Memory for a new instance of that class is allocated. The memory is not yet initialized. 该类的新实例的内存被分配。内存尚未初始化。
 - A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized. 该类的指定的初始化程序确认该类引入的所有存储属性都具有值。这些存储的属性的内存现在被初始化。
 - The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties. 指定的初始化程序将切换到超类初始化程序，为其自己存储的属性执行相同的任务。
 - This continues up the class inheritance chain until the top of the chain is reached. 这继续了类继承链，直到链的顶端到达。
 - Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete. 一旦达到链的顶端，并且链中的最终类确保其所有存储的属性都具有值，则该实例的内存被认为是完全初始化的，阶段1已经完成。

 Phase 2

 - Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on. 从链的顶部回退，链中的每个指定的初始化程序都可以进一步自定义实例。初始化程序现在可以访问自己，并可以修改其属性，调用其实例方法等等。
 - Finally, any convenience initializers in the chain have the option to customize the instance and to work with self. 最后，链中的任何方便的初始化器都可以自定义实例并与自己一起工作。
 
 Here’s how phase 1 looks for an initialization call for a hypothetical subclass and superclass: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/twoPhaseInitialization01_2x.png
 
 In this example, initialization begins with a call to a convenience initializer on the subclass. This convenience initializer cannot yet modify any properties. It delegates across to a designated initializer from the same class.

 The designated initializer makes sure that all of the subclass’s properties have a value, as per safety check 1. It then calls a designated initializer on its superclass to continue the initialization up the chain.

 The superclass’s designated initializer makes sure that all of the superclass properties have a value. There are no further superclasses to initialize, and so no further delegation is needed.

 As soon as all properties of the superclass have an initial value, its memory is considered fully initialized, and Phase 1 is complete.

 Here’s how phase 2 looks for the same initialization call:https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/twoPhaseInitialization02_2x.png
 
 The superclass’s designated initializer now has an opportunity to customize the instance further (although it does not have to).

 Once the superclass’s designated initializer is finished, the subclass’s designated initializer can perform additional customization (although again, it does not have to).

 Finally, once the subclass’s designated initializer is finished, the convenience initializer that was originally called can perform additional customization.

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
            /// Phase 1: Initialize class-defined properties and call the superclass initializer.
            self.name = name
            super.init()
            /// Phase 2: Further customization of local and inherited properties.
            self.gender = "Male"
        }
        convenience init(partialName name: String){
            /// Phase 1: Call designated initializer
            let newName = "\(name) Karmy"
            self.init(fullName: newName)
            /// Phase 2: Access to self and properties
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

/*:
 ## Initializer Inheritance and Overriding

 Unlike subclasses in Objective-C, Swift subclasses do not inherit their superclass initializers by default. Swift’s approach prevents a situation in which a simple initializer from a superclass is inherited by a more specialized subclass and is used to create a new instance of the subclass that is not fully or correctly initialized.
 
 与Objective-C中的子类不同，Swift子类默认不会继承其超类初始值。 Swift的方法防止了超类中的简单初始化器被更专门的子类继承并用于创建未完全或正确初始化的子类的新实例。

 - NOTE:
 Superclass initializers are inherited in certain circumstances, but only when it is safe and appropriate to do so. For more information, see Automatic Initializer Inheritance below. 超类初始化器在某些情况下是继承的，但只有在安全可靠的情况下才能继承。有关更多信息，请参阅下面的自动初始化程序继承。

 If you want a custom subclass to present one or more of the same initializers as its superclass, you can provide a custom implementation of those initializers within the subclass.

 如果您想要一个自定义子类来呈现一个或多个与其超类相同的初始化值，则可以在子类中提供这些初始化器的自定义实现。

 When you write a subclass initializer that matches a superclass designated initializer, you are effectively providing an override of that designated initializer. Therefore, you must write the override modifier before the subclass’s initializer definition. This is true even if you are overriding an automatically provided default initializer, as described in Default Initializers.
 
 当您编写与超类指定的初始化程序相匹配的子类初始化程序时，您将有效地提供该指定的初始化程序的覆盖。因此，您必须在子类的初始化器定义之前编写覆盖修饰符。即使您重写自动提供的默认初始化程序，这一点也是如此，如默认初始化程序中所述。

 As with an overridden property, method or subscript, the presence of the override modifier prompts Swift to check that the superclass has a matching designated initializer to be overridden, and validates that the parameters for your overriding initializer have been specified as intended.
 
 与覆盖属性，方法或下标一样，覆盖修饰符的存在会提示Swift检查超类是否具有匹配的指定的初始化程序以被覆盖，并验证您的重写初始化程序的参数是否按照预期进行了指定。

 - NOTE:
 You always write the override modifier when overriding a superclass designated initializer, even if your subclass’s implementation of the initializer is a convenience initializer. 当覆盖超类指定的初始化程序时，您始终会写入覆盖修饰符，即使您的子类的初始化程序的实现是一个方便的初始化程序。

 Conversely, if you write a subclass initializer that matches a superclass convenience initializer, that superclass convenience initializer can never be called directly by your subclass, as per the rules described above in Initializer Delegation for Class Types. Therefore, your subclass is not (strictly speaking) providing an override of the superclass initializer. As a result, you do not write the override modifier when providing a matching implementation of a superclass convenience initializer.

 相反，如果您编写一个与超类方便初始化程序相匹配的子类初始化程序，那么超类方便初始化程序永远不能由您的子类直接调用，按照上述“类型类型初始化程序委派”中所述的规则。因此，您的子类不是（严格地说）提供超类初始化器的覆盖。因此，当提供超类便利初始化程序的匹配实现时，不要写入覆盖修饰符。
 */
do {
    class Vehicle {
        var numberOfWheels = 0
        var description: String {
            return "\(numberOfWheels) wheel(s)"
        }
    }
    let vehicle = Vehicle()
    print("Vehicle: \(vehicle.description)")
    // Vehicle: 0 wheel(s)

    class Bicycle: Vehicle {
        /// The init() initializer for Bicycle starts by calling super.init(), which calls the default initializer for the Bicycle class’s superclass, Vehicle. This ensures that the numberOfWheels inherited property is initialized by Vehicle before Bicycle has the opportunity to modify the property. After calling super.init(), the original value of numberOfWheels is replaced with a new value of 2.
        override init() {
            super.init()
            numberOfWheels = 2
        }
    }
    let bicycle = Bicycle()
    print("Bicycle: \(bicycle.description)")
    // Bicycle: 2 wheel(s)
}
/*:
 - NOTE:
 Subclasses can modify inherited variable properties during initialization, but can not modify inherited constant properties.
 */

/*:
 ## Automatic Initializer Inheritance

 As mentioned above, subclasses do not inherit their superclass initializers by default. However, superclass initializers are automatically inherited if certain conditions are met. In practice, this means that you do not need to write initializer overrides in many common scenarios, and can inherit your superclass initializers with minimal effort whenever it is safe to do so.

 Assuming that you provide default values for any new properties you introduce in a subclass, the following two rules apply:

 Rule 1
 If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers. 如果您的子类没有定义任何指定的初始化器，它将自动继承其所有超类指定的初始化器。

 Rule 2
 If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers. 如果您的子类提供了其所有超类指定的初始化器的实现 - 通过按照规则1继承它们，或者通过提供自定义实现作为其定义的一部分，那么它将自动继承所有超类方便初始化器。

 These rules apply even if your subclass adds further convenience initializers.

 - NOTE:
 A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2. 子类可以实现一个超类指定的初始化器作为子类方便初始化器，作为满足规则2的一部分。
 */

/*:
 ## Designated and Convenience Initializers in Action

 The following example shows designated initializers, convenience initializers, and automatic initializer inheritance in action. This example defines a hierarchy of three classes called Food, RecipeIngredient, and ShoppingListItem, and demonstrates how their initializers interact.
 */
do {
    /// The figure below shows the initializer chain for the Food class: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/initializersExample01_2x.png
    class Food {
        var name: String
        init(name: String) {
            self.name = name
        }
        convenience init() {
            self.init(name: "[Unnamed]")
        }
    }
    let namedMeat = Food(name: "Bacon")
    // namedMeat's name is "Bacon"
    let mysteryMeat = Food()
    // mysteryMeat's name is "[Unnamed]

    /// The figure below shows the initializer chain for the RecipeIngredient class: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/initializersExample02_2x.png
    class RecipeIngredient: Food {
        var quantity: Int
        init(name: String, quantity: Int) {
            self.quantity = quantity
            super.init(name: name)
        }
        // Initializer Overriding
        override convenience init(name: String) {
            self.init(name: name, quantity: 1)
        }
    }
    let oneMysteryItem = RecipeIngredient()
    let oneBacon = RecipeIngredient(name: "Bacon")
    let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

    class ShoppingListItem: RecipeIngredient {
        var purchased = false
        var description: String {
            var output = "\(quantity) x \(name)"
            output += purchased ? " ✔" : " ✘"
            return output
        }
    }
    /// NOTE: ShoppingListItem does not define an initializer to provide an initial value for purchased, because items in a shopping list (as modeled here) always start out unpurchased 购物清单初始状态为空
    /// The figure below shows the overall initializer chain for all three classes: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/initializersExample03_2x.png

    var breakfastList = [
        ShoppingListItem(),
        ShoppingListItem(name: "Bacon"),
        ShoppingListItem(name: "Eggs", quantity: 6),
        ]
    breakfastList[0].name = "Orange juice"
    breakfastList[0].purchased = true
    //breakfastList[1].purchased = true
    for item in breakfastList {
        print(item.description)
    }
    // 1 x Orange juice ✔
    // 1 x Bacon ✘
    // 6 x Eggs ✘
}

/*:
 # Failable Initializers

 It is sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.

 To cope with initialization conditions that can fail, define one or more failable initializers as part of a class, structure, or enumeration definition. You write a failable initializer by placing a question mark after the init keyword (init?).

 - NOTE:
 You cannot define a failable and a nonfailable initializer with the same parameter types and names.

 A failable initializer creates an optional value of the type it initializes. You write return nil within a failable initializer to indicate a point at which initialization failure can be triggered.

 - NOTE:
 Strictly speaking, initializers do not return a value. Rather, their role is to ensure that self is fully and correctly initialized by the time that initialization ends. Although you write return nil to trigger an initialization failure, you do not use the return keyword to indicate initialization success.
 */
do {
    let wholeNumber: Double = 12345.0
    let pi = 3.14159

    if let valueMaintained = Int(exactly: wholeNumber) {
        print("\(wholeNumber) conversion to Int maintains value")
    }
    // Prints "12345.0 conversion to Int maintains value"

    let valueChanged = Int(exactly: pi)
    // valueChanged is of type Int?, not Int
    /// Creates a Int whose value is `value`
    /// if no rounding is necessary, nil otherwise.
    /// public init?(exactly value: Double)

    if valueChanged == nil {
        print("\(pi) conversion to Int does not maintain value")
    }
    // Prints "3.14159 conversion to Int does not maintain value"

    struct Animal {
        let species: String
        init?(species: String) {
            if species.isEmpty { return nil }
            self.species = species
        }
    }

    let someCreature = Animal(species: "Giraffe")
    // someCreature is of type Animal?, not Animal

    if let giraffe = someCreature {
        print("An animal was initialized with a species of \(giraffe.species)")
    }
    // Prints "An animal was initialized with a species of Giraffe"

    let anonymousCreature = Animal(species: "")
    // anonymousCreature is of type Animal?, not Animal

    if anonymousCreature == nil {
        print("The anonymous creature could not be initialized")
    }
    // Prints "The anonymous creature could not be initialized"
}
/*:
 - NOTE:
 Checking for an empty string value (such as "" rather than "Giraffe") is not the same as checking for nil to indicate the absence of an optional String value. In the example above, an empty string ("") is a valid, nonoptional String. However, it is not appropriate for an animal to have an empty string as the value of its species property. To model this restriction, the failable initializer triggers an initialization failure if an empty string is found.
 */
do {
    class DogFailable {
        let name : String
        let license : Int
        init?(name:String, license:Int) {
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
    let fido = DogFailable(name:"", license:0)
    let name = fido?.name
}

/*:
 ## Failable Initializers for Enumerations

 You can use a failable initializer to select an appropriate enumeration case based on one or more parameters. The initializer can then fail if the provided parameters do not match an appropriate enumeration case.
 */
do {
    enum TemperatureUnit {
        case kelvin, celsius, fahrenheit
        init?(symbol: Character) {
            switch symbol {
            case "K":
                self = .kelvin
            case "C":
                self = .celsius
            case "F":
                self = .fahrenheit
            default:
                return nil
            }
        }
    }

    let fahrenheitUnit = TemperatureUnit(symbol: "F")
    if fahrenheitUnit != nil {
        print("This is a defined temperature unit, so initialization succeeded.")
    }
    // Prints "This is a defined temperature unit, so initialization succeeded."

    let unknownUnit = TemperatureUnit(symbol: "X")
    if unknownUnit == nil {
        print("This is not a defined temperature unit, so initialization failed.")
    }
    // Prints "This is not a defined temperature unit, so initialization failed."

}

/*:
 ## Failable Initializers for Enumerations with Raw Values

 Enumerations with raw values automatically receive a failable initializer, init?(rawValue:), that takes a parameter called rawValue of the appropriate raw-value type and selects a matching enumeration case if one is found, or triggers an initialization failure if no matching value exists. 具有原始值的枚举会自动接收一个可用的初始化程序init？（rawValue :)，它可以使用一个名为rawValue的参数作为相应的原始值类型，如果没有匹配的值则触发初始化失败
 */
do {
    enum TemperatureUnit: Character {
        case kelvin = "K", celsius = "C", fahrenheit = "F"
    }

    let fahrenheitUnit = TemperatureUnit(rawValue: "F")
    if fahrenheitUnit != nil {
        print("This is a defined temperature unit, so initialization succeeded.")
    }
    // Prints "This is a defined temperature unit, so initialization succeeded."

    let unknownUnit = TemperatureUnit(rawValue: "X")
    if unknownUnit == nil {
        print("This is not a defined temperature unit, so initialization failed.")
    }
    // Prints "This is not a defined temperature unit, so initialization failed."
}

do {
    enum Filter : String {
        case albums = "Albums"
        case playlists = "Playlists"
        case podcasts = "Podcasts"
        case books = "Audiobooks"

        static var cases : [Filter] = [.albums, .playlists, .podcasts, .books]

        init?(_ index:Int) {
            if !(0...3).contains(index) {
                return nil
            }
            self = Filter.cases[index]
        }

        init?(_ rawValue:String) {
            self.init(rawValue:rawValue)
        }

        var description : String { return self.rawValue }

        var s: String {
            get {
                return "howdy"
            }
            set {}
        }

        mutating func advance() {
            var i = Filter.cases.index(of:self)!
            i = (i + 1) % 4
            self = Filter.cases[i]
        }

        var query : MPMediaQuery {
            switch self {
            case .albums:
                return .albums()
            case .playlists:
                return .playlists()
            case .podcasts:
                return .podcasts()
            case .books:
                return .audiobooks()
            }
        }
    }

    let type1 = Filter.albums
    let type2 = Filter(rawValue:"Playlists")!
    let type3 = Filter(2)
    let type4 = Filter(5) //nil

    do {
        /// compile error
        var type5 = Filter("Playlists")

        /// warning: expression implicitly coerced from 'String?' to Any
        print(type5?.description)

        /// error: use of unresolved identifier 'type5'
        //type5.s = "test"

        /// right
        type5?.s = "test"
    }

    var type6 = type2
    type6.s = "test"

    var type7 = Filter.books
    type7.advance()
}

/*:
 ## Propagation of Initialization Failure

 A failable initializer of a class, structure, or enumeration can delegate across to another failable initializer from the same class, structure, or enumeration. Similarly, a subclass failable initializer can delegate up to a superclass failable initializer.

 In either case, if you delegate to another initializer that causes initialization to fail, the entire initialization process fails immediately, and no further initialization code is executed.

 - NOTE:
 A failable initializer can also delegate to a nonfailable initializer. Use this approach if you need to add a potential failure state to an existing initialization process that does not otherwise fail.
 */
do {
    class Product {
        let name: String
        init?(name: String) {
            if name.isEmpty { return nil }
            self.name = name
        }
    }

    class CartItem: Product {
        let quantity: Int
        init?(name: String, quantity: Int) {
            if quantity < 1 { return nil }
            self.quantity = quantity
            super.init(name: name)
        }
    }

    if let twoSocks = CartItem(name: "sock", quantity: 2) {
        print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
    }
    // Prints "Item: sock, quantity: 2"

    if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
        print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
    } else {
        print("Unable to initialize zero shirts")
    }
    // Prints "Unable to initialize zero shirts"

    if let oneUnnamed = CartItem(name: "", quantity: 1) {
        print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
    } else {
        print("Unable to initialize one unnamed product")
    }
    // Prints "Unable to initialize one unnamed product"
}

/*:
 ## Overriding a Failable Initializer

 You can override a superclass failable initializer in a subclass, just like any other initializer. Alternatively, you can override a superclass failable initializer with a subclass nonfailable initializer. This enables you to define a subclass for which initialization cannot fail, even though initialization of the superclass is allowed to fail. 您可以像子类何其他初始化器一样在子类中覆盖超类可用的初始化器。 或者，您可以使用子类不可用的初始化程序覆盖超类可用的初始化程序。 这使您能够定义初始化不能失败的子类，即使允许超类的初始化失败。

 Note that if you override a failable superclass initializer with a nonfailable subclass initializer, the only way to delegate up to the superclass initializer is to force-unwrap the result of the failable superclass initializer. 请注意，如果您使用非可用子类初始化程序覆盖可用的超类初始化程序，则委托到超类初始化程序的唯一方法是强制打开可用的超类初始化程序的结果。

 - NOTE:
 You can override a failable initializer with a nonfailable initializer but not the other way around. 您可以使用不可用的初始化程序覆盖可用的初始化程序，但不能相反。
 */
do {
    class Document {
        var name: String?
        // this initializer creates a document with a nil name value
        init() {}
        // this initializer creates a document with a nonempty name value
        init?(name: String) {
            if name.isEmpty { return nil }
            self.name = name
        }
    }

    class AutomaticallyNamedDocument: Document {
        override init() {
            super.init()
            self.name = "[Untitled]"
        }
        override init(name: String) {
            super.init()
            if name.isEmpty {
                self.name = "[Untitled]"
            } else {
                self.name = name
            }
        }
    }

    class UntitledDocument: Document {
        override init() {
            super.init(name: "[Untitled]")!
        }
    }
}

/*:
 ## The init! Failable Initializer

 You typically define a failable initializer that creates an optional instance of the appropriate type by placing a question mark after the init keyword (init?). Alternatively, you can define a failable initializer that creates an implicitly unwrapped optional instance of the appropriate type. Do this by placing an exclamation mark after the init keyword (init!) instead of a question mark.

 You can delegate from init? to init! and vice versa, and you can override init? with init! and vice versa. You can also delegate from init to init!, although doing so will trigger an assertion if the init! initializer causes initialization to fail.
 */


/*:
 # Required Initializers

 Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer.
 */
do {
    class SomeClass {
        required init() {
            // initializer implementation goes here
        }
    }

    class SomeSubclass: SomeClass {
        required init() {
            // subclass implementation of the required initializer goes here
        }
    }
}

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
        /// without this override, NoisyDog won't compile
        required init(name: String) {
            super.init(name: name)
        }
    }
}
/*:
 - NOTE:
 You do not have to provide an explicit implementation of a required initializer if you can satisfy the requirement with an inherited initializer. 如果可以使用继承的初始化程序满足要求，则不需要提供必需的初始化程序的显式实现。
 */


/*:
 # Setting a Default Property Value with a Closure or Function
 If a stored property’s default value requires some customization or setup, you can use a closure or global function to provide a customized default value for that property. Whenever a new instance of the type that the property belongs to is initialized, the closure or function is called, and its return value is assigned as the property’s default value. 如果存储属性的默认值需要一些自定义或设置，则可以使用闭包或全局函数为该属性提供自定义的默认值。每当初始化属性所属类型的新实例时，将调用闭包或函数，并将其返回值赋为该属性的默认值。

 These kinds of closures or functions typically create a temporary value of the same type as the property, tailor that value to represent the desired initial state, and then return that temporary value to be used as the property’s default value. 这些闭包或函数通常创建与属性相同类型的临时值，将该值自定义为表示所需初始状态，然后将该临时值返回用作属性的默认值。
 
 Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure. 注意闭包结束后的括号后面是一对空括号。这告诉swift立即执行闭包。如果省略这些圆括号，则试图将闭包本身赋给属性，而不是闭包的返回值。

 - NOTE:
 If you use a closure to initialize a property, remember that the rest of the instance has not yet been initialized at the point that the closure is executed. This means that you cannot access any other property values from within your closure, even if those properties have default values. You also cannot use the implicit self property, or call any of the instance’s methods. 如果使用闭包来初始化一个属性，请记住实例的其余部分在执行闭包的时候还没有被初始化。 这意味着即使这些属性具有默认值，您也不能从闭包中访问任何其他属性值。 您也不能使用隐式自身属性，也不能调用任何实例的方法。
 
 FIXME: 除非 通过 self. 访问?
 */
do {
    class SomeType {}
    class SomeClass {
        let note = "You can pre-initialize properties by running code inside a closure. Since the execution happens before all other properties are initialized, you can't access other properties nor call self inside the closure."
        let someProperty: SomeType = {
            let someValue = SomeType()
            // create a default value for someProperty inside this closure
            // someValue must be of the same type as SomeType
            return someValue
        }()
    }
}
do {
    /// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/chessBoard_2x.png
    struct Chessboard {
        let boardColors: [Bool] = {
            var temporaryBoard = [Bool]()
            var isBlack = false
            for i in 1...8 {
                for j in 1...8 {
                    temporaryBoard.append(isBlack)
                    isBlack = !isBlack
                }
                isBlack = !isBlack
            }
            return temporaryBoard
        }()
        func squareIsBlackAt(row: Int, column: Int) -> Bool {
            return boardColors[(row * 8) + column]
        }
    }

    let board = Chessboard()
    print(board.squareIsBlackAt(row: 0, column: 1))
    // Prints "true"
    print(board.squareIsBlackAt(row: 7, column: 7))
    // Prints "false"
}

do {
    func imageOfSize(_ size:CGSize, _ whatToDraw:() -> ()) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        whatToDraw()
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }

    let cellBackgroundImage : UIImage = {
        return imageOfSize(CGSize(width:320, height:44)) {
            // ... drawing goes here ...
        }
    }()
}


//: # Example

//: ## conditional Initialization

do {
    var bti : UIBackgroundTaskIdentifier = 0
    bti = UIApplication.shared.beginBackgroundTask {
        UIApplication.shared.endBackgroundTask(bti)
    }
}

do {
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
}


do {
    /// showing that Swift no longer warns when AnyObject is implicitly assigned
    let arr = [1 as AnyObject, "howdy" as AnyObject]
    let thing = arr[0]
    _ = thing

    // var opts = [.Autoreverse, .Repeat] // compile error
    let opts : UIViewAnimationOptions = [.autoreverse, .repeat]
}

do {
    /// the universal type is now Any
    let arr2 : [Any] = [1,"howdy"]
    let thing2 = arr2[0] // no warning, it's okay
    _ = thing2
}

