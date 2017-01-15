//: [Previous](@previous)
import UIKit
/*:
 # ARC
 自动引用计数(Automatic Reference Counting)。也就是对于一个对象来说，只有在引用计数为0的情况下内存才会被释放。
 Reference counting only applies to instances of classes. Structures and enumerations are value types, not reference types, and are not stored and passed by reference.
 引用计数只适用于类的实例。结构和枚举是值类型，而不是引用类型，而不是通过引用存储和传递。
 */

/*
 ## Strong Reference
 实质上就是普通的引用(指针等等)，但是它的特殊之处在于它能够通过使对象的引用计数+1来保护对象，避免引用对象被ARC机制销毁。
 本质上来讲，任何对象只要有强引用，它就不会被销毁掉。
 声明一个属性时，它就默认是一个强引用。
 一般来说，当对象之间的关系为线性时，使用强引用是安全的。
 当对象之间的强引用是从父层级流向子层级时，用强引用通常也是安全的。
 */
class Person {
    let name: String
    init(name: String) {
        self.name = name
        ("\(name) is being initialized")
    }
    deinit {
        ("\(name) is being deinitialized")
    }
}

do {
    // At this point, these references are nil.
    var reference1: Person?
    var reference2: Person?
    var reference3: Person?

    //At this point 3 strong references of "John Appleseed" are being stored.
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
 Strong Reference Cycles Between Class Instances
 类实例之间的循环强引用
 */
class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { ("Apartment \(unit) is being deinitialized") }
}

class Tenant : Person {
    var apartment: Apartment?
}

do {
    var john: Tenant?
    var unit4A: Apartment?

    john = Tenant(name: "John Appleseed")
    unit4A = Apartment(unit: "4A")

    //创建循环强引用
    john!.apartment = unit4A
    unit4A!.tenant = john

    // The variables are still references from inside the properties. This creates the reference cycle, and therefore, a memory leak.
    // A simple way around this would be to manually set the apartment and tenant properties to nil, and then set the outside references to nil.
    john!.apartment = nil
    unit4A!.tenant = nil
    john = nil
    unit4A = nil
}


/*:
 ### Resolving Strong Reference Cycles Between Class Instances
 Weak and unowned references enable one instance in a reference cycle to refer to the other instance without keeping a strong hold on it. The instances can then refer to each other without creating a strong reference cycle.
 Use a weak reference whenever it is valid for that reference to become nil at some point during its lifetime.
 Conversely, use an unowned reference when you know that the reference will never be nil once it has been set during initialization.
 */

/*:
 ## Weak References
 Use a weak reference to avoid reference cycles whenever it is possible for that reference to have “no value” at some point in its life. If the reference will always have a value, use an unowned reference instead, as described in Unowned References. In the Apartment example above, it is appropriate for an apartment to be able to have “no tenant” at some point in its lifetime, and so a weak reference is an appropriate way to break the reference cycle in this case.
 weak 引用并不能保护所引用的对象被ARC机制销毁。强引用能使被引用对象的引用计数+1，而弱引用不会。此外，若弱引用的对象被销毁后，弱引用的指针会被清空, 这样保证了当你调用一个弱引用对象时，你能得到一个对象或者nil, 因此被标记为 weak 的变量一定需要是 Optional 值.
 - NOTE:
 Weak references must be declared as variables, to indicate that their value can change at runtime. A weak reference cannot be declared as a constant.
 因为弱引用变量在没有被强引用的条件下会变成nil，所以Swift 编译器要求你必须用var来定义弱引用对象。
 */
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

