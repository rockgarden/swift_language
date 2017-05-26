//: [Previous](@previous)
import UIKit
/*:
 # Classes and structures
 Classes and structures are general-purpose, flexible constructs that become the building blocks of your program’s code. You define properties and methods to add functionality to your classes and structures by using exactly the same syntax as for constants, variables, and functions.
 类和结构是通用的，其灵活的结构成为程序代码的基础。 您可以通过使用与常量，变量和函数完全相同的语法来定义属性和方法来向类和结构添加功能。
 Unlike other programming languages, Swift does not require you to create separate interface and implementation files for custom classes and structures. In Swift, you define a class or a structure in a single file, and the external interface to that class or structure is automatically made available for other code to use.
 与其他编程语言不同，Swift不需要为自定义类和结构创建单独的接口和实现文件。 在Swift中，可以在单个文件中定义一个类或结构，并且该类或结构的外部接口自动可供其他代码使用。
 - NOTE:
 An instance of a class is traditionally known as an object. However, Swift classes and structures are much closer in functionality than in other languages, and much of this chapter describes functionality that can apply to instances of either a class or a structure type. Because of this, the more general term instance is used.
 
 - NOTE: class与struct不能重名

 # Comparing Classes and Structures
 Classes and structures in Swift have many things in common. Both can:
 - Define properties to store values 定义要存储值的属性
 - Define methods to provide functionality 定义方法以提供功能
 - Define subscripts to provide access to their values using subscript syntax 定义下标，以使用下标语法访问其值
 - Define initializers to set up their initial state 定义初始化程序以设置其初始状态
 - Be extended to expand their functionality beyond a default implementation 扩展它们的功能超出默认实现
 - Conform to protocols to provide standard functionality of a certain kind 符合协议以提供某种类型的标准功能
 For more information, see Properties, Methods, Subscripts, Initialization, Extensions, and Protocols.
 Classes have additional capabilities that structures do not:
 - Inheritance enables one class to inherit the characteristics of another. 继承使一个类能够继承另一个类的特性
 - Type casting enables you to check and interpret the type of a class instance at runtime. 类型转换使您能够在运行时检查和解释类实例的类型。
 - Deinitializers enable an instance of a class to free up any resources it has assigned. Deinitializers使一个类的实例释放它分配的任何资源。
 - Reference counting allows more than one reference to a class instance. 引用计数允许对类实例的多个引用。
 For more information, see Inheritance, Type Casting, Deinitialization, and Automatic Reference Counting.

 - NOTE:
 Structures are always copied when they are passed around in your code, and do not use reference counting.
 
 ## Definition Syntax
 Classes and structures have a similar definition syntax. You introduce classes with the class keyword and structures with the struct keyword. Both place their entire definition within a pair of braces.
 */
class SomeClass {
// class definition goes here
}
struct SomeStructure {
// structure definition goes here
}
/*:
 - NOTE:
 Whenever you define a new class or structure, you effectively define a brand new Swift type. Give types UpperCamelCase names (such as SomeClass and SomeStructure here) to match the capitalization of standard Swift types (such as String, Int, and Bool). Conversely, always give properties and methods lowerCamelCase names (such as frameRate and incrementCount) to differentiate them from type names.
 */
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
/*:
 ## Class and Structure Instances
 The Resolution structure definition and the VideoMode class definition only describe what a Resolution or VideoMode will look like. They themselves do not describe a specific resolution or video mode. To do that, you need to create an instance of the structure or class.

 The syntax for creating instances is very similar for both structures and classes:
 */
let someResolution = Resolution()
let someVideoMode = VideoMode()
/*:
 Structures and classes both use initializer syntax for new instances. The simplest form of initializer syntax uses the type name of the class or structure followed by empty parentheses, such as Resolution() or VideoMode(). This creates a new instance of the class or structure, with any properties initialized to their default values. Class and structure initialization is described in more detail in Initialization.
 ## Accessing Properties
 You can access the properties of an instance using dot syntax. In dot syntax, you write the property name immediately after the instance name, separated by a period (.), without any spaces.
 */
