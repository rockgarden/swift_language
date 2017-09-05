//: [Previous](@previous)

import Foundation

/*: # Advanced Operators
 Swift provides several advanced operators that perform more complex value manipulation. These include all of the bitwise and bit shifting operators you will be familiar with from C and Objective-C.

 Unlike arithmetic operators in C, arithmetic operators in Swift do not overflow by default. Overflow behavior is trapped and reported as an error. To opt in to overflow behavior, use Swift’s second set of arithmetic operators that overflow by default, such as the overflow addition operator (&+). All of these overflow operators begin with an ampersand (&).
 与C中的算术运算符不同，Swift中的算术运算符默认不会溢出。溢出行为被捕获并报告为错误。要选择溢出行为，使用Swift的第二组默认溢出的算术运算符，例如溢出加法运算符（＆+）。所有这些溢出运算符都以＆符号开头。
 When you define your own structures, classes, and enumerations, it can be useful to provide your own implementations of the standard Swift operators for these custom types. Swift makes it easy to provide tailored implementations of these operators and to determine exactly what their behavior should be for each type you create.

 You’re not limited to the predefined operators. Swift gives you the freedom to define your own custom infix, prefix, postfix, and assignment operators, with custom precedence and associativity values. These operators can be used and adopted in your code like any of the predefined operators, and you can even extend existing types to support the custom operators you define.

 # Bitwise Operators
 Bitwise operators enable you to manipulate the individual raw data bits within a data structure. They are often used in low-level programming, such as graphics programming and device driver creation. Bitwise operators can also be useful when you work with raw data from external sources, such as encoding and decoding data for communication over a custom protocol.
 按位运算符使您能够处理数据结构中的各个原始数据位。它们经常用于低级编程，例如图形编程和设备驱动程序创建。当使用来自外部源的原始数据（例如，通过自定义协议进行编码和解码数据）时，按位运算符也很有用。
 Swift supports all of the bitwise operators found in C, as described below.
 ## Bitwise NOT Operator
 The bitwise NOT operator (~) inverts all bits in a number:
 按位非运算符（〜）反转数字中的所有位： https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/bitwiseNOT_2x.png
 The bitwise NOT operator is a prefix operator, and appears immediately before the value it operates on, without any white space.
 */
do {
    let initialBits: UInt8 = 0b00001111
    let invertedBits = ~initialBits // equals 11110000
    /// UInt8 integers have eight bits and can store any value between 0 and 255. This example initializes a UInt8 integer with the binary value 00001111, which has its first four bits set to 0, and its second four bits set to 1. This is equivalent to a decimal value of 15.
    /// The bitwise NOT operator is then used to create a new constant called invertedBits, which is equal to initialBits, but with all of the bits inverted. Zeros become ones, and ones become zeros. The value of invertedBits is 11110000, which is equal to an unsigned decimal value of 240.
}

/*:
 ## Bitwise AND Operator
 The bitwise AND operator (&) combines the bits of two numbers. It returns a new number whose bits are set to 1 only if the bits were equal to 1 in both input numbers: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/bitwiseAND_2x.png
 */
do {
    let firstSixBits: UInt8 = 0b11111100
    let lastSixBits: UInt8  = 0b00111111
    let middleFourBits = firstSixBits & lastSixBits // equals 00111100
}

/*:
 ## Bitwise OR Operator
 按位或运算符（|）
 The bitwise OR operator (|) compares the bits of two numbers. The operator returns a new number whose bits are set to 1 if the bits are equal to 1 in either input number: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/bitwiseOR_2x.png
 */
do {
    let someBits: UInt8 = 0b10110010
    let moreBits: UInt8 = 0b01011110
    let combinedbits = someBits | moreBits  // equals 11111110
}

/*:
 ## Bitwise XOR Operator
 The bitwise XOR operator, or “exclusive OR operator” (^), compares the bits of two numbers. The operator returns a new number whose bits are set to 1 where the input bits are different and are set to 0 where the input bits are the same: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/bitwiseXOR_2x.png
 */
do {
    let firstBits: UInt8 = 0b00010100
    let otherBits: UInt8 = 0b00000101
    let outputBits = firstBits ^ otherBits  // equals 00010001
}

