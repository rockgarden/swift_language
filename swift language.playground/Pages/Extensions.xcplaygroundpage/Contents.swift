//: [Previous](@previous)

import UIKit
//import XCPlayground
import PlaygroundSupport

//: # Extensions
/*:
 Extensions add new functionality to an existing class, structure, enumeration, or protocol type.
 Extensions can add new functionality to a type, but they cannot override existing functionality.
 
 全局量作为静态成员嵌入到类型当中，使得命名空间更加干净、Swift化，并且还让性能开销降到最低；所以只要条件允许，您应该尽量去扩展苹果所提供的类型，而不是创建新的类型。
 与此同时，不要强行将常量和函数放到并不适合的类当中。如果您必须要创建一个新的类型来生成一个新的命名空间，那么请使用不包含枚举值的枚举，这将保证这个类型无法被构造出来。
 */

public let π = CGFloat(Double.pi) // 不建议
public let τ = π * 2.0 // 不建议

public func halt() { // 不建议
    PlaygroundPage.current.finishExecution()
}

extension CGFloat {
    /// 存放 π 常量，建议
    public static let (pi, π) = (CGFloat(Double.pi), CGFloat(Double.pi))
    
    /// 存放 τ 常量，建议
    public static let (tau, τ) = (2 * pi, 2 * pi)
}

extension PlaygroundPage {
    // 这看起来好看不少
    public static func halt() {
        current.finishExecution()
    }
}

//: ## Extension Syntax
extension Int/*: SomeProtocol, AnotherProtocol*/ {
    // new functionality to add to SomeType goes here
    // implementation of protocol requirements goes here
}

/*:
 If you define an extension to add new functionality to an existing type, the new functionality will be available on all existing instances of that type, even if they were created before the extension was defined.
 */


//: ## Computed Properties
//: Extensions can add computed instance properties and computed type properties to existing types.

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
("One inch is \(oneInch) meters")
// prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
("Three feet is \(threeFeet) meters")

/*:
 Extensions can add new computed properties, but they cannot add stored properties, or add property observers to existing properties.
 */


//: ## Initializers
/*:
 Extensions can add new initializers to existing types. This enables you to extend other types to accept your own custom types as initializer parameters, or to provide additional initialization options that were not included as part of the type’s original implementation.
 Extensions can add new convenience initializers to a class, but they cannot add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.
 */

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
// 默认init
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))
// 扩展init
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
/*:
 If you provide a new initializer with an extension, you are still responsible for making sure that each instance is fully initialized once the initializer completes.
 */

class Dog<T> {
    var name: T?
}
extension Dog {
    func sayYourName() -> T? { // T is the type of self.name
        return self.name
    }
}
extension Dog where T: Equatable { }

// Array in extension
extension String {
    static var data:[String:Any] = [:]
}
String.data["swift"] = 89
String.data["oc"] = 92
String.data

// Get Set in extension
extension String {
    var lengthAll: Int {
        get {
            return self.characters.count
        }
        set {
            let originLength = self.characters.count
            if newValue > originLength {
                for _ in 1...newValue - originLength {
                    self += "@"
                }
            }else if newValue < originLength{
                var tmp = ""
                var count = 0
                for ch in self.characters {
                    tmp = "\(tmp)\(ch)"
                    count += 1
                    if count == newValue{
                        break
                    }
                }
                self = tmp
            }
        }
    }
}
var sE = "swift.oc"
sE.lengthAll = 12

//: ## Methods
/*
 Extensions can add new instance methods and type methods to existing types.
 The following example adds a new instance method called repetitions to the Int type:
 */
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
/*:
 The repetitions(_:) method takes a single argument of type () -> Void, which indicates a function that has no parameters and does not return a value.
 */
3.repetitions {
    debugPrint("Goodbye!")
}



//: ## Mutating Instance Methods
/*:
 变异实例方法
 Structure and enumeration methods that modify self or its properties must mark the instance method as mutating, just like mutating methods from an original implementation.
 */
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()

extension Array {
    // 定义用于计算数组的交集
    mutating func retainAll(array:[Element], compartor:(Element,Element)->Bool){
        var tmp=[Element]()
        for ele in self {
            for target in array {
                if compartor(ele,target){
                    tmp.append(ele)
                    break
                }
            }
        }
        self = tmp
    }
}
var books = ["iOS","Android","Swift","Java","Ruby"]
books.retainAll(array:["Android","iOS","C"]) {
    return $0 == $1
}
(books)


//: ## Subscripts
extension Int {
    subscript(digitIndex: Int) -> Int {
        var index = digitIndex
        var decimalBase = 1
        while index > 0 {
            decimalBase *= 10
            index -= 1
        }
        return (self / decimalBase) % 10
    }
    
    
}

746381295[0]
746381295[1]
746381295[2]
746381295[8]

//: ## closure
extension Int {
    func times(closure:(() -> ())?) {
        if self >= 0 {
            for _ in 0..<self {
                closure?()
            }
        }
    }
}
2.times{print("swift")}

//: ## protocol extension
extension CustomStringConvertible {
    var upperDescription: String {
        return self.description.uppercased()
    }
}
["key":"value"].upperDescription