/*
 weak delegate
 */
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
 ## Unowned References
 Like weak references, an unowned reference does not keep a strong hold on the instance it refers to. Unlike a weak reference, however, an unowned reference is assumed to always have a value. Because of this, an unowned reference is always defined as a nonoptional type. You indicate an unowned reference by placing the unowned keyword before a property or variable declaration.
 Because an unowned reference is nonoptional, you don’t need to unwrap the unowned reference each time it is used.
 An unowned reference can always be accessed directly. However, ARC cannot set the reference to nil when the instance it refers
 to is deallocated, because variables of a nonoptional type cannot be set to nil.
 weak引用和unowned引用有些类似但不完全相同。Unowned 引用，像weak引用一样，不会增加对象的引用计数。然而，在Swift里，一个unowned引用有着非可选类型的优点。这样相比于借助和使用optional binding更易于管理。这和隐式可选类型（Implicity Unwarpped Optionals）区别不大。此外，unowned引用是non-zeroing(非零的) ,这表示着当一个对象被销毁时，它指引的对象不会清零。也就是说使用unowned引用在某些情况下可能导致 dangling pointers(野指针url)。你是不是跟我一样想起了用Objective -C的时候, unowned引用映射到了 unsafe_unretained引用。
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
    deinit { ("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { ("Card #\(number) is being deinitialized") }
}

var mike: Customer?
mike = Customer(name: "Mike Appleseed")
mike!.card = CreditCard(number: 1234_5678_9012_3456, customer: mike!)
mike = nil

/*:
 ### Unowned References and Implicitly Unwrapped Optional Properties
 However, there is a third scenario, in which both properties should always have a value, and neither property should ever be nil once initialization is complete. In this scenario, it is useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class.
 This enables both properties to be accessed directly (without optional unwrapping) once initialization is complete, while still avoiding a reference cycle. This section shows you how to set up such a relationship.
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
/*
 ### 闭包和循环引用
 闭包中对任何其他元素的引用都是会被闭包自动持有的; 如果在闭包中调用了 self, 也就相当于在闭包内持有了当前的对象; 如果当前的实例直接或者间接地对这个闭包又有引用的话，就形成了一个 self -> 闭包 -> self 的循环引用。
 闭包用强引用形式捕获了self，而self也通过闭包属性保留了一个对闭包的强引用，这就出现了引用循环。只要给闭包添加[unowned/weak self] 就能打破引用循环.
 参数形式: [unowned/weak self],[unowned/weak var] (传入的参数)
 */
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

/// 懒加载变量中调用closure时, 由于没有retain(引用) closure, 所以不需要加 unowned self, 变量只是简单的把闭包的结果 assign 给了自己, 闭包在使用后就被立即销毁了.
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


/*
 The initializer for City is called from within the initializer for Country. However, the initializer for Country cannot pass self to the City initializer until a new Country instance is fully initialized, as described in Two-Phase Initialization.
 To cope with this requirement, you declare the capitalCity property of Country as an implicitly unwrapped optional property, indicated by the exclamation mark at the end of its type annotation (City!). This means that the capitalCity property has a
 default value of nil, like any other optional, but can be accessed without the need to unwrap its value as described in Implicitly Unwrapped Optionals.
 Because capitalCity has a default nil value, a new Country instance is considered fully initialized as soon as the Country instance sets its name property within its initializer. This means that the Country initializer can start to reference and pass around the implicit self property as soon as the name property is set. The Country initializer can therefore pass self as one of the parameters for the City initializer when the Country initializer is setting its own capitalCity property.
 */



/*:
 ## Strong Reference Cycles for Closures
 A strong reference cycle can also occur if you assign a closure to a property of a class instance, and the body of that closure captures the instance. This capture might occur because the closure’s body accesses a property of the instance, such as self.someProperty, or because the closure calls a method on the instance, such as self.someMethod(). In either case, these accesses cause the closure to “capture” self, creating a strong reference cycle.
 Swift provides an elegant solution to this problem, known as a closure capture list.
 */

class HTMLElement {
    let name: String
    let text: String?
    /// Void single argument function types require parentheses (Void)
    lazy var asHTML: (Void) -> String = {
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
        ("\(name) is being deinitialized")
    }
}

/*:
 A capture list defines the rules to use when capturing one or more reference types within the closure’s body.
 As with strong reference cycles between two class instances, you declare each captured reference to be a weak or unowned reference rather than a strong reference.
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
        ("\(name) is being deinitialized")
    }
}

//: [Next](@next)
