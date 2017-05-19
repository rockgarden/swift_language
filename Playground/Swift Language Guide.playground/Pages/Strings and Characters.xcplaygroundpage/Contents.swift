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

/*:
 # Initializing an Empty String

 To create an empty String value as the starting point for building a longer string, either assign an empty string literal to a variable, or initialize a new String instance with initializer syntax.
 */
do {
    var emptyString = ""               // empty string literal
    var anotherEmptyString = String()  // initializer syntax
    // these two strings are both empty, and are equivalent to each other

    if emptyString.isEmpty {
        print("Nothing to see here")
    }
    // Prints "Nothing to see here"
}

/*:
 # String Mutability

 You indicate whether a particular String can be modified (or mutated) by assigning it to a variable (in which case it can be modified), or to a constant (in which case it cannot be modified). 您可以通过将特定的String分配给一个变量（在这种情况下可以被修改）或一个常量（在这种情况下不能被修改）来指示特定的String是否可以修改（变化）。
 
 - NOTE:
 This approach is different from string mutation in Objective-C and Cocoa, where you choose between two classes (NSString and NSMutableString) to indicate whether a string can be mutated.
 */
do {
    var variableString = "Horse"
    variableString += " and carriage"
    // variableString is now "Horse and carriage"

    let constantString = "Highlander"
    //constantString += " and another Highlander"
    // this reports a compile-time error - a constant string cannot be modified
}

/*:
 # Strings Are Value Types

 Swift’s String type is a value type. If you create a new String value, that String value is copied when it is passed to a function or method, or when it is assigned to a constant or variable. In each case, a new copy of the existing String value is created, and the new copy is passed or assigned, not the original version. Value types are described in Structures and Enumerations Are Value Types.

 Swift’s copy-by-default String behavior ensures that when a function or method passes you a String value, it is clear that you own that exact String value, regardless of where it came from. You can be confident that the string you are passed will not be modified unless you modify it yourself. Swift的copy-by-default String行为确保当函数或方法传递一个String值时，很明显，您拥有该确切的String值，无论它来自哪里。 您可以确信，您传递的字符串将不会被修改，除非您自己修改。

 Behind the scenes, Swift’s compiler optimizes string usage so that actual copying takes place only when absolutely necessary. This means you always get great performance when working with strings as value types.
 */

/*:
 # Working with Characters
 */
do {
    for character in "Dog!🐶".characters {
        print(character)
    }
    // D
    // o
    // g
    // !
    // 🐶
    let exclamationMark: Character = "!"
    let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
    let catString = String(catCharacters)
    print(catString)
    // Prints "Cat!🐱"
}

/*:
 # Concatenating Strings and Characters

 - NOTE:
 You can’t append a String or Character to an existing Character variable, because a Character value must contain a single character only.
 */
do {
    let string1 = "hello"
    let string2 = " there"
    var welcome = string1 + string2
    // welcome now equals "hello there"

    var instruction = "look over"
    instruction += string2
    // instruction now equals "look over there"

    let exclamationMark: Character = "!"
    welcome.append(exclamationMark)
    // welcome now equals "hello there!"
}

/*:
 # String Interpolation

 String interpolation is a way to construct a new String value from a mix of constants, variables, literals, and expressions by including their values inside a string literal. Each item that you insert into the string literal is wrapped in a pair of parentheses, prefixed by a backslash (\).

 The value of multiplier is also part of a larger expression later in the string. This expression calculates the value of Double(multiplier) * 2.5 and inserts the result (7.5) into the string. In this case, the expression is written as \(Double(multiplier) * 2.5) when it is included inside the string literal.

 - NOTE:
 The expressions you write inside parentheses within an interpolated string cannot contain an unescaped backslash (\), a carriage return, or a line feed. However, they can contain other string literals.
 */
do {
    let multiplier = 3
    let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
    // message is "3 times 2.5 is 7.5"
}

