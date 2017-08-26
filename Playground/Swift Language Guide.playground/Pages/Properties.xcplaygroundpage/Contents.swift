//: [Previous](@previous)
import MediaPlayer
/*:
 # Properties
 Properties associate values with a particular class, structure, or enumeration. Stored properties store constant and variable values as part of an instance, whereas computed properties calculate (rather than store) a value. Computed properties are provided by classes, structures, and enumerations. Stored properties are provided only by classes and structures. 属性将值与特定类，结构或枚举相关联。 存储的属性将常量和变量值存储为实例的一部分，而计算的属性计算（而不是存储）值。 计算属性由类，结构和枚举提供。 存储的属性仅由类和结构提供。

 Stored and computed properties are usually associated with instances of a particular type. However, properties can also be associated with the type itself. Such properties are known as type properties. 存储和计算的属性通常与特定类型的实例相关联。 然而，属性也可以与类型本身相关联。 这些属性被称为类型属性。

 In addition, you can define property observers to monitor changes in a property’s value, which you can respond to with custom actions. Property observers can be added to stored properties you define yourself, and also to properties that a subclass inherits from its superclass.

 */
/*:
 # Stored Properties

 In its simplest form, a stored property is a constant or variable that is stored as part of an instance of a particular class or structure. Stored properties can be either variable stored properties (introduced by the var keyword) or constant stored properties (introduced by the let keyword). 在其最简单的形式中，存储的属性是作为特定类或结构的实例的一部分存储的常量或变量。 存储的属性可以是变量存储属性（由var关键字引入）或常量存储属性（由let关键字引入）。

 You can provide a default value for a stored property as part of its definition, as described in Default Property Values. You can also set and modify the initial value for a stored property during initialization. This is true even for constant stored properties, as described in Assigning Constant Properties During Initialization. 您可以为存储属性提供默认值作为其定义的一部分，如默认属性值中所述。 您还可以在初始化期间设置和修改存储属性的初始值。 即使对于常量存储的属性也是如此，如在初始化期间分配常量属性中所述。
 */
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
do {
    var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
    // the range represents integer values 0, 1, and 2
    rangeOfThreeItems.firstValue = 6
    // the range now represents integer values 6, 7, and 8
}

/*:
 ## Stored Properties of Constant Structure Instances

 If you create an instance of a structure and assign that instance to a constant, you cannot modify the instance’s properties, even if they were declared as variable properties:
 */
do {
    let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
    // this range represents integer values 0, 1, 2, and 3
    // rangeOfFourItems.firstValue = 6
    // error: cannot assign to property: 'rangeOfFourItems' is a 'let' constant
    // this will report an error, even though firstValue is a variable property
}

/*:
 ## Lazy Stored Properties

 A lazy stored property is a property whose initial value is not calculated until the first time it is used. You indicate a lazy stored property by writing the lazy modifier before its declaration. 一个懒惰的存储属性是一个属性，它的初始值在第一次使用之前不会被计算。在声明之前编写懒惰修饰符，表示一个懒惰的存储属性。

 - NOTE:
 You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore cannot be declared as lazy. 您必须始终将惰性属性声明为变量（使用var关键字），因为在实例初始化完成后，可能无法检索其初始值。常量属性必须始终在初始化完成之前具有一个值，因此不能被声明为惰性。

 Lazy properties are useful when the initial value for a property is dependent on outside factors whose values are not known until after an instance’s initialization is complete. Lazy properties are also useful when the initial value for a property requires complex or computationally expensive setup that should not be performed unless or until it is needed. 当属性的初始值取决于在实例初始化完成之后其值不知道的外部因素时，惰性属性很有用。当属性的初始值需要复杂或计算上昂贵的设置时，延迟属性也是有用的，除非或直到需要才能执行。
 */
class DataImporter {
    /*
     DataImporter is a class to import data from an external file.
     The class is assumed to take a non-trivial amount of time to initialize.
     */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}
