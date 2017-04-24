//: [Previous](@previous)
/*:
 # 范型 Generics
 Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.

 Generics are one of the most powerful features of Swift, and much of the Swift standard library is built with generic code. In fact, you’ve been using generics throughout the Language Guide, even if you didn’t realize it. For example, Swift’s Array and Dictionary types are both generic collections. You can create an array that holds Int values, or an array that holds String values, or indeed an array for any other type that can be created in Swift. Similarly, you can create a dictionary to store values of any specified type, and there are no limitations on what that type can be.
 */
/*:
 # The Problem That Generics Solve

 Here’s a standard, nongeneric function called swapTwoInts(_:_:), which swaps two Int values:
*/
do {
    /// This function makes use of in-out parameters to swap the values of a and b, as described in In-Out Parameters.
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }

    var someInt = 3
    var anotherInt = 107
    swapTwoInts(&someInt, &anotherInt)
    print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
    // Prints "someInt is now 107, and anotherInt is now 3"

    func swapTwoStrings(_ a: inout String, _ b: inout String) {
        let temporaryA = a
        a = b
        b = temporaryA
    }

    func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
}
/*:
 - NOTE:
 In all three functions, the types of a and b must be the same. If a and b aren’t of the same type, it isn’t possible to swap their values. Swift is a type-safe language, and doesn’t allow (for example) a variable of type String and a variable of type Double to swap values with each other. Attempting to do so results in a compile-time error.Swift是一种类型安全的语言，并且不允许（例如）String类型的变量和Double类型的变量彼此交换值。
 */

/*:
 # Generic Functions

 Generic functions can work with any type. Here’s a generic version of the swapTwoInts(_:_:) function from above, called swapTwoValues(_:_:):

 The generic version of the function uses a placeholder type name (called T, in this case) instead of an actual type name (such as Int, String, or Double). The placeholder type name doesn’t say anything about what T must be, but it does say that both a and b must be of the same type T, whatever T represents. The actual type to use in place of T is determined each time the swapTwoValues(_:_:) function is called.

 The other difference between a generic function and a nongeneric function is that the generic function’s name (swapTwoValues(_:_:)) is followed by the placeholder type name (T) inside angle brackets (<T>). The brackets tell Swift that T is a placeholder type name within the swapTwoValues(_:_:) function definition. Because T is a placeholder, Swift doesn’t look for an actual type called T. 通用函数和非函数函数之间的另一个区别是通用函数的名称（swapTwoValues（_：_ :)）之后是尖括号（<T>）中的占位符类型名称（T）。括号告诉Swift，T是swapTwoValues（_：_ :)函数定义中的占位符类型名称。因为T是一个占位符，所以Swift不会找到一个名为T的实际类型。

 The swapTwoValues(_:_:) function can now be called in the same way as swapTwoInts, except that it can be passed two values of any type, as long as both of those values are of the same type as each other. Each time swapTwoValues(_:_:) is called, the type to use for T is inferred from the types of values passed to the function. 从传递给函数的值的类型推断出用于T的类型。
 */
do {
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }

    var someInt = 3
    var anotherInt = 107
    swapTwoValues(&someInt, &anotherInt)
    // someInt is now 107, and anotherInt is now 3

    var someString = "hello"
    var anotherString = "world"
    swapTwoValues(&someString, &anotherString)
    // someString is now "world", and anotherString is now "hello"
}
/*:
 - NOTE:

 The swapTwoValues(_:_:) function defined above is inspired by a generic function called swap, which is part of the Swift standard library, and is automatically made available for you to use in your apps. If you need the behavior of the swapTwoValues(_:_:) function in your own code, you can use Swift’s existing swap(_:_:) function rather than providing your own implementation.
 */