/*:
 # Unicode

 Unicode is an international standard for encoding, representing, and processing text in different writing systems. It enables you to represent almost any character from any language in a standardized form, and to read and write those characters to and from an external source such as a text file or web page. Swift’s String and Character types are fully Unicode-compliant.

 ## Unicode Scalars

 Behind the scenes, Swift’s native String type is built from Unicode scalar values. A Unicode scalar is a unique 21-bit number for a character or modifier, such as U+0061 for LATIN SMALL LETTER A ("a"), or U+1F425 for FRONT-FACING BABY CHICK ("🐥").

 - NOTE:
 A Unicode scalar is any Unicode code point in the range U+0000 to U+D7FF inclusive or U+E000 to U+10FFFF inclusive. Unicode scalars do not include the Unicode surrogate pair code points, which are the code points in the range U+D800 to U+DFFF inclusive.

 Note that not all 21-bit Unicode scalars are assigned to a character—some scalars are reserved for future assignment. Scalars that have been assigned to a character typically also have a name, such as LATIN SMALL LETTER A and FRONT-FACING BABY CHICK in the examples above.
 
 ## Special Characters in String Literals

 String literals can include the following special characters:

 - The escaped special characters \0 (null character), \\ (backslash), \t (horizontal tab), \n (line feed), \r (carriage return), \" (double quote) and \' (single quote). 转义的特殊字符\ 0（空字符），\\（反斜杠），\ t（水平选项卡），\ n（换行），\ r（回车），\“（双引号）和\）

 - An arbitrary Unicode scalar, written as \u{n}, where n is a 1–8 digit hexadecimal number with a value equal to a valid Unicode code point. 一个任意的Unicode标量，写为\ u {n}，其中n是1-8位十六进制数字，其值等于有效的Unicode代码点.

 The code below shows four examples of these special characters. The wiseWords constant contains two escaped double quote characters. The dollarSign, blackHeart, and sparklingHeart constants demonstrate the Unicode scalar format:
 */
do {
    let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
    // "Imagination is more important than knowledge" - Einstein
    let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
    let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
    let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496
}

/*:
 ## Extended Grapheme Clusters

 Every instance of Swift’s Character type represents a single extended grapheme cluster. An extended grapheme cluster is a sequence of one or more Unicode scalars that (when combined) produce a single human-readable character.

 Here’s an example. The letter é can be represented as the single Unicode scalar é (LATIN SMALL LETTER E WITH ACUTE, or U+00E9). However, the same letter can also be represented as a pair of scalars—a standard letter e (LATIN SMALL LETTER E, or U+0065), followed by the COMBINING ACUTE ACCENT scalar (U+0301). The COMBINING ACUTE ACCENT scalar is graphically applied to the scalar that precedes it, turning an e into an é when it is rendered by a Unicode-aware text-rendering system.
 */
//: In both cases, the letter é is represented as a single Swift Character value that represents an extended grapheme cluster. In the first case, the cluster contains a single scalar; in the second case, it is a cluster of two scalars:
do {
    let eAcute: Character = "\u{E9}"                         // é
    let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by ́
    // eAcute is é, combinedEAcute is é
}
//: Extended grapheme clusters are a flexible way to represent many complex script characters as a single Character value. 扩展的图形集合是将许多复杂的脚本字符表示为单个字符值的灵活方式。
do {
    let precomposed: Character = "\u{D55C}"                  // 한
    let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
    // precomposed is 한, decomposed is 한
}
//: Extended grapheme clusters enable scalars for enclosing marks (such as COMBINING ENCLOSING CIRCLE, or U+20DD) to enclose other Unicode scalars as part of a single Character value: 扩展的图形集群使封闭标记的标量（如组合封装圆或U + 20DD）可将其他Unicode标量作为单个字符值的一部分
do {
    let enclosedEAcute: Character = "\u{E9}\u{20DD}"
    // enclosedEAcute is é⃝
}
//: Unicode scalars for regional indicator symbols can be combined in pairs to make a single Character value, such as this combination of REGIONAL INDICATOR SYMBOL LETTER U (U+1F1FA) and REGIONAL INDICATOR SYMBOL LETTER S (U+1F1F8): 用于区域指示符符号的Unicode标量可以成对组合以形成单个字符值，例如区域指示符符号U（U + 1F1FA）和区域指示符号表S（U + 1F1F8）的组合：
do {
    let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
    // regionalIndicatorForUS is 🇺🇸
}

/*:
 # Counting Characters

 To retrieve a count of the Character values in a string, use the count property of the string’s characters property:
 */
do {
    let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
    print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")
    // Prints "unusualMenagerie has 40 characters"
}
/*:
 Note that Swift’s use of extended grapheme clusters for Character values means that string concatenation and modification may not always affect a string’s character count.

 For example, if you initialize a new string with the four-character word cafe, and then append a COMBINING ACUTE ACCENT (U+0301) to the end of the string, the resulting string will still have a character count of 4, with a fourth character of é, not e:
 */