/*:
 # Bitwise Left and Right Shift Operators
 按位左和右移位运算符
 The bitwise left shift operator (<<) and bitwise right shift operator (>>) move all bits in a number to the left or the right by a certain number of places, according to the rules defined below.
 根据以下定义的规则，按位左移位运算符（<<）和按位右移位运算符（>>）将数字中的所有位向左或向右移动一定数量的位置。
 Bitwise left and right shifts have the effect of multiplying or dividing an integer by a factor of two. Shifting an integer’s bits to the left by one position doubles its value, whereas shifting it to the right by one position halves its value.
 按位左移和右移具有将整数乘以因子2的效果。将整数位左移一个位置将其值加倍，而将其向右移位一个位置将其值减半.
 ### Shifting Behavior for Unsigned Integers
 无符号整数的移位行为
 The bit-shifting behavior for unsigned integers is as follows:
 - Existing bits are moved to the left or right by the requested number of places.
 - Any bits that are moved beyond the bounds of the integer’s storage are discarded.
 - Zeros are inserted in the spaces left behind after the original bits are moved to the left or right.
 This approach is known as a logical shift.这种方法被称为逻辑移位。
 The illustration below shows the results of 11111111 << 1 (which is 11111111 shifted to the left by 1 place), and 11111111 >> 1 (which is 11111111 shifted to the right by 1 place). Blue numbers are shifted, gray numbers are discarded, and orange zeros are inserted: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/bitshiftUnsigned_2x.png
 */
do {
    let shiftBits: UInt8 = 4   // 00000100 in binary
    shiftBits << 1             // 00001000
    shiftBits << 2             // 00010000
    shiftBits << 5             // 10000000
    shiftBits << 6             // 00000000
    shiftBits >> 2             // 00000001

    let pink: UInt32 = 0xCC6699
    let redComponent = (pink & 0xFF0000) >> 16    // redComponent is 0xCC, or 204
    let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent is 0x66, or 102
    let blueComponent = pink & 0x0000FF           // blueComponent is 0x99, or 153
}
/*:
 ### Shifting Behavior for Signed Integers
 The shifting behavior is more complex for signed integers than for unsigned integers, because of the way signed integers are represented in binary. (The examples below are based on 8-bit signed integers for simplicity, but the same principles apply for signed integers of any size.)
 对于有符号整数，与无符号整数相比，移位行为更复杂，因为有符号整数以二进制表示的方式。 （为了简单起见，以下示例基于8位有符号整数，但相同的原则适用于任何大小的有符号整数。）
 Signed integers use their first bit (known as the sign bit) to indicate whether the integer is positive or negative. A sign bit of 0 means positive, and a sign bit of 1 means negative.
 有符号整数使用它们的第一个位（称为符号位）来指示整数是正还是负。 符号位0表示正，符号位1表示负。
 The remaining bits (known as the value bits) store the actual value. Positive numbers are stored in exactly the same way as for unsigned integers, counting upwards from 0. Here’s how the bits inside an Int8 look for the number 4:
 剩余位（称为值位）存储实际值。 正数以与无符号整数完全相同的方式存储，从0向上计数。这是Int8中的位如何查找数4：https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/bitshiftSignedFour_2x.png
 The sign bit is 0 (meaning “positive”), and the seven value bits are just the number 4, written in binary notation.符号位是0（意味着“正”），并且七个值位只是数字4，以二进制符号表示。
 Negative numbers, however, are stored differently. They are stored by subtracting their absolute value from 2 to the power of n, where n is the number of value bits. An eight-bit number has seven value bits, so this means 2 to the power of 7, or 128.
 然而，负数存储方式不同。 它们通过将其绝对值从2减去n的幂而存储，其中n是值位的数量。 一个8位数有7个值位，所以这意味着2的7的幂，或128。
 Here’s how the bits inside an Int8 look for the number -4: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/bitshiftSignedMinusFour_2x.png
 This time, the sign bit is 1 (meaning “negative”), and the seven value bits have a binary value of 124 (which is 128 - 4): https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/bitshiftSignedMinusFourValue_2x.png
 This encoding for negative numbers is known as a two’s complement representation. It may seem an unusual way to represent negative numbers, but it has several advantages.
 First, you can add -1 to -4, simply by performing a standard binary addition of all eight bits (including the sign bit), and discarding anything that doesn’t fit in the eight bits once you’re done: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/bitshiftSignedAddition_2x.png
 Second, the two’s complement representation also lets you shift the bits of negative numbers to the left and right like positive numbers, and still end up doubling them for every shift you make to the left, or halving them for every shift you make to the right. To achieve this, an extra rule is used when signed integers are shifted to the right: When you shift signed integers to the right, apply the same rules as for unsigned integers, but fill any empty bits on the left with the sign bit, rather than with a zero.
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/bitshiftSigned_2x.png
 This action ensures that signed integers have the same sign after they are shifted to the right, and is known as an arithmetic shift.
 Because of the special way that positive and negative numbers are stored, shifting either of them to the right moves them closer to zero. Keeping the sign bit the same during this shift means that negative integers remain negative as their value moves closer to zero.
 */


