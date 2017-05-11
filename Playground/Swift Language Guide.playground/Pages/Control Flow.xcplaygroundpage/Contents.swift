//: [Previous](@previous)
import UIKit

/*:
 # Control Flow
 Swift provides a variety of control flow statements. These include while loops to perform a task multiple times; if, guard, and switch statements to execute different branches of code based on certain conditions; and statements such as break and continue to transfer the flow of execution to another point in your code. Swift提供了各种控制流程语句。 这些包括多次执行任务的while循环; if，guard和switch语句根据某些条件执行不同的代码分支; 和断言等继续将执行流程转移到代码中的另一点。

 Swift also provides a for-in loop that makes it easy to iterate over arrays, dictionaries, ranges, strings, and other sequences.

 Swift’s switch statement is considerably more powerful than its counterpart in many C-like languages. Cases can match many different patterns, including interval matches, tuples, and casts to a specific type. Matched values in a switch case can be bound to temporary constants or variables for use within the case’s body, and complex matching conditions can be expressed with a where clause for each case. Swift的switch语句比许多类C语言的语言更强大。 案例可以匹配许多不同的模式，包括间隔匹配，元组和转换为特定类型。 switch case 中写的匹配值可以绑定到临时常量或变量以供在案例体内使用，复杂的匹配条件可以用每个案例的where子句表示。
 */


/*: 
 # For-In Loops

 You use the for-in loop to iterate over a sequence, such as items in an array, ranges of numbers, or characters in a string. 您可以使用for-in循环来迭代序列，例如数组中的项，数字范围或字符串中的字符。
 */
do {
    let names = ["Anna", "Alex", "Brian", "Jack"]
    for name in names {
        print("Hello, \(name)!")
    }
    // Hello, Anna!
    // Hello, Alex!
    // Hello, Brian!
    // Hello, Jack!

    /// dictionary
    let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
    for (animalName, legCount) in numberOfLegs {
        print("\(animalName)s have \(legCount) legs")
    }
    // ants have 6 legs
    // spiders have 8 legs
    // cats have 4 legs

    /// Index is implicitly declared 隐式声明
    for index in 1...5 {
        print("\(index) times 5 is \(index * 5)")
    }
    // 1 times 5 is 5
    // 2 times 5 is 10
    // 3 times 5 is 15
    // 4 times 5 is 20
    // 5 times 5 is 25

    let base = 3
    let power = 10
    var answer = 1
    /// 下划线符号_代替循环中的变量,能够忽略具体的值,并且不对值进行访问
    for _ in 1...power {
        answer *= base
    }
    print("\(base) to the power of \(power) is \(answer)")
    // Prints "3 to the power of 10 is 59049"

    let minutes = 60
    for tickMark in 0..<minutes {
        // render the tick mark each minute (60 times)
    }
    let minuteInterval = 5
    for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
        // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
    }
    let hours = 12
    let hourInterval = 3
    for tickMark in stride(from: 3, through: hours, by: hourInterval) {
        print(tickMark)
        // render the tick mark every 3 hours (3, 6, 9, 12)
    }

    /// Go through a string
    var char = "e"
    for char in "Yes".characters { //char != char
        print("\(char)")
    }

    /// break标签: 仅用于for或swith
    outer: for i in 0 ..< 5  {
        print(i)
        for j in 0 ..< 3 {
            print(j)
            if j == i {
                break outer
            }
        }
    }
}

/*:
 # While Loops

 A while loop performs a set of statements until a condition becomes false. These kinds of loops are best used when the number of iterations is not known before the first iteration begins. while循环执行一组语句，直到条件变为false。 当在第一次迭代开始之前不知道迭代次数时，最好使用这些循环。
 Swift provides two kinds of while loops:
 - while evaluates its condition at the start of each pass through the loop. 同时在每次通过循环的开始时评估其状态。
 - repeat-while evaluates its condition at the end of each pass through the loop.
 
 ## While

 A while loop starts by evaluating a single condition. If the condition is true, a set of statements is repeated until the condition becomes false.

 Here’s the general form of a while loop:

    while condition {
        statements
    }
 */
