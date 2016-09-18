//: [Previous](@previous)
import UIKit
//: # Enum
/*:
 Definition of an Enum
 In this case, there's no default value for the enum members.
 */
enum CompassPoint {
    case North
    case South
    case East
    case West
}
//: 等效于
enum CompassPointA {
    case North, South, East, West
}

var someEnum = CompassPoint.East
var someEnumA = CompassPointA.East
/*: 
 一旦类型是已知的，可以省略多次赋值
 Once the type is known, it can be omitted for reassignment.
 */
someEnum = .West
("This is the enum: \(someEnum)")
(someEnum == .West) ? ("Equal") : ("Not Equal")
switch(someEnum){
case .North:
    CompassPoint.North
case .South:
    CompassPoint.South
case .East:
    CompassPoint.East
case .West:
    CompassPoint.West
}
/*:
 显式定义枚举成员
 - Defines an enum with members with explicit types.
 */
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}
var newEnum = Barcode.QRCode("162534")
newEnum = Barcode.QRCode("692438")
/*:
 在这种情况下,枚举与原始值的定义必须是独一无二的
 In this case, the enum is defined with raw values.
 They must be unique
 */
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}
let asciiCode = ASCIIControlCharacter.Tab
("Code is \(asciiCode.rawValue)")
//: In this case, since it's not guaranteed to find an enum for the specified rawValue, the initializer returns an optional
if let lineFeed = ASCIIControlCharacter(rawValue: "\r") {
    //Do something
    lineFeed
}
do {
    enum Filter : String {
        case Albums = "Albums"
        case Playlists = "Playlists"
        case Podcasts = "Podcasts"
        case Books = "Audiobooks"
        static var cases : [Filter] = [Albums, Playlists, Podcasts, Books]
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
            var ix = Filter.cases.indexOf(self)!
            ix = (ix + 1) % 4
            self = Filter.cases[ix]
        }
        
    }
    let type1 = Filter.Albums
    let type2 = Filter(rawValue: "Playlists")! //???: init
    let type3 = Filter(2) // .Podcasts
    let type4 = Filter(5) // nil
    let type5 = Filter("Playlists")
    (type5.description)
    // type5.s = "test" // compile error
    var type6 = type5
    type6.s = "test" //no set, so still type5
    (type6.s)
    var type7 = Filter.Books
    type7.advance() // Filter.Albums, 返回0 = Albums
    (type7)
}
//: 赋值
enum season: Character{
    case spring="春"
    case summer="夏"
    case fall="秋"
    case winter="冬"
}
//: 赋值推断
enum weekday: Int {
    case mon, tur, wen=3, thur, fri, sat, sum //杖举值的类型为整型时才可
}
weekday.sum.rawValue //获取原始值

//: 取值
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

//: 关联值
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

var s : String? = "howdy"
switch s {
case .Some(let theString):
    (theString) // howdy
case .None:
    ("it's nil")
}
//: # Example
enum ShapeMaker {
    case Rectangle
    case Ellipse
    case Diamond
    func drawShape (p: CGMutablePath, inRect r : CGRect) -> () {
        switch self {
        case Rectangle:
            CGPathAddRect(p, nil, r)
        case Ellipse:
            CGPathAddEllipseInRect(p, nil, r)
        case Diamond:
            CGPathMoveToPoint(p, nil, r.minX, r.midY)
            CGPathAddLineToPoint(p, nil, r.midX, r.minY)
            CGPathAddLineToPoint(p, nil, r.maxX, r.midY)
            CGPathAddLineToPoint(p, nil, r.midX, r.maxY)
            CGPathCloseSubpath(p)
        }
    }
}
//: [Next](@next)