do {
    var word = "cafe"
    print("the number of characters in \(word) is \(word.characters.count)")
    // Prints "the number of characters in cafe is 4"

    word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

    print("the number of characters in \(word) is \(word.characters.count)")
    // Prints "the number of characters in café is 4"
}
/*:
 - NOTE:
 Extended grapheme clusters can be composed of multiple Unicode scalars. This means that different characters—and different representations of the same character—can require different amounts of memory to store. Because of this, characters in Swift do not each take up the same amount of memory within a string’s representation. As a result, the number of characters in a string cannot be calculated without iterating through the string to determine its extended grapheme cluster boundaries. If you are working with particularly long string values, be aware that the characters property must iterate over the Unicode scalars in the entire string in order to determine the characters for that string. 扩展的图形集合可以由多个Unicode标量组成。这意味着不同的字符和相同字符的不同表示可能需要不同的存储量来存储。因此，Swift中的字符不会在字符串表示中占用相同的内存量。因此，无法在不迭代字符串的情况下计算字符串中的字符数，以确定其扩展的字形集群边界。如果您使用特别长的字符串值，请注意，字符属性必须遍历整个字符串中的Unicode标量，以确定该字符串的字符。

 The count of the characters returned by the characters property is not always the same as the length property of an NSString that contains the same characters. The length of an NSString is based on the number of 16-bit code units within the string’s UTF-16 representation and not the number of Unicode extended grapheme clusters within the string. 由character属性返回的字符的计数并不总是与包含相同字符的NSString的length属性相同。 NSString的长度基于字符串UTF-16表示中16位代码单元的数量，而不是字符串中Unicode扩展的图形集合的数量。
 */

/*:
 # Accessing and Modifying a String

 You access and modify a string through its methods and properties, or by using subscript syntax. 您可以通过其方法和属性或使用下标语法访问和修改字符串。

 ## String Indices

 Each String value has an associated index type, String.Index, which corresponds to the position of each Character in the string. 每个String值都具有相关联的索引类型String.Index，它与字符串中每个Character的位置相对应。

 As mentioned above, different characters can require different amounts of memory to store, so in order to determine which Character is at a particular position, you must iterate over each Unicode scalar from the start or end of that String. For this reason, Swift strings cannot be indexed by integer values. 如上所述，不同的字符可能需要不同的存储量来存储，所以为了确定哪个字符在特定位置，必须从该字符串的开头或结尾遍历每个Unicode标量。因此，Swift字符串不能被整数值索引。

 Use the startIndex property to access the position of the first Character of a String. The endIndex property is the position after the last character in a String. As a result, the endIndex property isn’t a valid argument to a string’s subscript. If a String is empty, startIndex and endIndex are equal. 使用startIndex属性访问字符串的第一个字符的位置。 endIndex属性是字符串中最后一个字符之后的位置。因此，endIndex属性不是字符串下标的有效参数。如果一个String为空，startIndex和endIndex是相等的。

 You access the indices before and after a given index using the index(before:) and index(after:) methods of String. To access an index farther away from the given index, you can use the index(_:offsetBy:) method instead of calling one of these methods multiple times. 您可以使用索引（之前:)和索引（之后:)的String方法访问给定索引之前和之后的索引。要访问远离给定索引的索引，可以使用索引（_：offsetBy :)方法，而不是多次调用这些方法之一

 You can use subscript syntax to access the Character at a particular String index. 您可以使用下标语法访问特定String索引处的“字符”。
 */
