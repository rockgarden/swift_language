//: [Previous](@previous)
import UIKit
/*:
 # ARC
 Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage. In most cases, this means that memory management “just works” in Swift, and you do not need to think about memory management yourself. ARC automatically frees up the memory used by class instances when those instances are no longer needed.
 自动引用计数(Automatic Reference Counting)。也就是对于一个对象来说，只有在引用计数为0的情况下内存才会被释放。
 - NOTE:
 Reference counting only applies to instances of classes. Structures and enumerations are value types, not reference types, and are not stored and passed by reference.
 引用计数只适用于类的实例。结构和枚举是值类型，而不是引用类型，而不是通过引用存储和传递。
 */


/*: 
 # How ARC Works
 Every time you create a new instance of a class, ARC allocates a chunk of memory to store information about that instance. This memory holds information about the type of the instance, together with the values of any stored properties associated with that instance.

 Additionally, when an instance is no longer needed, ARC frees up the memory used by that instance so that the memory can be used for other purposes instead. This ensures that class instances do not take up space in memory when they are no longer needed.

 However, if ARC were to deallocate an instance that was still in use, it would no longer be possible to access that instance’s properties, or call that instance’s methods. Indeed, if you tried to access the instance, your app would most likely crash.

 To make sure that instances don’t disappear while they are still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance. ARC will not deallocate an instance as long as at least one active reference to that instance still exists.
 为了确保实例在仍然需要时不会消失，ARC会跟踪当前引用每个类实例的属性，常量和变量的数量。只要对该实例的至少一个活动引用仍然存在，ARC就不会释放实例。
 To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a strong reference to the instance. The reference is called a “strong” reference because it keeps a firm hold on that instance, and does not allow it to be deallocated for as long as that strong reference remains.
 为了使这一点成为可能，无论何时将一个类实例分配给一个属性，常量或变量，该属性，常量或变量都将强烈引用该实例。引用被称为“强”引用，因为它坚持保持该实例，并且不允许它被释放，只要该强引用仍然存在。
 */


//: # ARC in Action
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

do {
    /// At this point, these references are nil.
    var reference1: Person?
    var reference2: Person?
    var reference3: Person?

    /// At this point 3 strong references of "John Appleseed" are being stored.
    reference1 = Person(name: "John Appleseed")
    reference2 = reference1
    reference3 = reference1

    //John is still alive
    reference1 = nil
    reference2 = nil
    reference3

    //John is dead by now.
    reference3 = nil
}


/*: 
 # Strong Reference Cycles Between Class Instances 
 类实例之间的循环强引用
 In the examples above, ARC is able to track the number of references to the new Person instance you create and to deallocate that Person instance when it is no longer needed.

 However, it is possible to write code in which an instance of a class never gets to a point where it has zero strong references. This can happen if two class instances hold a strong reference to each other, such that each instance keeps the other alive. This is known as a strong reference cycle.

 You resolve strong reference cycles by defining some of the relationships between classes as weak or unowned references instead of as strong references. This process is described in Resolving Strong Reference Cycles Between Class Instances https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID52. However, before you learn how to resolve a strong reference cycle, it is useful to understand how such a cycle is caused.
 */
class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    weak var wTenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

class Tenant : Person {
    var apartment: Apartment?
}

do {
    var john: Tenant?
    var unit4A: Apartment?

    john = Tenant(name: "John Appleseed")
    unit4A = Apartment(unit: "4A")
    /// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/referenceCycle01_2x.png

    /// 创建循环强引用 The strong references between the Person instance and the Apartment instance remain and cannot be broken.
    john!.apartment = unit4A
    unit4A!.tenant = john
    /// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/referenceCycle02_2x.png

    /// The variables are still references from inside the properties. This creates the reference cycle, and therefore, a memory leak.
    /// A simple way around this would be to manually set the apartment and tenant properties to nil, and then set the outside references to nil.
    john!.apartment = nil
    unit4A!.tenant = nil
    john = nil
    unit4A = nil
}


