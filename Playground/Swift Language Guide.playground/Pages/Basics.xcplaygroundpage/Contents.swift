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
 # 基本数据类型
 - Int整型 Double/Float浮点型
 - Bool布尔值
 - String文本型数据
 - Array数组 Dictionary字典
 */
/*:
 ## Number - Int/Double/Float
 */
do {
    let i = 10
    _ = Double(i)

    let y = 3.8
    _ = Int(y)

    let what = 0x10
    _ = what

    if 3e2 == 300 {
        print("yep")
    }

    if 0x10p2 == 64 {
        print("yep")
    }

}

// no implicit coercion for variables
do {
    let d : Double = 10
    // let d2 : Double = i // compile error; you need to say Double(i)
    let n = 3.0
    let nn = 10/3.0
    // let x2 = i / n // compile error; you need to say Double(i)
}
do {
    let cdub = CDouble(1.2)
    let ti = TimeInterval(2.0)
    _ = cdub
    _ = ti
}
do {
    if let mars = UIImage(named:"Mars") {
        let marsCG = mars.cgImage!
        let szCG = CGSize(
            // CGImageGetWidth(marsCG),
            // CGImageGetHeight(marsCG)
            // legal because there is an Int initializer
            width:marsCG.width,
            height:marsCG.height
        )
        _ = szCG
    }
}

do {
    let s = UISlider()
    let g = UIGestureRecognizer()

    let pt = g.location(in:s)
    let percentage = pt.x / s.bounds.size.width
    // let delta = percentage * (s.maximumValue - s.minimumValue) // compile error
    let delta = Float(percentage) * (s.maximumValue - s.minimumValue)

    _ = delta
}

do {
    var i = UInt8(1)
    let j = Int8(2)
    i = numericCast(j)
    _ = i
}

do {
    let i = Int.max - 2
    // let j = i + 12/2 // crash
    let (j, over) = Int.addWithOverflow(i,12/2)
    (j)
    (over)
}

do {
    let i = -7
    let j = 6
    (abs(i)) // 7
    (max(i,j)) // 6
}

do {
    let sq = sqrt(2.0)
    (sq)
    let n = 10
    let i = Int(arc4random())%n
    (i)
}

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

/*:
 # Type Safety and Type Inference

 Swift is a type-safe language. A type safe language encourages you to be clear about the types of values your code can work with. If part of your code expects a String, you can’t pass it an Int by mistake. Swift是一种类型安全的语言。一种类型的安全语言鼓励您清楚代码可以使用的值的类型。如果你的一部分代码需要一个String，那么你就不能错误地传给Int。

 Because Swift is type safe, it performs type checks when compiling your code and flags any mismatched types as errors. This enables you to catch and fix errors as early as possible in the development process. 因为Swift是类型安全的，它在编译代码时执行类型检查，并将任何不匹配的类型标记为错误。这使您能够在开发过程中尽可能早地捕获并修复错误。

 Type-checking helps you avoid errors when you’re working with different types of values. However, this doesn’t mean that you have to specify the type of every constant and variable that you declare. If you don’t specify the type of value you need, Swift uses type inference to work out the appropriate type. Type inference enables a compiler to deduce the type of a particular expression automatically when it compiles your code, simply by examining the values you provide. 当您使用不同类型的值时，类型检查可帮助您避免错误。但是，这并不意味着您必须指定您声明的每个常量和变量的类型。如果您没有指定所需的值类型，Swift将使用类型推断来确定适当的类型。类型推断使得编译器可以在编译代码时自动推导特定表达式的类型，只需检查您提供的值即可。

 Because of type inference, Swift requires far fewer type declarations than languages such as C or Objective-C. Constants and variables are still explicitly typed, but much of the work of specifying their type is done for you.

 Type inference is particularly useful when you declare a constant or variable with an initial value. This is often done by assigning a literal value (or literal) to the constant or variable at the point that you declare it. 当您声明具有初始值的常量或变量时，类型推断特别有用。这通常是在您声明的那一点上为常量或变量分配文字值（或文字）来完成的。
 
 Swift always chooses Double (rather than Float) when inferring the type of floating-point numbers. 当推断出浮点数的类型时，Swift总是选择Double（而不是Float）.

 If you combine integer and floating-point literals in an expression, a type of Double will be inferred from the context. 如果在表达式中组合整数和浮点数字，则会从上下文中推断出Double类型.
 */
