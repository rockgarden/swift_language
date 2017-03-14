//: [Previous](@previous)
import UIKit
/*:
 # CLOSURES 
 闭包 = unnamed functions 匿名函数
 Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.
 Closures can capture and store references to any constants and variables from the context in which they are defined. This is known as closing over those constants and variables. Swift handles all of the memory management of capturing for you. Swift会为您管理在捕获过程中涉及到的所有内存操作。
 Global and nested functions, as introduced in Functions, are actually special cases of closures. Closures take one of three forms:
 - Global functions are closures that have a name and do not capture any values. 全局函数是具有名称并且不捕获任何值的闭包。
 - Nested functions are closures that have a name and can capture values from their enclosing function. 嵌套函数是具有名称的闭包，并且可以从其封闭函数捕获值。
 - Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context. 闭包表达式是以轻量级语法编写的未命名闭包，可以从其周围的上下文中捕获值。
 Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. 闭包表达式: { (parameters) -> returnType in statements }. These optimizations include:
 - Inferring parameter and return value types from context 从上下文中推断参数和返回值类型
 - Implicit returns from single-expression closures 单表达式闭包的隐式返回
 - Shorthand argument names 缩写参数名称
 - Trailing closure syntax 尾随闭包语法 
 */
do {
    func animateWithDuration(duration: TimeInterval, animations: () -> Void) {}

    var button = UIButton()
    UIView.animate(withDuration: 1, animations: {
        button.alpha = 0
    })
}

/*:
 # Closure Expressions
 Nested functions, as introduced in Nested Functions, are a convenient means of naming and defining self-contained blocks of code as part of a larger function. However, it is sometimes useful to write shorter versions of function-like constructs without a full declaration and name. This is particularly true when you work with functions or methods that take functions as one or more of their arguments.
 Closure expressions are a way to write inline closures in a brief, focused syntax. Closure expressions provide several syntax optimizations for writing closures in a shortened form without loss of clarity or intent.
 */
//: The closure expression examples below illustrate these optimizations by refining a single example of the sorted(by:) method over several iterations, each of which expresses the same functionality in a more succinct way.
do {
    var array = ["John", "Wangkan", "Steve", "Wangkan"]
    /// INLINE CLOSURES 内联闭包
    array.sort(by: {(s1, s2) in s1 == s2})
    array.sort(by: {s1, s2 in s1 == s2})
    array.sort(by: ==)
    array
}
/*: 
 ## The Sorted Method
 func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element]
 */
do {
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    var reversedNames = names.sorted(by: backward)
}
/*:
 ## Closure Expression Syntax
 Closure expression syntax has the following general form:
    { (parameters) -> return type in
        statements
    }
 */
do {
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    var reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
        return s1 > s2
    })
    /// can even be written on a single line:
    reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
}
/*:
 ## Inferring Type From Context
 类型推断
 Using type inference, can omit the params and return types.
 It is always possible to infer the parameter types and return type when passing a closure to a function or method as an inline closure expression. As a result, you never need to write an inline closure in its fullest form when the closure is used as a function or method argument.
 */
do {
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    names.sorted(by: { s1, s2 in return s1 > s2 } )
}
/*:
 ## Implicit Returns from Single-Expression Closures
 Single-expression closures can implicitly return the result of their single expression by omitting the return keyword from their declaration. 单表达式闭包可以通过在其声明中省略return关键字来隐式返回其单个表达式的结果
 */
do {
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    names.sorted(by: { s1, s2 in s1 > s2 } )
}
/*:
 ## Shorthand Argument Names
 Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
 Swift自动为内联闭包提供了速记参数名称，可以用来通过名称$ 0，$ 1，$ 2等引用闭包的参数的值。
 If you use these shorthand argument names within your closure expression, you can omit the closure’s argument list from its definition, and the number and type of the shorthand argument names will be inferred from the expected function type. The in keyword can also be omitted, because the closure expression is made up entirely of its body.
 如果在闭包表达式中使用这些速记参数名称，则可以从其定义中省略闭包的参数列表，并且将从预期的函数类型推断速记参数名称的数量和类型。 也可以省略in关键字，因为闭包表达式完全由其主体组成.
 */