/*:
 # Resolving Strong Reference Cycles Between Class Instances
 Swift provides two ways to resolve strong reference cycles when you work with properties of class type: weak references and unowned references.

 Weak and unowned references enable one instance in a reference cycle to refer to the other instance without keeping a strong hold on it. The instances can then refer to each other without creating a strong reference cycle.

 Use a weak reference when the other instance has a shorter lifetime—that is, when the other instance can be deallocated first. In the Apartment example above, it is appropriate for an apartment to be able to have no tenant at some point in its lifetime, and so a weak reference is an appropriate way to break the reference cycle in this case. In contrast, use an unowned reference when the other instance has the same lifetime or a longer lifetime.

 */

/*:
 ## Weak References
 A weak reference is a reference that does not keep a strong hold on the instance it refers to, and so does not stop ARC from disposing of the referenced instance. This behavior prevents the reference from becoming part of a strong reference cycle. You indicate a weak reference by placing the weak keyword before a property or variable declaration.

 Because a weak reference does not keep a strong hold on the instance it refers to, it is possible for that instance to be deallocated while the weak reference is still referring to it. Therefore, ARC automatically sets a weak reference to nil when the instance that it refers to is deallocated. And, because weak references need to allow their value to be changed to nil at runtime, they are always declared as variables, rather than constants, of an optional type.nce is an appropriate way to break the reference cycle in this case.
 weak 引用并不能保护所引用的对象被ARC机制销毁。强引用能使被引用对象的引用计数+1，而弱引用不会。此外，若弱引用的对象被销毁后，弱引用的指针会被清空, 这样保证了当你调用一个弱引用对象时，你能得到一个对象或者nil, 因此被标记为 weak 的变量一定需要是 Optional 值.
 Weak references must be declared as variables, to indicate that their value can change at runtime. A weak reference cannot be declared as a constant.
 因为弱引用变量在没有被强引用的条件下会变成nil，所以Swift 编译器要求你必须用var来定义弱引用对象。
 - NOTE:
 Property observers aren’t called when ARC sets a weak reference to nil.
 */
do {
    var john: Tenant?
    var unit4A: Apartment?

    john = Tenant(name: "Weak Appleseed")
    unit4A = Apartment(unit: "4A")

    john!.apartment = unit4A
    unit4A!.wTenant = john
    /// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/weakReference01_2x.png
    john = nil
    // Prints "Weak Appleseed is being deinitialized"
    /// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/weakReference02_2x.png
    unit4A = nil
    // Prints "Apartment 4A is being deinitialized"
}
/*: 
 - NOTE:
 In systems that use garbage collection, weak pointers are sometimes used to implement a simple caching mechanism because objects with no strong references are deallocated only when memory pressure triggers garbage collection. However, with ARC, values are deallocated as soon as their last strong reference is removed, making weak references unsuitable for such a purpose.
 */
//: Weak References In Closures
class WeakDemo {
    var notificationObserver: NSObjectProtocol!
    var weakObserver: NSObjectProtocol!

    init() {
        notificationObserver = NotificationCenter.default.addObserver(forName: Notification.Name(rawValue:"humanEnteredKrakensLair"), object: nil, queue: OperationQueue.main) { notification in
            /// 如果在闭包范围之外声明变量，那么在闭包中使用这个变量时，会对该变量产生另一个强引用, 所以要 deinit; 唯一的例外是使用值类型的变量，比如Swift中的 Ints、Strings、Arrays以及Dictionaries等。
            self.eatHuman()
        }

        weakObserver = NotificationCenter.default.addObserver(forName: Notification.Name(rawValue:"humanEnteredKrakensLair"), object: nil, queue: OperationQueue.main) { notification in
            let _ = { [weak self] in
                self?.eatHuman()
                /// Remember, all weak variables are Optionals! don't need deinit
            }
        }
    }

    deinit {
        if notificationObserver != nil {
            NotificationCenter.default.removeObserver(notificationObserver)
        }
    }

    func eatHuman() {}
}

//: Weak Delegate
// ModelObject类内容

