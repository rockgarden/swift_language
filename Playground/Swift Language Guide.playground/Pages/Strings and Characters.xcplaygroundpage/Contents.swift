//: [Previous](@previous)
import UIKit
/*:
 # Strings and Characters
 A string is a series of characters, such as "hello, world" or "albatross". Swift strings are represented by the String type. The contents of a String can be accessed in various ways, including as a collection of Character values.

 Swift’s String and Character types provide a fast, Unicode-compliant way to work with text in your code. The syntax for string creation and manipulation is lightweight and readable, with a string literal syntax that is similar to C. String concatenation is as simple as combining two strings with the + operator, and string mutability is managed by choosing between a constant or a variable, just like any other value in Swift. You can also use strings to insert constants, variables, literals, and expressions into longer strings, in a process known as string interpolation. This makes it easy to create custom string values for display, storage, and printing.

 Despite this simplicity of syntax, Swift’s String type is a fast, modern string implementation. Every string is composed of encoding-independent Unicode characters, and provides support for accessing those characters in various Unicode representations.

 - NOTE:
 Swift’s String type is bridged with Foundation’s NSString class. Foundation also extends String to expose methods defined by NSString. This means, if you import Foundation, you can access those NSString methods on String without casting.

 For more information about using String with Foundation and Cocoa, see Working with Cocoa Data Types in Using Swift with Cocoa and Objective-C (Swift 3.1).
 */
/*:
 # String Literals

 You can include predefined String values within your code as string literals. A string literal is a fixed sequence of textual characters surrounded by a pair of double quotes (""). 您可以在代码中将预定义的String值作为字符串文字包含。 字符串文字是由一对双引号（“”）包围的文本字符的固定序列。

 Use a string literal as an initial value for a constant or variable:

    let someString = "Some string literal value"
 
 Note that Swift infers a type of String for the someString constant, because it is initialized with a string literal value. 请注意，Swift会为someString常量推断一种String类型，因为它是用字符串字面值初始化的。

 - NOTE:
 For information about using special characters in string literals, see Special Characters in String Literals.
 */



/**
 var str = "Hello, playground"
 startIndex and endIndex

 startIndex is the index of the first character
 endIndex is the index after the last character.
 Example

 // character
 str[str.startIndex] // H
 str[str.endIndex]   // error: after last character

 // range
 let range = str.startIndex..<str.endIndex
 str[range]  // "Hello, playground"
 after

 As in: index(after: String.Index)

 after refers to the index of the character directly after the given index.
 Examples

 // character
 let index = str.index(after: str.startIndex)
 str[index]  // "e"

 // range
 let range = str.index(after: str.startIndex)..<str.endIndex
 str[range]  // "ello, playground"
 before

 As in: index(before: String.Index)

 before refers to the index of the character directly before the given index.
 Examples

 // character
 let index = str.index(before: str.endIndex)
 str[index]  // d

 // range
 let range = str.startIndex..<str.index(before: str.endIndex)
 str[range]  // Hello, playgroun
 offsetBy

 As in: index(String.Index, offsetBy: String.IndexDistance)

 The offsetBy value can be positive or negative and starts from the given index. Although it is of the type String.IndexDistance, you can give it an Int.
 Examples

 // character
 let index = str.index(str.startIndex, offsetBy: 7)
 str[index]  // p

 // range
 let start = str.index(str.startIndex, offsetBy: 7)
 let end = str.index(str.endIndex, offsetBy: -6)
 let range = start..<end
 str[range]  // play
 limitedBy

 As in: index(String.Index, offsetBy: String.IndexDistance, limitedBy: String.Index)

 The limitedBy is useful for making sure that the offset does not cause the index to go out of bounds. It is a bounding index. Since it is possible for the offset to exceed the limit, this method returns an Optional. It returns nil if the index is out of bounds.
 Example

 // character
 if let index = str.index(str.startIndex, offsetBy: 7, limitedBy: str.endIndex) {
 str[index]  // p
 }
 */

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
    let ud = UserDefaults.standard
    let s0 = "You have \(ud.integer(forKey: "widgets")) widgets."
    let n = ud.integer(forKey:"widgets")
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
    s.append(s2) // or: sss += sss2
}

do {
    let s = "hello"
    let s2 = "world"
    let space = " "
    // "join" has changed to "joinWithSeparator", which works the other way round
    let greeting = [s,s2].joined(separator: space)
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
        s.append(UnicodeScalar(base + v.value)!)
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
        let s = flag(country: "CH")
    }
}

do {
    let s = "hello world"
    let s2 = s.capitalized // "Hello World"
}

do {
    let s = "hello"
    let range = s.range(of: "ell") // Optional(Range(1..<4))
}

do {
    let s = "hello"
    let range = (s as NSString).range(of: "ell") // (1,3), an NSRange
    print(range)
}

do {
    let s = "hello"
    // let ss = s.substringWithRange(NSMakeRange(1,3)) // compile error
    let ss = (s as NSString).substring(with: NSMakeRange(1,3))
}

//: ## String And Range
do {
    let c = Character("h")
    let s = (String(c)).uppercased()
}

do {
    let s = "hello"
    let c1 = s.characters.first
    let c2 = s.characters.last
}

do {
    let s = "hello: ello: ekjfwijfiwjqifj!"
    let firstL = s.index(after: s.characters.index(of: "!")!)
        //.index(after: "!")


        //.successor() // Optional(2), meaning the third character
    firstL
    s.substring(to: firstL)
    firstL
    let lastL = String(s.characters.reversed()).characters.index(of: "l")
}

do {
    let s = "hello -> hello -> hello"
    let firstSmall = s.characters.index {$0 < "f"}
    let find = s.characters.index {$0 == ">"}
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
    let ok = s.characters.starts(with: "hell".characters)
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
    let c = s.index(ix, offsetBy: 1) //[ix.advancedBy(1)] // "e"
}

//example removed: ++ operator deprecated in Swift 2.2, will be removed in Swift 3
do {
    let s = "hello"
    let ix = s.startIndex
    let c = s.index(after: ix) // "e" 相当于 s[++ix]
}

do {
    var s = "hello"
    let ix = s.index(s.characters.startIndex, offsetBy: 1)
    // "splice" is now "insertContentsOf"
    s.insert(contentsOf: "ey, h".characters, at: ix)
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
    let r = s.range(of:":") // a Swift Range (wrapped in an Optional)
}

do {
    let s = "hello"
    let ix1 = s.index(s.startIndex, offsetBy: 1)
    let ix2 = s.index(ix1, offsetBy: 2)
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
