//: [Previous](@previous)

import CoreData
import Foundation
import UIKit

/*: 
 # Error Handling
 Error handling is the process of responding to and recovering from error conditions in your program. Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime.

 Some operations aren’t guaranteed to always complete execution or produce a useful output. Optionals are used to represent the absence of a value, but when an operation fails, it’s often useful to understand what caused the failure, so that your code can respond accordingly.

 As an example, consider the task of reading and processing data from a file on disk. There are a number of ways this task can fail, including the file not existing at the specified path, the file not having read permissions, or the file not being encoded in a compatible format. Distinguishing among these different situations allows a program to resolve some errors and to communicate to the user any errors it can’t resolve.

 - NOTE:
 Error handling in Swift interoperates with error handling patterns that use the NSError class in Cocoa and Objective-C. For more information about this class, see Error Handling in Using Swift with Cocoa and Objective-C (Swift 3.1).
 */

/*:
 # Representing and Throwing Errors

 In Swift, errors are represented by values of types that conform to the Error protocol. This empty protocol indicates that a type can be used for error handling. 在Swift中，错误由符合错误协议的类型的值表示。 这个空协议表示一个类型可以用于错误处理。

 Swift enumerations are particularly well suited to modeling a group of related error conditions, with associated values allowing for additional information about the nature of an error to be communicated. For example, here’s how you might represent the error conditions of operating a vending machine inside a game:

 Throwing an error lets you indicate that something unexpected happened and the normal flow of execution can’t continue. You use a throw statement to throw an error. For example, the following code throws an error to indicate that five additional coins are needed by the vending machine:
 */
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
do {
    /// The statement after the throw is not executed
    //throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
}

/*:
 # Handling Errors

 When an error is thrown, some surrounding piece of code must be responsible for handling the error—for example, by correcting the problem, trying an alternative approach, or informing the user of the failure.

 There are four ways to handle errors in Swift. You can propagate the error from a function to the code that calls that function, handle the error using a do-catch statement, handle the error as an optional value, or assert that the error will not occur. Each approach is described in a section below. 在Swift中有四种处理错误的方法。您可以将错误从函数传播到调用该函数的代码，使用do-catch语句处理错误，将错误处理为可选值，或断言错误不会发生。每种方法在下面的一节中进行描述。

 When a function throws an error, it changes the flow of your program, so it’s important that you can quickly identify places in your code that can throw errors. To identify these places in your code, write the try keyword—or the try? or try! variation—before a piece of code that calls a function, method, or initializer that can throw an error. These keywords are described in the sections below. 当一个函数抛出一个错误，它会改变程序的流程，所以重要的是你可以快速识别代码中可能会导致错误的地方。要在代码中识别这些地方，请写入try关键字或尝试？或尝试！在一段调用可能引发错误的函数，方法或初始化器的代码之前的变化。这些关键字在下面的部分描述。

 - NOTE:
 Error handling in Swift resembles exception handling in other languages, with the use of the try, catch and throw keywords. Unlike exception handling in many languages—including Objective-C—error handling in Swift does not involve unwinding the call stack, a process that can be computationally expensive. As such, the performance characteristics of a throw statement are comparable to those of a return statement. Swift中的错误处理类似于其他语言的异常处理，使用try，catch和throw关键字。与许多语言中的异常处理（包括Swift中的Objective-C错误处理）不同，它不涉及释放调用堆栈，这个过程可能在计算上是昂贵的。因此，throw语句的性能特征与return语句的性能特征相当。
 */
/*:
 ## Propagating Errors Using Throwing Functions

 To indicate that a function, method, or initializer can throw an error, you write the throws keyword in the function’s declaration after its parameters. A function marked with throws is called a throwing function. If the function specifies a return type, you write the throws keyword before the return arrow (->).

    func canThrowErrors() throws -> String
    func cannotThrowErrors() -> String

 A throwing function propagates errors that are thrown inside of it to the scope from which it’s called. 抛出函数会将其中抛出的错误传播到被调用的范围

 - NOTE:
 Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function. 只有投掷功能才能传播错误。必须在函数内部处理抛出不正确函数的任何错误
 */

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

/*: 
 ## Handling Errors Using Do-Catch
 You use a do-catch statement to handle errors by running a block of code. If an error is thrown by the code in the do clause, it is matched against the catch clauses to determine which one of them can handle the error.
 
 Here is the general form of a do-catch statement:

    do {
        try expression
        statements
    } catch pattern 1 {
        statements
    } catch pattern 2 where condition {
        statements
    }

 You write a pattern after catch to indicate what errors that clause can handle. If a catch clause doesn’t have a pattern, the clause matches any error and binds the error to a local constant named error. For more information about pattern matching, see Patterns.
 
 The catch clauses don’t have to handle every possible error that the code in its do clause can throw. If none of the catch clauses handle the error, the error propagates to the surrounding scope. However, the error must be handled by some surrounding scope—either by an enclosing do-catch clause that handles the error or by being inside a throwing function. 
 */

do {
    var vendingMachine = VendingMachine()
    vendingMachine.coinsDeposited = 8
    do {
        try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    } catch VendingMachineError.invalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.outOfStock {
        print("Out of Stock.")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    }
    // Prints "Insufficient funds. Please insert an additional 2 coins."
}

/*:
 ## Converting Errors to Optional Values

 You use try? to handle an error by converting it to an optional value. If an error is thrown while evaluating the try? expression, the value of the expression is nil. 
 */
do {
    func someThrowingFunction() throws -> Int {
        return 1
    }

    let x = try? someThrowingFunction()

    let y: Int?
    do {
        y = try someThrowingFunction()
    } catch {
        y = nil
    }

    func fetchData() -> Data? {
        //if let data = try? fetchDataFromDisk() { return data }
        //if let data = try? fetchDataFromServer() { return data }
        return nil
    }
}

/*:
 ## Disabling Error Propagation

 Sometimes you know a throwing function or method won’t, in fact, throw an error at runtime. On those occasions, you can write try! before the expression to disable error propagation and wrap the call in a runtime assertion that no error will be thrown. If an error actually is thrown, you’ll get a runtime error.

    let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
 */

/*:
 # Specifying Cleanup Actions

 You use a defer statement to execute a set of statements just before code execution leaves the current block of code. This statement lets you do any necessary cleanup that should be performed regardless of how execution leaves the current block of code—whether it leaves because an error was thrown or because of a statement such as return or break. For example, you can use a defer statement to ensure that file descriptors are closed and manually allocated memory is freed.

 A defer statement defers execution until the current scope is exited. This statement consists of the defer keyword and the statements to be executed later. The deferred statements may not contain any code that would transfer control out of the statements, such as a break or a return statement, or by throwing an error. Deferred actions are executed in reverse order of how they are specified—that is, the code in the first defer statement executes after code in the second, and so on.

    func processFile(filename: String) throws {
        if exists(filename) {
            let file = open(filename)
            defer {
                close(file)
            }
            while let line = try file.readline() {
                // Work with the file.
            }
            // close(file) is called here, at the end of the scope.
        }
    }

 - NOTE:
 You can use a defer statement even when no error handling code is involved. 即使不涉及错误处理代码，也可以使用延迟语句。
 */


//: [Next](@next)