do {
    print("The width of someResolution is \(someResolution.width)")
    // Prints "The width of someResolution is 0"
    print("The width of someVideoMode is \(someVideoMode.resolution.width)")
    // Prints "The width of someVideoMode is 0"
    someVideoMode.resolution.width = 1280
    print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
    // Prints "The width of someVideoMode is now 1280"
}
/*:
 - NOTE:
 Unlike Objective-C, Swift enables you to set sub-properties of a structure property directly. In the last example above, the width property of the resolution property of someVideoMode is set directly, without your needing to set the entire resolution property to a new value.
 */
/*:
 ## Memberwise Initializers for Structure Types
 All structures have an automatically-generated memberwise initializer, which you can use to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.

 Unlike structures, class instances do not receive a default memberwise initializer. Initializers are described in more detail in Initialization.
 与结构不同，类实例不接收默认的成员初始化。 在初始化中更详细地描述初始化器。
 */
do {
    let vga = Resolution(width: 640, height: 480)
}


/*:
 # Structures and Enumerations Are Value Types

 A value type is a type whose value is copied when it is assigned to a variable or constant, or when it is passed to a function.

 You’ve actually been using value types extensively throughout the previous chapters. In fact, all of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types, and are implemented as structures behind the scenes.

 All structures and enumerations are value types in Swift. This means that any structure and enumeration instances you create—and any value types they have as properties—are always copied when they are passed around in your code.
 */
do {
    let hd = Resolution(width: 1920, height: 1080)
    var cinema = hd
    cinema.width = 2048
    print("cinema is now \(cinema.width) pixels wide")
    // Prints "cinema is now 2048 pixels wide"
    print("hd is still \(hd.width) pixels wide")
    // Prints "hd is still 1920 pixels wide"

    enum CompassPoint {
        case north, south, east, west
    }
    var currentDirection = CompassPoint.west
    let rememberedDirection = currentDirection
    currentDirection = .east
    if rememberedDirection == .west {
        print("The remembered direction is still .west")
    }
    // Prints "The remembered direction is still .west"
}


/*:
 # Classes Are Reference Types
 Unlike value types, reference types are not copied when they are assigned to a variable or constant, or when they are passed to a function. Rather than a copy, a reference to the same existing instance is used instead.
 与值类型不同，引用类型在分配给变量或常量时或者传递给函数时不会被复制。 而不是副本，而是使用对同一现有实例的引用。
 */
do {
    let hd = Resolution(width: 1920, height: 1080)
    let tenEighty = VideoMode()
    tenEighty.resolution = hd
    tenEighty.interlaced = true
    tenEighty.name = "1080i"
    tenEighty.frameRate = 25.0

    let alsoTenEighty = tenEighty
    alsoTenEighty.frameRate = 30.0

    print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
    // Prints "The frameRate property of tenEighty is now 30.0"
}

/*:
 ## Identity Operators
 Because classes are reference types, it is possible for multiple constants and variables to refer to the same single instance of a class behind the scenes. (The same is not true for structures and enumerations, because they are always copied when they are assigned to a constant or variable, or passed to a function.)
 因为类是引用类型，所以有可能多个常量和变量在后台引用一个类的同一个单一实例。 （对于结构和枚举也不是这样，因为它们在被分配给常量或变量或传递给函数时总是被复制。）
 It can sometimes be useful to find out if two constants or variables refer to exactly the same instance of a class. To enable this, Swift provides two identity operators:
 有时可能有用的是找出两个常量或变量是否指向一个类的完全相同的实例。 为了实现这一点，Swift提供了两个身份操作符：
 - Identical to (===)
 - Not identical to (!==)
 Note that “identical to” (represented by three equals signs, or ===) does not mean the same thing as “equal to” (represented by two equals signs, or ==):
 - “Identical to” means that two constants or variables of class type refer to exactly the same class instance.
 - “Equal to” means that two instances are considered “equal” or “equivalent” in value, for some appropriate meaning of “equal”, as defined by the type’s designer.
 When you define your own custom classes and structures, it is your responsibility to decide what qualifies as two instances being “equal”. The process of defining your own implementations of the “equal to” and “not equal to” operators is described in Equivalence Operators.
 */
