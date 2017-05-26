//: [Previous](@previous)
import UIKit

do {
    var movenda = [1, 2, 3]
    var movenda2 = [1, 2, 3]
    do {
        while movenda.count > 0 {
            let p = movenda.removeLast()
        }
    }
    do {
        while let p = movenda2.popLast() { }
    }
}

do {
    enum Error {
        case Number(Int)
        case Message(String)
        case Fatal
    }
    do {
        let arr: [Error] = [
            .Message("ouch"), .Message("yipes"), .Number(10),
            .Number(-1), .Fatal
        ]
        var i = 0
        // removed use of i++, deprecated in Swift 2.2, to be removed in Swift 3
        while case let .Message(message) = arr[i] {
            i = i.successor()
            (message)
        }
        (arr)
    }
    do {
        let arr: [Error] = [
            .Message("ouch"), .Message("yipes"), .Number(10),
            .Number(-1), .Fatal
        ]
        for case let .Number(i) in arr {
            (i) // 10, -1
        }
    }
}

do {
    for i in 1...5 {
        (i)
    }
}

do {
    for var i in 1...5 {
        // removed use of i++, deprecated in Swift 2.2, to be removed in Swift 3
        i = i + 1
        (i)
    }
}

do {
    var g = (1...5).generate()
    while let i = g.next() {
        (i)
    }
}

do {
    class Pep: NSObject {
        let boys = ["Manny", "Moe", "Jack"]
    }
    do {
        let p = Pep()
        for boy in p.boys { // boys() doesn't provide type info
            let s = "One pep boy is " + boy
            (s)
        }
    }
}

do {
    var boardView = UIView()
    var tiles: [UIView] = []
    var centers: [CGPoint] = []
    do {
        for v in boardView.subviews {
            v.removeFromSuperview()
        }
    }
    do {
        for (i, v) in tiles.enumerate() {
            v.center = centers[i]
        }
    }
}

do {
    for i in 0...10 where i % 2 == 0 { // new in Swift 2.0
        (i)
    }
}

do {
    for i in 10.stride(through: 0, by: -2) {
        (i) // 10, 8, 6, 4, 2, 0
    }
}

do {
    let range = (0...10).reverse().filter { $0 % 2 == 0 }
    for i in range {
        (i) // 10, 8, 6, 4, 2, 0
    }
}

do {
    let arr1 = ["CA", "MD", "NY", "AZ"]
    let arr2 = ["California", "Maryland", "New York"]
    var d = [String: String]()
    for (s1, s2) in zip(arr1, arr2) {
        d[s1] = s2
    }
    (d) // now d is ["MD": "Maryland", "NY": "New York", "CA": "California"]
}

// here's one workaround
do {
    var values = [0.0]
    var direction = 1.0
    for i in 20.stride(to: 60, by: 5) {
        values.append(direction * M_PI / Double(i))
        direction *= -1
    }
}

// this is Swiftier and tighter, but a lot harder to understand
do {
    var values = [0.0]
    for (ix, i) in 20.stride(to: 60, by: 5).enumerate() {
        values.append((ix % 2 == 1 ? -1.0: 1.0) * M_PI / Double(i))
    }
    (values)
}

do {
    for i in 1...5 {
        for j in 1...5 {
            ("\(i), \(j);")
            break
        }
    }
    outer: for i in 1...5 {
        for j in 1...5 {
            ("\(i), \(j);")
            break outer
        }
    }
}

do { // new in 2.0, you can break to an "if" or "do"
    test: if true {
        for i in 1...5 {
            for j in 1...5 {
                ("\(i), \(j);")
                break test
            }
        }
    }
}

test2: do {
    // new in 2.0, you can break from within an "if", but only a label break
    var ok: Bool { return true }
    if ok {
        ("step one")
        break test2
    }
    ("step two")
}

do {
    let tvc = UITableViewCell()
    let subview1 = UIView()
    let subview2 = UITextField()
    tvc.addSubview(subview1)
    subview1.addSubview(subview2)
    let textField = subview2
    var v: UIView = textField
    repeat { v = v.superview! } while !(v is UITableViewCell)
    if let c = v as? UITableViewCell {
        ("got it \(c)")
    } else {
        ("nope")
    }
}

do {
    let tvc = UITableViewCell()
    let subview1 = UIView()
    let subview2 = UITextField()
    tvc.addSubview(subview1)
    subview1.addSubview(subview2)
    let textField = subview2
    var v: UIView = textField
    // v = tvc // try this to prove that we can cycle up to the top safely
    while let vv = v.superview where !(vv is UITableViewCell) { v = vv }
    if let c = v.superview as? UITableViewCell {
        ("got it \(c)")
    } else {
        ("nope, but at least we didn't crash")
    }
}

//: [Next](@next)