do {
    let meaningOfLife = 42
    // meaningOfLife is inferred to be of type Int

    let pi = 3.14159
    // pi is inferred to be of type Double

    let anotherPi = 3 + 0.14159
    // anotherPi is also inferred to be of type Double
}

/*:
 # Numeric Literals

 Integer literals can be written as:

 - A decimal number, with no prefix 十进制数，无前缀
 - A binary number, with a 0b prefix 一个二进制数，带有0b前缀
 - An octal number, with a 0o prefix 八进制数，前缀为0
 - A hexadecimal number, with a 0x prefix 十六进制数，带0x前缀
 */
do {
    let decimalInteger = 17
    let binaryInteger = 0b10001       // 17 in binary notation
    let octalInteger = 0o21           // 17 in octal notation
    let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
}
/*:
 Floating-point literals can be decimal (with no prefix), or hexadecimal (with a 0x prefix). They must always have a number (or hexadecimal number) on both sides of the decimal point. Decimal floats can also have an optional exponent, indicated by an uppercase or lowercase e; hexadecimal floats must have an exponent, indicated by an uppercase or lowercase p. 浮点文字可以是十进制（没有前缀）或十六进制（带有0x前缀）。 它们必须始终在小数点的两侧都有一个数字（或十六进制数字）。 十进制浮点也可以有一个可选指数，用大写或小写e表示; 十六进制浮点必须具有指数，以大写或小写p表示。
 */
do {
    let decimalDouble = 12.1875
    let exponentDouble = 1.21875e1
    let ex1 = 1.25e2
    let ex2 = 1.25e-2
    let hexadecimalDouble = 0xC.3p0
    let sixty = 0xF.0p2
    let hexthreepoint = 0xF.0p-2
}
/*:
 Numeric literals can contain extra formatting to make them easier to read. Both integers and floats can be padded with extra zeros and can contain underscores to help with readability. Neither type of formatting affects the underlying value of the literal: 数字文字可以包含额外的格式，使其更容易阅读。 这两个整数和浮点数可以用额外的零填充，并且可以包含下划线以帮助可读性。 两种类型的格式都会影响文字的底层值
 */
do {
    let paddedDouble = 000123.456
    let oneMillion = 1_000_000
    let justOverOneMillion = 1_000_000.000_000_1
}

/*:
 # Type Aliases

 Type aliases define an alternative name for an existing type. You define type aliases with the typealias keyword.

 Type aliases are useful when you want to refer to an existing type by a name that is contextually more appropriate, such as when working with data of a specific size from an external source. 当您想通过上下文更合适的名称引用现有类型时，例如在从外部源处理特定大小的数据时，类型别名很有用。
 */
do {
    typealias AudioSample = UInt16
    var maxAmplitudeFound = AudioSample.min
    // maxAmplitudeFound is now 0
}
do {
    // 别名添加泛型
    typealias IntFunction<T> = (T) -> Int
    
    //一个key为String，value为T的字典
    typealias StringDictionary<T> = Dictionary<String, T>
    
    //一个value为String的字典
    typealias DictionaryOfStrings<T : Hashable> = Dictionary<T, String>
    
    let keyIsStringDict: StringDictionary<Int> = ["key":6]
    let valueIsStringDict: DictionaryOfStrings<Int> = [5:"value"]
    
    //当然也可以使用在函数参数里
    func joinKey<T: Equatable>(dict: StringDictionary<T>) -> String {
        return dict.map {
            return $0.key
            }.reduce("")
            { (result, key) -> String in
                print("\(result) \(key)")
                return "\(result) \(key)"
        }
    }
    
    let testDict = ["first":6, "second":6, "third":6]
    let joinedKey = joinKey(dict: testDict)
    
    //结果为" second third first"
    
    typealias Vec3<T> = (T, T, T)
    
    func perimeter(data: Vec3<Int>) -> Int {
        return data.0 + data.1 + data.2
    }
    
    let triangle = (1,2,3)
    let result = perimeter(data: triangle)
    
    //result 为 6
}

/*:
 # Booleans

 Swift has a basic Boolean type, called Bool. Boolean values are referred to as logical, because they can only ever be true or false. Swift provides two Boolean constant values, true and false.
 */
