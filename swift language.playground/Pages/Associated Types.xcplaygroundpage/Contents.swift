//: [Previous](@previous)

import Foundation

/*:
 # Associated Types 关联类型
 When defining a protocol, it is sometimes useful to declare one or more associated types as part of the protocol’s definition. An associated type gives a placeholder name to a type that is used as part of the protocol. The actual type to use for that associated type is not specified until the protocol is adopted. Associated types are specified with the associatedtype keyword.
 - https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-XID_289
 
 协议中的关联类型表示：“我不知道具体类型是什么，一些服从我的类、结构体、枚举会帮我实现这个细节”。
 “这和类型参数（泛型）有什么不同呢？”：类型参数强迫每个人知道相关的类型以及需要反复的指明该类型（当你在构建他们的时候，这会让你写很多的类型参数）。他们是公共接口的一部分。这些代码使用多种结构（类、结构体、枚举）的代码会确定具体选择什么类型。

 通过对比关联类型实现细节的部分。它被隐藏了，就像是一个类可以隐藏内部的实例变量。使用抽象的类型成员的目的是推迟指明具体类型的时机。和泛型不同，它不是在实例化一个类或者结构体时指明具体类型，而且在服从该协议时，指明其具体类型。

 The Container protocol needs a way to refer to the type of the elements that a container will hold, without knowing what that type is for a specific container.
 容器协议需要一种方法来引用某个容器将要保持的元素的类型，而不知道该类型是什么特定的容器的类型。
 */

/*:
 ## Associated Types in Action
 Thanks to Swift’s type inference, you don’t actually need to declare a concrete ItemType of Int as part of the definition of IntStack.
 Because IntStack conforms to all of the requirements of the Container protocol, Swift can infer the appropriate ItemType to use,
 simply by looking at the type of the append(_:) method’s item parameter and the return type of the subscript.
 Indeed, if you delete the typealias ItemType = Int line from the code above,
 everything still works, because it is clear what type should be used for ItemType.
 */
protocol Container {
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}
/*:
 The Container protocol defines three required capabilities that any container must provide:
 - It must be possible to add a new item to the container with an append(_:) method.
 - It must be possible to access a count of the items in the container through a count property that returns an Int value.
 - It must be possible to retrieve each item in the container with a subscript that takes an Int index value.
 */
//: Make the non-generic IntStack type conform to the Container protocol
struct IntStack: Container {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    /// The definition of typealias ItemType = Int turns the abstract type of ItemType into a concrete type of Int for this implementation of the Container protocol.
    /// Thanks to Swift’s type inference, you don’t actually need to declare a concrete ItemType of Int as part of the definition of IntStack.
    typealias ItemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
//: Make the generic Stack type conform to the Container protocol
struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//: ## Extending an Existing Type to Specify an Associated Type
extension Array: Container {}

//: ## Generic Where Clauses
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }
        // Check each pair of items to see if they are equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        // All items match, so return true.
        return true
}

do {
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    var arrayOfStrings = ["uno", "dos", "tres"] //支持 Container
    if allItemsMatch(stackOfStrings, arrayOfStrings) {
        ("All items match.")
    } else {
        ("Not all items match.")
    }
}

//: ## Bad Example
protocol Food { }
class Grass : Food { }
class Salt {}
protocol Store {
    associatedtype FoodType
}
protocol Animal {
    associatedtype EdibleFood
    associatedtype SupplementKind
    func eat(_ f: EdibleFood)
    func supplement(_ s: SupplementKind)
}
class Cow : Animal {
    typealias EdibleFood = Grass
    typealias SupplementKind = Salt
    func eat(_ f: Grass) {}
    func supplement(_ s: Salt) {}
}
class Holstein : Cow {}
func buyFoodAndFeed<T: Animal, S: Store where T.EdibleFood == S.FoodType>(a:T, s:S){}

//: [Next](@next)