/// Example plays a simple game of Snakes and Ladders (also known as Chutes and Ladders): https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/snakesAndLadders_2x.png
do {
    let finalSquare = 25
    var board = [Int](repeating: 0, count: finalSquare + 1)

    board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
    board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

    var square = 0
    var diceRoll = 0
    while square < finalSquare {
        // roll the dice
        diceRoll += 1
        if diceRoll == 7 { diceRoll = 1 }
        // move by the rolled amount
        square += diceRoll
        if square < board.count {
            // if we're still on the board, move up or down for a snake or a ladder
            square += board[square]
        }
    }
    print("Game over!")
}

/*:
 ## Repeat-While

 The other variation of the while loop, known as the repeat-while loop, performs a single pass through the loop block first, before considering the loop’s condition. It then continues to repeat the loop until the condition is false. while循环的另一个变体，被称为repeat-while循环，在考虑循环的条件之前首先执行循环块的单次循环。然后继续重复循环，直到条件为假。

 - NOTE:
 The repeat-while loop in Swift is analogous to a do-while loop in other languages. Swift中的repeat-while循环类似于其他语言中的do-while循环。

 Here’s the general form of a repeat-while loop:

    repeat {
        statements
    } while condition

 Here’s the Snakes and Ladders example again, written as a repeat-while loop rather than a while loop. The values of finalSquare, board, square, and diceRoll are initialized in exactly the same way as with a while loop.
 */
do {
    let finalSquare = 25
    var board = [Int](repeating: 0, count: finalSquare + 1)
    board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
    board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    var square = 0
    var diceRoll = 0

    repeat {
        // move up or down for a snake or ladder
        square += board[square]
        // roll the dice
        diceRoll += 1
        if diceRoll == 7 { diceRoll = 1 }
        // move by the rolled amount
        square += diceRoll
    } while square < finalSquare
    print("Game over!")
}

/*:
 # Conditional Statements

 It is often useful to execute different pieces of code based on certain conditions. You might want to run an extra piece of code when an error occurs, or to display a message when a value becomes too high or too low. To do this, you make parts of your code conditional.

 Swift provides two ways to add conditional branches to your code: the if statement and the switch statement. Typically, you use the if statement to evaluate simple conditions with only a few possible outcomes. The switch statement is better suited to more complex conditions with multiple possible permutations and is useful in situations where pattern matching can help select an appropriate code branch to execute.

 ## If

 In its simplest form, the if statement has a single if condition. It executes a set of statements only if that condition is true.
 
 You can chain multiple if statements together to consider additional clauses.

 The final else clause is optional, however, and can be excluded if the set of conditions does not need to be complete.
 */
do {
    var temperatureInFahrenheit = 30
    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    }
    // Prints "It's very cold. Consider wearing a scarf."

    temperatureInFahrenheit = 90
    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    } else if temperatureInFahrenheit >= 86 {
        print("It's really warm. Don't forget to wear sunscreen.")
    } else {
        print("It's not that cold. Wear a t-shirt.")
    }
    // Prints "It's really warm. Don't forget to wear sunscreen."

    temperatureInFahrenheit = 72
    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    } else if temperatureInFahrenheit >= 86 {
        print("It's really warm. Don't forget to wear sunscreen.")
    }
}

/*:
 ## Switch

 A switch statement considers a value and compares it against several possible matching patterns. It then executes an appropriate block of code, based on the first pattern that matches successfully. A switch statement provides an alternative to the if statement for responding to multiple potential states.

 In its simplest form, a switch statement compares a value against one or more values of the same type.

    switch some value to consider {
    case value 1:
        respond to value 1
    case value 2, value 3:
        respond to value 2 or 3
    default:
        otherwise, do something else
    }

 Every switch statement consists of multiple possible cases, each of which begins with the case keyword. In addition to comparing against specific values, Swift provides several ways for each case to specify more complex matching patterns. These options are described later in this chapter.

 Like the body of an if statement, each case is a separate branch of code execution. The switch statement determines which branch should be selected. This procedure is known as switching on the value that is being considered.

 Every switch statement must be exhaustive. That is, every possible value of the type being considered must be matched by one of the switch cases. If it’s not appropriate to provide a case for every possible value, you can define a default case to cover any values that are not addressed explicitly. This default case is indicated by the default keyword, and must always appear last. 每个开关语句都必须详尽无遗。也就是说，所考虑的类型的每个可能的值必须由一个开关情况匹配。如果不适合为每个可能的值提供案例，您可以定义一个默认大小写，以覆盖未明确解决的任何值。默认情况下，默认关键字显示，必须始终显示在最后。
 */
