//: [Behavioral](Behavioral) |
//: Creational |
//: [Structural](Structural)
/*:
 Creational
 ==========

 > In software engineering, creational design patterns are design patterns that deal with object creation mechanisms, trying to create objects in a manner suitable to the situation. The basic form of object creation could result in design problems or added complexity to the design. Creational design patterns solve this problem by somehow controlling this object creation.
 >
 >**Source:** [wikipedia.org](http://en.wikipedia.org/wiki/Creational_pattern)
 */
import Swift
import Foundation
/*:
 🏭 Factory Method
 -----------------
 工厂方法模式
 ----------

 The factory pattern is used to replace class constructors, abstracting the process of object generation so that the type of the object instantiated can be determined at run-time.

 百度百科：是一种常用的对象创建型设计模式, 此模式的核心精神是封装类中不变的部分，提取其中个性化善变的部分为独立类，通过依赖注入以达到解耦、复用和方便后期维护拓展的目的。它的核心结构有四个角色，分别是抽象工厂\具体工厂\抽象产品\具体产品
 设计模式分类：创建型模式

 ### Example
 */
/// 抽象产品
protocol Currency {
    func symbol() -> String
    func code() -> String
}

/// 具体产品
class Euro : Currency {
    func symbol() -> String {
        return "€"
    }

    func code() -> String {
        return "EUR"
    }
}

class UnitedStatesDolar : Currency {
    func symbol() -> String {
        return "$"
    }

    func code() -> String {
        return "USD"
    }
}

/// 抽象工厂
enum Country {
    case unitedStates, spain, uk, greece
}

/// 具体工厂 (要实例化)
enum CurrencyFactory {
    static func currency(for country: Country) -> Currency? {
        switch country {
        case .spain, .greece :
            return Euro()
        case .unitedStates :
            return UnitedStatesDolar()
        default:
            return nil
        }

    }
}
/*:
 ### Usage
 */
let noCurrencyCode = "No Currency Code Available"

CurrencyFactory.currency(for: .greece)?.code() ?? noCurrencyCode
CurrencyFactory.currency(for: .spain)?.code() ?? noCurrencyCode
CurrencyFactory.currency(for: .unitedStates)?.code() ?? noCurrencyCode
CurrencyFactory.currency(for: .uk)?.code() ?? noCurrencyCode
/*:
 🌰 Abstract Factory
 -------------------
 抽象工厂模式
 ----------

 The abstract factory pattern is used to provide a client with a set of related or dependant objects (maybe classes or structs).
 The "family" of objects created by the factory are determined at run-time.

 百度百科：为创建一组相关或相互依赖的对象提供一个接口，而且无需指定他们的具体类
 设计模式分类：创建型模式

 ### Example
 */
/// Protocols 抽象工厂
protocol Decimal {
    func stringValue() -> String
    // factory 工厂方法
    static func make(string : String) -> Decimal
}

typealias NumberFactory = (String) -> Decimal

// Number implementations with factory methods
struct NextStepNumber: Decimal {
    private var nextStepNumber: NSNumber

    func stringValue() -> String { return nextStepNumber.stringValue }

    // factory
    static func make(string: String) -> Decimal {
        return NextStepNumber(nextStepNumber: NSNumber(value: (string as NSString).longLongValue))
    }
}

struct SwiftNumber : Decimal {
    private var swiftInt: Int

    func stringValue() -> String { return "\(swiftInt)" }

    // factory
    static func make(string: String) -> Decimal {
        return SwiftNumber(swiftInt:(string as NSString).integerValue)
    }
}

/// Abstract factory (不用实例化)
enum NumberType {
    case nextStep, swift
}

enum NumberHelper {
    static func factory(for type: NumberType) -> NumberFactory {
        switch type {
        case .nextStep:
            return NextStepNumber.make
        case .swift:
            return SwiftNumber.make
        }
    }
}
/*:
 ### Usage
 */
let factoryOne = NumberHelper.factory(for: .nextStep)
let numberOne = factoryOne("1")
numberOne.stringValue()

let factoryTwo = NumberHelper.factory(for: .swift)
let numberTwo = factoryTwo("2")
numberTwo.stringValue()
/*:
 👷 Builder
 ----------
 创建者模式
 --------

 The builder pattern is used to create complex objects with constituent parts that must be created in the same order or using a specific algorithm.
 An external class controls the construction algorithm.
 
 百度百科：其核心思想是将一个“复杂对象的构建算法”与它的“部件及组装方式”分离，使得构件算法和组装方式可以独立应对变化；复用同样的构建算法可以创建不同的表示，不同的构建过程可以复用相同的部件组装方式
 设计模式分类：创建型模式

 ### Example
 */
/// Builder 创建者
class DeathStarBuilder {

    var x: Double?
    var y: Double?
    var z: Double?

    /// 创建者闭包
    typealias BuilderClosure = (DeathStarBuilder) -> ()

    init(buildClosure: BuilderClosure) {
        buildClosure(self)
    }
}

struct DeathStar : CustomStringConvertible {

    let x: Double
    let y: Double
    let z: Double

    init?(builder: DeathStarBuilder) {
        if let x = builder.x, let y = builder.y, let z = builder.z {
            self.x = x
            self.y = y
            self.z = z
        } else {
            return nil
        }
    }

    var description: String {
        return "Death Star at (x:\(x) y:\(y) z:\(z))"
    }
}
/*:
 ### Usage
 */
let empire = DeathStarBuilder { builder in
    builder.x = 0.1
    builder.y = 0.2
    builder.z = 0.3
}

let deathStar = DeathStar(builder:empire)
/*:
 >**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Builder)
 */
/*:
 🃏 Prototype
 ------------
 原型模式
 -------

 The prototype pattern is used to instantiate a new object by copying all of the properties of an existing object, creating an independent clone.
 This practise is particularly useful when the construction of a new object is inefficient.

 百度百科：用原型实例指定创建对象的种类，并且通过拷贝这些原型创建新的对象
 设计模式分类：创建型模式

 ### Example
 */
class ChungasRevengeDisplay {
    var name: String?
    let font: String

    init(font: String) {
        self.font = font
    }

    func clone() -> ChungasRevengeDisplay {
        return ChungasRevengeDisplay(font:self.font)
    }
}
/*:
 ### Usage
 */
let Prototype = ChungasRevengeDisplay(font:"GotanProject")

let Philippe = Prototype.clone()
Philippe.name = "Philippe"

let Christoph = Prototype.clone()
Christoph.name = "Christoph"

let Eduardo = Prototype.clone()
Eduardo.name = "Eduardo"
/*:
 >**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Prototype)
 */
/*:
 💍 Singleton
 ------------
 单例模式
 -------

 The singleton pattern ensures that only one object of a particular class is ever created.
 All further references to objects of the singleton class refer to the same underlying instance.
 There are very few applications, do not overuse this pattern!

 百度百科：单例模式是一种常用的软件设计模式。在它的核心结构中只包含一个被称为单例的特殊类。通过单例模式可以保证系统中一个类只有一个实例
 设计模式分类：创建型模式

 ### Example:
 */
class DeathStarSuperlaser {
    static let sharedInstance = DeathStarSuperlaser()

    private init() {
        // Private initialization to ensure just one instance is created.
    }
}

class TestObject {
    private static let testObject = TestObject()
    static var sharedInstance: TestObject {
        return testObject
    }
    private init(){
    }
}

/*:
 ### Usage:
 */
let laser = DeathStarSuperlaser.sharedInstance