/*:
 # Overflow Operators
 溢流操作器
 If you try to insert a number into an integer constant or variable that cannot hold that value, by default Swift reports an error rather than allowing an invalid value to be created. This behavior gives extra safety when you work with numbers that are too large or too small.
 如果尝试将数字插入到不能容纳该值的整数常量或变量中，则默认情况下Swift报告错误，而不是允许创建无效值。当您使用太大或太小的数字时，此行为会提供额外的安全性。
 */
do {
//    var potentialOverflow = Int16.max
    // potentialOverflow equals 32767, which is the maximum value an Int16 can hold
    //potentialOverflow += 1
    // this causes an error
}
/*:
 Providing error handling when values get too large or too small gives you much more flexibility when coding for boundary value conditions.
 However, when you specifically want an overflow condition to truncate the number of available bits, you can opt in to this behavior rather than triggering an error. Swift provides three arithmetic overflow operators that opt in to the overflow behavior for integer calculations. These operators all begin with an ampersand (&):
 - Overflow addition (&+)
 - Overflow subtraction (&-)
 - Overflow multiplication (&*)
 */
/*:
 ## Value Overflow
 Numbers can overflow in both the positive and negative direction.
*/
//do {
//    var unsignedOverflow = UInt8.max
//    // unsignedOverflow equals 255, which is the maximum value a UInt8 can hold
//    unsignedOverflow = unsignedOverflow &+ 1
//    // unsignedOverflow is now equal to 0
//}
/*:
The variable unsignedOverflow is initialized with the maximum value a UInt8 can hold (255, or 11111111 in binary). It is then incremented by 1 using the overflow addition operator (&+). This pushes its binary representation just over the size that a UInt8 can hold, causing it to overflow beyond its bounds, as shown in the diagram below. The value that remains within the bounds of the UInt8 after the overflow addition is 00000000, or zero.
https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/overflowAddition_2x.png
*/
do {
    var unsignedOverflow = UInt8.min
    // unsignedOverflow equals 0, which is the minimum value a UInt8 can hold
    unsignedOverflow = unsignedOverflow &- 1
    // unsignedOverflow is now equal to 255
}
/*:
 The minimum value that a UInt8 can hold is zero, or 00000000 in binary. If you subtract 1 from 00000000 using the overflow subtraction operator (&-), the number will overflow and wrap around to 11111111, or 255 in decimal.
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/overflowUnsignedSubtraction_2x.png
 Overflow also occurs for signed integers. All addition and subtraction for signed integers is performed in bitwise fashion, with the sign bit included as part of the numbers being added or subtracted, as described in Bitwise Left and Right Shift Operators.
 */
do {
    var signedOverflow = Int8.min
    // signedOverflow equals -128, which is the minimum value an Int8 can hold
    signedOverflow = signedOverflow &- 1
    // signedOverflow is now equal to 127
}
/*:
 The minimum value that an Int8 can hold is -128, or 10000000 in binary. Subtracting 1 from this binary number with the overflow operator gives a binary value of 01111111, which toggles the sign bit and gives positive 127, the maximum positive value that an Int8 can hold.
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/overflowSignedSubtraction_2x.png
 For both signed and unsigned integers, overflow in the positive direction wraps around from the maximum valid integer value back to the minimum, and overflow in the negative direction wraps around from the minimum value to the maximum.
 */

/*:
 # Precedence and Associativity
 优先和相关性
 Operator precedence gives some operators higher priority than others; these operators are applied first.
 运算符优先级给一些运算符比其他运算符优先级高首先应用这些运算符。
 Operator associativity defines how operators of the same precedence are grouped together—either grouped from the left, or grouped from the right. Think of it as meaning “they associate with the expression to their left,” or “they associate with the expression to their right.”
 操作符关联性定义了相同优先级的操作符如何分组在一起 - 从左侧分组或从右侧分组。认为它是“他们与他们的左边的表达相关联”的意思，或者“他们与他们的权利的表达相关联。
 It is important to consider each operator’s precedence and associativity when working out the order in which a compound expression will be calculated.
 在计算复合表达式的计算顺序时，要考虑每个运算符的优先级和关联性。
 */
