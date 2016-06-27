//: [Previous](@previous)

import UIKit

//: # Extensions
/*:
 Extensions add new functionality to an existing class, structure, enumeration, or protocol type.
 Extensions can add new functionality to a type, but they cannot override existing functionality.
 */

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
books.retainAll(["Android","iOS","C"]) {
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
        return self.description.uppercaseString
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
var strEnum: String.suit? = String.judgeSuits("♣︎")
var strEnum1: String.suit? = String.judgeSuits("j")



//: [Next](@next)