protocol ModelObjectDelegate: class { }
class ModelObject {
    var delegate: ModelObjectDelegate?
}
class ModelObjectWeak {
    weak var delegate: ModelObjectDelegate?
}
class ModelObjectUnowed {
    /// swift要求变量一定要有初始值可选类型默认初始值为nil
    unowned var delegate: ModelObjectDelegate
    init(delegate: ModelObjectDelegate) {
        self.delegate = delegate
    }
}
class ModelObjectManager: ModelObjectDelegate {
    var modelObject: ModelObject?
    var name: String
    init(name: String) {
        self.name = name
        _ = ("\(name) is being initialized")
        setup()
    }
    func setup() {
        modelObject = ModelObject() // can't deinit
        // ModelObjectUnowed(delegate: self)  ModelObjectWeak() can deinit
        modelObject!.delegate = self
    }
    deinit {
        _ = ("\(name) is being deinitialized")
    }
}
do {
    var rockgarden: ModelObjectManager? = ModelObjectManager(name: "rockgarden")
    rockgarden = nil
}


/*:
 # Unowned References
 Like a weak reference, an unowned reference does not keep a strong hold on the instance it refers to. Unlike a weak reference, however, an unowned reference is used when the other instance has the same lifetime or a longer lifetime. You indicate an unowned reference by placing the unowned keyword before a property or variable declaration.
 An unowned reference is expected to always have a value. As a result, ARC never sets an unowned reference’s value to nil, which means that unowned references are defined using nonoptional types.
 weak引用和unowned引用有些类似但不完全相同。Unowned 引用，像weak引用一样，不会增加对象的引用计数。然而，在Swift里，一个unowned引用有着非可选类型的优点。这样相比于借助和使用optional binding更易于管理。这和隐式可选类型（Implicity Unwarpped Optionals）区别不大。此外，unowned引用是non-zeroing(非零的) ,这表示着当一个对象被销毁时，它指引的对象不会清零。也就是说使用unowned引用在某些情况下可能导致 dangling pointers(野指针url)。你是不是跟我一样想起了用Objective -C的时候, unowned引用映射到了 unsafe_unretained引用。
 - IMPORTANT:
 Use an unowned reference only when you are sure that the reference always refers to an instance that has not been deallocated.
 If you try to access the value of an unowned reference after that instance has been deallocated, you’ll get a runtime error.
 - NOTE:
 If you try to access an unowned reference after the instance that it references is deallocated, you will trigger a runtime error.
 Use unowned references only when you are sure that the reference will always refer to an instance.
 Note also that Swift guarantees your app will crash if you try to access an unowned reference after the instance it references is deallocated.
 You will never encounter unexpected behavior in this situation. Your app will always crash reliably, although you should, of course, prevent it from doing so.
 “Use a weak reference whenever it is valid for that reference to become nil at some point during its lifetime. Conversely, use an unowned reference when you know that the reference will never be nil once it has been set during initialization.”
 翻译：在引用对象的生命周期内，如果它可能释放为nil，那么就用weak引用。反之，当你知道引用对象在初始化后永远都不会被释放成为nil就用unowned.
 Define a capture in a closure as an unowned reference when the closure and the instance it captures will always refer to each other, and will always be deallocated at the same time.
 如果你知道你引用的对象会在正确的时机释放掉，且它们是相互依存的，而你不想写一些多余的代码来清空你的引用指针，那么你就应该使用unowned引用而不是weak引用。
 */
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}
/*:
 - NOTE:
 The number property of the CreditCard class is defined with a type of UInt64 rather than Int, to ensure that the number property’s capacity is large enough to store a 16-digit card number on both 32-bit and 64-bit systems.
 */
do {
    var john: Customer?
    john = Customer(name: "John Appleseed")
    john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
    john = nil
    /// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/unownedReference01_2x.png
    /// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/unownedReference02_2x.png
}
/*:
 - NOTE:
 The examples above show how to use safe unowned references. Swift also provides unsafe unowned references for cases where you need to disable runtime safety checks—for example, for performance reasons. As with all unsafe operations, you take on the responsiblity for checking that code for safety.
 You indicate an unsafe unowned reference by writing unowned(unsafe). If you try to access an unsafe unowned reference after the instance that it refers to is deallocated, your program will try to access the memory location where the instance used to be, which is an unsafe operation.
 */