do {
    2 + 3 % 4 * 5
    // this equals 17
}
/*:
 Higher-precedence operators are evaluated before lower-precedence ones. In Swift, as in C, the remainder operator (%) and the multiplication operator (*) have a higher precedence than the addition operator (+). As a result, they are both evaluated before the addition is considered.
 高优先级运算符在低优先级运算符之前被评估。在Swift中，如在C中，余数运算符（％）和乘法运算符（*）的优先级高于加法运算符（+）。因此，在考虑添加之前对它们进行评价。
 However, remainder and multiplication have the same precedence as each other. To work out the exact evaluation order to use, you also need to consider their associativity. Remainder and multiplication both associate with the expression to their left. 
 然而，余数和乘法具有彼此相同的优先级。要确定要使用的确切评估顺序，还需要考虑它们的关联性。余数和乘法都与其左边的表达式相关联。
 Think of this as adding implicit parentheses around these parts of the expression, starting from their left:
 */
do {
    2 + ((3 % 4) * 5)
    2 + (3 * 5)
    2 + 15
}
/*:
 For a complete list of Swift operator precedences and associativity rules, see https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Expressions.html#//apple_ref/doc/uid/TP40014097-CH32-ID383. For information about the operators provided by the Swift standard library, see https://developer.apple.com/reference/swift/swift_standard_library_operators.
 - NOTE:
 Swift’s operator precedences and associativity rules are simpler and more predictable than those found in C and Objective-C. However, this means that they are not exactly the same as in C-based languages. Be careful to ensure that operator interactions still behave in the way you intend when porting existing code to Swift.
 */


/*:
 # Operator Methods
 Classes and structures can provide their own implementations of existing operators. This is known as overloading the existing operators.
 类和结构可以提供它们自己的现有运算符的实现。这被称为重载现有运算符
*/
struct Vector2D {
    var x = 0.0, y = 0.0
}
extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}
do {
    let vector = Vector2D(x: 3.0, y: 1.0)
    let anotherVector = Vector2D(x: 2.0, y: 4.0)
    let combinedVector = vector + anotherVector
    // combinedVector is a Vector2D instance with values of (5.0, 5.0)
    // https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/vectorAddition_2x.png
}

struct Vial {
    var numberOfBacteria : Int
    init(_ n:Int) {
        self.numberOfBacteria = n
    }
}
extension Vial : Equatable {
    static func +(lhs:Vial, rhs:Vial) -> Vial {
        let total = lhs.numberOfBacteria + rhs.numberOfBacteria
        return Vial(total)
    }
    static func +=(lhs: inout Vial, rhs:Vial) {
        let total = lhs.numberOfBacteria + rhs.numberOfBacteria
        lhs.numberOfBacteria = total
    }

    static func ==(lhs:Vial, rhs:Vial) -> Bool {
        return lhs.numberOfBacteria == rhs.numberOfBacteria
    }
}
do {
    var v1 = Vial(500_000)
    let v2 = Vial(400_000)
    let v3 = v1 + v2
    (v3.numberOfBacteria) // 900000
    v1 += v2
    (v1.numberOfBacteria) // 900000
    let arr = [v1,v2]
    let ix = arr.index(of:v1) // Optional wrapping 0
}

/*:
 ## Prefix and Postfix Operators
 Classes and structures can also provide implementations of the standard unary operators. Unary operators operate on a single target. They are prefix if they precede their target (such as -a) and postfix operators if they follow their target (such as b!).
 类和结构还可以提供标准一元运算符的实现。 一元运算符在单个目标上操作。 如果它们在目标之前（如-a）和后缀运算符（如果它们跟随其目标（例如b！）），则它们是前缀。
 You implement a prefix or postfix unary operator by writing the prefix or postfix modifier before the func keyword when declaring the operator method.
 通过在声明运算符方法之前在func关键字前写入前缀或后缀修饰符，可以实现前缀或后缀一元运算符.
 */
extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}
do {
    let positive = Vector2D(x: 3.0, y: 4.0)
    let negative = -positive
    // negative is a Vector2D instance with values of (-3.0, -4.0)
    let alsoPositive = -negative
    // alsoPositive is a Vector2D instance with values of (3.0, 4.0)
}

