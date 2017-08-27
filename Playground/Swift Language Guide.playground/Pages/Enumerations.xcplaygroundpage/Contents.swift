//: [Previous](@previous)
import UIKit
//: # Enum
/*:
 An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.
 */
//: # Enumeration Syntax
enum SomeEnumeration {
    // enumeration definition goes here
}

enum CompassPoint {
    case north
    case south
    case east
    case west
}

do {
    /// 使用
    let someEnum = CompassPoint.west
    ("This is the enum: \(someEnum)")
    (someEnum == .west) ? ("Equal") : ("Not Equal")
    switch(someEnum){
    case .north:
        CompassPoint.north
    case .south:
        CompassPoint.south
    case .east:
        CompassPoint.east
    case .west:
        CompassPoint.west
    }
}
/*
 - NOTE:
 Unlike C and Objective-C, Swift enumeration cases are not assigned a default integer value when they are created. In the CompassPoint example above, north, south, east and west do not implicitly equal 0, 1, 2 and 3. Instead, the different enumeration cases are fully-fledged values in their own right, with an explicitly-defined type of CompassPoint.
 */
//: Multiple cases can appear on a single line, separated by commas:
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
do {
    var directionToHead = CompassPoint.west
    directionToHead = .east
}


//: # Matching Enumeration Values with a Switch Statement
do {
    var directionToHead = CompassPoint.west
    directionToHead = .south
    switch directionToHead {
    case .north:
        print("Lots of planets have a north")
    case .south:
        print("Watch out for penguins")
    case .east:
        print("Where the sun rises")
    case .west:
        print("Where the skies are blue")
    }
}
do {
    /// When it is not appropriate to provide a case for every enumeration case, you can provide a default case to cover any cases that are not addressed explicitly
    let somePlanet = Planet.earth
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
}
do {
    do {
        enum Shape {
            case rectangle
            case ellipse
            case diamond
            func addShape (to p: CGMutablePath, in r : CGRect) -> () {
                switch self {
                case .rectangle:
                    p.addRect(r)
                case .ellipse:
                    p.addEllipse(in:r)
                case .diamond:
                    p.move(to: CGPoint(x:r.minX, y:r.midY))
                    p.addLine(to: CGPoint(x: r.midX, y: r.minY))
                    p.addLine(to: CGPoint(x: r.maxX, y: r.midY))
                    p.addLine(to: CGPoint(x: r.midX, y: r.maxY))
                    p.closeSubpath()
                }
            }
        }
    }
}
//: # Associated Values 关联值
/*:
 显式定义枚举成员
 - Defines an enum with members with explicit types.
 */
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
//: mean “Define an enumeration type called Barcode, which can take either a value of upc with an associated value of type (Int, Int, Int, Int), or a value of qrCode with an associated value of type String.”
do {
    /// New barcodes can then be created using either type
    var productBarcode = Barcode.upc(8, 85909, 51226, 3)
    /// assigned a different type of barcode
    productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

    switch productBarcode {
    case .upc(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case .qrCode(let productCode):
        print("QR code: \(productCode).")
    }
}
do {
    enum planet {
        case earth(weight: Double, name: String)
        case mars(density: Double, name: String, weight: Double)
        case venus(Double, String)
        case saturn
        case neptune
    }
    var p1 = planet.earth(weight: 1.0, name: "地球")
    var p3 = planet.mars(density: 3.95, name: "火星", weight: 0.1)
    var p2: planet = .venus(3.95, "水星")

    switch(p3){
    case planet.earth(var weight, var name):
        ("earth \(weight)")
    case let planet.mars(density:d, name:n, weight:w):
        ("\(n)\(w)\(d)")
    default:
        break
    }

    enum Error2 {
        case Number(Int)
        case Message(String)
        case Fatal(n:Int, s:String)
    }
    do {
        let fatalMaker = Error2.Fatal
        let err = fatalMaker(n:-1000, s:"Unbelievably bad error")
        _ = err
    }
}


//: # Raw Values 原始值
/*:
 在这种情况下,枚举与原始值的定义必须是独一无二的
 In this case, the enum is defined with raw values.
 They must be unique.
 */
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
do {
    let asciiCode = ASCIIControlCharacter.lineFeed
    ("Code is \(asciiCode.rawValue)")
    /// In this case, since it's not guaranteed to find an enum for the specified rawValue, the initializer returns an optional
    if let lineFeed = ASCIIControlCharacter(rawValue: "\r") {
        //Do something
        lineFeed
    }
}
/*
 - NOTE:
 Raw values are not the same as associated values. Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above. The raw value for a particular enumeration case is always the same. Associated values are set when you create a new constant or variable based on one of the enumeration’s cases, and can be different each time you do so.
 原始值与关联值不同。 当您首次在代码中定义枚举时，原始值将设置为预填充值，如上面的三个ASCII代码。 特定枚举大小的原始值总是相同的。 当您基于枚举的一种情况创建新的常量或变量时，相关值将被设置，并且每次这样做都可能不同。
 */
do {
    /// 赋值
    enum season: Character{
        case spring="春"
        case summer="夏"
        case fall="秋"
        case winter="冬"
    }
    var mySeason = season(rawValue: "秋")
    if mySeason != nil {
        switch(mySeason!) {
        case .spring:
            season.spring
        case .summer:
            season.summer
        case .fall, .winter:
            season.fall
        }
    }
}

/*: 
 ## Implicitly Assigned Raw Values 隐式赋值原始值
 赋值推断
 */
do {
    /// with integer raw values to represent each planet’s order from the sun:
    enum Planet: Int {
        case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    }
    /// with string raw values to represent each direction’s name:
    enum CompassPoint: String {
        case north, south, east, west
    }
    /// 获取原始值
    let earthsOrder = Planet.earth.rawValue
    let sunsetDirection = CompassPoint.west.rawValue
}

//: ## Initializing from a Raw Value
do {
    enum Planet: Int {
        case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    }

    let possiblePlanet = Planet(rawValue: 7)
    /// possiblePlanet is of type Planet? and equals Planet.uranus

    /// eturned by the raw value initializer will be nil:
    let positionToFind = 11
    if let somePlanet = Planet(rawValue: positionToFind) {
        switch somePlanet {
        case .earth:
            print("Mostly harmless")
        default:
            print("Not a safe place for humans")
        }
    } else {
        print("There isn't a planet at position \(positionToFind)")
    }
}
/*
 - NOTE:
 The raw value initializer is a failable initializer, because not every raw value will return an enumeration case. 
 */

//: # Recursive Enumerations
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
do {
    /// can also write indirect before the beginning of the enumeration, to enable indirection for all of the enumeration’s cases that need it.
    indirect enum ArithmeticExpression {
        case number(Int)
        case addition(ArithmeticExpression, ArithmeticExpression)
        case multiplication(ArithmeticExpression, ArithmeticExpression)
    }
}
do {
    let five = ArithmeticExpression.number(5)
    let four = ArithmeticExpression.number(4)
    let sum = ArithmeticExpression.addition(five, four)
    let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

    func evaluate(_ expression: ArithmeticExpression) -> Int {
        switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            return evaluate(left) * evaluate(right)
        }
    }
    print(evaluate(product))
}


