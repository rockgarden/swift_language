//: [Previous](@previous)

/*:
 # Classes and structures
 Classes and structures in Swift have many things in common. Both can:
 - Define properties to store values
 - Define methods to provide functionality
 - Define subscripts to provide access to their values using subscript syntax
 - Define initializers to set up their initial state
 - Be extended to expand their functionality beyond a default implementation
 - Conform to protocols to provide standard functionality of a certain kind
 Classes have additional capabilities that structures do not:
 - Inheritance enables one class to inherit the characteristics of another.
 - Type casting enables you to check and interpret the type of a class instance at runtime.
 - Deinitializers enable an instance of a class to free up any resources it has assigned.
 - Reference counting allows more than one reference to a class instance.
 - Note: Structures are always copied when they are passed around in your code, and do not use reference counting.
 The same applies to Enums
 类和结构体的选择
 在你的代码中,你可以使用类和结构体来定义你的自定义数据类型.
 然而,结构体实例总是通过值传递,类实例总是通过引用传递.
 这意味两者适用不同的任务.当你的在考虑一个工程项目的数据构造和功能的时候,你需要决定每个数据构造是定义成类还是结构体.
 按照通用的准则,当符合一条或多条以下条件时,请考虑构建结构体:
 - 结构体的主要目的是用来封装少量相关的简单数据值。
 - 有理由预计一个结构体实例在赋值或传递时，封装的数据将会被拷贝而不是被引用。
 - 任何在结构体中储存的值类型属性，也将会被拷贝，而不是被引用。
 - 结构体不需要去继承另一个已存在类型的属性或者行为。
 合适的结构体候选者包括:
 - 几何形状的大小，封装一个width属性和height属性，两者均为Double类型。
 - 一定范围内的路径，封装一个start属性和length属性，两者均为Int类型。
 - 三维坐标系内一点，封装x，y和z属性，三者均为Double类型。
 在所有其它案例中,定义一个类,生成一个它的实例,并通过引用来管理和传递.实际中,这意味着绝大部分的自定义数据构造都应该是类,而非结构体。
 Assignment and Copy Behavior for Strings, Arrays, and Dictionaries
 Swift’s String, Array, and Dictionary types are implemented as structures. This means that strings, arrays, and dictionaries are copied when they are assigned to a new constant or variable, or when they are passed to a function or method.
 This behavior is different from NSString, NSArray, and NSDictionary in Foundation, which are implemented as classes, not structures. NSString, NSArray, and NSDictionary instances are always assigned and passed around as a reference to an existing instance, rather than as a copy.
 */

import UIKit

/*:
 ## structures
 */
do {
    struct Resolution {
        var width = 0
        var height = 0
    }
    class ViewController: UIViewController {
        var resolution = Resolution()
    }
}
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


//: ## 值类型和引用类型 value Types And Reference Types
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


/*:
 ## Classes
 */
//: class与struct不能重名
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

//: ### Sub Class
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

import UIKit
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

//: ## 转型
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
