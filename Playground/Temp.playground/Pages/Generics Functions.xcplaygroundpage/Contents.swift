//: [Previous](@previous)

//: # Generic Functions 泛型函数
import UIKit

let s: Optional<String> = "howdy"

func takeAndReturnSameThing<T> (t: T) -> T {
    return t
}
let thing = takeAndReturnSameThing("howdy")

struct HolderOfTwoSameThings<T> {
    var firstThing: T
    var secondThing: T
    init(thingOne: T, thingTwo: T) {
        self.firstThing = thingOne
        self.secondThing = thingTwo
    }
}
let holder = HolderOfTwoSameThings(thingOne: "howdy", thingTwo: "getLost")

func flockTwoTogether<T, U>(f1: T, _ f2: U) { }
let vd: Void = flockTwoTogether("hey", 1)


func myMin<T: Comparable>(things: T...) -> T {
    var minimum = things[0]
    for ix in 1..<things.count {
        if things[ix] < minimum { // compile error if you remove Comparable constraint
            minimum = things[ix]
        }
    }
    return minimum
}

protocol Flier4 {
    associatedtype Other
}
struct Bird4: Flier4 {
    typealias Other = String
}

class Dog<T> {
    var name: T?
}
let d = Dog<String>()

protocol Flier5 {
    init()
}
struct Bird5: Flier5 {
    init() { }
}
struct FlierMaker<T: Flier5> {
    static func makeFlier() -> T {
        return T() // a little surprising I don't have to say T.init(), but I guess it is a real type
    }
}
let f = FlierMaker<Bird5>.makeFlier() // returns a Bird5

class NoisyDog: Dog<String> { } // yes! This is new in Swift 2.0
class NoisyDog2<T>: Dog<T> { } // and this is also legal!
// class NoisyDog3 : Dog<T> {} // but this is not; the superclass generic must be resolved somehow

struct Wrapper<T> { }
struct Wrapper2<T> {
    var thing: T
}
class Cat { }
class CalicoCat: Cat { }

protocol Flier6 {
    associatedtype Other
    func fly()
}

/*
 func flockTwoTogether6(f1:Flier6, _ f2:Flier6) { // compile error
 f1.fly()
 f2.fly()
 }
 */

func flockTwoTogether6<T1: Flier6, T2: Flier6>(f1: T1, _ f2: T2) {
    f1.fly()
    f2.fly()
}

// just testing: this one actually segfaults
// but not any more! In Swift 2.2 (Xcode 7.3b) this is fine; not sure when that happened
class Dog2<T: Dog2> { }
let min = myMin(4, 1, 5, 2)
(min)
do {
    // let w : Wrapper<Cat> = Wrapper<CalicoCat>() // error
    var w2: Wrapper2<Cat> = Wrapper2(thing: CalicoCat()) // fine
    let w3 = Wrapper2(thing: CalicoCat())
    // w2 = w3 // error
    // ==== shut up the compiler
    w2 = Wrapper2(thing: CalicoCat())
    _ = w2
    _ = w3
}

//: ## Basic example - 栈(Stack)的操作
func swapTwoValues<T>(inout a: T, inout _ b: T) { // "_"方法调用时可不申明参数b
    let temporaryA = a
    a = b
    b = temporaryA
    (a,b)=(b,a)
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)

/*:
 The swapTwoValues(_:_:) function defined above is inspired by a generic function called swap, which is part of the Swift standard library, and is automatically made available for you to use in your apps.
 If you need the behavior of the swapTwoValues(_:_:) function in your own code, you can use Swift’s existing swap(_:_:) function rather than providing your own implementation.
 You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.
 */

/*:
 ## Naming Type Parameters
 In most cases, type parameters have descriptive names, such as Key and Value in Dictionary<Key, Value>
 and Element in Array<Element>, which tells the reader about the relationship between the type parameter
 and the generic type or function it’s used in. However, when there isn’t a meaningful relationship between them,
 it’s traditional to name them using single letters such as T, U, and V, such as T in the swapTwoValues(_:_:) function above.
 - NOTE:
 Always give type parameters upper camel case names (such as T and MyTypeParameter) to indicate 
 that they are a placeholder for a type, not a value.
 */

/*:
 ## Generic Types
 Swift enables you to define your own generic types. These are custom classes, structures, and enumerations that can work with any type, in a similar way to Array and Dictionary.
 */

struct Stack<Element> {
    var items = [Element]()
    // 入栈操作 即Push 添加最新数据到容器最顶部
    mutating func push(item: Element) {
        items.append(item)
    }
    // 出栈操作 即Pop 将容器最顶部数据移除
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

/*:
 - Note:
 How the generic version of Stack is essentially the same as the non-generic version,
 but with a type parameter called Element instead of an actual type of Int.
 This type parameter is written within a pair of angle brackets (<Element>) immediately after the structure’s name.
 Element defines a placeholder name for “some type Element” to be provided later on.
 This future type can be referred to as “Element” anywhere within the structure’s definition.
 */

var stackOfStrings = Stack<String> ()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")


/*
 ## Extending a Generic Type
 When you extend a generic type, you do not provide a type parameter list as part of the extension’s definition.
 Instead, the type parameter list from the original type definition is available within the body of the extension,
 and the original type parameter names are used to refer to the type parameters from the original definition.
 */

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

/*
 - Note:
 that this extension does not define a type parameter list.
 Instead, the Stack type’s existing type parameter name, Element,
 is used within the extension to indicate the optional type of the topItem computed property.
 */


/*
 ## Type Constraints 类型约束
 T占位符后面添加冒号和协议类型，这种表示方式被称为泛型约束
 */

protocol SomeProtocol {}

class SomeClass {}

func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
}

/*:
 The hypothetical function above has two type parameters. The first type parameter, T,
 has a type constraint that requires T to be a subclass of SomeClass.
 The second type parameter, U, has a type constraint that requires U to conform to the protocol SomeProtocol.
 */
func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

func isEquals<T: Comparable>(a: T, b: T) -> Bool {
    return (a == b)
}


//: [Next](@next)
