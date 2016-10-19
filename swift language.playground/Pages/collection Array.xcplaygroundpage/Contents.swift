//: [Previous](@previous)
import UIKit
import Foundation

protocol Flier { }
struct Bird : Flier {
    var name = "Tweety"
}
struct Insect : Flier { }
class Dog { }
class NoisyDog : Dog { }

do {
    var arr = [Int]()
    _ = arr
    arr = []
}

do {
    var arr: [Int] = []
    _ = arr
    arr = []
}

do {
    let dogs = [Dog(), NoisyDog()]
    let objs = [1, "howdy"]
//     let arrr = [Insect(), Bird()] // compile error
    let arr: [Flier] = [Insect(), Bird()]

    do {
        let arr2: [Flier] = [Insect()]
        // WARNING next line is legal (compiles) but you'll crash at runtime
        // can't use array-casting to cast down from protocol type to adopter type
        // let arr3 = arr2 as! [Insect]
        _ = arr2
    }

    do {
        let arr2: [Flier] = [Insect()]
        // instead of above, to cast down, must cast individual elements down
        let arr3 = arr2.map { $0 as! Insect }
    }

    let rs = Array(1...3)
    let chars = Array("howdy".characters)
    let kvs = Array(["hey": "ho", "nonny": "nonny no"])
    let strings: [String?] = Array(count: 100, repeatedValue: nil)
}

do {
    let arr: [Int?] = [1, 2, 3]
    // print(arr) // [Optional(1), Optional(2), Optional(3)]
}

do {
    let dog1: Dog = NoisyDog()
    let dog2: Dog = NoisyDog()
    let arr = [dog1, dog2]
    if arr is [NoisyDog] {
        ("yep") // meaning it can be cast down
    }
    let arr2 = arr as! [NoisyDog]
}

do {
    let dog1: Dog = NoisyDog()
    let dog2: Dog = NoisyDog()
    let dog3: Dog = Dog()
    let arr = [dog1, dog2]
    let arr2 = arr as? [NoisyDog] // Optional wrapping an array of NoisyDog
    let arr3 = [dog2, dog3]
    let arr4 = arr3 as? [NoisyDog] // nil
}

do {
    let i1 = 1
    let i2 = 2
    let i3 = 3
    if [1, 2, 3] == [i1, i2, i3] { // they are equal!
        ("equal")
    }
    let nd1 = NoisyDog()
    let d1 = nd1 as Dog
    let nd2 = NoisyDog()
    let d2 = nd2 as Dog
    if [d1, d2] == [nd1, nd2] { // they are equal!
        ("equal")
    }
}

do {
    var arr = [1, 2, 3]
    arr[1] = 4 // arr is now [1,4,3]
    arr
    arr[1..<2] = [7, 8] // arr is now [1,7,8,3]
    arr
    arr[1..<2] = [] // arr is now [1,8,3]
    arr
    arr[1..<1] = [10] // arr is now [1,10,8,3] (no element was removed!)
    arr
    let slice = arr[1..<2]
}

do {
    var arr = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    let i = arr[1][1] // 5
    arr[1][1] = 100
    arr
}

do {
    let arr = [1, 2, 3]
    (arr.first)
    (arr.last)
    let arr2 = arr[arr.count - 2...arr.count - 1] // [2,3]
    arr[1...2]
    let arr3 = arr.suffix(2) // [2,3]
    arr.suffix(1) // [2,3]
    let arr4 = arr.suffix(10) // [1,2,3] with no penalty

    // new in beta 6
    do {
        let arr2 = arr.suffixFrom(1)
        let arr3 = arr.prefixUpTo(1)
        let arr4 = arr.prefixThrough(1)
    }
    // let arr5 = arr[0..<10] // fatal error: Array index out of range
    do {
        let arr = [1, 2, 3]
        var r = arr.indices
        r.startIndex = r.endIndex - 2
        let arr2 = arr[r] // [2,3]
    }
}

do {
    let arr: [Int?] = [1, 2, 3]
    let i = arr.last // a double-wrapped Optional
}

do {
    let arr = [1, 2, 3]
    let ok = arr.contains(2) // ***
    let okk = arr.contains { $0 > 3 } // false
    let ix = arr.indexOf(2) // *** Optional wrapping 1
    let aviary = [Bird(name: "Tweety"), Bird(name: "Flappy"), Bird(name: "Lady")]
    let ix2 = aviary.indexOf { $0.name.characters.count < 5 }
    (ix2)
    do {
        let ok = arr.startsWith([1, 2])
        let ok2 = arr.startsWith([1, 2]) { $0 == $1 } // ***
        let ok3 = arr.startsWith([1, 2], isEquivalent: ==) // ***
        let ok4 = arr.startsWith([1, 2])
        let ok5 = arr.startsWith(1...2)
        let ok6 = arr.startsWith([1, -2]) { abs($0) == abs($1) }
    }
}

do {
    let arr = [3, 1, -2]
    let min = arr.minElement() // *** -2
    let min2 = arr.minElement { abs($0) < abs($1) }
    (min2)
}

do {
    var arr = [1, 2, 3]
    arr.append(4)
    arr.appendContentsOf([5, 6])
    arr.appendContentsOf(7...8) // arr is now [1,2,3,4,5,6,7,8]
    let arr2 = arr + [4] // arr2 is now [1,2,3,4]
    var arr3 = [1, 2, 3]
    arr3 += [4] // arr3 is now [1,2,3,4]
}

do {
    var arr = [1, 2, 3]
    arr.insert(4, atIndex: 1)
    arr.insertContentsOf([10, 9, 8], at: 1)
    let i = arr.removeAtIndex(3)
    let ii = arr.removeLast()
    let iii = arr.popLast()
    (arr)
    do {
        // let iiii = arr.popFirst() // not sure what happened to this
        var arrslice = arr[arr.indices] // is this weird or what
        let i = arrslice.popFirst()
        (arr) // untouched, of course
    }
    let arr2 = arr.dropFirst()
    let arr3 = arr.dropLast()
}

