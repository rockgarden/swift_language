//: [Previous](@previous)
import Foundation
import MediaPlayer
/*: 
 # THE BASICS
 Swift is a new programming language for iOS, macOS, watchOS, and tvOS app development. Nonetheless, many parts of Swift will be familiar from your experience of developing in C and Objective-C.

 Swift provides its own versions of all fundamental C and Objective-C types, including Int for integers, Double and Float for floating-point values, Bool for Boolean values, and String for textual data. Swift also provides powerful versions of the three primary collection types, Array, Set, and Dictionary, as described in Collection Types.

 Like C, Swift uses variables to store and refer to values by an identifying name. Swift also makes extensive use of variables whose values cannot be changed. These are known as constants, and are much more powerful than constants in C. Constants are used throughout Swift to make code safer and clearer in intent when you work with values that do not need to change.

 In addition to familiar types, Swift introduces advanced types not found in Objective-C, such as tuples. Tuples enable you to create and pass around groupings of values. You can use a tuple to return multiple values from a function as a single compound value.

 Swift also introduces optional types, which handle the absence of a value. Optionals say either “there is a value, and it equals x” or “there isn’t a value at all”. Using optionals is similar to using nil with pointers in Objective-C, but they work for any type, not just classes. Not only are optionals safer and more expressive than nil pointers in Objective-C, they are at the heart of many of Swift’s most powerful features.

 Swift is a type-safe language, which means the language helps you to be clear about the types of values your code can work with. If part of your code expects a String, type safety prevents you from passing it an Int by mistake. Likewise, type safety prevents you from accidentally passing an optional String to a piece of code that expects a nonoptional String. Type safety helps you catch and fix errors as early as possible in the development process.
 */

/*: 
 # Constants and Variables
 Constants and variables associate a name (such as maximumNumberOfLoginAttempts or welcomeMessage) with a value of a particular type (such as the number 10 or the string "Hello"). The value of a constant cannot be changed once it is set, whereas a variable can be set to a different value in the future.
 
 ## Declaring Constants and Variables

 Constants and variables must be declared before they are used. You declare constants with the let keyword and variables with the var keyword.
 
 - NOTE:
 If a stored value in your code is not going to change, always declare it as a constant with the let keyword. Use variables only for storing values that need to be able to change.
 */
do {
    let maximumNumberOfLoginAttempts = 10
    var currentLoginAttempt = 0
    var x = 0.0, y = 0.0, z = 0.0
}
/*:
 ## Type Annotations

 You can provide a type annotation when you declare a constant or variable, to be clear about the kind of values the constant or variable can store. Write a type annotation by placing a colon after the constant or variable name, followed by a space, followed by the name of the type to use.

 - NOTE:
 It is rare that you need to write type annotations in practice. If you provide an initial value for a constant or variable at the point that it is defined, Swift can almost always infer the type to be used for that constant or variable, as described in Type Safety and Type Inference. In the welcomeMessage example above, no initial value is provided, and so the type of the welcomeMessage variable is specified with a type annotation rather than being inferred from an initial value.
 */
do {
    var welcomeMessage: String
    welcomeMessage = "Hello"

    var red, green, blue: Double
}
/*:
 ## Naming Constants and Variables
 
 Constant and variable names can contain almost any character, including Unicode characters.
 */
do {
    let π = 3.14159
    let 你好 = "你好世界"
    let 🐶🐮 = "dogcow"

    ("\u{02197}") //颜字符

    var 眼睛 = "👀"

    //var b11=a11=20 //不支持连续赋值

    ("占位符: \(眼睛)")
}
/*:
 Constant and variable names cannot contain whitespace characters, mathematical symbols, arrows, private-use (or invalid) Unicode code points, or line- and box-drawing characters. Nor can they begin with a number, although numbers may be included elsewhere within the name. 常量和变量名称不能包含空格字符，数学符号，箭头，私有使用（或无效）Unicode代码点或线条和框图形字符。 他们也不能从数字开始，尽管数字可能包含在其他名称之内。

 Once you’ve declared a constant or variable of a certain type, you can’t redeclare it again with the same name, or change it to store values of a different type. Nor can you change a constant into a variable or a variable into a constant.
 */
