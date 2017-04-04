//: [Previous](@previous)

//: # Inheritance 继承

/*:
 A class can inherit methods, properties, and other characteristics from another class. When one class inherits from another, the inheriting class is known as a subclass, and the class it inherits from is known as its superclass. Inheritance is a fundamental behavior that differentiates classes from other types in Swift.

 Classes in Swift can call and access methods, properties, and subscripts belonging to their superclass and can provide their own overriding versions of those methods, properties, and subscripts to refine or modify their behavior. Swift helps to ensure your overrides are correct by checking that the override definition has a matching superclass definition.

 Classes can also add property observers to inherited properties in order to be notified when the value of a property changes. Property observers can be added to any property, regardless of whether it was originally defined as a stored or computed property.类还可以将属性观察器添加到继承的属性，以便在属性值更改时通知它们。 属性观察者可以添加到任何属性，无论它是否最初被定义为存储或计算属性。
 */

/*:
 # Defining a Base Class
 Any class that does not inherit from another class is known as a base class.

 - NOTE:
 Swift classes do not inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.
 */
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")
// Vehicle: traveling at 0.0 miles per hour

/*:
 # Subclassing

 Subclassing is the act of basing a new class on an existing class. The subclass inherits characteristics from the existing class, which you can then refine. You can also add new characteristics to the subclass.

 To indicate that a subclass has a superclass, write the subclass name before the superclass name, separated by a colon:

    class SomeSubclass: SomeSuperclass {
        // subclass definition goes here
    }
 */
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
// Bicycle: traveling at 15.0 miles per hour

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// Tandem: traveling at 22.0 miles per hour

/*:
 # Overriding

 A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.

 To override a characteristic that would otherwise be inherited, you prefix your overriding definition with the override keyword. Doing so clarifies that you intend to provide an override and have not provided a matching definition by mistake. Overriding by accident can cause unexpected behavior, and any overrides without the override keyword are diagnosed as an error when your code is compiled.

 The override keyword also prompts the Swift compiler to check that your overriding class’s superclass (or one of its parents) has a declaration that matches the one you provided for the override. This check ensures that your overriding definition is correct.
 
 ## Accessing Superclass Methods, Properties, and Subscripts

 When you provide a method, property, or subscript override for a subclass, it is sometimes useful to use the existing superclass implementation as part of your override. For example, you can refine the behavior of that existing implementation, or store a modified value in an existing inherited variable.

 Where this is appropriate, you access the superclass version of a method, property, or subscript by using the super prefix:

  - An overridden method named someMethod() can call the superclass version of someMethod() by calling super.someMethod() within the overriding method implementation.

  - An overridden property called someProperty can access the superclass version of someProperty as super.someProperty within the overriding getter or setter implementation.

  - An overridden subscript for someIndex can access the superclass version of the same subscript as super[someIndex] from within the overriding subscript implementation.
 
 ## Overriding Methods

 You can override an inherited instance or type method to provide a tailored or alternative implementation of the method within your subclass.
 */
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()
// Prints "Choo Choo"

/*:
 ## Overriding Properties

 You can override an inherited instance or type property to provide your own custom getter and setter for that property, or to add property observers to enable the overriding property to observe when the underlying property value changes. 您可以覆盖继承的实例或类型属性，为该属性提供自己的自定义getter和setter，或添加属性观察器以启用覆盖属性以观察基础属性值何时更改。

 ### Overriding Property Getters and Setters

 You can provide a custom getter (and setter, if appropriate) to override any inherited property, regardless of whether the inherited property is implemented as a stored or computed property at source. The stored or computed nature of an inherited property is not known by a subclass—it only knows that the inherited property has a certain name and type. You must always state both the name and the type of the property you are overriding, to enable the compiler to check that your override matches a superclass property with the same name and type. 您可以提供一个自定义的getter（和setter，如果适用）来覆盖任何继承的属性，而不管继承的属性是否被实现为源的存储或计算属性。继承属性的存储或计算性质不被子类所知 - 它只知道继承的属性具有一定的名称和类型。您必须始终声明要覆盖的属性的名称和类型，以使编译器能够检查您的覆盖是否与具有相同名称和类型的超类属性匹配。

 You can present an inherited read-only property as a read-write property by providing both a getter and a setter in your subclass property override. You cannot, however, present an inherited read-write property as a read-only property. 您可以通过在子类属性覆盖中同时提供一个getter和一个setter来呈现一个继承的只读属性作为读写属性。但是，您不能将继承的读写属性提供为只读属性。
 
 - NOTE:
 If you provide a setter as part of a property override, you must also provide a getter for that override. If you don’t want to modify the inherited property’s value within the overriding getter, you can simply pass through the inherited value by returning super.someProperty from the getter, where someProperty is the name of the property you are overriding. 如果您提供一个setter作为属性覆盖的一部分，您还必须为该覆盖提供一个getter。 如果您不想在覆盖的getter中修改继承属性的值，可以通过从getter返回super.someProperty来简单地传递继承的值，其中someProperty是要覆盖的属性的名称。
 */
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// Car: traveling at 25.0 miles per hour in gear 3

/*:
 ### Overriding Property Observers

 You can use property overriding to add property observers to an inherited property. This enables you to be notified when the value of an inherited property changes, regardless of how that property was originally implemented. For more information on property observers, see Property Observers.
 
 - NOTE:
 You cannot add property observers to inherited constant stored properties or inherited read-only computed properties. The value of these properties cannot be set, and so it is not appropriate to provide a willSet or didSet implementation as part of an override.

 Note also that you cannot provide both an overriding setter and an overriding property observer for the same property. If you want to observe changes to a property’s value, and you are already providing a custom setter for that property, you can simply observe any value changes from within the custom setter.
 */

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
// AutomaticCar: traveling at 35.0 miles per hour in gear 4

/*:
 # Preventing Overrides

 You can prevent a method, property, or subscript from being overridden by marking it as final. Do this by writing the final modifier before the method, property, or subscript’s introducer keyword (such as final var, final func, final class func, and final subscript). 您可以通过将其标记为final来防止方法，属性或下标被覆盖。 通过在方法，属性或下标的引用器关键字（如final var，final func，final类func和final下标）之前编写最终修饰符来执行此操作。

 Any attempt to override a final method, property, or subscript in a subclass is reported as a compile-time error. Methods, properties, or subscripts that you add to a class in an extension can also be marked as final within the extension’s definition.

 You can mark an entire class as final by writing the final modifier before the class keyword in its class definition (final class). Any attempt to subclass a final class is reported as a compile-time error.
 */

//: [Next](@next)