/*:
 ## Compound Assignment Operators
 复合分配操作符
 Compound assignment operators combine assignment (=) with another operation. For example, the addition assignment operator (+=) combines addition and assignment into a single operation. You mark a compound assignment operator’s left input parameter type as inout, because the parameter’s value will be modified directly from within the operator method.
 */
extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}
do {
    var original = Vector2D(x: 1.0, y: 2.0)
    let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
    original += vectorToAdd
    // original now has values of (4.0, 6.0)
}
/*:
 - NOTE:
 It is not possible to overload the default assignment operator (=). Only the compound assignment operators can be overloaded. Similarly, the ternary conditional operator (a ? b : c) cannot be overloaded.
 */

/*:
 ## Equivalence Operators
 等效运算符
 Custom classes and structures do not receive a default implementation of the equivalence operators, known as the “equal to” operator (==) and “not equal to” operator (!=). It is not possible for Swift to guess what would qualify as “equal” for your own custom types, because the meaning of “equal” depends on the roles that those types play in your code.
 自定义类和结构不接收等价运算符的默认实现，称为“等于”运算符（==）和“不等于”运算符（！=）。 Swift不可能猜测对于自己的自定义类型，什么是合格的“等于”，因为“等于”的含义取决于这些类型在代码中扮演的角色。
 */
extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    static func != (left: Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
}
do {
    let twoThree = Vector2D(x: 2.0, y: 3.0)
    let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
    if twoThree == anotherTwoThree {
        print("These two vectors are equivalent.")
    }
}

/*:
 # Custom Operators

 You can declare and implement your own custom operators in addition to the standard operators provided by Swift. For a list of characters that can be used to define custom operators, see Operators.
 New operators are declared at a global level using the operator keyword, and are marked with the prefix, infix or postfix modifiers.
 新运算符在全局级别使用operator关键字声明，并标有前缀，中缀或后缀修饰符.
 */
prefix operator +++
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}
do {
    var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
    let afterDoubling = +++toBeDoubled
    // toBeDoubled now has values of (2.0, 8.0)
    // afterDoubling also has values of (2.0, 8.0)
}

/*:
 ## Precedence for Custom Infix Operators
 自定义中缀操作符的优先级
 Custom infix operators each belong to a precedence group. A precedence group specifies an operator’s precedence relative to other infix operators, as well as the operator’s associativity. See https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AdvancedOperators.html#//apple_ref/doc/uid/TP40014097-CH27-ID41 for an explanation of how these characteristics affect an infix operator’s interaction with other infix operators.
 自定义中缀运算符都属于优先级组。优先级组指定操作符相对于其他中缀运算符的优先级，以及运算符的关联性。有关这些特征如何影响中缀运算符与其他中缀运算符的交互的说明，请参见优先和关联性。
 A custom infix operator that is not explicitly placed into a precedence group is given a default precedence group with a precedence immediately higher than the precedence of the ternary conditional operator.
 未显式放入优先级组的自定义中缀运算符会被赋予默认优先级组，其优先级立即高于三元条件运算符的优先级。
 */
infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
do {
    let firstVector = Vector2D(x: 1.0, y: 2.0)
    let secondVector = Vector2D(x: 3.0, y: 4.0)
    let plusMinusVector = firstVector +- secondVector
    // plusMinusVector is a Vector2D instance with values of (4.0, -2.0)
}
/*:
 - NOTE:
 You do not specify a precedence when defining a prefix or postfix operator. However, if you apply both a prefix and a postfix operator to the same operand, the postfix operator is applied first.
 在定义前缀或后缀运算符时，不要指定优先级。但是，如果将前缀和后缀运算符应用于同一个操作数，则首先应用后缀运算符。
 */
//: 中间运算符 infix
infix operator ^^
extension Int {
    static func ^^(lhs:Int, rhs:Int) -> Int {
        var result = lhs
        for _ in 1..<rhs {result *= lhs}
        return result
    }
}
do {
    (2^^2) // 4
    (2^^3) // 8
    (3^^3) // 27
}

infix operator >>> : RangeFormationPrecedence
func >>><Bound>(maximum: Bound, minimum: Bound)
    -> ReversedRandomAccessCollection<CountableRange<Bound>>
    where Bound : Comparable & Strideable, Bound.Stride : Integer {
        return (minimum..<maximum).reversed()
}
do {
    let r2 = 10>>>1
    for i in r2 {print(i)}
}

//: [Next](@next)
