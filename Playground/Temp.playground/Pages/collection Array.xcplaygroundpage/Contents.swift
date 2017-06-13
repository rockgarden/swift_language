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
    if [1, 2, 3].elementsEqual([i1, i2, i3]) { // they are equal!
        ("equal")
    }
    let nd1 = NoisyDog()
    let d1 = nd1 as Dog
    let nd2 = NoisyDog()
    let d2 = nd2 as Dog
    // TODO: elementsEqual 处理类
//    if [d1, d2].elementsEqual([nd1, nd2], by: { (_, _) -> Bool in
//    })  { // they are equal!
//        ("equal")
//    }
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
        let arr2 = arr.suffix(from: 1)
        let arr3 = arr.prefix(upTo: 1)
        let arr4 = arr.prefix(through: 1)
    }
    do {
        let arr = [1, 2, 3]
        var r = arr.indices
        let newStartIndex = r.endIndex - 2
        let arr2 = arr[newStartIndex] // [2,3]
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
    let ix = arr.index(of: 2) // *** Optional wrapping 1
    let aviary = [Bird(name: "Tweety"), Bird(name: "Flappy"), Bird(name: "Lady")]
    let ix2 = aviary.index { $0.name.characters.count < 5 }
    print(ix2 as Any)
    do {
        let ok = arr.starts(with: [1, 2])
        let ok2 = arr.starts(with: [1, 2]) { $0 == $1 } // ***
        let ok3 = arr.starts(with:[1, 2], by: == ) // ***
        let ok4 = arr.starts(with: [1, 2])
        let ok5 = arr.starts(with: 1...2)
        let ok6 = arr.starts(with: [1, -2]) { abs($0) == abs($1) }
    }
}

do {
    let arr = [3, 1, -2]
    let min = arr.min() //.minElement() // *** -2
    let min2 = arr.min { abs($0) < abs($1) }
    (min2)
}

do {
    var arr = [1, 2, 3]
    arr.append(4)
    arr.append(contentsOf:[5, 6])
    arr.append(contentsOf:7...8) // arr is now [1,2,3,4,5,6,7,8]
    let arr2 = arr + [4] // arr2 is now [1,2,3,4]
    var arr3 = [1, 2, 3]
    arr3 += [4] // arr3 is now [1,2,3,4]
}

do {
    var arr = [1, 2, 3]
    arr.insert(4, at: 1)
    arr.insert(contentsOf:[10, 9, 8], at: 1)
    let i = arr.remove(at:3)
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
    let arr2 = arr.joined(separator:[10, 11]) // [1, 2, 10, 11, 3, 4, 10, 11, 5, 6]
    let arr3 = arr.joined(separator:[]) // [1, 2, 3, 4, 5, 6]
    let arr4 = arr.flatMap { $0 } // new in Swift 1.2
    let arr5 = Array(arr.joined()) // new in Xcode 7 beta 6
}

do {
    var arr = [4, 3, 5, 2, 6, 1]
    arr.sort()
    arr.sort { $0 > $1 } // *** [1, 2, 3, 4, 5, 6]
    arr = [4, 3, 5, 2, 6, 1]
    arr.sort(by:>) // *** [1, 2, 3, 4, 5, 6]

}

do {
    let arr = [1, 2, 3, 4, 5, 6]
    let arr2 = arr.split { $0 % 2 == 0 } // split at evens: [[1], [3], [5]]
    (arr2)
}

do {
    let arr = [[1, 2], [3, 4], [5, 6]]
    let flat = arr.reduce([], +) // [1, 2, 3, 4, 5, 6]
    let arr2 = [[1, 2], [3, 4], [5, 6], 7] as [Any]
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
            let options = String.CompareOptions.caseInsensitive
            let found = $0.range(of: target, options: options, range: nil, locale: nil) //rangeOfString(target, options: options)
            return (found != nil)
        }
        }.filter { $0.count > 0 }
    (arr2)
}

do {
    var arr = ["Manny", "Moe", "Jack"]
    // let ss = arr.componentsJoinedByString(", ") // compile error
    let s = (arr as NSArray).componentsJoined(by:", ")
    let arr2 = NSMutableArray(array: arr)
    arr2.remove("Moe")
    arr = arr2 as NSArray as! [String]
}

do {
    let arr = [String?]()
    // let arr2 = arr.map{if $0 == nil {return NSNull()} else {return $0!}} // compile error
    // let arr2 = arr.map{s -> AnyObject in if s == nil {return NSNull()} else {return s!}}
    let arr2 = arr.map {
        s -> Any in
        if s == nil {
            return NSNull()
        } else {
            return s! }
    }
}

do {
    let arr = UIFont.familyNames.map {
        UIFont.fontNames(forFamilyName: $0)
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
    (nsarr.object(at:0))
    let arr2 = ["howdy", Dog()] as [Any]
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
            let arrNSValues = arrCGPoints.map { NSValue(cgPoint: $0) }
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