do {
    var friendlyWelcome = "Hello!"
    friendlyWelcome = "Bonjour!"
    // friendlyWelcome is now "Bonjour!"

    let languageName = "Swift"
    //languageName = "Swift++"
    // This is a compile-time error: languageName cannot be changed.

    print(friendlyWelcome)
    // Prints "Bonjour!"

    print("The current value of friendlyWelcome is \(friendlyWelcome)")
    // Prints "The current value of friendlyWelcome is Bonjour!"
}
/*:
 ## Reserved words
 can be used as variables or constants using ``

 - NOTE:
 If you need to give a constant or variable the same name as a reserved Swift keyword, surround the keyword with backticks (`) when using it as a name. However, avoid using keywords as names unless you have absolutely no choice. 如果您需要给予一个常量或变量与一个保留的Swift关键字相同的名称，那么在使用它作为一个名称时，使用反引号（`）来围绕该关键字。 但是，除非你绝对没有选择，否则不要使用关键字作为名称.
 */
do {
    let `private` = "private word"
    var word = `private`
}

/*:
 ## Printing Constants and Variables

 You can print the current value of a constant or variable with the print(_:separator:terminator:) function.

 The print(_:separator:terminator:) function is a global function that prints one or more values to an appropriate output. In Xcode, for example, the print(_:separator:terminator:) function prints its output in Xcode’s “console” pane. The separator and terminator parameter have default values, so you can omit them when you call this function. By default, the function terminates the line it prints by adding a line break. To print a value without a line break after it, pass an empty string as the terminator—for example, print(someValue, terminator: ""). For information about parameters with default values, see Default Parameter Values.

 Swift uses string interpolation to include the name of a constant or variable as a placeholder in a longer string, and to prompt Swift to replace it with the current value of that constant or variable. Wrap the name in parentheses and escape it with a backslash before the opening parenthesis.

 - NOTE:

 All options you can use with string interpolation are described in String Interpolation.
 */

/*:
 # Comments

 Use comments to include nonexecutable text in your code, as a note or reminder to yourself. Comments are ignored by the Swift compiler when your code is compiled.

 Comments in Swift are very similar to comments in C. Single-line comments begin with two forward-slashes (//).

 Multiline comments start with a forward-slash followed by an asterisk (/*) and end with an asterisk followed by a forward-slash (*/).

 Unlike multiline comments in C, multiline comments in Swift can be nested inside other multiline comments. You write nested comments by starting a multiline comment block and then starting a second multiline comment within the first block. The second block is then closed, followed by the first block.

 Nested multiline comments enable you to comment out large blocks of code quickly and easily, even if the code already contains multiline comments.
 */
do {
    // This is a comment.

    /* This is also a comment
     but is written over multiple lines. */

    /* This is the start of the first multiline comment.
     /* This is the second, nested multiline comment. */
     This is the end of the first multiline comment.
     */
}

/*:
 # Integers

 Integers are whole numbers with no fractional component, such as 42 and -23. Integers are either signed (positive, zero, or negative) or unsigned (positive or zero).

 Swift provides signed and unsigned integers in 8, 16, 32, and 64 bit forms. These integers follow a naming convention similar to C, in that an 8-bit unsigned integer is of type UInt8, and a 32-bit signed integer is of type Int32. Like all types in Swift, these integer types have capitalized names.

 ## Integer Bounds

 You can access the minimum and maximum values of each integer type with its min and max properties.
 
 The values of these properties are of the appropriate-sized number type (such as UInt8 in the example below) and can therefore be used in expressions alongside other values of the same type.
 */