do {
    let manager = DataManager()
    manager.data.append("Some data")
    manager.data.append("Some more data")
    // the DataImporter instance for the importer property has not yet been created
    print(manager.importer.filename)
    // the DataImporter instance for the importer property has now been created
    // Prints "data.txt"
}
/*:
 - NOTE:
 If a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property has not yet been initialized, there is no guarantee that the property will be initialized only once. 如果标记有延迟修饰符的属性同时被多个线程访问，并且该属性尚未初始化，则不能保证该属性将仅被初始化一次。麻烦的! 所以在访问前要判断是否为nil.
 
 ## Stored Properties and Instance Variables

 If you have experience with Objective-C, you may know that it provides two ways to store values and references as part of a class instance. In addition to properties, you can use instance variables as a backing store for the values stored in a property.

 Swift unifies these concepts into a single property declaration. A Swift property does not have a corresponding instance variable, and the backing store for a property is not accessed directly. This approach avoids confusion about how the value is accessed in different contexts and simplifies the property’s declaration into a single, definitive statement. All information about the property—including its name, type, and memory management characteristics—is defined in a single location as part of the type’s definition. Swift将这些概念统一为一个属性声明。 Swift属性没有相应的实例变量，并且不直接访问属性的后备存储。这种方法避免了在不同上下文中如何访问值的混淆，并将属性的声明简化为一个单一的定义语句。关于属性的所有信息（包括其名称，类型和内存管理特性）都在单个位置定义，作为类型定义的一部分。
 */
/*:
 ### example
 */
class MyView : UIView {
    lazy var arrow : UIImage = self.arrowImage()
    func arrowImage () -> UIImage {
        // ... big image-generating code goes here ...
        return UIImage() // stub
    }
}
class ViewController: UIViewController {

    lazy var prog : UIProgressView = {
        let p = UIProgressView(progressViewStyle: .default)
        p.alpha = 0.7
        p.trackTintColor = UIColor.clear
        p.progressTintColor = UIColor.black
        p.frame = CGRect(x:0, y:0, width:self.view.bounds.size.width, height:20)
        p.progress = 1.0
        return p
    }()

    override func viewDidLoad() {
        let layout = UICollectionViewLayout()
        class MyDynamicAnimator : UIDynamicAnimator {}
        let anim2 = MyDynamicAnimator(collectionViewLayout:layout)
        _ = anim2
    }
}

/*:
 # Computed Properties
 computed Variables

 In addition to stored properties, classes, structures, and enumerations can define computed properties, which do not actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly. 除了存储的属性之外，类，结构和枚举可以定义计算的属性，而实际上并不存储值。 相反，它们提供一个getter和一个可选的setter来间接检索和设置其他属性和值。
 */
/// Point encapsulates the x- and y-coordinate of a point.
struct Point {
    var x = 0.0, y = 0.0
}
/// Size encapsulates a width and a height.
struct Size {
    var width = 0.0, height = 0.0
}
/// Rect defines a rectangle by an origin point and a size. see picture: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/computedProperties_2x.png
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
do {
    var square = Rect(origin: Point(x: 0.0, y: 0.0),
                      size: Size(width: 10.0, height: 10.0))
    let initialSquareCenter = square.center
    square.center = Point(x: 15.0, y: 15.0)
    print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
    // Prints "square.origin is now at (10.0, 10.0)"
}
do {
    /// Normal get and set
    var now : String {
        get {
            return NSDate().description
        }
        set {
            print(newValue)
        }
    }

    /// showing you can omit "get" if there is no "set"
    var now2: String {
        return NSDate().description
    }

    var mp : MPMusicPlayerController {
        return MPMusicPlayerController.systemMusicPlayer()
    }
}
do {
    /// typical "facade" structure
    var _p : String = "" /// 一般定义为 private, but at here make error: attribute 'private' can only be used in a non-local scope
    var p : String {
        get {
            return _p //在类里加self._p
        }
        set {
            _p = newValue
        }
    }
    p="test"
}
//: ## example
private var myBigDataReal : NSData! = nil
var myBigData : NSData! {
    set (newdata) {
        myBigDataReal = newdata
    }
    get {
        if myBigDataReal == nil {
            let fm = FileManager()
            let f = (NSTemporaryDirectory() as NSString).appendingPathComponent("myBigData")
            if fm.fileExists(atPath: f) {
                print("loading big data from disk")
                myBigDataReal = NSData(contentsOfFile: f)
                do {
                    try fm.removeItem(atPath: f)
                    print("deleted big data from disk")
                } catch {
                    print("Couldn't remove temp file")
                }
            }
        }
        return myBigDataReal
    }
}
do {
    var _myBigData : Data! = nil
    var myBigData : Data! {
        set (newdata) {
            _myBigData = newdata
        }
        get {
            if _myBigData == nil {
                let fm = FileManager.default
                let f = fm.temporaryDirectory.appendingPathComponent("myBigData")
                if let d = try? Data(contentsOf:f) {
                    print("loaded big data from disk")
                    _myBigData = d
                    do {
                        try fm.removeItem(at:f)
                        print("deleted big data from disk")
                    } catch {
                        print("Couldn't remove temp file")
                    }
                }
            }
            return _myBigData
        }
    }
}