do {
    let tenEighty = VideoMode()
    let alsoTenEighty = tenEighty

    if tenEighty === alsoTenEighty {
        print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
    }
}
/*:
 ## Pointers
 If you have experience with C, C++, or Objective-C, you may know that these languages use pointers to refer to addresses in memory. A Swift constant or variable that refers to an instance of some reference type is similar to a pointer in C, but is not a direct pointer to an address in memory, and does not require you to write an asterisk (*) to indicate that you are creating a reference. Instead, these references are defined like any other constant or variable in Swift.
 

 */

/*:
 ## Choosing Between Classes and Structures
 类和结构体的选择
 You can use both classes and structures to define custom data types to use as the building blocks of your program’s code.
 您可以使用类和结构来定义自定义数据类型，以用作程序代码的构建块。
 However, structure instances are always passed by value, and class instances are always passed by reference. This means that they are suited to different kinds of tasks. As you consider the data constructs and functionality that you need for a project, decide whether each data construct should be defined as a class or as a structure.
 然而，结构实例总是通过值传递，类实例总是通过引用传递。这意味着它们适合于不同类型的任务。在考虑项目所需的数据结构和功能时，请确定每个数据结构是否应定义为类或结构。
 As a general guideline, consider creating a structure when one or more of these conditions apply:
 作为一般准则，考虑在以下一个或多个条件适用时创建结构：
 - The structure’s primary purpose is to encapsulate a few relatively simple data values. 结构体的主要目的是用来封装少量相关的简单数据值。
 - It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure. 当您分配或传递该结构的实例时，期望封装的值将被复制而不是被引用是合理的。
 - Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced. 由结构存储的任何属性都是值类型，这也将被期望被复制而不是被引用。
 - The structure does not need to inherit properties or behavior from another existing type. 该结构不需要从另一个现有类型继承属性或行为。
 Examples of good candidates for structures include 合适的结构体候选者包括:
 - The size of a geometric shape, perhaps encapsulating a width property and a height property, both of type Double. 几何形状的大小，封装一个width属性和height属性，两者均为Double类型。
 - A way to refer to ranges within a series, perhaps encapsulating a start property and a length property, both of type Int. 一定范围内的路径，可能封装了start属性和length属性，都是Int类型。
 - A point in a 3D coordinate system, perhaps encapsulating x, y and z properties, each of type Double. 三维坐标系内一点，封装x，y和z属性，三者均为Double类型。
 In all other cases, define a class, and create instances of that class to be managed and passed by reference. In practice, this means that most custom data constructs should be classes, not structures.
 */
/*:
 # Assignment and Copy Behavior for Strings, Arrays, and Dictionaries

 In Swift, many basic data types such as String, Array, and Dictionary are implemented as structures. This means that data such as strings, arrays, and dictionaries are copied when they are assigned to a new constant or variable, or when they are passed to a function or method.
 在Swift中，许多基本数据类型，例如String，Array和Dictionary被实现为结构体。这意味着，如果字符串，数组和字典等数据被分配给一个新的常量或变量，或者当它们传递给一个函数或方法时，它们就被复制。
 This behavior is different from Foundation: NSString, NSArray, and NSDictionary are implemented as classes, not structures. Strings, arrays, and dictionaries in Foundation are always assigned and passed around as a reference to an existing instance, rather than as a copy.
 这个行为与Foundation不同：NSString，NSArray和NSDictionary实现为类而不是结构。 Foundation中的字符串，数组和字典总是作为对现有实例的引用而分配和传递，而不是作为副本。
 - NOTE:
 The description above refers to the “copying” of strings, arrays, and dictionaries. The behavior you see in your code will always be as if a copy took place. However, Swift only performs an actual copy behind the scenes when it is absolutely necessary to do so. Swift manages all value copying to ensure optimal performance, and you should not avoid assignment to try to preempt this optimization.
 上面的描述涉及字符串，数组和字典的“复制”。您在代码中看到的行为将始终如同复制发生。但是，Swift只在绝对必要的情况下在幕后执行一个实际的副本。 Swift管理所有值复制以确保最佳性能，并且您不应该避免分配尝试抢占此优化。
 */



/*:
 # Example
 */