do {
    let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
    let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
}
/*:
 ## Int

 In most cases, you don’t need to pick a specific size of integer to use in your code. Swift provides an additional integer type, Int, which has the same size as the current platform’s native word size:

    On a 32-bit platform, Int is the same size as Int32.
    On a 64-bit platform, Int is the same size as Int64.
 Unless you need to work with a specific size of integer, always use Int for integer values in your code. This aids code consistency and interoperability. Even on 32-bit platforms, Int can store any value between -2,147,483,648 and 2,147,483,647, and is large enough for many integer ranges.
 
 ## UInt

 Swift also provides an unsigned integer type, UInt, which has the same size as the current platform’s native word size:

    On a 32-bit platform, UInt is the same size as UInt32.
    On a 64-bit platform, UInt is the same size as UInt64.

 - NOTE:
 Use UInt only when you specifically need an unsigned integer type with the same size as the platform’s native word size. If this is not the case, Int is preferred, even when the values to be stored are known to be non-negative. A consistent use of Int for integer values aids code interoperability, avoids the need to convert between different number types, and matches integer type inference, as described in Type Safety and Type Inference. 只有当您特别需要与平台本机字大小相同大小的无符号整数类型时，才使用UInt。 如果不是这种情况，Int是首选，即使要存储的值被称为非负数。 Int对于整数值的一致使用有助于代码互操作性，避免了在不同数字类型之间转换的需要，并且匹配整数类型推断，如类型安全和类型推断中所述。
 */

/*:
 # Floating-Point Numbers

 Floating-point numbers are numbers with a fractional component, such as 3.14159, 0.1, and -273.15.

 Floating-point types can represent a much wider range of values than integer types, and can store numbers that are much larger or smaller than can be stored in an Int. Swift provides two signed floating-point number types:

    Double represents a 64-bit floating-point number.
    Float represents a 32-bit floating-point number.

 - NOTE:
 Double has a precision of at least 15 decimal digits, whereas the precision of Float can be as little as 6 decimal digits. The appropriate floating-point type to use depends on the nature and range of values you need to work with in your code. In situations where either type would be appropriate, Double is preferred. Double的精度至少为15位十进制数，而Float的精度可以是6位十进制数。 要使用的适当浮点类型取决于您需要在代码中处理的值的性质和范围。 在任何一种类型适合的情况下，优选Double。
 */






//: ## 类型转换
let a1: UInt8 = 10
let b1: UInt16 = 100
("\(UInt16(a1) + b1)")

let sa = 3
let pi = 3.1415
let add = Double(sa) + pi
(add)

/*:
 ## 基本数据类型
 Int整型 Double/Float浮点型
 Bool布尔值 
 String文本型数据
 Array数组 Dictionary字典
 Padding numbers with "_" makes them more readable
 */
var paddedInteger = 1_000_000

/*:
 显式类型如整型,在使用时要显式转换
 Explicit conversion must be made when working with explicit types.
 For any other case, use the Int class
 */
let thousand: UInt16 = 1_000
let one: UInt8 = 1
let thousandAndOne = thousand + UInt16(one)

//: 类型标注
let anotherNumber: Int = Int(UINT32_MAX)
var Who: String

//: 声明变量同时赋了初始值,则不必须进行类型标注
var cc = "rockgarden"

//: 类型推断默认是int Inferred as Int by default
let number = 6745
let result = anotherNumber + number

//: ## Tuple 元组
//: Tuples can be of any kind and of any number of elements
let success = (200, "Success")
typealias Success = (Int, String) //用typealias定义
let exito: Success = success
//: If you receive a response in this format, it can be conveniently stored like this.
let (code, message) = success
//: 分解时候要忽略的部分用 _ 表示 If you just need one value.
let (response, _) = success
("The code is \(response)")
("\(success.0)")
do {
    let pair = (1, "One")
    let (_, s) = pair // now s is "One"
    _ = s
}
//: Values can be accessed like indexes:
success.0
success.1
/*: 
 定义元组的时候,给单个元素命名
 names can be added upon declaration
 Invalid redeclaration of name 不能多次命名
 */
let someTuple = (number: 456, assertion: "Yes")
someTuple.number
someTuple.assertion

var scorKey:(math:Int, english:Int, assessment:String)
scorKey = (english:80, math:89, assessment:"A")