do {
    let greeting = "Guten Tag!"
    greeting[greeting.startIndex]
    // G
    greeting[greeting.index(before: greeting.endIndex)]
    // !
    greeting[greeting.index(after: greeting.startIndex)]
    // u
    let index = greeting.index(greeting.startIndex, offsetBy: 7)
    greeting[index]
    // a

    /// Attempting to access an index outside of a string’s range or a Character at an index outside of a string’s range will trigger a runtime error.

    //greeting[greeting.endIndex] // Error: fatal error: Can't form a Character from an empty String
    //greeting.index(after: greeting.endIndex) // Error

    /// Use the indices property of the characters property to access all of the indices of individual characters in a string.

    for index in greeting.characters.indices {
        print("\(greeting[index]) ", terminator: "")
    }
    // Prints "G u t e n   T a g ! "
}
do {
    var str = "Hello, playground"

    /// startIndex is the index of the first character, endIndex is the index after the last character.
    str[str.startIndex] // H
    //str[str.endIndex]   // error: after last character
    var range = str.startIndex..<str.endIndex
    str[range]  // "Hello, playground"

    /// after As in: index(after: String.Index); after refers to the index of the character directly after the given index.
    var index = str.index(after: str.startIndex)
    str[index]  // "e"
    range = str.index(after: str.startIndex)..<str.endIndex
    str[range]  // "ello, playground"

    /// before As in: index(before: String.Index); before refers to the index of the character directly before the given index.
    index = str.index(before: str.endIndex)
    str[index]  // d
    range = str.startIndex..<str.index(before: str.endIndex)
    str[range]  // Hello, playgroun

    /// offsetBy As in: index(String.Index, offsetBy: String.IndexDistance). The offsetBy value can be positive or negative and starts from the given index. Although it is of the type String.IndexDistance, you can give it an Int.
    index = str.index(str.startIndex, offsetBy: 7)
    str[index]  // p
    let start = str.index(str.startIndex, offsetBy: 7)
    let end = str.index(str.endIndex, offsetBy: -6)
    range = start..<end
    str[range]  // play

    /// limitedBy As in: index(String.Index, offsetBy: String.IndexDistance, limitedBy: String.Index). The limitedBy is useful for making sure that the offset does not cause the index to go out of bounds. It is a bounding index. Since it is possible for the offset to exceed the limit, this method returns an Optional. It returns nil if the index is out of bounds.
    if let i = str.index(str.startIndex, offsetBy: 7, limitedBy: str.endIndex) {
        str[i]  // p
    }

}

/*:
 ## Inserting and Removing

 To insert a single character into a string at a specified index, use the insert(_:at:) method, and to insert the contents of another string at a specified index, use the insert(contentsOf:at:) method.
 */
do {
    var welcome = "hello"
    welcome.insert("!", at: welcome.endIndex)
    // welcome now equals "hello!"

    welcome.insert(contentsOf: " there".characters, at: welcome.index(before: welcome.endIndex))
    // welcome now equals "hello there!"

    /// To remove a single character from a string at a specified index, use the remove(at:) method, and to remove a substring at a specified range, use the removeSubrange(_:) method.

    welcome.remove(at: welcome.index(before: welcome.endIndex))
    // welcome now equals "hello there"

    let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
    welcome.removeSubrange(range)
    // welcome now equals "hello"
}
/*:
 - NOTE
 You can use the the insert(_:at:), insert(contentsOf:at:), remove(at:), and removeSubrange(_:) methods on any type that conforms to the RangeReplaceableCollection protocol. This includes String, as shown here, as well as collection types such as Array, Dictionary, and Set. 您可以使用符合RangeReplaceableCollection协议的任何类型的插入（_：at :)，insert（contentsOf：at :)，remove（at :)和removeSubrange（_ :)方法。 这包括String，如此处所示，以及集合类型，如Array，Dictionary和Set。
 */

/*:
 # Comparing Strings

 Swift provides three ways to compare textual values: string and character equality, prefix equality, and suffix equality.

 ## String and Character Equality

 String and character equality is checked with the “equal to” operator (==) and the “not equal to” operator (!=), as described in Comparison Operators.
 */
do {
    let quotation = "We're a lot alike, you and I."
    let sameQuotation = "We're a lot alike, you and I."
    if quotation == sameQuotation {
        print("These two strings are considered equal")
    }
    // Prints "These two strings are considered equal"
}
/*: 
 Two String values (or two Character values) are considered equal if their extended grapheme clusters are canonically equivalent. Extended grapheme clusters are canonically equivalent if they have the same linguistic meaning and appearance, even if they are composed from different Unicode scalars behind the scenes. 如果两个字符串值（或两个字符值）的扩展字形集合在规范上是等效的，则它们被认为是相等的。 如果扩展的字母集合具有相同的语言意义和外观，即使它们是由幕后不同的Unicode标量组成的，则扩展的图形集群也是经典的等效的。
 */
do {
    // "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE
    let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

    // "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
    let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

    if eAcuteQuestion == combinedEAcuteQuestion {
        print("These two strings are considered equal")
    }
    // Prints "These two strings are considered equal"
}
//: The characters are visually similar, but do not have the same linguistic meaning. 若字符只是在视觉上相似，但语言意义不一样，则不相等：
do {
    let latinCapitalLetterA: Character = "\u{41}"

    let cyrillicCapitalLetterA: Character = "\u{0410}"

    if latinCapitalLetterA != cyrillicCapitalLetterA {
        print("These two characters are not equivalent.")
    }
}