do {
    let orangesAreOrange = true
    let turnipsAreDelicious = false
    if turnipsAreDelicious {
        print("Mmm, tasty turnips!")
    } else {
        print("Eww, turnips are horrible.")
    }
    // Prints "Eww, turnips are horrible."

    let i = 1
    if i == 1 {
        // this example will compile successfully
    }
}

/*:
 # Tuples

 Tuples group multiple values into a single compound value. The values within a tuple can be of any type and do not have to be of the same type as each other. 元组将多个值组合成单个复合值。 元组中的值可以是任何类型的，并且不必彼此具有相同的类型。
 
 元组相当于匿名结构体: 元组与结构体这两个类型很像，只是结构体通过结构体描述声明，声明之后就可以用这个结构体来定义实例，而元组仅仅是一个实例。如果需要在一个方法或者函数中定义临时结构体，就可以利用这种相似性。就像 Swift 文档中所说：
 “需要临时组合一些相关值的时候，元组非常有用。（…）如果数据结构需要在临时范围之外仍然存在。那就把它抽象成类或者结构体（…）”
 */
do {
    let http404Error = (404, "Not Found")
    // http404Error is of type (Int, String), and equals (404, "Not Found")

    let (statusCode, statusMessage) = http404Error
    print("The status code is \(statusCode)")
    // Prints "The status code is 404"
    print("The status message is \(statusMessage)")
    // Prints "The status message is Not Found"

    let (justTheStatusCode, _) = http404Error
    print("The status code is \(justTheStatusCode)")
    // Prints "The status code is 404"

    print("The status code is \(http404Error.0)")
    // Prints "The status code is 404"
    print("The status message is \(http404Error.1)")
    // Prints "The status message is Not Found"

    let http200Status = (statusCode: 200, description: "OK")

    print("The status code is \(http200Status.statusCode)")
    // Prints "The status code is 200"
    print("The status message is \(http200Status.description)")
    // Prints "The status message is OK"
}
/*:
 Tuples are particularly useful as the return values of functions. A function that tries to retrieve a web page might return the (Int, String) tuple type to describe the success or failure of the page retrieval. By returning a tuple with two distinct values, each of a different type, the function provides more useful information about its outcome than if it could only return a single value of a single type. 元组作为函数的返回值特别有用。 尝试检索网页的功能可能会返回（Int，String）元组类型来描述页面检索的成功或失败。 通过返回一个具有两个不同值的元组，每个元素都有一个不同的类型，该函数提供了有关其结果的更有用的信息，而不是仅返回单个类型的单个值。
 
 - NOTE:
 Tuples are useful for temporary groups of related values. They are not suited to the creation of complex data structures. If your data structure is likely to persist beyond a temporary scope, model it as a class or structure, rather than as a tuple. 元组对于相关值的临时组是有用的。 它们不适合创建复杂的数据结构。 如果您的数据结构可能持续超出临时范围，则将其建模为类或结构，而不是作为元组。
 */

/*:
 ## 元组解构
 */
do {
    func abc() -> (Int, Int, String) {
        return (3, 5, "Carl")
    }
    /// 之前的例子大多只展示了如何把东西塞到元组中，解构则是一种迅速把东西从元组中取出的方式，结合上面的 abc 例子，我们写出如下代码：
    let (a, b, c) = abc()
    //print(a)
    // 另外一个例子是把多个方法调用写在一行代码中
    // let (d, e, f) = (a1(), b1(), c1())
    // 简单的交换两个值
    var a1 = 5
    var b1 = 4
    (b1, a1) = (a1, b1)
}