var peopleRec:(Int,String,(Int,Int))
peopleRec = (10,"元组元组",(28,32))
(peopleRec.2.0)
//: 通过解构元组交换变量
var aa=1, bb=2
(aa,bb) = (bb,aa)
aa
bb
do {
    var s1 = "Hello"
    var s2 = "world"
    (s1, s2) = (s2, s1) // now s1 is "world" and s2 is "Hello"
}
//: ### Use Example
do {
    let pair : (Int, String) = (1, "One")
    _ = pair
}
do {
    let pair = (1, "One")
}
do {
    var ix: Int
    var s: String
    (ix, s) = (1, "One")
    _ = ix
    _ = s
}
do {
    let (ix, s) = (1, "One") // can use let or var here
    _ = ix
    _ = s
}

do {
    let s = "hello"
    for (ix,c) in s.characters.enumerated() {
        print("character \(ix) is \(c)")
    }
}
do {
    var pair = (1, "One")
    let ix = pair.0 // now ix is 1
    pair.0 = 2 // now pair is (2, "One")
    (pair)
    _ = ix
}
do {
    let pair : (first:Int, second:String) = (1, "One")
    _ = pair
}
do {
    let pair = (first:1, second:"One")
    _ = pair
}
do {
    var pair = (first:1, second:"One")
    let x = pair.first // 1
    pair.first = 2
    let y = pair.0 // 2
    _ = x
    _ = y
}
do {
    let pair = (1, "One")
    let pairWithNames : (first:Int, second:String) = pair
    let ix = pairWithNames.first // 1
    _ = pair
    _ = pairWithNames
    _ = ix
}
do {
    var pairWithoutNames = (1, "One")
    pairWithoutNames = (first:2, second:"Two")
    (pairWithoutNames)
    // let ix = pairWithoutNames.first // compile error, we stripped the names
}
do {
    func tupleMaker() -> (first:Int, second:String) {
        return (1, "One")
    }
    let ix = tupleMaker().first // 1
    (ix)
}


//: parameter list in function call is actually a tuple
// however, new in Swift 2.2, these two calls now get a warning:
// "Passing 2 arguments to a callee as a single tuple value is deprecated"
// so is this "feature" going away? If so, you could _store_ as a tuple ...
// ...but _pass_ as individual arguments
func f (_ i1:Int, _ i2:Int) -> () {}
func f2 (i1 i1:Int, i2:Int) -> () {}
do {
    let tuple = (1,2)
    //f(tuple)
}
do {
    let tuple = (i1:1, i2:2)
    //f2(tuple)
}
do {
    //            var tuple = (i1:1, i2:2)
    //            f2(tuple) // compile error
}
do { // examples from the dev forums
    var array: [(Int, Int)] = []
    // Error - literals
    // array.append(1, 1)
    // Error - let integer
    // let int_const = 1
    // array.append(int_const, 1)
    
    // OK - let tuple
    let const_tuple: (Int, Int) = (1, 1)
    array.append(const_tuple)
    
    // NOK - var integer
    // var int_var = 1
    // array.append(int_var, 1)
    
    // OK - var tuple
    var var_tuple: (Int, Int) = (1, 1)
    array.append(var_tuple)
}
do {
    var array: [(Int, Int)] = []
    // OK - literals
    array.append((1,1))
    // OK - let integer
    let int_const = 1
    array.append((int_const, 1))
    // OK - let tuple
    let const_tuple: (Int, Int) = (1, 1)
    array.append(const_tuple)
    // OK - var integer
    var int_var = 1
    array.append((int_var, 1))
    // OK - var tuple
    var var_tuple: (Int, Int) = (1, 1)
    array.append(var_tuple)
    // shut the compiler up
    int_var = 0
    var_tuple = (0,0)
    array
    array[2].1 = 13
    array
}
/*:
 ## Optionals
 Optionals whether have a value or not.
 can be nil or the number they store, if any.
 */
var optionalInteger: Int?
optionalInteger = 42

let optional: Int? = 2
if optional != nil {
    "It's not nil!"
    optional!
} else {
    "It's nil"
}

//: You can use optional binding as well
if let value = optional {
    "It's not nil!"
    value
}else {
    "It's nil"
}

/*:
 You can also use implicitly unwrapped optionals
 Value becomes accessible automatically once a value has been set
 */