/*:
 ## Prefix and Suffix Equality

 To check whether a string has a particular string prefix or suffix, call the string’s hasPrefix(_:) and hasSuffix(_:) methods, both of which take a single argument of type String and return a Boolean value.
 
 - NOTE:
 The hasPrefix(_:) and hasSuffix(_:) methods perform a character-by-character canonical equivalence comparison between the extended grapheme clusters in each string, as described in String and Character Equality. hasPrefix（_ :)和hasSuffix（_ :)方法在String和Character Equality中描述的每个字符串中的扩展字形集合之间执行逐个字符的等效对等比较。
 */
do {
    let romeoAndJuliet = [
        "Act 1 Scene 1: Verona, A public place",
        "Act 1 Scene 2: Capulet's mansion",
        "Act 1 Scene 3: A room in Capulet's mansion",
        "Act 1 Scene 4: A street outside Capulet's mansion",
        "Act 1 Scene 5: The Great Hall in Capulet's mansion",
        "Act 2 Scene 1: Outside Capulet's mansion",
        "Act 2 Scene 2: Capulet's orchard",
        "Act 2 Scene 3: Outside Friar Lawrence's cell",
        "Act 2 Scene 4: A street in Verona",
        "Act 2 Scene 5: Capulet's mansion",
        "Act 2 Scene 6: Friar Lawrence's cell"
    ]

    var act1SceneCount = 0
    for scene in romeoAndJuliet {
        if scene.hasPrefix("Act 1 ") {
            act1SceneCount += 1
        }
    }
    print("There are \(act1SceneCount) scenes in Act 1")
    // Prints "There are 5 scenes in Act 1"

    var mansionCount = 0
    var cellCount = 0
    for scene in romeoAndJuliet {
        if scene.hasSuffix("Capulet's mansion") {
            mansionCount += 1
        } else if scene.hasSuffix("Friar Lawrence's cell") {
            cellCount += 1
        }
    }
    print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
    // Prints "6 mansion scenes; 2 cell scenes"
}

/*:
 # Unicode Representations of Strings

 When a Unicode string is written to a text file or some other storage, the Unicode scalars in that string are encoded in one of several Unicode-defined encoding forms. Each form encodes the string in small chunks known as code units. These include the UTF-8 encoding form (which encodes a string as 8-bit code units), the UTF-16 encoding form (which encodes a string as 16-bit code units), and the UTF-32 encoding form (which encodes a string as 32-bit code units).

 Swift provides several different ways to access Unicode representations of strings. You can iterate over the string with a for-in statement, to access its individual Character values as Unicode extended grapheme clusters. This process is described in Working with Characters.

 Alternatively, access a String value in one of three other Unicode-compliant representations:

 - A collection of UTF-8 code units (accessed with the string’s utf8 property)
 - A collection of UTF-16 code units (accessed with the string’s utf16 property)
 - A collection of 21-bit Unicode scalar values, equivalent to the string’s UTF-32 encoding form (accessed with the string’s unicodeScalars property)

 ## UTF-8 Representation

 You can access a UTF-8 representation of a String by iterating over its utf8 property. This property is of type String.UTF8View, which is a collection of unsigned 8-bit (UInt8) values, one for each byte in the string’s UTF-8 representation.

 example: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/UTF8_2x.png
 
 ## UTF-16 Representation

 You can access a UTF-16 representation of a String by iterating over its utf16 property. This property is of type String.UTF16View, which is a collection of unsigned 16-bit (UInt16) values, one for each 16-bit code unit in the string’s UTF-16 representation:
 
 example: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/UTF16_2x.png
 
 ## Unicode Scalar Representation

 You can access a Unicode scalar representation of a String value by iterating over its unicodeScalars property. This property is of type UnicodeScalarView, which is a collection of values of type UnicodeScalar.

 Each UnicodeScalar has a value property that returns the scalar’s 21-bit value, represented within a UInt32 value:
 
 example: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/UnicodeScalar_2x.png
 
 As an alternative to querying their value properties, each UnicodeScalar value can also be used to construct a new String value, such as with string interpolation.
 */