do {
    let someCharacter: Character = "z"
    switch someCharacter {
    case "a":
        print("The first letter of the alphabet")
    case "z":
        print("The last letter of the alphabet")
    default:
        print("Some other character")
    }
    // Prints "The last letter of the alphabet"
}
/*:
 ## No Implicit Fallthrough 没有隐含的落差

 In contrast with switch statements in C and Objective-C, switch statements in Swift do not fall through the bottom of each case and into the next one by default. Instead, the entire switch statement finishes its execution as soon as the first matching switch case is completed, without requiring an explicit break statement. This makes the switch statement safer and easier to use than the one in C and avoids executing more than one switch case by mistake. 与C和Objective-C中的开关语句相反，Swift中的switch语句默认不会落在每种情况的底部，而不是下一个。 相反，只要第一个匹配的switch case完成，整个switch语句就会完成其执行，而不需要显式的break语句。 这使得switch语句比C中的语句更安全，更容易使用，并避免错误地执行多个switch情况。
 
 No need for break, and every case must have some code.

 - NOTE:
 Although break is not required in Swift, you can use a break statement to match and ignore a particular case or to break out of a matched case before that case has completed its execution. 虽然在Swift中不需要break，但是在这种情况完成执行之前，您可以使用break语句来匹配和忽略特定的情况，或者从匹配的案例中删除。For details, see Break in a Switch Statement.

 */
do {
    let anotherCharacter: Character = "a"
    switch anotherCharacter {
    case "a": // Invalid, the case has an empty body
        break //no "break" make error: 'case' label in a 'switch' should have at least one executable statement
    case "A":
        print("The letter A")
    default:
        print("Not the letter A")
    }
    // This will report a compile-time error.

    do {
        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "a", "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        // Prints "The letter A"
    }
}
/*:
 For readability, a compound case can also be written over multiple lines. For more information about compound cases, see Compound Cases.

 - NOTE:
 To explicitly fall through at the end of a particular switch case, use the fallthrough keyword, as described in Fallthrough.
 */
/*:
 ## Interval Matching 间隔匹配

 Values in switch cases can be checked for their inclusion in an interval.
 */
do {
    let approximateCount = 62
    let countedThings = "moons orbiting Saturn"
    let naturalCount: String
    switch approximateCount {
    case 0:
        naturalCount = "no"
    case 1..<5:
        naturalCount = "a few"
    case 5..<12:
        naturalCount = "several"
    case 12..<100:
        naturalCount = "dozens of"
    case 100..<1000:
        naturalCount = "hundreds of"
    default:
        naturalCount = "many"
    }
    print("There are \(naturalCount) \(countedThings).")
    // Prints "There are dozens of moons orbiting Saturn."
}
/*:
 ## Tuples

 You can use tuples to test multiple values in the same switch statement. Each element of the tuple can be tested against a different value or interval of values. Alternatively, use the underscore character (_), also known as the wildcard pattern, to match any possible value. 您可以使用元组在同一个switch语句中测试多个值。 可以针对不同的值或间隔值测试元组的每个元素。 或者，使用下划线字符（_）（也称为通配符模式）来匹配任何可能的值。
 */
/// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/coordinateGraphSimple_2x.png
do {
    let somePoint = (1, 1)
    switch somePoint {
    case (0, 0):
        print("\(somePoint) is at the origin")
    case (_, 0):
        print("\(somePoint) is on the x-axis")
    case (0, _):
        print("\(somePoint) is on the y-axis")
    case (-2...2, -2...2):
        print("\(somePoint) is inside the box")
    default:
        print("\(somePoint) is outside of the box")
    }
    // Prints "(1, 1) is inside the box"
}
/*:
 ## Value Bindings 价值绑定

 A switch case can name the value or values it matches to temporary constants or variables, for use in the body of the case. This behavior is known as value binding, because the values are bound to temporary constants or variables within the case’s body. switch case可以将其匹配的值或值命名为临时常量或变量，以便在case正文中使用。这个行为被称为值绑定，因为这些值绑定到case的body中的临时常量或变量.
 
 After the temporary constants are declared, they can be used within the case’s code block. 临时常数被声明之后，可以在case的代码块中使用它们。
 */
/// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/coordinateGraphMedium_2x.png
do {
    let anotherPoint = (2, 0)
    switch anotherPoint {
    case (let x, 0):
        print("on the x-axis with an x value of \(x)")
    case (0, let y):
        print("on the y-axis with a y value of \(y)")
    case let (x, y):
        print("somewhere else at (\(x), \(y))")
    }
    // Prints "on the x-axis with an x value of 2"
}
/*:
 ## Where

 A switch case can use a where clause to check for additional conditions.
 */
/// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/coordinateGraphComplex_2x.png
do {
    let yetAnotherPoint = (1, -1)
    switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        print("(\(x), \(y)) is just some arbitrary point")
    }
    // Prints "(1, -1) is on the line x == -y"
}
/*:
 ## Compound Cases 复合案例

 Multiple switch cases that share the same body can be combined by writing several patterns after case, with a comma between each of the patterns. If any of the patterns match, then the case is considered to match. The patterns can be written over multiple lines if the list is long. 共享相同身体的多个开关盒可以通过在案例之后写入几个模式，每个模式之间以逗号组合。 如果任何一种模式匹配，则认为这种情况是匹配的。 如果列表很长，模式可以写在多行上。
 */
do {
    let someCharacter: Character = "e"
    switch someCharacter {
    case "a", "e", "i", "o", "u":
        print("\(someCharacter) is a vowel")
    case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
        print("\(someCharacter) is a consonant")
    default:
        print("\(someCharacter) is not a vowel or a consonant")
    }
    // Prints "e is a vowel"
}
/*: 
 Compound cases can also include value bindings. All of the patterns of a compound case have to include the same set of value bindings, and each binding has to get a value of the same type from all of the patterns in the compound case. This ensures that, no matter which part of the compound case matched, the code in the body of the case can always access a value for the bindings and that the value always has the same type. 
 
 复合案例还可以包括值绑定。复合案例的所有模式必须包含相同的值绑定集合，并且每个绑定必须从复合大小写中的所有模式获取相同类型的值。这可以确保，无论组合案例的哪一部分匹配，案件正文中的代码都可以随时访问绑定的值，并且该值始终具有相同的类型。
 */
do {
    let stillAnotherPoint = (9, 0)
    switch stillAnotherPoint {
    case (let distance, 0), (0, let distance):
        print("On an axis, \(distance) from the origin")
    default:
        print("Not on an axis")
    }
    // Prints "On an axis, 9 from the origin"
}




//: ## Switches
enum Filter: CustomStringConvertible {
    case Albums
    case Playlists
    case Podcasts
    case Books
    var description: String {
        switch self {
        case .Albums:
            return "Albums"
        case .Playlists:
            return "Playlists"
        case .Podcasts:
            return "Podcasts"
        case .Books:
            return "Books"
        }
    }
}
enum Error {
    case Number(Int)
    case Message(String)
    case Fatal
}
class Dog {
    func bark() {}
}
class NoisyDog : Dog {
    func beQuiet() { print("arf arf arf") }
}
do {
    var type : Filter = .Albums
    var err = Error.Number(-6)
}