do {
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    names.sorted(by: {$0 > $1} )
}
/*:
 ## Operator Methods
 There’s actually an even shorter way to write the closure expression above. Swift’s String type defines its string-specific implementation of the greater-than operator (>) as a method that has two parameters of type String, and returns a value of type Bool. This exactly matches the method type needed by the sorted(by:) method. Therefore, you can simply pass in the greater-than operator, and Swift will infer that you want to use its string-specific implementation.
 */
do {
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    names.sorted(by: >)
}


/*: 
 # Trailing Closures
 尾部闭包:方法中最后一个参数是闭包
 If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead. A trailing closure is written after the function call’s parentheses, even though it is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the closure as part of the function call.
 尾部闭包允许我们省略参数名，并且能放置在参数表括号以外，进一步简洁代码。当闭包太长, 不适合定义为内联. Closures which are too long to be defined inline. 如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数, 可以使用尾随闭包来增强函数的可读性. 尾随闭包是一个书写在函数括号之后的闭包表达式, 函数支持将其作为最后一个参数调用.
 */
do {
    func someFunctionThatTakesAClosure(closure: () -> Void) {
        // function body goes here
    }

    /// Here's how you call this function without using a trailing closure:
    someFunctionThatTakesAClosure(closure: {
        // closure's body goes here
    })

    /// Here's how you call this function with a trailing closure instead:
    someFunctionThatTakesAClosure() {
        // trailing closure's body goes here
    }

    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    var reversedNames = names.sorted() { $0 > $1 }
    /// In case the function doesn't take any params other than a trailing closure, there's no need for parenthesis.如果函数除了trailing closure不接受任何参数，就不需要括号。
    reversedNames = names.sorted { $0 > $1 }
}
/*:
 Trailing closures are most useful when the closure is sufficiently long that it is not possible to write it inline on a single line. As an example, Swift’s Array type has a map(_:) method which takes a closure expression as its single argument. The closure is called once for each item in the array, and returns an alternative mapped value (possibly of some other type) for that item. The nature of the mapping and the type of the returned value is left up to the closure to specify.
 After applying the provided closure to each array element, the map(_:) method returns a new array containing all of the new mapped values, in the same order as their corresponding values in the original array.
 Here’s how you can use the map(_:) method with a trailing closure to convert an array of Int values into an array of String values. The array [16, 58, 510] is used to create the new array ["OneSix", "FiveEight", "FiveOneZero"]:
 */
do {
    let digitNames = [
        0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
        5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
    ]
    let numbers = [16, 58, 510]
    let strings = numbers.map {
        (number) -> String in
        var number = number
        var output = ""
        repeat {
            output = digitNames[number % 10]! + output
            print(output)
            number /= 10
            print(number)
        } while number > 0
        return output
    }
    strings
    // strings is inferred to be of type [String]
    // its value is ["OneSix", "FiveEight", "FiveOneZero"]
    /*
     - NOTE:
     The call to the digitNames dictionary’s subscript is followed by an exclamation mark (!), because dictionary subscripts return an optional value to indicate that the dictionary lookup can fail if the key does not exist. In the example above, it is guaranteed that number % 10 will always be a valid subscript key for the digitNames dictionary, and so an exclamation mark is used to force-unwrap the String value stored in the subscript’s optional return value.
     */
}


/*: 
 # Capturing Values
 A closure can capture constants and variables from the surrounding context in which it is defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.
 闭包可以从定义它的周围环境捕获常量和变量。 然后，闭包可以引用并修改那些常量和变量的值，即使定义常量和变量的原始作用域不再存在。
 In Swift, the simplest form of a closure that can capture values is a nested function, written within the body of another function. A nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function.
 在Swift中，可以捕获值的闭包的最简单形式是嵌套函数，写在另一个函数的主体内。 嵌套函数可以捕获其任何外部函数的参数，也可以捕获外部函数中定义的任何常量和变量。
 */
/// The return type of makeIncrementer is () -> Int. This means that it returns a function, rather than a simple value.
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    /// The incrementer() function doesn’t have any parameters, and yet it refers to runningTotal and amount from within its function body. It does this by capturing a reference to runningTotal and amount from the surrounding function and using them within its own function body. Capturing by reference ensures that runningTotal and amount do not disappear when the call to makeIncrementer ends, and also ensures that runningTotal is available the next time the incrementer function is called.
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
/*:
 - NOTE:
 As an optimization, Swift may instead capture and store a copy of a value if that value is not mutated by a closure, and if the value is not mutated after the closure is created.
 Swift also handles all memory management involved in disposing of variables when they are no longer needed.
 */