/*:
 ## Shorthand Setter Declaration

 If a computed property’s setter does not define a name for the new value to be set, a default name of newValue is used. 如果计算属性的设置器未定义要设置的新值的名称，则使用默认名称newValue。Here’s an alternative version of the Rect structure, which takes advantage of this shorthand notation:
 */
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
/*:
 ## Read-Only Computed Properties

 A computed property with a getter but no setter is known as a read-only computed property. A read-only computed property always returns a value, and can be accessed through dot syntax, but cannot be set to a different value. 具有getter但不设置器的计算属性称为只读计算属性。 只读计算属性始终返回一个值，可以通过点语法访问，但不能设置为不同的值。

 - NOTE:
 You must declare computed properties—including read-only computed properties—as variable properties with the var keyword, because their value is not fixed. 您必须将计算的属性（包括只读计算属性）声明为具有var关键字的变量属性，因为它们的值不是固定的。 The let keyword is only used for constant properties, to indicate that their values cannot be changed once they are set as part of instance initialization. let关键字仅用于常量属性，表示它们的值在实例初始化后被设置为无法更改。
 
 You can simplify the declaration of a read-only computed property by removing the get keyword and its braces. 您可以通过删除get关键字及其大括号来简化只读计算属性的声明:
 */
do {
    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        var volume: Double {
            return width * height * depth
        }
    }
    let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
    print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
    // Prints "the volume of fourByFiveByTwo is 40.0"
}


/*:
 # Property Observers

 Property observers observe and respond to changes in a property’s value. Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.

 You can add property observers to any stored properties you define, except for lazy stored properties. You can also add property observers to any inherited property (whether stored or computed) by overriding the property within a subclass. You don’t need to define property observers for nonoverridden computed properties, because you can observe and respond to changes to their value in the computed property’s setter. Property overriding is described in Overriding.

 You have the option to define either or both of these observers on a property:

 - willSet is called just before the value is stored. 将在存储值之前调用willSet。
 - didSet is called immediately after the new value is stored. 在存储新值后立即调用didSet。
 If you implement a willSet observer, it’s passed the new property value as a constant parameter. You can specify a name for this parameter as part of your willSet implementation. If you don’t write the parameter name and parentheses within your implementation, the parameter is made available with a default parameter name of newValue. 如果你实现了一个willSet观察者，它将新的属性值作为一个常量参数传递。您可以为该参数指定一个名称作为您的willSet实现的一部分。如果您不在实现中写入参数名称和括号，则该参数将使用默认参数名称newValue。

 Similarly, if you implement a didSet observer, it’s passed a constant parameter containing the old property value. You can name the parameter or use the default parameter name of oldValue. If you assign a value to a property within its own didSet observer, the new value that you assign replaces the one that was just set. 类似地，如果您实现了一个didSet观察器，它将传递一个包含旧属性值的常量参数。您可以命名参数或使用默认参数名称oldValue。如果您为自己的didSet观察者中的属性分配了一个值，则您分配的新值将替换刚刚设置的值。

 - NOTE:
 The willSet and didSet observers of superclass properties are called when a property is set in a subclass initializer, after the superclass initializer has been called. They are not called while a class is setting its own properties, before the superclass initializer has been called. 在调用超类初始化程序之后，在子类初始化器中设置属性时，将调用willSet和didSet的超类属性。一个类在调用超类初始化器之前设置自己的属性时不会调用它们。

 For more information about initializer delegation, see Initializer Delegation for Value Types https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID215 and Initializer Delegation for Class Types https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID219.
 */