/*:
 # Type Parameters

 In the swapTwoValues(_:_:) example above, the placeholder type T is an example of a type parameter. Type parameters specify and name a placeholder type, and are written immediately after the function’s name, between a pair of matching angle brackets (such as <T>).

 Once you specify a type parameter, you can use it to define the type of a function’s parameters (such as the a and b parameters of the swapTwoValues(_:_:) function), or as the function’s return type, or as a type annotation within the body of the function. In each case, the type parameter is replaced with an actual type whenever the function is called. (In the swapTwoValues(_:_:) example above, T was replaced with Int the first time the function was called, and was replaced with String the second time it was called.)

 You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.
*/
/*:
 # Naming Type Parameters

 In most cases, type parameters have descriptive names, such as Key and Value in Dictionary<Key, Value> and Element in Array<Element>, which tells the reader about the relationship between the type parameter and the generic type or function it’s used in. However, when there isn’t a meaningful relationship between them, it’s traditional to name them using single letters such as T, U, and V, such as T in the swapTwoValues(_:_:) function above. 在大多数情况下，类型参数具有描述性名称，例如字典中的键和值字典<Key，Value>和Array <Element>中的元素，它告诉读者关于类型参数与其使用的通用类型或函数之间的关系然而，当它们之间没有有意义的关系时，传统的是使用单个字母（如T，U和V），如上面的swapTwoValues（_：_ :)函数中的T来命名它们。
 
 - NOTE:
 Always give type parameters upper camel case names (such as T and MyTypeParameter) to indicate that they are a placeholder for a type, not a value.
 */
/*:
 # Generic Types

 In addition to generic functions, Swift enables you to define your own generic types. These are custom classes, structures, and enumerations that can work with any type, in a similar way to Array and Dictionary.

 This section shows you how to write a generic collection type called Stack. A stack is an ordered set of values, similar to an array, but with a more restricted set of operations than Swift’s Array type. An array allows new items to be inserted and removed at any location in the array. A stack, however, allows new items to be appended only to the end of the collection (known as pushing a new value on to the stack). Similarly, a stack allows items to be removed only from the end of the collection (known as popping a value off the stack).

 - NOTE:
 The concept of a stack is used by the UINavigationController class to model the view controllers in its navigation hierarchy. You call the UINavigationController class pushViewController(_:animated:) method to add (or push) a view controller on to the navigation stack, and its popViewControllerAnimated(_:) method to remove (or pop) a view controller from the navigation stack. A stack is a useful collection model whenever you need a strict “last in, first out” approach to managing a collection. UINavigationController类使用堆栈的概念来对其导航层次结构中的视图控制器建模。您调用UINavigationController类pushViewController（_：animated :)方法将视图控制器添加（或推送）到导航堆栈，以及其popViewControllerAnimated（_ :)方法从导航堆栈中删除（或弹出）视图控制器。只要您需要严格的“先进先出”方法来管理集合，堆栈就是一个有用的集合模型。
 
 The illustration below shows the push and pop behavior for a stack: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/stackPushPop_2x.png

 1. There are currently three values on the stack.
 2. A fourth value is pushed onto the top of the stack.
 3. The stack now holds four values, with the most recent one at the top.
 4. The top item in the stack is popped.
 5. After popping a value, the stack once again holds three values.
 */
do {
    /// This structure uses an Array property called items to store the values in the stack. Stack provides two methods, push and pop, to push and pop values on and off the stack. These methods are marked as mutating, because they need to modify (or mutate) the structure’s items array.
    struct IntStack {
        var items = [Int]()
        mutating func push(_ item: Int) {
            items.append(item)
        }
        mutating func pop() -> Int {
            return items.removeLast()
        }
    }
}
/*:
 Element defines a placeholder name for a type to be provided later. This future type can be referred to as Element anywhere within the structure’s definition. In this case, Element is used as a placeholder in three places:

 - To create a property called items, which is initialized with an empty array of values of type Element
 - To specify that the push(_:) method has a single parameter called item, which must be of type Element
 - To specify that the value returned by the pop() method will be a value of type Element

 Because it is a generic type, Stack can be used to create a stack of any valid type in Swift, in a similar manner to Array and Dictionary.
 */

/// generic version
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings

let fromTheTop = stackOfStrings.pop()
// fromTheTop is equal to "cuatro", and the stack now contains 3 strings


/*:
 # Extending a Generic Type

 When you extend a generic type, you do not provide a type parameter list as part of the extension’s definition. Instead, the type parameter list from the original type definition is available within the body of the extension, and the original type parameter names are used to refer to the type parameters from the original definition.

 The following example extends the generic Stack type to add a read-only computed property called topItem, which returns the top item on the stack without popping it from the stack:
*/

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
// Prints "The top item on the stack is tres."

