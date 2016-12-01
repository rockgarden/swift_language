//: [Previous](@previous)

import Foundation

/*:
 # Associated Types 关联类型
 - https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-XID_289
 协议中的关联类型表示：“我不知道具体类型是什么，一些服从我的类、结构体、枚举会帮我实现这个细节”。
 “这和类型参数（泛型）有什么不同呢？”：类型参数强迫每个人知道相关的类型以及需要反复的指明该类型（当你在构建他们的时候，这会让你写很多的类型参数）。他们是公共接口的一部分。这些代码使用多种结构（类、结构体、枚举）的代码会确定具体选择什么类型。

 通过对比关联类型实现细节的部分。它被隐藏了，就像是一个类可以隐藏内部的实例变量。使用抽象的类型成员的目的是推迟指明具体类型的时机。和泛型不同，它不是在实例化一个类或者结构体时指明具体类型，而且在服从该协议时，指明其具体类型。

 The Container protocol needs a way to refer to the type of the elements that a container will hold, without knowing what that type is for a specific container.
 容器协议需要一种方法来引用某个容器将要保持的元素的类型，而不知道该类型是什么特定的容器的类型。
 */
//protocol Food { }
//class Grass : Food { }
//protocol Animal<F:Food> {
//   	func eat(f:F)
//}
//class Cow : Animal<Grass> {
//    func eat(f:Grass) {}
//}
//class Salt {}
//protocol Animal {
//    associatedtype EdibleFood
//    associatedtype SupplementKind
//    func eat(f: EdibleFood)
//    func supplement(s: SupplementKind)
//}
//class Cow : Animal {
//    typealias EdibleFood = Grass
//    typealias SupplementKind = Salt
//    func eat(f: Grass) {}
//    func supplement(s: Salt) {}
//}
//class Holstein : Cow {}
//func buyFoodAndFeed<T: Animal, S: Store where T.EdibleFood == S.FoodType>(a:T, s:S){}

/*:
 Thanks to Swift’s type inference, you don’t actually need to declare a concrete ItemType of Int as part of the definition of IntStack.
 Because IntStack conforms to all of the requirements of the Container protocol, Swift can infer the appropriate ItemType to use,
 simply by looking at the type of the append(_:) method’s item parameter and the return type of the subscript.
 Indeed, if you delete the typealias ItemType = Int line from the code above,
 everything still works, because it is clear what type should be used for ItemType.
 */
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct OtherStack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(item: Element) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//: You can extend an existing type to add conformance to a protocol.
//extension Array: Container {}
//
func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, _ anotherContainer: C2) -> Bool {

    // check that both containers contain the same number of items
    if someContainer.count != anotherContainer.count {
        return false
    }

    // check each pair of items to see if they are equivalent
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    // all items match, so return true
    return true
}

/*:
 It can also be useful to define requirements for associated types.
 You do this by defining where clauses as part of a type parameter list.
 */


//: [Next](@next)