do {
    /// 元组做为匿名结构体
    struct User {
        let name: String
        let age: Int
    }
    // vs.
    let user = (name: "Carl", age: 40)
    
    // 下面来看一个例子：需要收集多个方法的返回值，去重并插入到数据集中：
    func zipForUser(userid: String) -> String { return "12124" }
    func streetForUser(userid: String) -> String { return "Charles Street" }
    // 从数据集中找出所有不重复的街道
    var streets: [String: (zip: String, street: String, count: Int)] = [:]
//    for userid in users {
//        let zip = zipForUser(userid)
//        let street = streetForUser(userid)
//        let key = "\(zip)-\(street)"
//        if let (_, _, count) = streets[key] {
//            streets[key] = (zip, street, count + 1)
//        } else {
//            streets[key] = (zip, street, 1)
//        }
//    }
//    drawStreetsOnMap(streets.values)
    
    // 在处理算法数据的类中，你需要把某个方法返回的临时结果传入到另外一个方法中。定义一个只有两三个方法会用的结构体显然是不必要的。
    // 编造算法
    //func calculateInterim(values: [Int]) -> (r: Int, alpha: CGFloat, chi: (CGFloat, CGFloat)) {}
    //func expandInterim(interim: (r: Int, alpha: CGFloat, chi: (CGFloat, CGFloat))) -> CGFloat {}
}

//: 私有状态
do {
    // 元组只在当前的实现方法中有效。使用元组可以很好的存储内部状态。
    let tableViewValues = [(title: "Age", value: "user.age", editable: true),
                           (title: "Name", value: "user.name.combinedName", editable: true),
                           (title: "Username", value: "user.name.username", editable: false),
                           (title: "ProfilePicture", value: "user.pictures.thumbnail", editable: false)]
}

do {
    // 你定义了一个对象，并且想给这个对象添加多个变化监听器，每个监听器都包含它的名字以及发生变化时被调用的闭包：
//    func addListener(name: String, action: (change: AnyObject?) -> ())
//    func removeListener(name: String)
    // 你会如何在对象中保存这些监听器呢？显而易见的解决方案是定义一个结构体，但是这些监听器只能在三种情况下用，也就是说它们使用范围极其有限，而结构体只能定义为 internal ，所以，使用元组可能会是更好的解决方案，因为它的解构能力会让事情变得很简单：
    var listeners: [(String, (AnyObject?) -> ())]
//    func addListener(name: String, @escaping action: (_ change: AnyObject?) -> ()) {
//        listeners.append((name, action))
//    }
    func removeListener(name: String) {
        if let idx = listeners.index(where: { e in return e.0 == name }) {
            listeners.remove(at:idx)
        }
    }
    func execute(change: Int) {
        for (_, listener) in listeners {
            listener(change as AnyObject)
        }
    }
}

do {
    /// 元组当做复杂的可变参数类型
    // 可变参数（比如可变函数参数）是在函数参数的个数不定的情况下非常有用的一种技术。
    // 传统例子
    func sumOf(_ numbers: Int...) -> Int {
        // 使用 + 操作符把所有数字加起来
        return numbers.reduce(0,+)
    }
    sumOf(1, 2, 5, 7, 9) // 24
    // 如果你的需求不单单是 integer，元组就会变的很有用。下面这个函数做的事情就是批量更新数据库中的 n 个实体：
    var db: [(String, Int)]
//    func batchUpdate(_ updates: (String, Int)...) -> Bool {
//        //db.begin()
//        for (key, value) in updates {
//            db.append((key, value))
//        }
//        //db.end()
//    }
    // 我们假想数据库是很复杂的
//    batchUpdate(("tk1", 5), ("tk7", 9), ("tk21", 44), ("tk88", 12))
}

/*:
 ## 元组迭代
 Swift 提供了有限的反射能力，这就允许我们检查元组的内容然后对它进行遍历。不好的地方就是类型检查器不知道如何确定遍历元素的类型，所以所有内容的类型都是 Any。你需要自己转换和匹配那些可能有用的类型并决定要对它们做什么。
 */
do {
    let t = (a: 5, b: "String", c: NSDate())
    /// Mirror: 表示任何主体实例的子结构和可选的“显示样式”。
    /// 描述构成特定实例的部分（如存储属性，集合元素，元组元素或活动枚举情况）。 也可以提供一个“显示风格”属性，表明如何呈现此结构。
    /// 镜子由操场和调试器使用。
    let mirror = Mirror(reflecting: t)
    for (label, value) in mirror.children {
        switch value {
        case is Int:
            print("int")
        case is String:
            print("string")
        case is NSDate:
            print("nsdate")
        default: ()
        }
    }
}
/*:
 ## 元组和泛型
 Swift 中并没有 Tuple 这个类型。如果你不知道为什么，可以这样想：每个元组都是完全不同的类型，它的类型取决于它包含元素的类型。
 */
