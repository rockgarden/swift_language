//: [Previous](@previous)
import UIKit
/*: 
 # Basic Operators
 An operator is a special symbol or phrase that you use to check, change, or combine values. 
 Swift supports most standard C operators and improves several capabilities to eliminate common coding errors. The assignment operator (=) does not return a value, to prevent it from being mistakenly used when the equal to operator (==) is intended. Arithmetic operators (+, -, *, /, % and so forth) detect and disallow value overflow, to avoid unexpected results when working with numbers that become larger or smaller than the allowed value range of the type that stores them. You can opt in to value overflow behavior by using Swift’s overflow operators.
 Swift also provides two range operators (a..<b and a...b) not found in C, as a shortcut for expressing a range of values.
 */

/*:
 # Terminology
 Operators are unary, binary, or ternary:
 - Unary operators operate on a single target (such as -a). Unary prefix operators appear immediately before their target (such as !b), and unary postfix operators appear immediately after their target (such as c!).
 - Binary operators operate on two targets (such as 2 + 3) and are infix because they appear in between their two targets.
 - Ternary operators operate on three targets. Like C, Swift has only one ternary operator, the ternary conditional operator (a ? b : c).
 - The values that operators affect are operands. In the expression 1 + 2, the + symbol is a binary operator and its two operands are the values 1 and 2.
*/

/*:
 # Assignment Operator

 The assignment operator (a = b) initializes or updates the value of a with the value of b
 */
do {
    let b = 10
    var a = 5
    a = b

    /// If the right side of the assignment is a tuple with multiple values, its elements can be decomposed into multiple constants or variables at once:
    let (x, y) = (1, 2)
    // x is equal to 1, and y is equal to 2

    /// Unlike the assignment operator in C and Objective-C, the assignment operator in Swift does not itself return a value. The following statement is not valid:
    //if x = y {}
    /// This feature prevents the assignment operator (=) from being used by accident when the equal to operator (==) is actually intended. By making if x = y invalid, Swift helps you to avoid these kinds of errors in your code.
}
/*:
 # Arithmetic Operators
 Swift supports the four standard arithmetic operators for all number types:
 - Addition (+)
 - Subtraction (-)
 - Multiplication (*)
 - Division (/)
*/
do {
    1 + 2       // equals 3
    5 - 3       // equals 2
    2 * 3       // equals 6
    10.0 / 2.5  // equals 4.0

    /// The addition operator is also supported for String concatenation:
    "hello, " + "world"  // equals "hello, world"
}
//: Unlike the arithmetic operators in C and Objective-C, the Swift arithmetic operators do not allow values to overflow by default. You can opt in to value overflow behavior by using Swift’s overflow operators (such as a &+ b).

/*:
 ## Remainder Operator
 The remainder operator (a % b) works out how many multiples of b will fit inside a and returns the value that is left over (known as the remainder).
 - NOTE:
 The remainder operator (%) is also known as a modulo operator in other languages. However, its behavior in Swift for negative numbers means that it is, strictly speaking, a remainder rather than a modulo operation.
 */
do {
    9 % 4    // equals 1
    -9 % 4   // equals -1
}

/*:
 # Unary Minus Operator
 The sign of a numeric value can be toggled using a prefixed -, known as the unary minus operator
 The unary minus operator (-) is prepended directly before the value it operates on, without any white space.
*/
do {
    let three = 3
    let minusThree = -three       // minusThree equals -3
    let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"
}
/*:
 # Unary Plus Operator
 The unary plus operator (+) simply returns the value it operates on, without any change:
 Although the unary plus operator doesn’t actually do anything, you can use it to provide symmetry in your code for positive numbers when also using the unary minus operator for negative numbers.
 */
do {
    let minusSix = -6
    let alsoMinusSix = +minusSix  // alsoMinusSix equals -6
}

/*:
 # Compound Assignment Operators
 Like C, Swift provides compound assignment operators that combine assignment (=) with another operation. One example is the addition assignment operator (+=).
 - NOTE:
 The compound assignment operators do not return a value. For example, you cannot write let b = a += 2.
 For a complete list of the compound assignment operators provided by the Swift standard library, see https://developer.apple.com/reference/swift/swift_standard_library_operators.
 */
do {
    var a = 1
    a += 2
}


/*:
 # Comparison Operators
 Swift supports all standard C comparison operators:
 - Equal to (a == b)
 - Not equal to (a != b)
 - Greater than (a > b)
 - Less than (a < b)
 - Greater than or equal to (a >= b)
 - Less than or equal to (a <= b)
 - NOTE:
 Swift also provides two identity operators (=== and !==), which you use to test whether two object references both refer to the same object instance. For more information, see Classes and Structures.
 */