do {
    struct Dog {
        var name: String
        var age: Int
        func run() {
            name
        }
    }
    var dog = Dog(name: "rock", age: 2)
    dog.name
    dog.run()
    var dog2 = dog //struct copy!
    dog2.name = "snoopy"
    dog2.name
    dog.name
}
do {
    let rect = CGRect.zero
    var arrow = CGRect.zero
    var body = CGRect.zero
    struct Arrow {
        static let ARHEIGHT : CGFloat = 0
    }
    rect.divided(atDistance: Arrow.ARHEIGHT, from: .minYEdge)
}
do {
    struct Digit3 {
        var number = 42
        init() {}
        init(number:Int) {
            self.number = number
        }
    }
}
do {
    struct Thing {
        var rawValue : Int = 0
        static var One = Thing(rawValue:1)
        static var Two = Thing(rawValue:2)
    }
    let t = Thing.One
    t.rawValue
    //t.One //static member 'One' cannot be used on instance of type 'Thing'
    let thing : Thing = .Two // no need to say Thing.One here
    thing.rawValue
    let th = Thing.init(rawValue: 10)
    th.rawValue
}
do {
    struct DigitReplacer {
        var number = 42
        mutating func replace() {
            self = DigitReplacer(number:86)
        }
    }
    var d = DigitReplacer()
    d.number
    d.replace()
    d.number
}
do {
    struct Digit {
        var number: Int
        init(_ n: Int) {
            self.number = n
        }
        mutating func changeNumberTo(_ n: Int) {
            self.number = n
        }
        /// illegal without "mutating", cannot assign to property: 'self' is immutable

        /*
         func changeNumberTo2(n:Int) {
         self.number = n // compile error
         }
         */
    }

    /// In swift 3 func parameter can't use var. the example exactly illustrates the reason: you probably _think_ you are changing the original Digit object... but you're just changing a copy
    /*
     func digitChanger(d:Digit) {
     d.number = 42 // compile error: cannot assign to 'number' in 'd'
     }
     */

    do {
        /// if you really intended to change the original object, use inout key word
        ///
        /// - Parameter d: Digit
        func digitChanger(d: inout Digit) {
            d.number = 42
            print(d.number)
        }
        var digit = Digit(8)
        digitChanger(d: &digit)
    }
    do {
        /// Redeclare var d = d to make local d mutable...
        ///
        /// - Parameter d: Digit
        func digitChanger(d: Digit) {
            /// assignment! Struct value 由于是值传送,所以原Struct不变
            var d1 = d
            d1.number = 42
            print(d1.number, d.number)
        }
        var vD = Digit(8)
        digitChanger(d: vD)
        vD.number
        let lD = Digit(123)
        /// Class Reference value change
        (lD.number) // 123
        digitChanger(d: lD)
        (lD.number) // 123
    }
    do {
        let d = Digit(123)
        //d.number = 42 // compile error: cannot assign to property: 'd' is a 'let' constant need change to var
        var d2 = Digit(123) {
            didSet {
                ("d2 was set")
            }
        }
        d2.number = 42 // "d2 was set"
    }
    do {
        var d = Digit(123)
        // let d = Digit(123)
        d.changeNumberTo(42) // compile error if d is `let`
    }
}
do {
    class Dog {
        var name : String = "Fido"
    }

    func dogChanger(_ d: Dog) {
        d.name = "Rover"
    }

    let rover = Dog()
    rover.name = "Rover" // fine
    rover.name
    var rover2 = Dog() {
        didSet {
            ("did set rover2")
        }
    }
    rover2.name = "Rover" // nothing in console

    do {
        let fido = Dog()
        (fido.name) // Fido
        /// assignment! Class Reference
        let rover = fido
        rover.name = "Rover"
        (fido.name) // Rover
    }
    do {
        /// Class Reference value change
        let fido = Dog()
        (fido.name) // "Fido"
        dogChanger(fido)
        (fido.name) // "Rover"
    }

}

do {
    class Dog {
        var name = ""
        var whatADogSays = "woof"
        func bark() {
            print(self.whatADogSays)
        }
        func speak() {
            self.bark()
        }
    }
    let d1 = Dog()
    d1.name = "Fido"
    var d2 = Dog()
    d2.name = "Rover"
    d2 = d1 //指针
    (d2.name)
    (d1.self) //the magic word "self"
    d1.bark()
    d1.speak()
}

//: 定义抽象类
do {
    final class A {
        var surname: String
        var name: String
        /// 若用private init() -> error: 'A' initializer is inaccessible due to 'private' protection level
        init() {
            self.surname = ""
            self.name = ""
        }
    }
    var a: A
    a = A()
}


