//: [Previous](@previous)

import UIKit
import XCPlayground
import PlaygroundSupport

/*: # Extensions
 Extensions add new functionality to an existing class, structure, enumeration, or protocol type.
 Extensions can add new functionality to a type, but they cannot override existing functionality.
 Extensions in Swift can:
 - Add computed instance properties and computed type properties
 - Define instance methods and type methods
 - Provide new initializers
 - Define subscripts
 - Define and use new nested types
 - Make an existing type conform to a protocol
 - NOTE:
 Extensions can add new functionality to a type, but they cannot override existing functionality.
 */

/*:
 ## Extension 的优点
 全局量作为静态成员嵌入到类型当中，使得命名空间更加干净、Swift化，并且还让性能开销降到最低；所以只要条件允许，您应该尽量去扩展苹果所提供的类型，而不是创建新的类型。
 与此同时，不要强行将常量和函数放到并不适合的类当中。如果您必须要创建一个新的类型来生成一个新的命名空间，那么请使用不包含枚举值的枚举，这将保证这个类型无法被构造出来。
 */
public let π = CGFloat(Double.pi) //不建议
public let τ = π * 2.0 //不建议
public func halt() { //不建议
    PlaygroundPage.current.finishExecution()
}

extension CGFloat {
    /// 存放 π 常量，建议
    public static let (pi, π) = (CGFloat(Double.pi), CGFloat(Double.pi))
    /// 存放 τ 常量，建议
    public static let (tau, τ) = (2 * pi, 2 * pi)
}

extension PlaygroundPage {
    public static func halt() {
        current.finishExecution()
    }
}


/*: 
 # Extension Syntax
 Declare extensions with the extension keyword.
 An extension can extend an existing type to make it adopt one or more protocols. Where this is the case, the protocol names are written in exactly the same way as for a class or structure:
 - NOTE:
 If you define an extension to add new functionality to an existing type, the new functionality will be available on all existing instances of that type, even if they were created before the extension was defined.
 */


//: # Computed Properties
//: Extensions can add computed instance properties and computed type properties to existing types.
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
do {
    let oneInch = 25.4.mm
    print("One inch is \(oneInch) meters")
    let threeFeet = 3.ft
    print("Three feet is \(threeFeet) meters")
    let aMarathon = 42.km + 195.m
    print("A marathon is \(aMarathon) meters long")
}
/*:
 - NOTE:
 Extensions can add new computed properties, but they cannot add stored properties, or add property observers to existing properties.
 */
//: Get Set in extension
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
            } else if newValue < originLength {
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
do {
    var sE = "swift.oc"
    sE.lengthAll = 12
    sE.lengthAll = 5
}

/*:
 # Initializers
 Extensions can add new initializers to existing types. This enables you to extend other types to accept your own custom types as initializer parameters, or to provide additional initialization options that were not included as part of the type’s original implementation.
 Extensions can add new convenience initializers to a class, but they cannot add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.
 - NOTE:
 If you use an extension to add an initializer to a value type that provides default values for all of its stored properties and does not define any custom initializers, you can call the default initializer and memberwise initializer for that value type from within your extension’s initializer.
 This would not be the case if you had written the initializer as part of the value type’s original implementation, as described in Initializer Delegation for Value Types.
 */
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
/// Default Initializers
struct Rect {
    var origin = Point()
    var size = Size()
}
do {
    /// the Rect structure provides default values for all of its properties, it receives a default initializer and a memberwise initializer automatically, as described in Default Initializers. These initializers can be used to create new Rect instances:
    let defaultRect = Rect()
    let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                              size: Size(width: 5.0, height: 5.0))
}
/// extend the Rect structure to provide an additional initializer
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
do {
    let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                          size: Size(width: 3.0, height: 3.0))
    // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
}
/*:
 - NOTE:
 If you provide a new initializer with an extension, you are still responsible for making sure that each instance is fully initialized once the initializer completes.
 */


//: # Methods
/*
 Extensions can add new instance methods and type methods(实例方法和类型方法) to existing types.
 The following example adds a new instance method called repetitions to the Int type:
 */