do {
    func wantsTuple<T1, T2>(_ tuple: (T1, T2)) -> T1 {
        return tuple.0
    }
    wantsTuple(("a", "b")) //"a"
    wantsTuple((1, 2)) //1
    /// 你也可以通过 typealiases 使用元组，从而允许子类指定具体的类型。这看起来相当复杂而且无用，但是我已经碰到了需要特意这样做的使用场景。
    class BaseClass<A,B> {
        typealias Element = (A, B)
        func addElement(_ elm: Element) {
            print(elm)
        }
    }
    class IntegerClass<B> : BaseClass<Int, B> {}
    let example = IntegerClass<String>()
    example.addElement((5, ""))
    // Prints (5, "")
}
/*:
 # Optionals

 You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all. 在值可能不存在的情况下，您可以使用可选项。一个可选的代表了两种可能性：有一个值，你可以打开可选的来访问该值，或者根本没有一个值。

 - NOTE:
 The concept of optionals doesn’t exist in C or Objective-C. The nearest thing in Objective-C is the ability to return nil from a method that would otherwise return an object, with nil meaning “the absence of a valid object.” However, this only works for objects—it doesn’t work for structures, basic C types, or enumeration values. For these types, Objective-C methods typically return a special value (such as NSNotFound) to indicate the absence of a value. This approach assumes that the method’s caller knows there is a special value to test against and remembers to check for it. Swift’s optionals let you indicate the absence of a value for any type at all, without the need for special constants.C或Objective-C中不存在可选项的概念。 Objective-C中最接近的东西是从一个否则返回一个对象的方法返回nil的能力，其中nil表示“没有有效对象”。但是，这仅适用于对象 - 它不适用于结构，基本C类型或枚举值。对于这些类型，Objective-C方法通常返回一个特殊值（例如NSNotFound）来表示没有值。这种方法假设方法的调用者知道有一个特殊的值来测试和记住它来检查它。 Swift的可选项可让您指出任何类型的值都不存在，而不需要特殊的常量。
 */
let possibleNumber = "123"
do {
    let convertedNumber = Int(possibleNumber)
    // convertedNumber is inferred to be of type "Int?", or "optional Int"
}

/*:
 ## nil

 You set an optional variable to a valueless state by assigning it the special value nil.
 
 - NOTE:
 nil cannot be used with nonoptional constants and variables. If a constant or variable in your code needs to work with the absence of a value under certain conditions, always declare it as an optional value of the appropriate type.
 

 - NOTE:
 Swift’s nil is not the same as nil in Objective-C. In Objective-C, nil is a pointer to a nonexistent object. In Swift, nil is not a pointer—it is the absence of a value of a certain type. Optionals of any type can be set to nil, not just object types. Objective-C中的Swift的零点不同于零。 在Objective-C中，nil是指向不存在对象的指针。 在Swift中，nil不是一个指针 - 它是没有某种类型的值。 任何类型的可选项可以设置为nil，而不仅仅是对象类型。

 */
do {
    var serverResponseCode: Int? = 404
    // serverResponseCode contains an actual Int value of 404
    serverResponseCode = nil
    // serverResponseCode now contains no value

    var surveyAnswer: String?
    // surveyAnswer is automatically set to nil
}

/*:
 ## If Statements and Forced Unwrapping

 You can use an if statement to find out whether an optional contains a value by comparing the optional against nil. You perform this comparison with the “equal to” operator (==) or the “not equal to” operator (!=).
 
 - NOTE
 Trying to use ! to access a nonexistent optional value triggers a runtime error. Always make sure that an optional contains a non-nil value before using ! to force-unwrap its value. 试图使用！ 访问不存在的可选值会触发运行时错误。 始终确保可选项在使用前包含非零值！ 强制解开它的价值。
 */
do {
    let convertedNumber = Int(possibleNumber)

    if convertedNumber != nil {
        print("convertedNumber contains some integer value.")
    }
    // Prints "convertedNumber contains some integer value."

    if convertedNumber != nil {
        print("convertedNumber has an integer value of \(convertedNumber!).")
    }
    // Prints "convertedNumber has an integer value of 123."
}