/*:
 ## Unowned References and Implicitly Unwrapped Optional Properties
 However, there is a third scenario, in which both properties should always have a value, and neither property should ever be nil once initialization is complete. In this scenario, it is useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class.
 然而，存在第三种情况，其中两个属性应该总是具有值，并且一旦初始化完成，则两个属性都不应为零。 在这种情况下，将一个类上的未知属性与另一个类上的隐式可选属性组合是非常有用的。
 This enables both properties to be accessed directly (without optional unwrapping) once initialization is complete, while still avoiding a reference cycle.
 这使得两个属性在初始化完成后可以直接访问（没有可选的解开），同时仍然避免了参考周期。 本节介绍如何设置此类关系。
 */
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
do {
    /// In the example above, the use of an implicitly unwrapped optional means that all of the two-phase class initializer requirements are satisfied. The capitalCity property can be used and accessed like a nonoptional value once initialization is complete, while still avoiding a strong reference cycle.
    var country = Country(name: "Canada", capitalName: "Ottawa")
    print("\(country.name)'s capital city is called \(country.capitalCity.name)")
}


/*
 # Strong Reference Cycles for Closures
 闭包和循环引用
 A strong reference cycle can also occur if you assign a closure to a property of a class instance, and the body of that closure captures the instance. This capture might occur because the closure’s body accesses a property of the instance, such as self.someProperty, or because the closure calls a method on the instance, such as self.someMethod(). In either case, these accesses cause the closure to “capture” self, creating a strong reference cycle.
 Swift provides an elegant solution to this problem, known as a closure capture list.
 闭包中对任何其他元素的引用都是会被闭包自动持有的; 如果在闭包中调用了 self, 也就相当于在闭包内持有了当前的对象; 如果当前的实例直接或者间接地对这个闭包又有引用的话，就形成了一个 self -> 闭包 -> self 的循环引用。
 闭包用强引用形式捕获了self，而self也通过闭包属性保留了一个对闭包的强引用，这就出现了引用循环。只要给闭包添加[unowned/weak self] 就能打破引用循环.
 参数形式: [unowned/weak self],[unowned/weak var] (传入的参数)
 */
class HTMLElement {

    let name: String
    let text: String?

    /// The asHTML property is declared as a lazy property, because it is only needed if and when the element actually needs to be rendered as a string value for some HTML output target. The fact that asHTML is a lazy property means that you can refer to self within the default closure, because the lazy property will not be accessed until after initialization has been completed and self is known to exist.
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}
do {
    let heading = HTMLElement(name: "h1")
    let defaultText = "some default text"
    heading.asHTML = {
        return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
    }
    print(heading.asHTML())

    var paragraph: HTMLElement? = HTMLElement(name: "p<HTMLElement>", text: "hello, world")
    print(paragraph!.asHTML())
    /// The paragraph variable above is defined as an optional HTMLElement, so that it can be set to nil below to demonstrate the presence of a strong reference cycle.

    paragraph = nil //Can't deinitialized
    /// set the paragraph variable to nil and break its strong reference to the HTMLElement instance, neither the HTMLElement instance nor its closure are deallocated, because of the strong reference cycle
}


/*:
 # Resolving Strong Reference Cycles for Closures
 You resolve a strong reference cycle between a closure and a class instance by defining a capture list as part of the closure’s definition. A capture list defines the rules to use when capturing one or more reference types within the closure’s body. As with strong reference cycles between two class instances, you declare each captured reference to be a weak or unowned reference rather than a strong reference. The appropriate choice of weak or unowned depends on the relationships between the different parts of your code.
 - NOTE:
 Swift requires you to write self.someProperty or self.someMethod() (rather than just someProperty or someMethod()) whenever you refer to a member of self within a closure. This helps you remember that it’s possible to capture self by accident.
 */

/*: 
 ## Defining a Capture List
 */