do {
    class StepCounter {
        var totalSteps: Int = 0 {
            willSet(newTotalSteps) {
                print("About to set totalSteps to \(newTotalSteps)")
            }
            didSet {
                if totalSteps > oldValue  {
                    print("Added \(totalSteps - oldValue) steps")
                }
            }
        }
    }
    let stepCounter = StepCounter()
    stepCounter.totalSteps = 200
    // About to set totalSteps to 200
    // Added 200 steps
    stepCounter.totalSteps = 360
    // About to set totalSteps to 360
    // Added 160 steps
    stepCounter.totalSteps = 896
    // About to set totalSteps to 896
    // Added 536 steps

    var s = "whatever" {
        willSet {
            print(newValue)
        }
        didSet {
            print(oldValue)
        }
    }
    s = "Hello"
    s = "Bonjour"
}
/*:
 - NOTE:
 If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called. This is because of the copy-in copy-out memory model for in-out parameters: The value is always written back to the property at the end of the function. For a detailed discussion of the behavior of in-out parameters, see In-Out Parameters https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Declarations.html#//apple_ref/doc/uid/TP40014097-CH34-ID545. 如果将具有观察者的属性作为in-out参数传递给函数，则将始终调用willSet和didSet观察器。 这是因为in-out参数的copy-in copy-out内存模型：该值始终写回函数末尾的属性。 有关in-out参数的行为的详细讨论，请参阅In-Out参数。
 */

/*:
 # Global and Local Variables

 The capabilities described above for computing and observing properties are also available to global variables and local variables. Global variables are variables that are defined outside of any function, method, closure, or type context. Local variables are variables that are defined within a function, method, or closure context. 全局变量是在任何函数，方法，闭包或类型上下文之外定义的变量。局部变量是在函数，方法或闭包上下文中定义的变量。

 The global and local variables you have encountered in previous chapters have all been stored variables. Stored variables, like stored properties, provide storage for a value of a certain type and allow that value to be set and retrieved.

 However, you can also define computed variables and define observers for stored variables, in either a global or local scope. Computed variables calculate their value, rather than storing it, and they are written in the same way as computed properties.

 - NOTE:
 Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables do not need to be marked with the lazy modifier. 全局常量和变量总是以懒惰存储属性的方式懒惰地计算。与延迟存储的属性不同，全局常量和变量不需要用延迟修饰符标记。

 Local constants and variables are never computed lazily. 本地常量和变量永远不会懒惰地计算。
 */

/*:
 # Type Properties 类型属性

 Instance properties are properties that belong to an instance of a particular type. Every time you create a new instance of that type, it has its own set of property values, separate from any other instance. 实例属性是属于特定类型的实例的属性。每次创建该类型的新实例时，它都有自己的一组属性值，与任何其他实例分开。

 You can also define properties that belong to the type itself, not to any one instance of that type. There will only ever be one copy of these properties, no matter how many instances of that type you create. These kinds of properties are called type properties. 您还可以定义属于类型本身的属性，而不是该类型的任何一个实例。只有这些属性的一个副本，无论你创建了多少个类型的实例。这些属性称为类型属性。

 Type properties are useful for defining values that are universal to all instances of a particular type, such as a constant property that all instances can use (like a static constant in C), or a variable property that stores a value that is global to all instances of that type (like a static variable in C). 类型属性可用于定义通用于特定类型的所有实例的值，例如所有实例可以使用的常量属性（如C中的静态常量）或存储全局值的变量属性该类型的实例（如C中的静态变量）。

 Stored type properties can be variables or constants. Computed type properties are always declared as variable properties, in the same way as computed instance properties.

 - NOTE:
 Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself does not have an initializer that can assign a value to a stored type property at initialization time. 与存储的实例属性不同，您必须始终将存储的类型属性指定为默认值。这是因为类型本身没有初始化程序，可以在初始化时为一个存储类型属性分配一个值。

 Stored type properties are lazily initialized on their first access. They are guaranteed to be initialized only once, even when accessed by multiple threads simultaneously, and they do not need to be marked with the lazy modifier. 存储类型属性在其第一次访问时被延迟初始化。它们保证只被初始化一次，即使同时被多个线程访问，也不需要使用延迟修饰符进行标记。
 
 ## Type Property Syntax

 In C and Objective-C, you define static constants and variables associated with a type as global static variables. In Swift, however, type properties are written as part of the type’s definition, within the type’s outer curly braces, and each type property is explicitly scoped to the type it supports. 在C和Objective-C中，将与类型关联的静态常量和变量定义为全局静态变量。 然而，在Swift中，类型属性将作为类型定义的一部分写入类型的外部花括号中，并且每个类型属性都明确地定义为其支持的类型。

 You define type properties with the static keyword. For computed type properties for class types, you can use the class keyword instead to allow subclasses to override the superclass’s implementation. 您使用static关键字定义类型属性。 对于类类型的计算类型属性，可以使用class关键字来允许子类覆盖超类的实现。
 */
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
/// The computed type property examples above are for read-only computed type properties, but you can also define read-write computed type properties with the same syntax as for computed instance properties.