do {
    let arr = [[1, 2], [3, 4], [5, 6]]
    let arr2 = arr.joinWithSeparator([10, 11]) // [1, 2, 10, 11, 3, 4, 10, 11, 5, 6]
    let arr3 = arr.joinWithSeparator([]) // [1, 2, 3, 4, 5, 6]
    let arr4 = arr.flatMap { $0 } // new in Swift 1.2
    let arr5 = Array(arr.flatten()) // new in Xcode 7 beta 6
}

do {
    var arr = [4, 3, 5, 2, 6, 1]
    arr.sortInPlace()
    arr.sortInPlace { $0 > $1 } // *** [1, 2, 3, 4, 5, 6]
    arr = [4, 3, 5, 2, 6, 1]
    arr.sortInPlace(>) // *** [1, 2, 3, 4, 5, 6]

}

do {
    let arr = [1, 2, 3, 4, 5, 6]
    let arr2 = arr.split { $0 % 2 == 0 } // split at evens: [[1], [3], [5]]
    (arr2)
}

do {
    let pepboys = ["Manny", "Moe", "Jack"]
    for pepboy in pepboys {
        (pepboy) // prints Manny, then Moe, then Jack
    }
    for (ix, pepboy) in pepboys.enumerate() { // ***
        ("Pep boy \(ix) is \(pepboy)") // Pep boy 0 is Manny, etc.
    }
    let arr = [1, 2, 3]
    let arr2 = arr.map { $0 * 2 } // [2,4,6]
    let arr3 = arr.map { Double($0) } // [1.0, 2.0, 3.0]
    pepboys.forEach { print($0) } // prints Manny, then Moe, then Jack
    pepboys.enumerate().forEach { print("Pep boy \($0.0) is \($0.1)") }
    // pepboys.map(print) // no longer compiles
    let arr4 = pepboys.filter { $0.hasPrefix("M") } // [Manny, Moe]
    let arrr = [1, 4, 9, 13, 112]
    let sum = arrr.reduce(0) { $0 + $1 } // 139
    let sum2 = arrr.reduce(0, combine: +)
}

do {
    let arr = [[1, 2], [3, 4], [5, 6]]
    let flat = arr.reduce([], combine: +) // [1, 2, 3, 4, 5, 6]
    let arr2 = [[1, 2], [3, 4], [5, 6], 7]
    let arr3 = arr2.flatMap { $0 }
    print(arr3)
}

// flatMap has another use that I really should talk about:
// it unwraps Optionals safely while eliminating nils
do {
    let arr: [String?] = ["Manny", nil, nil, "Moe", nil, "Jack", nil]
    let arr2 = arr.flatMap { $0 }
    (arr2)
}

do {
    let arr = [["Manny", "Moe", "Jack"], ["Harpo", "Chico", "Groucho"]]
    let target = "m"
    let arr2 = arr.map {
        $0.filter {
            let options = NSStringCompareOptions.CaseInsensitiveSearch
            let found = $0.rangeOfString(target, options: options)
            return (found != nil)
        }
        }.filter { $0.count > 0 }
    (arr2)
}

do {
    var arr = ["Manny", "Moe", "Jack"]
    // let ss = arr.componentsJoinedByString(", ") // compile error
    let s = (arr as NSArray).componentsJoinedByString(", ")
    let arr2 = NSMutableArray(array: arr)
    arr2.removeObject("Moe")
    arr = arr2 as NSArray as! [String]
}

do {
    let arr = [String?]()
    // let arr2 = arr.map{if $0 == nil {return NSNull()} else {return $0!}} // compile error
    // let arr2 = arr.map{s -> AnyObject in if s == nil {return NSNull()} else {return s!}}
    let arr2: [AnyObject] = arr.map { if $0 == nil { return NSNull() } else { return $0! } }
}

do {
    let arr = UIFont.familyNames().map {
        UIFont.fontNamesForFamilyName($0)
    }
    (arr)
}

do {
    let arr = [AnyObject]()
    let arr2: [String] = arr.map {
        if $0 is String {
            return $0 as! String
        } else {
            return ""
        }
    }
    _ = arr2
}

do {
    // there seems to be some doubt now as to whether the medium of exchange...
    // ... is AnyObject or NSObject
    let s = "howdy" as NSObject
    let s2 = "howdy" as AnyObject
    let s3 = s as! String
    let s4 = s2 as! String
    let arr = [Dog()]
    let nsarr = arr as NSArray
    // there is no problem even if it is NOT an NSObject, so what's the big deal?
    (nsarr.objectAtIndex(0))
    let arr2 = ["howdy", Dog()]
    let nsarr2 = arr2 as NSArray
    (nsarr2)
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let arr = [UIBarButtonItem(), UIBarButtonItem()]
            self.navigationItem.leftBarButtonItems = arr
            self.navigationItem.setLeftBarButtonItems(arr, animated: true)
        }

        do {
            let arrCGPoints = [CGPoint]()
            // let arrr = arrCGPoints as NSArray // compiler stops you
            let arrNSValues = arrCGPoints.map { NSValue(CGPoint: $0) }
            let arr = arrNSValues as NSArray
            _ = arrNSValues
            _ = arr
        }
        
        do {
            let views = self.view.subviews
            _ = views
            // but you can still receive an untyped array
//            let p = Pep()
//            let boys = p.boys() as! [String]
//            print(boys)
//            let boys2 = p.boysGood() // it's already a [String]
//            print(boys2)
        }
    }
}

//: [Next](@next)