/*:
 ## Optional Binding
 可选绑定

 You use optional binding to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable. Optional binding can be used with if and while statements to check for a value inside an optional, and to extract that value into a constant or variable, as part of a single action. if and while statements are described in more detail in Control Flow. 您可以使用可选绑定来确定可选项是否包含值，如果是，则将该值用作临时常量或变量。 可选绑定可以与if和while语句一起使用，以检查可选内容中的值，并将该值提取为常量或变量，作为单个操作的一部分。 if和while语句在Control Flow中有更详细的描述。

 Write an optional binding for an if statement as follows:

    if let constantName = someOptional {
        statements
    }
 */
do {
    if let actualNumber = Int(possibleNumber) {
        print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
    } else {
        print("\"\(possibleNumber)\" could not be converted to an integer")
    }
    // Prints ""123" has an integer value of 123"

    if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
        print("\(firstNumber) < \(secondNumber) < 100")
    }
    // Prints "4 < 42 < 100"

    if let firstNumber = Int("4") {
        if let secondNumber = Int("42") {
            if firstNumber < secondNumber && secondNumber < 100 {
                print("\(firstNumber) < \(secondNumber) < 100")
            }
        }
    }
    // Prints "4 < 42 < 100"
}
/*:
 - NOTE:
 Constants and variables created with optional binding in an if statement are available only within the body of the if statement. In contrast, the constants and variables created with a guard statement are available in the lines of code that follow the guard statement, as described in Early Exit.
 */
/*:
 # Implicitly Unwrapped Optionals
 隐式展开的可选项

 As described above, optionals indicate that a constant or variable is allowed to have “no value”. Optionals can be checked with an if statement to see if a value exists, and can be conditionally unwrapped with optional binding to access the optional’s value if it does exist.

 Sometimes it is clear from a program’s structure that an optional will always have a value, after that value is first set. In these cases, it is useful to remove the need to check and unwrap the optional’s value every time it is accessed, because it can be safely assumed to have a value all of the time. 有时从程序的结构中可以清楚地看到，可选项将始终具有一个值，该值首先设置为该值。在这些情况下，删除在每次访问时检查和解除可选项值的需要是有用的，因为可以安全地假定所有时间都具有值。

 These kinds of optionals are defined as implicitly unwrapped optionals. You write an implicitly unwrapped optional by placing an exclamation mark (String!) rather than a question mark (String?) after the type that you want to make optional. 这些可选项定义为隐式解包选项。通过在想要选择的类型之后放置一个感叹号（String！）而不是一个问号（String？）来编写一个隐式解开的可选项。

 Implicitly unwrapped optionals are useful when an optional’s value is confirmed to exist immediately after the optional is first defined and can definitely be assumed to exist at every point thereafter. The primary use of implicitly unwrapped optionals in Swift is during class initialization, as described in Unowned References and Implicitly Unwrapped Optional Properties. 当可选的值在第一次定义可选项之后立即确认存在可选值时，隐式展开的可选项是有用的，并且可以肯定地假设存在于其后的每个点。在Swift中主要使用隐式解包的可选项是在类初始化期间，如“未知引用”和“隐式解包”可选属性中所述。

 An implicitly unwrapped optional is a normal optional behind the scenes, but can also be used like a nonoptional value, without the need to unwrap the optional value each time it is accessed. The following example shows the difference in behavior between an optional string and an implicitly unwrapped optional string when accessing their wrapped value as an explicit String. 隐式解开的可选项是幕后的常规可选选项，但也可以像非选用值一样使用，无需在每次访问时解除可选的值。以下示例显示了在将其包装值作为显式字符串访问时，可选字符串与隐式解除的可选字符串之间的行为差​​异.
 */
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark
/*:
 You can think of an implicitly unwrapped optional as giving permission for the optional to be unwrapped automatically whenever it is used. Rather than placing an exclamation mark after the optional’s name each time you use it, you place an exclamation mark after the optional’s type when you declare it. 您可以将隐式解包的可选作为给予权限，使其可以自动被自动解包。 在每次使用可选名称之后，不要在可选名称之后放置一个感叹号，而是在您声明该选项后的类型之后放置一个感叹号。

 - NOTE:
 If an implicitly unwrapped optional is nil and you try to access its wrapped value, you’ll trigger a runtime error. The result is exactly the same as if you place an exclamation mark after a normal optional that does not contain a value. 如果隐式解除的可选项为nil，并尝试访问其包装值，则会触发运行时错误。 结果与在不包含值的常规可选项之后放置感叹号完全相同。
 */