do {
    /// Each example below shows a different representation of the following string, which is made up of the characters D, o, g, ‼ (DOUBLE EXCLAMATION MARK, or Unicode scalar U+203C), and the 🐶 character (DOG FACE, or Unicode scalar U+1F436):
    let dogString = "Dog‼🐶"
    for codeUnit in dogString.utf8 {
        print("UTF8: \(codeUnit) ", terminator: "")
    }
    print("")
    // Prints "68 111 103 226 128 188 240 159 144 182 "
    /*
     the first three decimal codeUnit values (68, 111, 103) represent the characters D, o, and g, whose UTF-8 representation is the same as their ASCII representation. The next three decimal codeUnit values (226, 128, 188) are a three-byte UTF-8 representation of the DOUBLE EXCLAMATION MARK character. The last four codeUnit values (240, 159, 144, 182) are a four-byte UTF-8 representation of the DOG FACE character.
     */

    for codeUnit in dogString.utf16 {
        print("UTF16: \(codeUnit) ", terminator: "")
    }
    print("")
    // Prints "68 111 103 8252 55357 56374 "

    /*
     The value properties for the first three UnicodeScalar values (68, 111, 103) once again represent the characters D, o, and g.

     The fourth codeUnit value (8252) is a decimal equivalent of the hexadecimal value 203C, which represents the Unicode scalar U+203C for the DOUBLE EXCLAMATION MARK character. This character can be represented as a single code unit in UTF-16. 第四个代码单元值（8252）是十六进制值203C的十进制数，表示DOUBLE EXCLAMATION MARK字符的Unicode标量U + 203C。 该字符可以在UTF-16中表示为单个代码单元。

     The fifth and sixth codeUnit values (55357 and 56374) are a UTF-16 surrogate pair representation of the DOG FACE character. These values are a high-surrogate value of U+D83D (decimal value 55357) and a low-surrogate value of U+DC36 (decimal value 56374). 第五和第六个代码单元值（55357和56374）是DOG FACE字符的UTF-16代理对表示。 这些值是U + D83D（十进制值55357）的高替代值和U + DC36（十进制值56374）的低替代值。
     */

    for scalar in dogString.unicodeScalars {
        print("\(scalar.value) ", terminator: "")
    }
    print("")
    // Prints "68 111 103 8252 128054 "
    /*
     The value properties for the first three UnicodeScalar values (68, 111, 103) once again represent the characters D, o, and g.

     The fourth codeUnit value (8252) is again a decimal equivalent of the hexadecimal value 203C, which represents the Unicode scalar U+203C for the DOUBLE EXCLAMATION MARK character. 第四个代码单元值（8252）也是十六进制值203C的十进制等效值，表示DOUBLE EXCLAMATION MARK字符的Unicode标量U + 203C。

     The value property of the fifth and final UnicodeScalar, 128054, is a decimal equivalent of the hexadecimal value 1F436, which represents the Unicode scalar U+1F436 for the DOG FACE character. 第五个也是最后一个UnicodeScalar，128054的value属性是十进制值，十六进制值为1F436，表示DOG FACE字符的Unicode标量U + 1F436。
     */

    for scalar in dogString.unicodeScalars {
        print("\(scalar) ")
    }
    // D
    // o
    // g
    // ‼
    // 🐶
}



//: # Example
do {
    let greeting = "hello"
    let leftTripleArrow = "\u{21DA}"
    let n = 5
    let s = "You have \(n) widgets."
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
    s += s2
    s.append(s2)
}

do {
    let s = "hello"
    let s2 = "world"
    let space = " "
    let greeting = [s,s2].joined(separator: space)
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
    for c in s.characters {
        // get each Character
    }
}

func flag(country: String) -> String {
    let base : UInt32 = 127397
    var s = ""
    for v in country.unicodeScalars {
        //s.append(UnicodeScalar(base + v.value)!)
        //s.append(_: UnicodeScalar(base + v.value)!)
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
    let ss = (s as NSString).substring(with: NSMakeRange(1,3))
}

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
    s.substring(to: firstL)
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
    let s2 = String(s.characters.dropFirst())
    print(s2)
}

do {
    let s = "hello"
    let s2 = String(s.characters.prefix(4)) // "hell"
}

do {
    let s = "hello world"
    let arra = s.characters.split{$0 == " "}
    print(arra)
    let arr = s.characters.split{$0 == " "}.map{String($0)}
    print(arr)
}

do {
    let s = "hello"
    let ix = s.startIndex
    let c = s.index(after: ix) // "e" 相当于 s[++ix]
}

do {
    var s = "hello"
    let ix = s.index(s.characters.startIndex, offsetBy: 1)
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

do {
    let r = NSRange(2..<4)
    let r2 = r.toRange()
}

//: [Next](@next)