//: Each item in a capture list is a pairing of the weak or unowned keyword with a reference to a class instance (such as self) or a variable initialized with some value (such as delegate = self.delegate!). These pairings are written within a pair of square braces, separated by commas.
//lazy var someClosure: (Int, String) -> String = {
    //[unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
//}
//: If a closure does not specify a parameter list or return type because they can be inferred from context, place the capture list at the very start of the closure, followed by the in keyword:
//lazy var someClosure: () -> String = {
    //[unowned self, weak delegate = self.delegate!] in
    // closure body goes here
//}

/*: 
 ## Weak and Unowned References
 Define a capture in a closure as an unowned reference when the closure and the instance it captures will always refer to each other, and will always be deallocated at the same time.
 Conversely, define a capture as a weak reference when the captured reference may become nil at some point in the future. Weak references are always of an optional type, and automatically become nil when the instance they reference is deallocated. This enables you to check for their existence within the closure’s body.
 - NOTE:
 If the captured reference will never become nil, it should always be captured as an unowned reference, rather than a weak reference.
 */
class HTMLElement2 {
    let name: String
    let text: String?

    lazy var asHTML: (Void) -> String = {
        [unowned self] in //Closure List
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
do {
    var paragraph: HTMLElement2? = HTMLElement2(name: "p<HTMLElement2>", text: "hello, world")
    print(paragraph!.asHTML())
    paragraph = nil
}


//: ## Example
class RetainCycleStrong {
    var closure: (() -> Void)!
    var string = "Hello"
    init() {
        closure = { _ in
            self.string = "closure retain cycle!"
            _ = self.string
        }
    }
    deinit {
        _  = ("RetainCycleStrong deinit \(string)")
    }
}
do {
    var rockgarden: RetainCycleStrong? = RetainCycleStrong()
    rockgarden!.closure()
    rockgarden = nil
}

class RetainCycleUnowned {
    var closure: (() -> Void)!
    var string = "Hello"
    init() {
        closure = { [unowned self] in
            self.string = "close closure retain cycle by unowned!"
        }
    }
    deinit {
        _  = ("RetainCycleUnowned deinit \(string)")
    }
}
do {
    var rockgarden: RetainCycleUnowned? = RetainCycleUnowned()
    rockgarden!.closure()
    /// Closure 加入 [unowned self] in 可正常 deinit
    rockgarden = nil
}

class PersonLazyUnowned {
    let name: String
    lazy var printName: ()->() = {
        [unowned self] in
        _ = ("The name is \(self.name)")
    }
    init(name: String) {
        self.name = name
        _ = ("\(name) is being initialized")
    }
    deinit {
        _ = ("\(name) is being deinitialized")
    }
}
do {
    var rockgarden: PersonLazyUnowned? = PersonLazyUnowned(name: "rockgarden")
    rockgarden!.printName()
    /// printName Closure 加入 [unowned self] in 可正常 deinit
    rockgarden = nil
}

class PersonLazy {
    let name: String

    lazy var printName: ()->() = {
        [weak self] in
        _ = ("The name is \(self!.name)")
    }

    init(name: String) {
        self.name = name
        _ = ("\(name) is being initialized")
    }

    deinit {
        _ = ("\(name) is being deinitialized")
    }
}
do {
    var rockgarden: PersonLazy? = PersonLazy(name: "rockgarden")
    rockgarden!.printName()
    /// printName Closure 加入 [weak self] in 可正常 deinit
    rockgarden = nil
}

//: 懒加载变量中调用closure时, 由于没有retain(引用) closure, 所以不需要加 unowned self, 变量只是简单的把闭包的结果 assign 给了自己, 闭包在使用后就被立即销毁了.
class PersonLazyAssign {
    let name: String

    lazy var printName: String = {
        return ("The name is \(self.name)")
    }()

    init(name: String) {
        self.name = name
        _ = ("\(name) is being initialized")
    }

    deinit {
        _ = ("\(name) is being deinitialized")
    }
}
do {
    var rockgarden: PersonLazyAssign? = PersonLazyAssign(name: "rockgarden")
    rockgarden!.printName
    rockgarden = nil
}

//: [Next](@next)