/*:
 # Type Constraints

 The swapTwoValues(_:_:) function and the Stack type can work with any type. However, it is sometimes useful to enforce certain type constraints on the types that can be used with generic functions and generic types. Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition. 对于可以与通用函数和泛型类型一起使用的类型，强制执行某些类型约束是有时有用的。类型约束指定类型参数必须从特定类继承，或符合特定协议或协议组合。

 For example, Swift’s Dictionary type places a limitation on the types that can be used as keys for a dictionary. As described in Dictionaries, the type of a dictionary’s keys must be hashable. That is, it must provide a way to make itself uniquely representable. Dictionary needs its keys to be hashable so that it can check whether it already contains a value for a particular key. Without this requirement, Dictionary could not tell whether it should insert or replace a value for a particular key, nor would it be able to find a value for a given key that is already in the dictionary. 例如，Swift的Dictionary类型对可用作字典键的类型设置了限制。如字典中所述，字典的键的类型必须是可哈希的。也就是说，它必须提供一种独特的表现方式。字典需要其密钥是可加密的，以便它可以检查它是否已经包含特定密钥的值。没有这个要求，Dictionary无法判断是否应插入或替换特定键的值，也不能找到已经在字典中的给定键的值。

 This requirement is enforced by a type constraint on the key type for Dictionary, which specifies that the key type must conform to the Hashable protocol, a special protocol defined in the Swift standard library. All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default. 该要求由字典的键类型的类型约束强制执行，该类型约束指定密钥类型必须符合Swash标准库中定义的特殊协议Hashable协议。默认情况下，所有Swift的基本类型（如String，Int，Double和Bool）都是可以进行散列的

 You can define your own type constraints when creating custom generic types, and these constraints provide much of the power of generic programming. Abstract concepts like Hashable characterize types in terms of their conceptual characteristics, rather than their concrete type. 您可以在创建自定义泛型类型时定义自己的类型约束，并且这些约束提供了通用编程的大部分功能。抽象概念如Hashable在其概念特征方面表征类型，而不是其具体类型。
 
 ## Type Constraint Syntax

 You write type constraints by placing a single class or protocol constraint after a type parameter’s name, separated by a colon, as part of the type parameter list. The basic syntax for type constraints on a generic function is shown below (although the syntax is the same for generic types): 您可以通过在类型参数名称之后放置单个类或协议约束来写入类型约束，以冒号分隔，作为类型参数列表的一部分。 通用函数的类型约束的基本语法如下所示（尽管通用类型的语法相同）
 
    func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
    }

 The hypothetical function above has two type parameters. The first type parameter, T, has a type constraint that requires T to be a subclass of SomeClass. The second type parameter, U, has a type constraint that requires U to conform to the protocol SomeProtocol.
 
 ## Type Constraints in Action
*/
do {
    func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }

    let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
    if let foundIndex = findIndex(ofString: "llama", in: strings) {
        print("The index of llama is \(foundIndex)")
    }
    // Prints "The index of llama is 2"
}
/*:
 Here’s how you might expect a generic version of findIndex(ofString:in:), called findIndex(of:in:), to be written. Note that the return type of this function is still Int?, because the function returns an optional index number, not an optional value from the array. Be warned, though—this function doesn’t compile, for reasons explained after the example:

    func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
 
 The problem lies with the equality check, “if value == valueToFind”. Not every type in Swift can be compared with the equal to operator (==). If you create your own class or structure to represent a complex data model, for example, then the meaning of “equal to” for that class or structure isn’t something that Swift can guess for you. Because of this, it isn’t possible to guarantee that this code will work for every possible type T, and an appropriate error is reported when you try to compile the code.
*/
do {
    func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }

    let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
    // doubleIndex is an optional Int with no value, because 9.3 isn't in the array
    let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
    // stringIndex is an optional Int containing a value of 2

}







//: http://docs.scala-lang.org/tutorials/tour/abstract-types.html
import Foundation
//: 带范型的类
class Wat<T> {}
//: 带范型的结构体
struct WatWat<T> {}
//: 带范型的枚举
enum GoodDaySir<T> {}
/*: 
 带范型的协议 == No Support
 protocol 不支持范型类型参数。在 Swift 用 关联类型，代替支持抽象类型成员。
 - 参见 ["关联类型"](Associated%20Types)
 */
//protocol WellINever {
//    typealias T
//}
//: [Next](@next)