//: # Example
//: ## Initializers
import MediaPlayer
do {
    enum Filter : String {
        case albums = "Albums"
        case playlists = "Playlists"
        case podcasts = "Podcasts"
        case books = "Audiobooks"
        static var cases : [Filter] = [albums, playlists, podcasts, books]
        init!(_ ix: Int) {
            if !(0...3).contains(ix) {
                return nil
            }
            self = Filter.cases[ix]
        }
        init!(_ rawValue: String) {
            self.init(rawValue: rawValue)
        }
        var description : String { return self.rawValue }
        var s : String {
            get { return "howdy" }
            set {}
        }
        mutating func advance() {
            var ix = Filter.cases.index(of:self)!
            ix = (ix + 1) % 4
            self = Filter.cases[ix]
        }
        var query : MPMediaQuery {
            switch self {
            case .albums:
                return .albums()
            case .playlists:
                return .playlists()
            case .podcasts:
                return .podcasts()
            case .books:
                return .audiobooks()
            }
        }
    }

    let type1 = Filter.albums
    /// init Filter 若 rawValue 存在 则 fatal error: unexpectedly found nil while unwrapping an Optional value
    let type2 = Filter(rawValue: "Playlists")!
    let type3 = Filter(2) // .Podcasts
    let type4 = Filter(5) // nil
    let type5 = Filter("Playlists")

    type5?.description
    // type5.s = "test" // compile error
    var type6 = type5
    type6?.s = "test" //no set, so still type5
    (type6?.s)
    var type7 = Filter.books
    type7.advance() // Filter.Albums, 返回0 = Albums
    (type7)
}

do {
    var s : String? = "howdy"
    switch s {
    case .some(let theString):
        (theString)
    case .none:
        ("it's nil")
    }
}


//: [Next](@next)