var navbar = UINavigationBar()
var toolbar = UIToolbar()
var progress = 0.0
var d: Dog = NoisyDog()
var i = 1
var ii: Int? = nil
var iii = 1 as AnyObject
var type: Filter = .Albums
var err = Error.Number(-6)
var pep = "Groucho"

do {
    switch i {
    case 1:
        print("You have 1 thingy!")
    case 2:
        print("You have 2 thingies!")
    default:
        print("You have \(i) thingies!")
    }
    
    switch i {
    case 1: print("You have 1 thingy!")
    case 2: print("You have 2 thingies!")
    default: print("You have \(i) thingies!")
    }
    
    switch i {
    case 1:
        print("You have 1 thingy!")
    case _:
        print("You have many thingies!")
    }
    
    switch i {
    case 1:
        print("You have 1 thingy!")
    case let n:
        print("You have \(n) thingies!")
    }
    
    switch i {
    case 1:
        print("You have 1 thingy!")
    case 2...10:
        print("You have \(i) thingies!")
    default:
        print("You have more thingies than I can count!")
    }
    
    do {
        let i = ii
        switch i {
        case nil: break
        default:
            switch i! {
            case 1:
                print("You have 1 thingy!")
            case let n:
                print("You have \(n) thingies!")
            }
        }
    }
    
    do { // new in Swift 2.0: question-mark suffix
        let i = ii
        switch i {
        case 1?:
            print("You have 1 thingy!")
        case let n?:
            print("You have \(n) thingies!")
        case nil: break
        }
    }
    
    switch i {
    case let j where j < 0:
        print("i is negative")
    case let j where j > 0:
        print("i is positive")
    case 0:
        print("i is 0")
    default:break
    }
    
    switch i {
    case _ where i < 0:
        print("i is negative")
    case _ where i > 0:
        print("i is positive")
    case 0:
        print("i is 0")
    default:break
    }
    
    switch d {
    case is NoisyDog:
        print("You have a noisy dog!")
    case _:
        print("You have a dog.")
    }
    
    switch d {
    case let nd as NoisyDog:
        nd.beQuiet()
    case let d:
        d.bark()
    }
}

do {
    let i = iii
    switch i {
    case 0 as Int:
        print("It is 0")
    default:break
    }
}

do {
    let i = Optional(iii)
    switch i {
    case 0 as Int:
        print("It is 0")
    default:break
    }
}


do {
//    let d : [NSObject:AnyObject] = [:]
//    switch (d["size"], d["desc"]) {
//    case let (size as Int, desc as String):
//        print("You have size \(size) and it is \(desc)")
//    default:break
//    }
}

switch type {
case .Albums:
    print("Albums")
case .Playlists:
    print("Playlists")
case .Podcasts:
    print("Podcasts")
case .Books:
    print("Books")
}

switch err {
case .Number(let theNumber):
    print("It is a .Number: \(theNumber)")
case let .Message(theMessage):
    print("It is a .Message: \(theMessage)")
case .Fatal:
    print("It is a .Fatal")
}

switch err {
case let .Number(n) where n > 0:
    print("It's a positive error number \(n)")
case let .Number(n) where n < 0:
    print("It's a negative error number \(n)")
case .Number(0):
    print("It's a zero error number")
default:break
}

switch err {
case .Number(1..<Int.max):
    print("It's a positive error number")
case .Number(Int.min...(-1)):
    print("It's a negative error number")
case .Number(0):
    print("It's a zero error number")
default:break
}

do {
    let i = ii
    switch i {
    case .none: break
    case .some(1):
        print("You have 1 thingy!")
    case .some(let n):
        print("You have \(n) thingies!")
    }
}

// new in Swift 2.0, case pattern syntax in an "if", "while", or "for"
// the tag follows the pattern after an equal sign
if case let .Number(n) = err {
    print("The error number is \(n)")
}
//if case let .Number(n) = err where n < 0 {
//    print("The negative error number is \(n)")
//}

// note that most patterns will actually work here; for example, we had this:
//        switch d {
//        case let nd as NoisyDog:
//            nd.beQuiet()
// you can rewrite like this:
do {
    if case let nd as NoisyDog = d {
        nd.beQuiet()
    }
}
// however, _that_ would be pointless, because there is already syntax for expressing that

