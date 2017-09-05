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
    var ixs = IndexSet()
    ixs.insert(integersIn: Range(1...4))
    ixs.insert(integersIn: Range(8...10))
    let arr2 = (arr as NSArray).objects(at:ixs)
    print(arr2)
}

do {
    let marr = NSMutableArray()
    marr.add(1) //NSNumber
    marr.add(2) //NSNumber
    print(type(of: marr[0]))
    let arr = marr as NSArray as! [Int]
    let arr2 = marr as! [Int] // warns, but it _looks_ like it succeeds...
    print(arr2)
    print(type(of: arr2[0]))

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

    let arr3 = marr.copy()
    _ = arr3

    /// using Swift's collection methods, rather than using an NSArrays method:
//    let swift_pep = ["Manny", "Moe", "Jack"]
//    let swift_ems = swift_pep.enumerated().lazy
//        .filter {(a, b) in
//            //...
//        }.map{$0.offset}
}

do {
    let oldButtonCenter = CGPoint.zero
    let button = UIButton(type:.system)
    do {
        // let obj = NSObject().copy(with:nil) // compile error
        let s = "hello".copy()
        _ = s
        let s2 = ("hello" as NSString).copy(with: nil)
        _ = s2
    }

    do {
        let arr = ["hey"] as NSArray
        let ix = arr.index(of:"ho")
        if ix == NSNotFound {
            print("it wasn't found")
        }
    }

    do {
        // let rr = NSRange(1...3)
        let r = NSRange(Range(1...3))
        print(r)
        debugPrint(r) // that didn't help
        print(NSStringFromRange(r))
        let r2 = r.toRange()
        print(r2)
        // let r3 = Range(r)
        // print(r3)
    }

    do {
        let s = "hello"
        let r = s.range(of:"ha") // nil; an Optional wrapping a Swift Range
        if r == nil {
            print("it wasn't found")
        }
    }

    do {
        let s = "hello" as NSString
        let r = s.range(of:"ha") // an NSRange
        if r.location == NSNotFound {
            print("it wasn't found")
        }
    }

    do {
        let s = "hello"
        let s2 = s.capitalized // -[NSString capitalizedString]
    }

    do {
        let s = "hello"
        let ix = "hello".startIndex
        // let s2a = s.substringToIndex(4) // compile error
        let s2 = s.substring(to:s.index(s.startIndex, offsetBy:4))
        let ss2 = (s as NSString).substring(to:4)
    }

    do {
        let s = "MyFile"
        let s2 = (s as NSString).appendingPathExtension("txt")
        // let s3 = s.stringByAppendingPathExtension("txt") // compile error
    }

    do {
        let s = "hello"
        let ms = NSMutableString(string:s)
        ms.deleteCharacters(in: NSRange(location:ms.length-1,length:1))
        let s2 = (ms as String) + "ion" // now s2 is a Swift String
        print(s2)
    }

    do {
        let s = NSMutableString(string:"hello world, go to hell")
        let r = try! NSRegularExpression(
            pattern: "\\bhell\\b",
            options: .caseInsensitive)
        r.replaceMatches(
            in: s, range: NSRange(location:0, length:s.length),
            withTemplate: "heaven")
        // I loooove being able to omit the options: parameter!
        print(s)
    }

    do {
        let greg = Calendar(identifier:.gregorian)
        let comp = DateComponents(calendar: greg, year: 2016, month: 8, day: 10, hour: 15)
        let d = comp.date // Optional wrapping Date
        if let d = d {
            print(d)
            print(d.description(with:Locale.current))
        }

    }

    do {
        let d = Date() // or whatever
        let comp = DateComponents(month:1)
        let greg = Calendar(identifier:.gregorian)
        let d2 = greg.date(byAdding: comp, to:d) // Optional wrapping Date
        print("one month from now:", d2)
    }

    do {
        let greg = Calendar(identifier:.gregorian)
        let d1 = DateComponents(calendar: greg,
                                year: 2016, month: 1, day: 1, hour: 0).date!
        let d2 = DateComponents(calendar: greg,
                                year: 2016, month: 8, day: 10, hour: 15).date!
        let di = DateInterval(start: d1, end: d2)
        if di.contains(Date()) { // are we currently between those two dates?
            print("yep")
        }
    }

    do {
        let df = DateFormatter()
        let format = DateFormatter.dateFormat(
            fromTemplate:"dMMMMyyyyhmmaz", options:0,
            locale:Locale.current)
        df.dateFormat = format
        let s = df.string(from: Date()) // just now
        print(s)
    }

    do {
        UserDefaults.standard.set(1, forKey: "Score")
        // wow - unable to call setObject:forKey: while supplying a number!
        // ud.set(object: 0, forKey: "Score")
        let n = 1 as NSNumber
        // similarly, unable to call NSNumber initWithFloat:
        // instead we just supply a float and let it disambiguate
        let i : UInt8 = 1
        // let n2 = i as NSNumber // not bridged
        let n2 = NSNumber(value:i)

        do {
            // I regard these as bugs
            // let n = UInt32(0) as NSNumber // compile error
            // let i = n as! UInt32 // "always fails"
        }

        let dec1 = NSDecimalNumber(value: 4.0)
        let dec2 = NSDecimalNumber(value: 5.0)
        let sum = dec1.adding(dec2) // 9.0
    }

    do {
        // perhaps the first example is more convincing if we use a variable
        let ud = UserDefaults.standard
        let i = 0
        ud.set(i, forKey: "Score")
        // ud.setObject(i, forKey: "Score")
    }

    do {
        let goal = CGPoint.zero // dummy
        let ba = CABasicAnimation(keyPath:"position")
        ba.duration = 10
        ba.fromValue = NSValue(cgPoint: oldButtonCenter)
        ba.toValue = NSValue(cgPoint:goal)
        button.layer.add(ba, forKey:nil)
    }

    do {
        let anim = CAKeyframeAnimation(keyPath:"position") // dummy
        let (oldP,p1,p2,newP) = (CGPoint.zero,CGPoint.zero,CGPoint.zero,CGPoint.zero) // dummy
        anim.values = [oldP,p1,p2,newP].map {NSValue(cgPoint:$0)}
    }

    do {
        let ud = UserDefaults.standard
        let c = UIColor.blue
        let cdata = NSKeyedArchiver.archivedData(withRootObject:c)
        ud.set(cdata, forKey: "myColor")
    }

    do {
        let m1 = Measurement(value:5, unit: UnitLength.miles)
        let m2 = Measurement(value:6, unit: UnitLength.kilometers)
        let total = m1 + m2
        print(total)
        let totalFeet = total.converted(to: .feet).value // 46084.9737532808
        print(totalFeet)
        let mf = MeasurementFormatter()
        let s = mf.string(from:total) // "8.728 mi"
        print(s)
    }

    do {
        let n1 = NSNumber(value:1)
        let n2 = NSNumber(value:2)
        let n3 = NSNumber(value:3)
        let ok = n2 == 2 // true
        let ok2 = n2 == NSNumber(value:2) // true
        let ix = [n1,n2,n3].index(of:2) // Optional wrapping 1

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
        let arr = ["zero", "one", "two", "three", "four", "five",
                   "six", "seven", "eight", "nine", "ten"]
        var ixs = IndexSet()
        ixs.insert(integersIn: Range(1...4))
        ixs.insert(integersIn: Range(8...10))
        let arr2 = (arr as NSArray).objects(at:ixs)
        print(arr2)
    }

    do {
        let marr = NSMutableArray()
        marr.add(1) // an NSNumber
        marr.add(1) // an NSNumber
        print(type(of:marr[0]))
        let arr = marr as NSArray as! [Int]
        let arr2 = marr as! [Int] // warns, but it _looks_ like it succeeds...
        print(arr2)
        print(type(of:arr2[0]))

        let pep = ["Manny", "Moe", "Jack"] as NSArray

        // filed a bug: "ambiguous" without the []

        let ems = pep.objects(
            at: pep.indexesOfObjects(options:[]) {
                (obj, idx, stop) -> Bool in
                return (obj as! NSString).range(
                    of: "m", options:.caseInsensitive
                    ).location == 0
            }
        ) // ["Manny", "Moe"]
        print(ems)

        let arr3 = marr.copy()
    }

}

//: [Next](@next)