/*:
 ## override type property and func
 提示: 在静态计算属性中不能访问实例属性（包括存储属性和计算属性），但可以访问其他静态属性。在实例计算属性中能访问实例属性，也能访问静态属性。
 */
do {
    class Person {
        //class修饰：支持子类对该实现进行重写
        class func show(){
            print("class-func...")
        }

        //static修饰：不支持子类对该实现进行重写
        static func display() {
            print("static-func...")
        }
    }

    class Student:Person {
        override class func show(){
            print("Student重写:class-func...")
        }

        //    //这里报错...cannot override static method
        //    override static func display(){}
    }

    /// 使用关键字static来定义类型属性。在为类定义 “计算型” 类型属性时，可以改用关键字class来支持子类对父类的实现进行重写
    class SomeClass {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 1
        }

        //class修饰“计算型” ：支持子类对该实现进行重写
        class var overrideableComputedTypeProperty: Int {
            return 2
        }
    }

    class OneClass : SomeClass {
        //     //这里报错...cannot override static var
        //    override static var computedTypeProperty: Int {
        //        return 111
        //    }

        override class var overrideableComputedTypeProperty: Int {
            return 222
        }
    }
}

/*:
 ## Querying and Setting Type Properties

 Type properties are queried and set with dot syntax, just like instance properties. However, type properties are queried and set on the type, not on an instance of that type. 查询类型属性并使用点语法设置，就像实例属性一样。 但是，类型属性将被查询并设置在类型上，而不是该类型的实例上。
 */
do {
    print(SomeStructure.storedTypeProperty)
    // Prints "Some value."
    SomeStructure.storedTypeProperty = "Another value."
    print(SomeStructure.storedTypeProperty)
    // Prints "Another value."
    print(SomeEnumeration.computedTypeProperty)
    // Prints "6"
    print(SomeClass.computedTypeProperty)
    // Prints "27"
}

/// structure that models an audio level meter for a number of audio channels. https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/staticPropertiesVUMeter_2x.png
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
do {
    var leftChannel = AudioChannel()
    var rightChannel = AudioChannel()
    leftChannel.currentLevel = 7
    print(leftChannel.currentLevel)
    // Prints "7"
    print(AudioChannel.maxInputLevelForAllChannels)
    // Prints "7"
    rightChannel.currentLevel = 11
    print(rightChannel.currentLevel)
    // Prints "10"
    print(AudioChannel.maxInputLevelForAllChannels)
    // Prints "10"
}

/*:
 ## type property access each other
 在静态计算属性中不能访问实例属性（包括存储属性和计算属性），但可以访问其他静态属性。在实例计算属性中能访问实例属性，也能访问静态属性。
 */

/*:
 ## type property in protocol
 class methods are only allowed within classes, so protocol only can use key word static.
 有一个比较特殊的是protocol。在Swift中class、struct和enum都是可以实现protocol的。那么如果我们想在protocol里定义一个类型域上的方法或者计算属性的话，应该用哪个关键字呢？答案是使用class进行定义，但是在实现时还是按照上面的规则：在class里使用class关键字，而在struct或enum中仍然使用static——虽然在protocol中定义时使用的是class：
 */

protocol MyProtocol {
    static func foo() -> String
}
struct MyStruct: MyProtocol {
    static func foo() -> String {
        return "MyStruct"
    }
}
enum MyEnum: MyProtocol {
    static func foo() -> String {
        return "MyEnum"
    }
}
class MyClass: MyProtocol {
    class func foo() -> String {
        return "MyClass"
    }
}

do {
    MyClass.foo()
}


//: [Next](@next)