switch i {
case 1,3,5,7,9:
    print("You have a small odd number of thingies.")
case 2,4,6,8,10:
    print("You have a small even number of thingies.")
default:
    print("You have too many thingies for me to count.")
}

do {
    let i = iii
    switch i {
    case is Int, is Double:
        print("It's some kind of number.")
    default:
        print("I don't know what it is.")
    }
}

switch pep {
case "Manny": fallthrough
case "Moe": fallthrough
case "Jack":
    print("\(pep) is a Pep boy")
default:
    print("I don't know who \(pep) is")
}

class ViewController: UIViewController {
    
    var navbar = UINavigationBar()
    var toolbar = UIToolbar()
    var progress = 0.0
    var d : Dog = NoisyDog()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // and the inverse
        do {
            guard case let .Number(n) = err else {return}
            print("not to worry, it's a number: \(n)")
        }
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(notificationArrived), name: NSNotification.Name(rawValue:  "test"), object: nil)
        nc.post(name: NSNotification.Name(rawValue:  "test"), object: self, userInfo: ["junk":"nonsense"])
        nc.post(name: NSNotification.Name(rawValue:  "test"), object: self, userInfo: ["progress":"nonsense"])
        nc.post(name: NSNotification.Name(rawValue:  "test"), object: self, userInfo: ["progress":"3"])
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        switch true {
        case bar === self.navbar:  return .topAttached
        case bar === self.toolbar: return .bottom
        default:
            return .any
        }
    }
    
    func notificationArrived(n:NSNotification) {
        switch n.userInfo?["progress"] {
        case let prog as Double:
            self.progress = prog
        default:break
        }

        // but that seems a bit forced, since why wouldn't you just say:
        if let prog = n.userInfo?["progress"] as? Double {
            self.progress = prog
        }
    }
}

// There can also be range matching
let count = 3_000_000_000_000
let countedThings = "stars"
switch count {
case 0...9:
    ("a few")
case 10...10_000:
    ("many")
default:
    ("a lot of")
}

// Use tuples
let coord = (1,1)
switch coord {
case (0,0):
    ("Origin")
case (_, 0):
    ("x axis")
case (0, _):
    ("y axis")
case (-2...2, -3...3):
    ("within boundries")
default:
    ("out of bounds")
}

// Value binding: Assign temp values to variables inside the cases.
let anotherPoint = (0, 0)
var position = ""
switch anotherPoint {
case(0,0):
    position = "原点"
case (let x, 0):
    position = "on the x-axis with an x value of \(x)" //(\(anotherPoint.0),0 位于x轴上)
case (0, let y):
    position = "on the y-axis with a y value of \(y)"
case (0...Int.max,0...Int.max):
    position = "第一象限"
case let (z, w): //This acts as the default case. Since it is only assigning a tuple, any value matches.
    ("somewhere else at (\(z), \(w))") //相当于 default:break
}

switch anotherPoint {
case let (x, y) where x == y:
    ("x = y")
default:
    break
}

var point1 = (x: 1,y: -1)
var position1 = ""
switch point1 {
case(0,0):
    position1 = "原点"
case(var a,0):
    position1 = "(\(a),0 位于x轴上)"
case var (x,y) where x > 0 && y > 0: //条件值绑定
    position1 = "第一象限"
default:
    break
}

// The fallthrough line forces the switch statement to fall into the default case after a previous case.
switch anotherPoint {
case let (x, y) where x == y:
    ("x = y")
    fallthrough
default:
    (" are equal")
}

// Nesting while, for and switches can be confusing sometimes
// Use labels to better use the break and continue statements
master: while true {
    loop: for rats in 1...5{
        continue master
    }
}

let num1 = 5
var desc = "\(num1)是"
switch num1 {
case 2,3,5,7:
    desc = "质数,而且还是"
fallthrough //=break
case 4,6,8:
    desc = "合数"
default:
    desc += "整数"
}

//: [Next](@next)