do {
    let incrementByTen = makeIncrementer(forIncrement: 10)
    incrementByTen()
    incrementByTen()
    incrementByTen()
    /// If you create a second incrementer, it will have its own stored reference to a new, separate runningTotal variable 如果创建第二个增量器，它将有自己的存储引用到一个新的，单独的runningTotal变量 :
    let incrementBySeven = makeIncrementer(forIncrement: 7)
    incrementBySeven()
    incrementByTen()
    incrementBySeven()
}
do {
    enum HTTPResponse {
        case ok
        case error(Int)
    }

    var responses: [HTTPResponse] = [.error(500), .ok, .ok, .error(404), .error(403)]

    responses.sort {
        switch ($0, $1) {
        // Order errors by code
        case let (.error(aCode), .error(bCode)):
            return aCode < bCode

        // All successes are equivalent, so none is before any other
        case (.ok, .ok): return false

        // Order errors before successes
        case (.error, .ok): return true
        case (.ok, .error): return false
        }
    }
    (responses)
}

/*:
 # Closures Are Reference Types
 In the example above, incrementBySeven and incrementByTen are constants, but the closures these constants refer to are still able to increment the runningTotal variables that they have captured. This is because functions and closures are reference types.
 在上面的例子中，incrementBySeven和incrementByTen是常量，但这些常量引用的闭包仍然能够增加他们捕获的runningTotal变量。 这是因为函数和闭包是引用类型。
 Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a reference to the function or closure. In the example above, it is the choice of closure that incrementByTen refers to that is constant, and not the contents of the closure itself.
 每当你将一个函数或一个闭包赋给一个常量或一个变量时，你实际上是将该常量或变量设置为函数或闭包的引用。 在上面的示例中，它是incrementByTen引用的闭包的选择，它是常量，而不是闭包本身的内容。
 This also means that if you assign a closure to two different constants or variables, both of those constants or variables will refer to the same closure.
 这也意味着，如果你给两个不同的常量或变量赋值一个闭包，这两个常量或变量都将引用同一闭包。
 */
do {
    let incrementByTen = makeIncrementer(forIncrement: 10)
    incrementByTen()
    incrementByTen()
    incrementByTen()
    incrementByTen()
    let alsoIncrementByTen = incrementByTen
    alsoIncrementByTen()
}


/*:
 # Escaping Closures
 A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape.
 当闭包作为参数传递给函数时，闭包被称为逃逸函数，但在函数返回后被调用。当你声明一个函数，它接受一个闭包作为其参数之一，你可以在参数的类型之前写入@escaping，表示允许闭包逃脱。
 One way that a closure can escape is by being stored in a variable that is defined outside the function. As an example, many functions that start an asynchronous operation take a closure argument as a completion handler. The function returns after it starts the operation, but the closure isn’t called until the operation is completed—the closure needs to escape, to be called later. 
 闭包可以逃逸的一种方式是通过存储在函数外部定义的变量中。作为示例，许多启动异步操作的函数将闭包参数作为完成处理程序。 该函数在启动操作后返回，但是在操作完成之前不会调用闭包 - 闭包需要转义，稍后调用。
 */
/*:
 The someFunctionWithEscapingClosure(_:) function takes a closure as its argument and adds it to an array that’s declared outside the function. If you didn’t mark the parameter of this function with @escaping, you would get a compiler error. someFunctionWithEscapingClosure（_ :)函数接受一个闭包作为其参数，并将其添加到在函数外声明的数组。 如果你没有使用@escaping标记这个函数的参数，你会得到一个编译器错误。
 Marking a closure with @escaping means you have to refer to self explicitly within the closure. For example, in the code below, the closure passed to someFunctionWithEscapingClosure(_:) is an escaping closure, which means it needs to refer to self explicitly. In contrast, the closure passed to someFunctionWithNonescapingClosure(_:) is a nonescaping closure, which means it can refer to self implicitly. 使用@escape标记闭包意味着你必须在闭包内自我引用。 例如，在下面的代码中，传递给someFunctionWithEscapingClosure（_ :)的闭包是一个转义闭包，这意味着它需要自我引用。 相反，传递给someFunctionWithNonescapingClosure（_ :)的闭包是一个非转义闭包，这意味着它可以自我引用。
 */
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
do {
    class SomeClass {
        var x = 10
        func doSomething() {
            someFunctionWithEscapingClosure { self.x = 100 }
            someFunctionWithNonescapingClosure { x = 200 }
        }
    }

    let instance = SomeClass()
    instance.doSomething()
    print(instance.x)

    completionHandlers.first?()
    print(instance.x)
}