//: required init
do {
    /// 直接实例属性
    class Person {
        var name = "tina"
        var age = 19
        var height = 172.2
        func produce(){
            age += 1
        }
        func say(_ content: String){
            print(name, "say", content)
        }
    }
    var p: Person
    p = Person()
    p.name
    p.say("hello")
    var p2=p
    p2.name = "rock"
    p.name
}
do {
    /// 通过init方法赋值
    class user {
        let name: String
        let age: Int
        /// init方法都需要在方法中保证所有非Optional的实例变量被赋值初始化
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
        func info() {
            print("\(name) \(age)")
        }
    }
    var u1 = user(name: "jerry", age: 6)
    var u2 = user(name: "tom", age: 36)
    /// 引用比较
    u1 === u2
    u1 !== u2
    var u3 = u1
    u3 === u1
    var u4 = user(name:"lily", age:10)
    u4.info()
}
do {
    /// init? 可失败的初始化方法,即不保证所有Optional的实例变量被赋值初始化,可返回nil
    class pm {
        var name: String!
        init?(name: String) {
            if name.isEmpty {
                return nil
            }
            self.name = name
        }
    }
    class subPM: pm {
        var grade: Int!
        init!(name: String, grade: Int) { //!=?
            super.init(name: name)
            if grade < 1 {
                return nil
            }
            self.grade = grade
        }
    }
    let subPM1 = subPM(name: "tom", grade: 4)
    let subPM2 = subPM(name: "jerry", grade: 0)
    subPM2 == nil
    /// super init is nil sub also nil
    let subPM3 = subPM(name: "", grade: 3)
    subPM3 == nil
}

//: Sub Class
do {
    class Quadruped {
        func walk () {
            ("walk walk walk")
        }
    }
    class Dog : Quadruped {
        func bark () {
            print("woof")
        }
        func bark2 () {
            ("woof")
        }
        func barkAndWalk() {
            self.bark()
            self.walk()
        }
    }
    class Cat : Quadruped {}
    class NoisyDog : Dog {
        override func bark () {
            print("woof woof woof")
        }
        override func bark2 () {
            for _ in 1...3 {
                super.bark()
            }
        }
    }
    let fido = Dog()
    fido.walk() // walk walk walk
    fido.bark() // woof
    fido.barkAndWalk() // woof walk walk walk

    let rover = NoisyDog()
    rover.bark() // woof woof woof
    rover.bark2() // woof woof woof
}
do {
    class Bird {
        var name: String!
        init(){}
        init?(name: String) {
            if name.isEmpty {
                return nil
            }
            self.name = name
        }
        func fly() {
        }
    }

    class Sparrow: Bird {
        var weight: Double!
        init?(name: String, weight: Double) { //init?可调用super.init?
            super.init(name: name)
            if weight <= 0 {
                return nil
            }
            self.weight = weight
            self.name = name
        }
        override init(name: String) {
            super.init()
            if name.isEmpty {
                super.name = "麻雀"
            }
            self.name = name
        }
        override func fly() {
            print("fly bird")
        }
    }
    let sp1 = Sparrow(name: "")
    let sp2 = Sparrow(name: "", weight: 2.2)
    let sp3 = Sparrow(name: "小黄嘴", weight: 0)
    let sp4 = Sparrow(name: "小黄嘴", weight: 2.2)
    (sp4!.name, sp2 == nil, sp3 == nil)
}
do {
    class Fruit {
        var name = ""
        var weight: Double
        /// 若加了 "required" init 关键字进行限制, 则强制子类对这个方法重写实现. 'required' initializer 'init(name:)' must be provided by subclass of 'Fruit'
        init(name: String) {
            self.name = name
            self.weight = 0.0
        }
        convenience init(name: String, weight: Double){
            self.init(name: name)
            self.weight = weight
        }
        convenience init(n name: String, w weight: Double){
            self.init(name: name)
        }
        convenience init() {
            self.init(name: "水果")
            self.weight = 1.0
        }
        deinit{
            print("deinit Fruit")
        }
    }
    class Apple: Fruit {
        var color = ""
        // 指定构造器
        init(name: String, weight: Double, color: String) {
            self.color = color
            super.init(name: name)
            self.weight = weight
        }
        init(name: String, weight: Double) {
            self.color = ""
            super.init(name: name)
            self.weight = weight
        }
        init(color: String) {
            self.color = color
            self.color = "red"
            super.init(name: "rose")
            super.name = "apple"
            self.weight = 0.0
        }
        init() {
            self.color = ""
            super.init(name: "")
            self.weight = 0.0
        }
        /// 父类的便利构造器的初始化方法是不能被子类重写,也不能在子类中以super的方式被调用
        /// 便利构造器必须调用同一个类中其它designated指定构造器
        convenience init(name: String, color: String){
            self.init(name: name, weight: 0.0, color: color)
            self.weight = weight
        }
        convenience init(n name: String, c color: String) {
            self.init(name: name, color:color)
        }
        convenience init(n name: String, w weight: Double){
            self.init(name: name, weight: weight, color: "")
        }
        deinit{
            print("deinit Apple")
        }
    }
    var app1: Apple? = Apple(n: "red apple", w: 0.5)
    /// Apple? 必须加不然app1无法赋nil
    print(app1)
    app1 = nil //error: nil cannot be assigned to type 'Apple'
    var app2 = Apple(name: "yellow", weight: 0.6)
    /*: deinit的调用
     - 对象为nil后调用
     - 是在一个消息处理结束之后发生的
     - 消息处理就是指你的线程所对应的AutoreleasePool在该线程的runloop执行模式下,处理完一个指定的event,比如点击事件.
     */

    class sonApple: Apple {
        var vitamin: Double = 0.21
    }

    var anyArray:[Any] = [
        "swift",
        29,
        ["ios":89,"android":92],
        Fruit(name: "Fruit", weight: 2.2),
        Apple(name: "Apple", weight: 0.2)
    ]
    for element in anyArray{
        if let f = element as? Fruit{
            print(f.name,f.weight)
        }
    }

}

