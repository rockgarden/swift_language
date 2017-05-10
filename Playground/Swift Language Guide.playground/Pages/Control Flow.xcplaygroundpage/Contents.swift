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




//: ## Switches

// No need for break, and every case must have some code.
let someChar = "e"
switch someChar {
case "a", "e", "i", "o", "u":
    ("\(someChar) is a vowel")
default:
    ("\(someChar) is a consonant")
}

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