//: ## 扩展添加嵌套类型
extension String {
    enum suit: String{
        case diamond = "♦︎"
        case club = "♣︎"
        case heart = "♥︎"
        case spade = "♠︎"
    }
    static func judgeSuits(s:String) -> suit? {
        switch(s){
        case "♦︎":
            return .diamond
        case "♣︎":
            return .club
        case "♥︎":
            return .heart
        case "♠︎":
            return .spade
        default:
            return nil
        }
    }
}
var strEnum: String.suit? = String.judgeSuits(s: "♣︎")
var strEnum1: String.suit? = String.judgeSuits(s: "j")

//: Example
struct Digit {
    var number: Int
}
extension Digit {
    init() {
        self.init(number: 42)
    }
}
let d = Digit(number: 42)

protocol Flier { }
extension Flier {
    func fly() {
        print("flap flap flap")
    }
}
struct Bird: Flier { }
struct Insect: Flier {
    func fly() {
        print("whirr")
    }
}

class Rocket: Flier {
    func fly() {
        print("zoooom")
    }
}
class AtlasRocket: Rocket {
    override func fly() {
        print("ZOOOOOM")
    }
}
class Daedalus: Flier { }
class Icarus: Daedalus {
    func fly() {
        print("fall into the sea")
    }
}
do {
    let b = Bird()
    b.fly() // flap flap flap
    (b as Flier).fly() // flap flap flap
    
    let i = Insect()
    i.fly() // whirr
    (i as Flier).fly() // flap flap flap
    
    let r = Rocket()
    r.fly() // zoooom
    (r as Flier).fly() // flap flap flap
    
    let r2 = AtlasRocket()
    r2.fly() // ZOOOOOM
    (r2 as Rocket).fly() // ZOOOOOM
    (r2 as Flier).fly() // flap flap flap
    
    let d = Daedalus()
    d.fly() // flap flap flap
    (d as Flier).fly() // flap flap flap
    
    let d2 = Icarus()
    d2.fly() // fall into the sea
    (d2 as Daedalus).fly() // flap flap flap
    (d2 as Flier).fly() // flap flap flap
}

protocol Flier2 {
    func fly() // *
}
extension Flier2 {
    func fly() {
        print("flap flap flap")
    }
}
struct Bird2: Flier2 {
}
struct Insect2: Flier2 {
    func fly() {
        print("whirr")
    }
}
class Rocket2: Flier2 {
    func fly() {
        print("zoooom")
    }
}
class AtlasRocket2: Rocket2 {
    override func fly() {
        print("ZOOOOOM")
    }
}
class Daedalus2: Flier2 { }
class Icarus2: Daedalus2 {
    func fly() {
        print("fall into the sea")
    }
}
do {
    let b = Bird2()
    b.fly() // flap flap flap
    
    let i = Insect2()
    i.fly() // whirr
    (i as Flier2).fly() // whirr (!!!)
    
    let r = Rocket2()
    r.fly() // zoooom
    (r as Flier2).fly() // zoooom (!!!)
    
    let r2 = AtlasRocket2()
    r2.fly() // ZOOOOOM
    (r2 as Rocket2).fly() // ZOOOOOM
    (r2 as Flier2).fly() // ZOOOOOM (!!!)
    
    let d = Daedalus2()
    d.fly() // flap flap flap
    (d as Flier2).fly() //run extension: flap flap flap
    
    let d2 = Icarus2()
    d2.fly() // fall into the sea
    (d2 as Daedalus2).fly() // flap flap flap
    (d2 as Flier2).fly() //run extension:  flap flap flap
    
}

extension RawRepresentable {
    init?(_ what: RawValue) {
        self.init(rawValue: what)
    }
}
public enum Fill: Int {
    case Empty = 1
    case Solid
    case Hazy
}
public enum Color: Int {
    case Color1 = 1
    case Color2
    case Color3
}

extension Array where Element: Comparable {
    func min() -> Element {
        var minimum = self[0]
        for ix in 1..<self.count {
            if self[ix] < minimum {
                minimum = self[ix]
            }
        }
        return minimum
    }
}
do {
    let m = [4, 1, 5, 7, 2].min() // 1
    ([4, 1, 5].min())
}

//: Other
extension Array {
    mutating func shuffle () {
        for i in (0..<self.count).reversed() {
            let ix1 = i
            let ix2 = Int(arc4random_uniform(UInt32(i + 1)))
            (self[ix1], self[ix2]) = (self[ix2], self[ix1])
        }
    }
}

extension Array {
    mutating func removeAtIndexes (ixs: [Int]) -> () {
        for i in ixs.sorted(by: >) {
            self.remove(at: i)
        }
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY) //CGPointMake(self.midX, self.midY)
    }
}

extension CGSize {
    func sizeByDelta(dw dw: CGFloat, dh: CGFloat) -> CGSize {
        return CGSize(width: self.width + dw, height: self.height + dh)
    }
}

extension UIColor {
    class func myGoldenColor() -> UIColor {
        return self.init(red: 1.000, green: 0.894, blue: 0.541, alpha: 0.900)
    }
}

//: [Next](@next)