do {
    1 == 1
    2 != 1
    2 > 1
    1 < 2
    1 >= 1
    2 <= 1

    let name = "world"
    if name == "world" {
        print("hello, world")
    } else {
        print("I'm sorry \(name), but I don't recognize you")
    }
}

/*:
 You can also compare tuples that have the same number of values, as long as each of the values in the tuple can be compared. For example, both Int and String can be compared, which means tuples of the type (Int, String) can be compared. In contrast, Bool can’t be compared, which means tuples that contain a Boolean value can’t be compared.
 Tuples are compared from left to right, one value at a time, until the comparison finds two values that aren’t equal. Those two values are compared, and the result of that comparison determines the overall result of the tuple comparison. If all the elements are equal, then the tuples themselves are equal.
 - NOTE
 The Swift standard library includes tuple comparison operators for tuples with fewer than seven elements. To compare tuples with seven or more elements, you must implement the comparison operators yourself.
 */
do {
    (1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" are not compared
    (3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
    (4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
}

/*:
 ## Ternary Conditional Operator

 The ternary conditional operator is a special operator with three parts, which takes the form question ? answer1 : answer2. It is a shortcut for evaluating one of two expressions based on whether question is true or false. If question is true, it evaluates answer1 and returns its value; otherwise, it evaluates answer2 and returns its value.
 */
do {
    let contentHeight = 40
    let hasHeader = true
    let rowHeight = contentHeight + (hasHeader ? 50 : 20)
}


/*:
 # Nil-Coalescing Operator
 The nil-coalescing operator (a ?? b) unwraps an optional a if it contains a value, or returns a default value b if a is nil. The expression a is always of an optional type. The expression b must match the type that is stored inside a.
 The nil-coalescing operator is shorthand for the code below:
 a != nil ? a! : b
 The code above uses the ternary conditional operator and forced unwrapping (a!) to access the value wrapped inside a when a is not nil, and to return b otherwise. The nil-coalescing operator provides a more elegant way to encapsulate this conditional checking and unwrapping in a concise and readable form.
 - NOTE:
 If the value of a is non-nil, the value of b is not evaluated. This is known as short-circuit evaluation.
 */
do {
    let defaultColorName = "red"
    var userDefinedColorName: String?   // defaults to nil

    var colorNameToUse = userDefinedColorName ?? defaultColorName

    userDefinedColorName = "green"
    colorNameToUse = userDefinedColorName ?? defaultColorName
}


/*:
 # Range Operators
 Swift includes two range operators, which are shortcuts for expressing a range of values.
 ## Closed Range Operator
 The closed range operator (a...b) defines a range that runs from a to b, and includes the values a and b. The value of a must not be greater than b.
 */
do {
    for index in 1...5 {
        print("\(index) times 5 is \(index * 5)")
    }
}
/*:
 ## Half-Open Range Operator
 The half-open range operator (a..<b) defines a range that runs from a to b, but does not include b. It is said to be half-open because it contains its first value, but not its final value. As with the closed range operator, the value of a must not be greater than b. If the value of a is equal to b, then the resulting range will be empty.
 */
do {
    let names = ["Anna", "Alex", "Brian", "Jack"]
    let count = names.count
    for i in 0..<count {
        print("Person \(i + 1) is called \(names[i])")
    }
}


/*:
 # Logical Operators
 Logical operators modify or combine the Boolean logic values true and false. Swift supports the three standard logical operators found in C-based languages:
 - Logical NOT (!a)
 - Logical AND (a && b)
 - Logical OR (a || b)
 
 ## Logical NOT Operator
 The logical NOT operator (!a) inverts a Boolean value so that true becomes false, and false becomes true.
 The logical NOT operator is a prefix operator, and appears immediately before the value it operates on, without any white space. It can be read as “not a”.
 */
do {
    let allowedEntry = false
    if !allowedEntry {
        print("ACCESS DENIED")
    }
}

/*:
 ## Logical AND Operator
 The logical AND operator (a && b) creates logical expressions where both values must be true for the overall expression to also be true.
 If either value is false, the overall expression will also be false. In fact, if the first value is false, the second value won’t even be evaluated, because it can’t possibly make the overall expression equate to true. This is known as short-circuit evaluation.
 */
do {
    let enteredDoorCode = true
    let passedRetinaScan = false
    if enteredDoorCode && passedRetinaScan {
        print("Welcome!")
    } else {
        print("ACCESS DENIED")
    }
}

/*:
 ## LLogical OR Operator
 The logical OR operator (a || b) is an infix operator made from two adjacent pipe characters. You use it to create logical expressions in which only one of the two values has to be true for the overall expression to be true.
 Like the Logical AND operator above, the Logical OR operator uses short-circuit evaluation to consider its expressions. If the left side of a Logical OR expression is true, the right side is not evaluated, because it cannot change the outcome of the overall expression.
 */
do {
    let hasDoorKey = false
    let knowsOverridePassword = true
    if hasDoorKey || knowsOverridePassword {
        print("Welcome!")
    } else {
        print("ACCESS DENIED")
    }
}

/*:
 ## Combining Logical Operators
 You can combine multiple logical operators to create longer compound expressions:
 - NOTE:
 The Swift logical operators && and || are left-associative, meaning that compound expressions with multiple logical operators evaluate the leftmost subexpression first.
 */
do {
    let enteredDoorCode = true
    let passedRetinaScan = false
    let hasDoorKey = false
    let knowsOverridePassword = true
    if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
        print("Welcome!")
    } else {
        print("ACCESS DENIED")
    }
}

/*:
 ## Explicit Parentheses
 It is sometimes useful to include parentheses when they are not strictly needed, to make the intention of a complex expression easier to read. In the door access example above, it is useful to add parentheses around the first part of the compound expression to make its intent explicit.
 */
do {
    let enteredDoorCode = true
    let passedRetinaScan = false
    let hasDoorKey = false
    let knowsOverridePassword = true
    if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
        print("Welcome!")
    } else {
        print("ACCESS DENIED")
    }
}


/*: # Example

let hello = "Hola, qué tal"
var word = "world"
let (x, y) = (1, 2)
//: ## 运算符
var c1 = 19/4
var ww = 4.0/0.0
var fff = 0.0/0.0 //非数

var g = -5.2
var h = -3.1
//var mod = g%h //求余结果正负取决于被除数

var a111 = 5
//TODO: swift 实现自增
//var b111 = a111++ + 6 //先计算再自增
//var c111 = ++a111 + 6 //自增再计算

//: ## 溢出运算符 &+,&-,&*,&/,&%
var cmin = UInt8.min
//var f = cmin-1 //error
cmin = cmin &- 1 //下溢

//: ## 浮点数求余
var rem = 10%2

/*: 
 ## 特征运算符
 基于引用的对象比较
 - 等价于 ( === )
 - 不等价于 ( !== )
 */
do {
    class T {}
    let a = T()
    var b = a
    let c = T()
    // ab指向的类型实例相同时c为ture
    let bool1 = (a === b)
    let bool2 = (c !== b)
}


/*:
 ## 字符串拼接
 strings can be achieved by "sum" or by \()
 */
(hello + " " + word)
("\(hello) \(word)")
//: ### 字符串String插值
var apples = 10
var oranges = 4
("I have \(apples + oranges) fruits") //自动转型

//: 字符串NSString连接
var i = 200
var str = "Hello Swift"
var strN: NSString
strN = str as NSString
//TODO: String to NSString 转成Foundation
str = "\(str),\(i)"
strN.substring(with: NSRange(location: 0, length: 5)) //可用NSString的相关方法

//: ## 三目(元)运算符
let name = "uraimo"
var happyStr = ""
(1...4).forEach{ happyStr = ("Happy Birthday " + (($0 == 1) ? "dear \(name)":"to You"))}
happyStr
//var ab = a>b ? "a>b":"a<b"
/*:
 Nil Coalescing Operator
 - It's equivalent to (a ? b : c), but for optionals
 - 空合并运算符 (a ?? b)对a进行空判断,若a有值就解封,否则返回b
 - 表达式a必是可选类型 默认值b的类型必须要和a存储的类型保持一致
 */
var say:String?
var content = say ?? word

var optional: String? //Currently nil
// optional = "Some Value"
// Uncomment/comment this line and observe what values get printed below
var value = optional ?? "Value when `optional` is nil"

// above statement is equivalent to below
if optional != nil {
    value = optional! //Unwrapped value
} else {
    value = "Value when `optional` is nil"
}

//Range operators
//闭区间运算符 a...b
for index in 1...5 {
    //It will iterate 5 times.
}
//半开区间运算符 a..<b
var array = [1,2,3]
for index in 1..<array.count{
    //It will iterate (array.count - 1) times.
}

//枚举Enumerate array with index and value, C loop will be removed soon
for (index, value) in array.enumerated() {
    ("value \(value) at index \(index)")
}

var image = UIImage(named: "1")

//: ## Operator Overloading
// 运算符重载函数
func * (lhs: String, rhs: Int) -> String {
    var result = lhs
    for _ in 2...rhs {
        result += lhs
    }
    return result
}
let u = "abc"
let v = u * 5

//: [Next](@next)
