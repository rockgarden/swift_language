//: [Previous](@previous)

import Foundation
import UIKit

class Dog : NSObject {
    var name : String
    init(_ name:String) {self.name = name}
}

do {
    let arr = ["hey"] as NSArray
    let ix = arr.index(of: "ho")
    if ix == NSNotFound {
        print("it wasn't found")
    }
}

do {
    let r = NSRange(location: 1, length: 3)
    print(r)
    let r2 = r.toRange()
    print(r2)
    // let r3 = Range(r)
    // print(r3)
}

do {
    let s = "hello"
    let r = s.range(of: "ha") // nil; an Optional wrapping a Swift Range
    if r == nil {
        print("it wasn't found")
    }
}

do {
    let s = "hello" as NSString
    let r = s.range(of: "ha") // an NSRange
    if r.location == NSNotFound {
        print("it wasn't found")
    }
}

do {
    let s = "hello"
    let s2 = s.capitalized // -[NSString capitalizedString]
    _ = s2
}

do {
    let s = "hello"
    // let s2 = s.substringToIndex(4) // compile error
    let s2 = s.substring(to: s.characters.index(s.startIndex, offsetBy: 4))
    let ss2 = (s as NSString).substring(to: 4)
    _ = s2
    _ = ss2
}

do {
    let s = "MyFile"
    let s2 = (s as NSString).appendingPathExtension("txt")
    // let s3 = s.stringByAppendingPathExtension("txt") // compile error

    print(s2)
}

do {
    let s = "hello"
    let ms = NSMutableString(string: s)
    ms.deleteCharacters(in: NSMakeRange(ms.length-1,1))
    let s2 = (ms as String) + "ion" // now s2 is a Swift String
    print(s2)
}

do {
    let s = NSMutableString(string:"hello world, go to hell")
    let r = try! NSRegularExpression(
        pattern: "\\bhell\\b",
        options: .caseInsensitive)
    r.replaceMatches(
        in: s, options: [], range: NSMakeRange(0,s.length),
        withTemplate: "heaven")
    print(s)
}

do {
    let greg = Calendar(identifier:Calendar.Identifier.gregorian)
    var comp = DateComponents()
    comp.year = 2016
    comp.month = 8
    comp.day = 10
    comp.hour = 15
    let d = greg.date(from: comp) // Optional wrapping NSDate
    if let d = d {
        print(d)
        print(d.description(with: Locale.current))
    }

}

do {
    let d = Date() // or whatever
    var comp = DateComponents()
    comp.month = 1
    let greg = Calendar(identifier:Calendar.Identifier.gregorian)
    let d2 = (greg as NSCalendar).date(byAdding: comp, to:d, options:[])
    _ = d2
}

do {
    let df = DateFormatter()
    let format = DateFormatter.dateFormat(
        fromTemplate: "dMMMMyyyyhmmaz", options:0, locale:Locale.current)
    df.dateFormat = format
    let s = df.string(from: Date()) // just now
    print(s)
}

do {
    let ud = UserDefaults.standard
    ud.set(0, forKey: "Score")
    ud.set(0, forKey: "Score")
    let n = 0 as NSNumber
    let n2 = NSNumber(value: 0 as Float)

    do {
        // I regard these as bugs
        // let n = UInt32(0) as NSNumber // compile error
        // let i = n as! UInt32 // "always fails"
    }

    let dec1 = NSDecimalNumber(value: 4.0 as Float)
    let dec2 = NSDecimalNumber(value: 5.0 as Float)
    let sum = dec1.adding(dec2) // 9.0
    _ = n
    _ = n2
    _ = sum
}

do {
    // perhaps the first example is more convincing if we use a variable
    let ud = UserDefaults.standard
    let i = 0
    ud.set(i, forKey: "Score")
    ud.set(i, forKey: "Score")

}

do {
    let ud = UserDefaults.standard
    let c = UIColor.blue
    let cdata = NSKeyedArchiver.archivedData(withRootObject: c)
    ud.set(cdata, forKey: "myColor")
}

do {
    let n1 = NSNumber(value: 1 as Int)
    let n2 = NSNumber(value: 2 as Int)
    let n3 = NSNumber(value: 3 as Int)
    let ok = n2 == 2 // true
    let ok2 = n2 == NSNumber(value: 2 as Int) // true
    let ix = [n1,n2,n3].index(of: 2) // Optional wrapping 1

    // let ok3 = n1 < n2 // compile error
    let ok4 = n1.compare(n2) == .orderedAscending // true
    print(ok)
    print(ok2)
    print(ix)
    print(ok4)
}

do {
    let d1 = Dog("Fido")
    let d2 = Dog("Fido")
    let ok = d1 == d2 // false
    print(ok)
}

do {
    let arr = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
    let ixs = NSMutableIndexSet()
    ixs.add(in: NSRange(location: 1, length: 4))
    ixs.add(in: NSRange(location: 8, length: 3))
    let arr2 = (arr as NSArray).objects(at: ixs as IndexSet)
    print(arr2)
}

do {
    let marr = NSMutableArray()
    marr.add(1) // an NSNumber
    marr.add(2) // an NSNumber
    let arr = marr as NSArray as! [Int]

    let pep = ["Manny", "Moe", "Jack"] as NSArray
    /// Swift 3 indexesOfObjects has given a default value for the parameter options, which has made a simple call like .indexesOfObjects (passingTest: ...) ambiguous.
    let ems = pep.objects(
        at: pep.indexesOfObjects(options: [], passingTest: {
            obj, idx, stop in
            return (obj as! NSString).range(
                of: "m", options:.caseInsensitive
                ).location == 0
        })
    ) // ["Manny", "Moe"]
    _ = arr
    print(ems)

    /// using Swift's collection methods, rather than using an NSArrays method:
//    let swift_pep = ["Manny", "Moe", "Jack"]
//    let swift_ems = swift_pep.enumerated().lazy
//        .filter {(a, b) in
//            //...
//        }.map{$0.offset}
}



//: [Next](@next)
