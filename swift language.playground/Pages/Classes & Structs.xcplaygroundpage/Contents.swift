//: [Previous](@previous)

/*:
 # Classes and structures
 */

import UIKit
import CoreBluetooth;

/*:
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

 Choosing Between Classes and Structures

 You can use both classes and structures to define custom data types to use as the building blocks of your program’s code.

 However, structure instances are always passed by value, and class instances are always passed by reference. This means that they are suited to different kinds of tasks. As you consider the data constructs and functionality that you need for a project, decide whether each data construct should be defined as a class or as a structure.

 As a general guideline, consider creating a structure when one or more of these conditions apply:

   - The structure’s primary purpose is to encapsulate a few relatively simple data values.
   - It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
   - Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
   - The structure does not need to inherit properties or behavior from another existing type.

 Examples of good candidates for structures include:

   - The size of a geometric shape, perhaps encapsulating a width property and a height property, both of type Double.
   - A way to refer to ranges within a series, perhaps encapsulating a start property and a length property, both of type Int.
   - A point in a 3D coordinate system, perhaps encapsulating x, y and z properties, each of type Double.
 In all other cases, define a class, and create instances of that class to be managed and passed by reference. In practice, this means that most custom data constructs should be classes, not structures.


 Assignment and Copy Behavior for Strings, Arrays, and Dictionaries

 Swift’s String, Array, and Dictionary types are implemented as structures. This means that strings, arrays, and dictionaries are copied when they are assigned to a new constant or variable, or when they are passed to a function or method.

 This behavior is different from NSString, NSArray, and NSDictionary in Foundation, which are implemented as classes, not structures. NSString, NSArray, and NSDictionary instances are always assigned and passed around as a reference to an existing instance, rather than as a copy.
 */

struct Resolution {
    var width = 0
    var height = 0
}

class ViewController: UIViewController {

    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


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

//: 定义抽象类
final class A {
    var surname: String
    var name: String
    private init() {
        self.surname = ""
        self.name = ""
    }
}
var a: A
a = A()

//: required deinit
class Person{
    var name = "tina"
    var age = 19
    var height = 172.2
    func produce(){
        age += 1
    }
    func say(content: String){
        content
    }
}
var p: Person
p = Person()
p.name
p.say("hello")
var p2=p
p2.name = "rock"
p.name //class reference!


class user {
    let name: String //注意在init里多对let的实例常量进行赋值,这是初始化方法的重要特点
    let age: Int
    init(name: String, age: Int) { //init方法都需要在方法中保证所有非Optional的实例变量被赋值初始化
        self.name = name
        self.age = age
    }
    func info() {
        print("\(name) \(age)")
    }
}
var u1 = user(name: "jerry", age: 6)
var u2 = user(name: "tom", age: 36)
u1 === u2 //引用比较
u1 !== u2
var u3 = u1
u3 === u1
var u4 = user(name:"lily", age:10)
u4.info() //???


class pm {
    var name: String!
    init?(name: String) { //?可失败的初始化方法,即不保证所有Optional的实例变量被赋值初始化,可返回nil
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
let subPM3 = subPM(name: "", grade: 3) //super init is nil sub also nil
subPM3 == nil


class myDog{
    func jump() {
    }
    func run() {
        jump()
    }
}


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


class Fruit {
    var name = ""
    var weight: Double
    init(name: String) { //required关键字进行限制,强制子类对这个方法重写实现。
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
    // 父类的便利构造器的初始化方法是不能被子类重写,也不能在子类中以super的方式被调用
    // 便利构造器必须调用同一个类中其它designated指定构造器
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
var app1:Apple? = Apple(n: "red apple", w: 0.5) //Apple?必须加不然app1无法赋nil
app1 = nil
var app2 = Apple(name: "yellow", weight: 0.6)

class sonApple: Apple {
    var vitamin: Double = 0.21
}

var anyArray:[Any] = [
    "swift",
    29,
    ["ios":89,"android":92],
    Fruit(name: "is fruit", weight: 2.2),
    Apple(name: "is apple", weight: 0.2)
]
for element in anyArray{
    if let f = element as? Fruit{
        print(f.name,f.weight)
    }
}


//: 重写下标与属性
//: final关键字防止重写
class Base {
    subscript(idx: Int) -> Int {
        get{
            return idx + 10
        }
    }
    var speed: Double = 0
    var speed1: Double = 0
    final var name: String = ""
    final func say(content: String) {
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

//: 向上转型子类附给父类＝用父类编译子类
var base2: Base = Sub()

//: is运算符
let hello: NSObject = "hello"
(hello is NSString)
(hello is NSDate)

//: as类型转换
let obj: NSObject = "hello"
let objStr = obj as! NSString //NSObject是编译时类型,NSString是运行时类型
let objPri: NSObject = 5
//NSObject是编译时类型,运行时类型为NSNumber
//let strPri: NSString = objPri as! NSString


//: [Next](@next)
