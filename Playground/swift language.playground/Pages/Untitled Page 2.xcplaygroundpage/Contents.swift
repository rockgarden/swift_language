
/*:
 Capture Lists

 By default, a closure expression captures constants and variables from its surrounding scope with strong references to those values. You can use a capture list to explicitly control how values are captured in a closure.

 A capture list is written as a comma separated list of expressions surrounded by square brackets, before the list of parameters. If you use a capture list, you must also use the in keyword, even if you omit the parameter names, parameter types, and return type.

 The entries in the capture list are initialized when the closure is created. For each entry in the capture list, a constant is initialized to the value of the constant or variable that has the same name in the surrounding scope. For example in the code below, a is included in the capture list but b is not, which gives them different behavior.
 捕获列表
 默认情况下，闭包表达式从其周围作用域捕获常量和变量，并对这些值进行强引用。可以使用捕获列表显式控制闭包中如何捕获值。
 捕获列表以逗号分隔的表达式写成，方括号括在参数列表之前。如果使用捕获列表，即使忽略参数名、参数类型和返回类型，也必须使用关键字。
 当创建闭包时，捕获列表中的条目初始化。对于捕获列表中的每个条目，常量被初始化为在周围范围内具有相同名称的常量或变量的值。例如，在下面的代码中，a包含在捕获列表中，但B不是，这给他们不同的行为。
 捕获列表

 默认情况下，闭包表达式从其周围范围捕获常量和变量，并强引用这些值。 您可以使用捕获列表来明确地控制如何在闭包中捕获值。

 捕获列表被写为以逗号分隔的表达式列表，这些表达式由方括号包围，位于参数列表之前。 如果使用捕获列表，则还必须使用in关键字，即使省略了参数名称，参数类型和返回类型。

 创建闭包时，将初始化捕获列表中的条目。 对于捕获列表中的每个条目，常量将初始化为在周围范围中具有相同名称的常量或变量的值。 例如在下面的代码中，a包括在捕获列表中，但b不是，这给它们不同的行为。
 */
var a = 0
var b = 0
let closure = { [a] in
    print(a, b)
}

a = 10
b = 10
closure()
// Prints "0 10"