let knownString: Int! = 10
if knownString != nil {
    "It's got a value"
    knownString // No need for explicit unwrapping
}

//: ### Example
var stringMaybe = Optional("howdy")
stringMaybe = Optional("farewell")
//print(stringMaybe) // 包含Optional("farewell")
stringMaybe = "farewell" // wrapped implicitly as it is assigned
func optionalExpecter(_ s: String?) { print(s!) }
func realStringExpecter(_ s:String) {}
let stringMaybe2 : String? = "howdy"
do {
    let stringMaybe2: String? = nil
    let upper4 = stringMaybe2?.uppercased() // no crash!
    print(upper4!)
}
optionalExpecter(stringMaybe)
optionalExpecter("howdy") // wrapped implicitly as it is passed
// realStringExpecter(stringMaybe) // compile error, no implicit unwrapping
realStringExpecter(stringMaybe!)
let upper = stringMaybe!.uppercased()
let stringMaybe3 : ImplicitlyUnwrappedOptional<String> = "howdy"
realStringExpecter(stringMaybe3) // no problem
let stringMaybe4 : String! = "howdy"
realStringExpecter(stringMaybe4)
var stringMaybe5 : String? = "Howdy"
stringMaybe5 = nil

var crash : Bool {return false}
if crash {
    var stringMaybe6 : String?
    optionalExpecter(stringMaybe6) // legal because of implicit initialization
    let s = stringMaybe6! // crash!
    _ = s
    _ = stringMaybe6
    stringMaybe6 = "howdy"
}

let stringMaybe7 : String?
// optionalExpecter(stringMaybe7) // compile error; can't do that with a `let`

do {
    var stringMaybe : String?
    if stringMaybe != nil {
        let s = stringMaybe!
        _ = s
    }
    stringMaybe = "howdy"
}

do {
    let v = UIView()
    let c = v.backgroundColor
    // let c2 = withAlphaComponent(0.5) // compile error
    let c2 = c?.withAlphaComponent(0.5)
}
do {
    let arr = [1, 2, 3]
    let ix = (arr as NSArray).index(of: 4)
    if ix == NSNotFound { print("not found") }
    
    let arr2 = [1, 2, 3]
    let ix2 = arr2.index(of: 4)
    if ix2 == nil { print("not found") }
}
do {
    class Dog {
        var noise: String?
        func speak() -> String? {
            return self.noise
        }
    }
    let d = Dog()
    let bigname = d.speak()?.uppercased()
}

//: ## 断言
let age2 = 10
assert(age2 >= 0, "年龄要大于0") //<0时可触发
assert(true == true, "True isn't equal to false")
//: ## computed Variables
var now : String {
get {
    return NSDate().description
}
set {
    print(newValue)
}
}
now = "Howdy"
(now)

var now2 : String { // showing you can omit "get" if there is no "set"
    return NSDate().description
}

var mp : MPMusicPlayerController {
    return MPMusicPlayerController.systemMusicPlayer()
}

// typical "facade" structure
private var _p : String = ""
var p : String {
get {
    return _p //在类里加self._p
}
set {
    _p = newValue
}
}
p="test"

// observer
var s = "whatever" {
willSet {
    print(newValue)
}
didSet {
    print(oldValue)
    // self.s = "something else"
}
}
s = "Hello"
s = "Bonjour"

private var myBigDataReal : NSData! = nil
var myBigData : NSData! {
set (newdata) {
    myBigDataReal = newdata
}
get {
    if myBigDataReal == nil {
        let fm = FileManager()
        let f = (NSTemporaryDirectory() as NSString).appendingPathComponent("myBigData")
        if fm.fileExists(atPath: f) {
            print("loading big data from disk")
            myBigDataReal = NSData(contentsOfFile: f)
            do {
                try fm.removeItem(atPath: f)
                print("deleted big data from disk")
            } catch {
                print("Couldn't remove temp file")
            }
        }
    }
    return myBigDataReal
}
}

//: 注释 多行注释可以嵌套
/*
 /*
 第一层注释
 第二层注释
 */
 */

//: [Next](@next)