/*:
 # Autoclosures
 An autoclosure is a closure that is automatically created to wrap an expression that’s being passed as an argument to a function. It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it. This syntactic convenience lets you omit braces around a function’s parameter by writing a normal expression instead of an explicit closure.
 autoclosure是一个闭包，它被自动创建以包装一个表达式，该表达式作为参数传递给函数。它不接受任何参数，当它被调用时，它返回包装在其中的表达式的值。这种语法方便的方法允许你通过写一个正则表达式而不是显式的闭包来省略函数参数周围的大括号。
 It’s common to call functions that take autoclosures, but it’s not common to implement that kind of function. For example, the assert(condition:message:file:line:) function takes an autoclosure for its condition and message parameters; its condition parameter is evaluated only in debug builds and its message parameter is evaluated only if condition is false.
 通常调用接受自动隐藏的函数，但实现那种函数并不常见。例如，assert（condition：message：file：line :)函数对其条件和消息参数采用自动隐藏;其条件参数只在调试版本中评估，并且仅当condition为false时才会计算其消息参数。
 An autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure. Delaying evaluation is useful for code that has side effects or is computationally expensive, because it lets you control when that code is evaluated. The code below shows how a closure delays evaluation.
 autoclosure让你延迟评估，因为里面的代码不会运行，直到你调用闭包。延迟评估对于具有副作用或计算成本高的代码非常有用，因为它允许您控制何时评估该代码。下面的代码显示了闭包如何延迟评估。
 */
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
do {
    print(customersInLine.count)

    let customerProvider = { customersInLine.remove(at: 0) }
    print(customersInLine.count)

    print("Now serving \(customerProvider())!")
    print(customersInLine.count)
}
do {
    // customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
    func serve(customer customerProvider: () -> String) {
        print("Now serving \(customerProvider())!")
    }
    serve(customer: { customersInLine.remove(at: 0) } )
}
/*: 
 The serve(customer:) function in the listing above takes an explicit closure that returns a customer’s name. The version of serve(customer:) below performs the same operation but, instead of taking an explicit closure, it takes an autoclosure by marking its parameter’s type with the @autoclosure attribute. Now you can call the function as if it took a String argument instead of a closure. The argument is automatically converted to a closure, because the customerProvider parameter’s type is marked with the @autoclosure attribute. 
 上面的列表中的serve（customer :)函数采用返回客户名称的显式闭包。下面的serve（customer :)的版本执行相同的操作，但是它不是采取显式的闭包，而是通过使用@autoclosure属性标记其参数的类型来进行自动闭包。 现在你可以调用函数，就好像它需要一个String参数，而不是一个闭包。 参数将自动转换为闭包，因为customerProvider参数的类型标记为@autoclosure属性。
 */
do {
    // customersInLine is ["Ewa", "Barry", "Daniella"]
    func serve(customer customerProvider: @autoclosure () -> String) {
        print("Now serving \(customerProvider())!")
    }
    serve(customer: customersInLine.remove(at: 0))
    customersInLine
}
/*:
 - NOTE:
 Overusing autoclosures can make your code hard to understand. The context and function name should make it clear that evaluation is being deferred.
 */

do {
    // customersInLine is ["Barry", "Daniella"]
    var customerProviders: [() -> String] = []
    func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
        customerProviders.append(customerProvider)
    }
    collectCustomerProviders(customersInLine.remove(at: 0))
    collectCustomerProviders(customersInLine.remove(at: 0))

    print("Collected \(customerProviders.count) closures.")
    for customerProvider in customerProviders {
        print("Now serving \(customerProvider())!")
    }
    // Prints "Now serving Barry!"
    // Prints "Now serving Daniella!"
}

//: [Next](@next)
