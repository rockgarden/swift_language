//: [Previous](@previous)
import Foundation
import UIKit
/*:
 ## In-Out Parameters

 In-out parameters are passed as follows:

  1. When the function is called, the value of the argument is copied. 当函数被调用时，参数的值被复制
  2. In the body of the function, the copy is modified. 在函数的正文中，该副本被修改
  3. When the function returns, the copy’s value is assigned to the original argument. 当函数返回时，副本的值被分配给原始参数。
 This behavior is known as copy-in copy-out or call by value result. For example, when a computed property or a property with observers is passed as an in-out parameter, its getter is called as part of the function call and its setter is called as part of the function return. 这种行为被称为复制拷贝或通过值结果调用。例如，当计算的属性或具有观察者的属性作为in-out参数传递时，其getter被调用为函数调用的一部分，并且其setter作为函数返回的一部分被调用。

 As an optimization, when the argument is a value stored at a physical address in memory, the same memory location is used both inside and outside the function body. The optimized behavior is known as call by reference; it satisfies all of the requirements of the copy-in copy-out model while removing the overhead of copying. Write your code using the model given by copy-in copy-out, without depending on the call-by-reference optimization, so that it behaves correctly with or without the optimization. 这种行为被称为复制拷贝或通过值结果调用。例如，当计算的属性或具有观察者的属性作为in-out参数传递时，其getter被调用为函数调用的一部分，并且其setter作为函数返回的一部分被调用。

 Do not access the value that was passed as an in-out argument, even if the original argument is available in the current scope. When the function returns, your changes to the original are overwritten with the value of the copy. Do not depend on the implementation of the call-by-reference optimization to try to keep the changes from being overwritten. 不要访问作为in-out参数传递的值，即使原始参数在当前作用域中可用。当函数返回时，对原始的更改将被副本的值覆盖。不要依赖于调用参考优化的实现来尝试保留更改被覆盖。
 
 You can’t pass the same argument to multiple in-out parameters because the order in which the copies are written back is not well defined, which means the final value of the original would also not be well defined. For example:
 */
do {
    var x = 10
    func f(a: inout Int, b: inout Int) {
        a += 1
        b += 10
    }
    //f(a: &x, b: &x) // Invalid, in-out arguments alias each other
}
/*:
 A closure or nested function that captures an in-out parameter must be nonescaping. If you need to capture an in-out parameter without mutating it or to observe changes made by other code, use a capture list to explicitly capture the parameter immutably. 捕获in-out参数的闭包或嵌套函数必须是非转义的。 如果您需要捕获一个in-out参数而不使其突变或观察其他代码所做的更改，请使用捕获列表来显式捕获参数。
 */
do {
    func someFunction(a: inout Int) -> () -> Int {
        return { [a] in return a + 1 }
    }
}
/*:
 If you need to capture and mutate an in-out parameter, use an explicit local copy, such as in multithreaded code that ensures all mutation has finished before the function returns.
 */
do {
    func multithreadedFunction(queue: DispatchQueue, x: inout Int) {
        // Make a local copy and manually copy it back.
        var localX = x
        defer { x = localX }

        // Operate on localX asynchronously, then wait before returning.
        queue.async { someMutatingOperation(&localX) }
        queue.sync {}
    }

    func someMutatingOperation(_ a: inout Int) {
        print(a + 1)
    }
}
//: [Next](@next)