extension Int {
    /// The repetitions(task:) method takes a single argument of type () -> Void, which indicates a function that has no parameters and does not return a value.
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
do {
    3.repetitions {
        debugPrint("Goodbye!")
    }
}


//: ## Mutating Instance Methods
/*:
 变异实例方法
 Instance methods added with an extension can also modify (or mutate) the instance itself. Structure and enumeration methods that modify self or its properties must mark the instance method as mutating, just like mutating methods from an original implementation.
 */
extension Int {
    mutating func square() {
        self = self * self
    }
}
do {
    var someInt = 3
    someInt.square()
}

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
do {
    var books = ["iOS","Android","Swift","Java","Ruby"]
    books.retainAll(array:["Android","iOS","C"]) {
        return $0 == $1
    }
    (books)
}

//: # Subscripts
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        /*
        var index = digitIndex
        while index > 0 {
            decimalBase *= 10
            index -= 1
        }
        */
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
    
    
}
do {
    746381295[0]
    746381295[1]
    746381295[2]
    746381295[8]
    746381295[9]
    /// returns 0, as if you had requested:
    0746381295[9]
}


//: # Nested Types
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}
do {
    func printIntegerKinds(_ numbers: [Int]) {
        for number in numbers {
            switch number.kind {
            case .negative:
                print("- ", terminator: "")
            case .zero:
                print("0 ", terminator: "")
            case .positive:
                print("+ ", terminator: "")
            }
        }
        print("")
    }
    printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
    // Prints "+ + - 0 - 0 + "
}
/*:
 - NOTE:
 number.kind is already known to be of type Int.Kind. Because of this, all of the Int.Kind case values can be written in shorthand form inside the switch statement, such as .negative rather than Int.Kind.negative.
 */
//: 扩展添加嵌套类型
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
do {
    var strEnum: String.suit? = String.judgeSuits(s: "♣︎")
    var strEnum1: String.suit? = String.judgeSuits(s: "j")
}

/*:
 # 限定扩展 extesion where
 需要给A类扩展另外一个属性，但B和C暂时不需要，大部分人的思维肯定是既然只有A需要，那我们就单独给A来扩展一个属性不就可以了吗，这样肯定行得通，但既然我们都已经走上了POP编程的道路，可以在给protocol扩展的时候添加限定,就是说在满足该限定条件（遵循另一个协议或者满足某个类型）下才能允许使用此扩展下的属性或方法, 而这个限定就是通过where来添加的。
 */
// TODO: 示例
//class A {}
//protocol someProtocol {
//    var clickCount: Int { set get }
//    func ClickEvent(action: String,value: NSNumber)
//}
//
//extension A: someProtocol {
//    var clickCount: Int {
//        set {}
//        get {}
//    }
//    func ClickEvent(action: String,value: NSNumber){}
//}
//
//extension someProtocol where Self: UIViewController{
//    var otherProperty: String{
//        return "something you want"
//    }
//
//    func handleError(error: String) {}
//}

class Dog<T> {
    var name: T?
}
extension Dog {
    func sayYourName() -> T? { // T is the type of self.name
        return self.name
    }
}
extension Dog where T: Equatable { }


//: # Example

// protocol extension
extension CustomStringConvertible {
    var upperDescription: String {
        return self.description.uppercased()
    }
}
do {
    ["key":"value"].upperDescription
}

// Array in extension
extension String {
    static var data:[String:Any] = [:]
}
do {
    String.data["swift"] = 89
    String.data["oc"] = 92
    String.data
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
    let m = [4, 1, 5, 7, 2].min()
    ([4, 10, 5].min())
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

enum Archive : String {
    case color = "itsColor"
    case number = "itsNumber"
    case shape = "itsShape"
    case fill = "itsFill"
}

extension NSCoder {
    func encode(_ objv: Any?, forKey key: Archive) {
        self.encode(objv, forKey:key.rawValue)
    }
}

extension Array where Element: Comparable {
    func myMin() -> Element {
        var minimum = self[0]
        for ix in 1..<self.count {
            if self[ix] < minimum {
                minimum = self[ix]
            }
        }
        return minimum
    }
}

extension Sequence where Iterator.Element == Int {
    func sum() -> Int {
        return self.reduce(0, +)
    }
}

//: [Next](@next)









