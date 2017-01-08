//: [Previous](@previous)
import UIKit

//: # Control Flow
//: ## For
// Index is implicitly declared 隐式声明
for index in 1...5 {
    ("Index is \(index)")
}
// In this case, we don't care about the value.
let base=3
let power=11
var answer=1
for _ in 1..<power { //下划线符号_代替循环中的变量,能够忽略具体的值,并且不对值进行访问
    answer *= base
}
// Use dictionary
let dictionary = ["one": 1, "two": 2, "three": 3]
for (numberName, numberValue) in dictionary {
    ("\(numberName) is \(numberValue)")
}
// Go through a string
var char = "e"
for char in "Yes".characters { //char != char
    ("\(char)")
}
// break标签: 仅用于for或swith
outer: for i in 0 ..< 5  {
    for j in 0 ..< 3 {
        if j == i {
            break outer
        }
    }
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
        case Albums:
            return "Albums"
        case Playlists:
            return "Playlists"
        case Podcasts:
            return "Podcasts"
        case Books:
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
var iii: AnyObject = 1
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
    let d : [NSObject:AnyObject] = [:]
    switch (d["size"], d["desc"]) {
    case let (size as Int, desc as String):
        print("You have size \(size) and it is \(desc)")
    default:break
    }
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
    case .None: break
    case .Some(1):
        print("You have 1 thingy!")
    case .Some(let n):
        print("You have \(n) thingies!")
    }
}

// new in Swift 2.0, case pattern syntax in an "if", "while", or "for"
// the tag follows the pattern after an equal sign
if case let .Number(n) = err {
    print("The error number is \(n)")
}
if case let .Number(n) = err where n < 0 {
    print("The negative error number is \(n)")
}

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
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(notificationArrived), name: "test", object: nil)
        nc.postNotificationName("test", object: self, userInfo: ["junk":"nonsense"])
        nc.postNotificationName("test", object: self, userInfo: ["progress":"nonsense"])
        nc.postNotificationName("test", object: self, userInfo: ["progress":3])
    }
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        switch true {
        case bar === self.navbar:  return .TopAttached
        case bar === self.toolbar: return .Bottom
        default:                   return .Any
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