do {
    if assumedString != nil {
        print(assumedString)
    }
    // Prints "An implicitly unwrapped optional string."

    if let definiteString = assumedString {
        print(definiteString)
    }
    // Prints "An implicitly unwrapped optional string."
}
/*:
 - NOTE:
 Do not use an implicitly unwrapped optional when there is a possibility of a variable becoming nil at a later point. Always use a normal optional type if you need to check for a nil value during the lifetime of a variable. 当有可能的变量在以后变为零时，不要使用隐式解开的可选。 如果需要在变量生命周期内检查一个零值，请始终使用正常的可选类型。
 */

/*:
 # Error Handling

 You use error handling to respond to error conditions your program may encounter during execution.

 In contrast to optionals, which can use the presence or absence of a value to communicate success or failure of a function, error handling allows you to determine the underlying cause of failure, and, if necessary, propagate the error to another part of your program. 与可选项相反，可以使用值的存在或不存在来传达功能的成功或失败，错误处理允许您确定故障的根本原因，如有必要，将错误传播到程序的另一部分。

 When a function encounters an error condition, it throws an error. That function’s caller can then catch the error and respond appropriately. 当函数遇到错误条件时，会引发错误。 那个函数的调用者可以捕获错误并作出适当的响应。
 
 A function indicates that it can throw an error by including the throws keyword in its declaration. When you call a function that can throw an error, you prepend the try keyword to the expression. 一个函数表示它可以通过在其声明中包含throws关键字来引发错误。 当你调用一个可以引发错误的函数时，你可以在表达式中添加try关键字。

 Swift automatically propagates errors out of their current scope until they are handled by a catch clause. Swift自动将错误传播到当前范围之外，直到被catch子句处理。
 
 A do statement creates a new containing scope, which allows errors to be propagated to one or more catch clauses. do语句创建一个新的包含范围，允许将错误传播到一个或多个catch子句。
 */
do {
    func canThrowAnError() throws {
        // this function may or may not throw an error
    }
    do {
        try canThrowAnError()
        // no error was thrown
    } catch {
        // an error was thrown
    }
}

do {
    enum SandwichError {
        case outOfCleanDishes
        case missingIngredients
    }

    func makeASandwich() throws {}
    func eatASandwich() {}
    func washDishes() {}
    func buyGroceries() {}

    do {
        try makeASandwich()
        eatASandwich()
    } catch SandwichError.outOfCleanDishes {
        washDishes()
    } catch SandwichError.missingIngredients(let ingredients) {
        buyGroceries(ingredients)
    }
}

/*:
 # Assertions
 断言

 In some cases, it is simply not possible for your code to continue execution if a particular condition is not satisfied. In these situations, you can trigger an assertion in your code to end code execution and to provide an opportunity to debug the cause of the absent or invalid value. 在某些情况下，如果特定条件不满足，您的代码根本无法继续执行。在这些情况下，您可以在代码中触发断言以结束代码执行，并提供调试缺失值或无效值的原因的机会。

 ## Debugging with Assertions

 An assertion is a runtime check that a Boolean condition definitely evaluates to true. Literally put, an assertion “asserts” that a condition is true. You use an assertion to make sure that an essential condition is satisfied before executing any further code. If the condition evaluates to true, code execution continues as usual; if the condition evaluates to false, code execution ends, and your app is terminated. 一个断言是一个运行时检查，一个布尔条件绝对评估为真。一个断言“断言”一个条件是真实的。在执行任何其他代码之前，您使用断言确保满足基本条件。如果条件评估为真，代码执行按照惯例继续执行;如果条件评估为false，则代码执行结束，并且您的应用程序被终止。

 If your code triggers an assertion while running in a debug environment, such as when you build and run an app in Xcode, you can see exactly where the invalid state occurred and query the state of your app at the time that the assertion was triggered. An assertion also lets you provide a suitable debug message as to the nature of the assert. 如果您的代码在调试环境中运行时触发断言，例如在Xcode中构建和运行应用程序时，您可以确定发生无效状态的位置，并在断言被触发时查询应用程序的状态。断言还允许您提供关于断言本质的适当调试信息。

 You write an assertion by calling the Swift standard library global assert(_:_:file:line:) function. You pass this function an expression that evaluates to true or false and a message that should be displayed if the result of the condition is false. 您通过调用Swift标准库全局assert（_：_：file：line :)函数来写入断言。您传递此函数的一个表达式，其计算结果为true或false，如果条件的结果为false，则应显示该消息.
 

 - NOTE:
 Assertions are disabled when your code is compiled with optimizations, such as when building with an app target’s default Release configuration in Xcode.
 */