//: 重写下标与属性
do {
    class Base {
        subscript(idx: Int) -> Int {
            get{
                return idx + 10
            }
        }
        var speed: Double = 0
        var speed1: Double = 0
        final var name: String = ""
        final func say(_ content: String) {
            print(content)
        }
    }
    class Sub: Base {
        override subscript(idx: Int) -> Int{
            get{
                return idx * idx
            }
            set{
                print(newValue)
            }
        }
        override var speed: Double{
            get{
                return super.speed
            }
            set{
                super.speed = newValue * newValue
            }
        }
        override var speed1:Double{
            didSet{
                print(oldValue)
                super.speed1 *= speed1
            }
        }
    }
    var base1 = Base()
    (base1[7])
    var sub = Sub()
    (sub[7]) //get下标
    sub[7] = 90 //set下标
    sub.speed = 20 //set属性
    (sub.speed) //get属性
}

//: # 转型
//: 向上转型子类附给父类＝用父类编译子类
do {
    class Base {}
    class Sub: Base {}

    var base2: Base = Sub()
}

//: ## is运算符
do {
    let hello: Any = "hello"
    (hello is NSString)
    (hello is NSDate)
}

//: ## as类型转换
do {
    let obj: Any = "hello"
    let objStr = obj as! NSString //NSObject是编译时类型,NSString是运行时类型
    let objPri: NSObject = 5 as NSObject
    //NSObject是编译时类型,运行时类型为NSNumber
    //let strPri: NSString = objPri as! NSString
}

//: final关键字防止重写

//: ## Example
do {
    var one = 1
    func changeOne() {
        let two = 2
        func sayTwo() {
            print(two)
        }
        class Klass {}
        struct Struct {}
        enum Enum {}
        one = two
    }
    class Manny {
        let name = "manny"
        func sayName() {
            print(name)
        }
        class Klass {}
        struct Struct {}
        enum Enum {}
    }
    struct Moe {
        let name = "moe"
        func sayName() {
            (name)
        }
        class Klass {}
        struct Struct {}
        enum Enum {}
    }
    enum Jack {
        var name : String {
            return "jack"
        }
        func sayName() {
            (name)
        }
        class Klass {}
        struct Struct {}
        enum Enum {}
    }
}

//: [Next](@next)
