//: [Previous](@previous)
import UIKit

do {
    let greeting = "hello"
    let leftTripleArrow = "\u{21DA}"
    let n = 5
    let s = "You have \(n) widgets."
}

do {
    let m = 4
    let n = 5
    let s = "You have \(m + n) widgets."
}

do {
    let ud = NSUserDefaults.standardUserDefaults()
    let s0 = "You have \(ud.integerForKey("widgets")) widgets."
    let n = ud.integerForKey("widgets")
    let s = "You have \(n) widgets."
}

do {
    let s = "hello"
    let s2 = " world"
    let greeting = s + s2
}

do {
    var s = "hello"
    let s2 = " world"
    // "extend" has changed to "appendContentsOf"
    s.appendContentsOf(s2) // or: sss += sss2
}

do {
    let s = "hello"
    let s2 = "world"
    let space = " "
    // "join" has changed to "joinWithSeparator", which works the other way round
    let greeting = [s,s2].joinWithSeparator(space)
}

do {
    ("hello".hasPrefix("he"))
    ("hello".hasSuffix("lo"))
}

do {
    let i = 7
    let s = String(i)
}

do {
    let i = 31
    let s = String(i, radix: 16) // "1f"
}

do {
    let s = "31"
    let i = Int(s) // Optional(31)
}

do {
    let s = "1f"
    let i = Int(s, radix:16) // Optional(31)
}

do {
    let s = "31.34"
    let i = Int(s) // nil because it wasn't an Int; you don't get magical double-coercion
}

do {
    let s = "hello"
    let length = s.characters.count // 5
}

do {
    let s = "hello"
    for c in s.characters {
        // get each Character
    }
}

func flag(country: String) -> String {
    let base : UInt32 = 127397
    var s = ""
    for v in country.unicodeScalars {
        s.append(UnicodeScalar(base + v.value))
    }
    return s
}
do {
    let s = "\u{BF}Qui\u{E9}n?"
    for i in s.utf8 {
        (i) // 194, 191, 81, 117, 105, 195, 169, 110, 63
    }
    for i in s.utf16 {
        (i) // 191, 81, 117, 105, 233, 110, 63
    }
    
    do {
        let s = flag("CH")
    }
}

do {
    let s = "hello world"
    let s2 = s.capitalizedString // "Hello World"
}

do {
    let s = "hello"
    let range = s.rangeOfString("ell") // Optional(Range(1..<4))
}

do {
    let s = "hello"
    let range = (s as NSString).rangeOfString("ell") // (1,3), an NSRange
    print(range)
}

do {
    let s = "hello"
    // let ss = s.substringWithRange(NSMakeRange(1,3)) // compile error
    let ss = (s as NSString).substringWithRange(NSMakeRange(1,3))
}

//: ## String And Range
do {
    let c = Character("h")
    let s = (String(c)).uppercaseString
}

do {
    let s = "hello"
    let c1 = s.characters.first
    let c2 = s.characters.last
}

do {
    let s = "hello: ello: ekjfwijfiwjqifj"
    let firstL = s.characters.indexOf(":")?.successor() // Optional(2), meaning the third character
    firstL
    s.substringToIndex(firstL!)
    s.substringFromIndex(firstL!)
    firstL
    let lastL = String(s.characters.reverse()).characters.indexOf("l")
}

do {
    let s = "hello -> hello -> hello"
    let firstSmall = s.characters.indexOf {$0 < "f"}
    let find = s.characters.indexOf {$0 == ">"}
}

do {
    let s = "hello"
    let ok = s.characters.contains("o") // true
}

do {
    let s = "hello"
    let ok = s.characters.contains {"aeiou".characters.contains($0)} // true
    print(ok)
}

do {
    let s = "hello"
    let s2 = String(s.characters.filter {"aeiou".characters.contains($0)})
    print(s2) // "eo"
}

do {
    let s = "hello"
    let ok = s.characters.startsWith("hell".characters)
}

do {
    let s = "hello"
    let s2 = String(s.characters.dropFirst()) //???
    print(s2)
}

do {
    let s = "hello"
    let s2 = String(s.characters.prefix(4)) // "hell"
}

do {
    let s = "hello world"
    let arra = s.characters.split{$0 == " "}
    print(arra) //???
    let arr = s.characters.split{$0 == " "}.map{String($0)}
    print(arr)
}

do {
    let s = "hello"
    // let c = s[1] // compile error
    // let c = s.characters[1] // compile error
}

do {
    let s = "hello"
    let ix = s.startIndex
    // "advance" is now an instance method "advancedBy"
    let c = s[ix.advancedBy(1)] // "e"
}

//example removed: ++ operator deprecated in Swift 2.2, will be removed in Swift 3
do {
    let s = "hello"
    let ix = s.startIndex
    let c = s[ix.successor()] // "e" 相当于 s[++ix]
}

do {
    var s = "hello"
    let ix = s.characters.startIndex.advancedBy(1)
    // "splice" is now "insertContentsOf"
    s.insertContentsOf("ey, h".characters, at: ix)
}

do {
    let s = "Ha\u{030A}kon"
    s.characters.count // 5
    (s as NSString).length // or:
    s.utf16.count
}
do {
    let _ = 1...3
    let _ = -1000...(-1)
    // let _ = 3...1 // legal but you'll crash
}
for ix in 1 ... 3 {
    // 1, 2, 3
}

do {
    let d = 2.1 // ... a Double ...
    if (0.1...2.9).contains(d) {
        ("yes it does")
    }
}

do {
    let s = "hello"
    let arr = Array(s.characters)
    let result = arr[1...3]
    let s2 = String(result)
}

do {
    let s = "hello : Hello :"
    let r = s.rangeOfString(":") // a Swift Range (wrapped in an Optional)
    print(r)
}

do {
    let s = "hello"
    let ix1 = s.startIndex.advancedBy(1)
    let ix2 = ix1.advancedBy(2)
    let s2 = s[ix1...ix2] // "ell"
}

// removed ++ and -- from this example
do {
    let s = "hello"
    var r = s.characters.indices
    r.startIndex = r.startIndex.successor()
    r.endIndex = r.endIndex.predecessor()
    let s2 = s[r] // "ell"
}

do {
    var s = "hello"
    let ix = s.startIndex
    let r = ix.advancedBy(1)...ix.advancedBy(3)
    s.replaceRange(r, with: "ipp") // s is now "hippo"
}

do {
    var s = "hello"
    let ix = s.startIndex
    let r = ix.advancedBy(1)...ix.advancedBy(3)
    s.removeRange(r) // s is now "ho"
}

do {
    let r = NSRange(2..<4)
    (r)
    let r2 = r.toRange()
    (r2)
}

//: [Next](@next)