do {
    let age = -3
    //assert(age >= 0, "A person's age cannot be less than zero")
    // this causes the assertion to trigger, because age is not >= 0

}

/*:
 ## When to Use Assertions

 Use an assertion whenever a condition has the potential to be false, but must definitely be true in order for your code to continue execution. Suitable scenarios for an assertion check include:

 - An integer subscript index is passed to a custom subscript implementation, but the subscript index value could be too low or too high.
 - A value is passed to a function, but an invalid value means that the function cannot fulfill its task.
 - An optional value is currently nil, but a non-nil value is essential for subsequent code to execute successfully.

 - NOTE:
 Assertions cause your app to terminate and are not a substitute for designing your code in such a way that invalid conditions are unlikely to arise. Nonetheless, in situations where invalid conditions are possible, an assertion is an effective way to ensure that such conditions are highlighted and noticed during development, before your app is published. 断言导致您的应用程序终止，并且不能替代设计您的代码，使得无法产生无效的条件。 然而，在无效条件可能的情况下，断言是在应用程序发布之前确保在开发过程中突出显示和注意到这些条件的有效方法。
 */




//: # Example

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
    print(pair)
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
}
do {
    let tuple = (i1:1, i2:2)
}
do {
    let pair : (Int, String) = (1, "Two")
}

do {
    let pair = (1, "Two")
}

do {
    var ix: Int
    var s: String
    (ix, s) = (1, "Two")
}

do {
    let (ix, s) = (1, "Two") // can use let or var here
    _ = ix; _ = s
}

do {
    var s1 = "Hello"
    var s2 = "world"
    (s1, s2) = (s2, s1) // now s1 is "world" and s2 is "Hello"
}

do {
    let pair = (1, "Two")
    let (_, s) = pair // now s is "Two"
}

do {
    let s = "hello"
    for (ix,c) in s.characters.enumerated() {
        print("character \(ix) is \(c)")
    }
}

do {
    var pair = (1, "Two")
    let ix = pair.0 // now ix is 1
    pair.0 = 2 // now pair is (2, "Two")
    print(pair)
}

do {
    let pair : (first:Int, second:String) = (1, "Two")
}

do {
    let pair = (first:1, second:"Two")
}

do {
    var pair = (first:1, second:"Two")
    let x = pair.first // 1
    pair.first = 2
    let y = pair.0 // 2
}

do {
    let pair = (1, "Two")
    let pairWithNames : (first:Int, second:String) = pair
    let ix = pairWithNames.first // 1
}


do {
    var pairWithoutNames = (1, "Two")
    pairWithoutNames = (first:2, second:"Two")
    print(pairWithoutNames)
    //let ix = pairWithoutNames.first /// compile error: we stripped the names
}

do {
    func tupleMaker() -> (first:Int, second:String) {
        return (1, "Two") // no labels here
    }
    let ix = tupleMaker().first // 1
    print(ix)
}

do { // examples from the dev forums
    var array: [(Int, Int)] = []

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

class test: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        // better example would be to start with a view controller:
        let f = self.view.window?.rootViewController?.view.frame

        self.navigationController?.hidesBarsOnTap = true
        let ok : Void? = self.navigationController?.hidesBarsOnTap = true
        if ok != nil {
            // it worked
        }
    }
}
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
    //print(upper4!) // crash: unexpectedly found nil while unwrapping an Optional value
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
    let c : UIColor! = nil
    if c != .red { // crash at runtime
        // and if you change it to == you'll crash the compiler!'
        print("it is not red")
    }
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

//: 注释 多行注释可以嵌套
/*
 /*
 第一层注释
 第二层注释
 */
 */

//: [Next](@next)
