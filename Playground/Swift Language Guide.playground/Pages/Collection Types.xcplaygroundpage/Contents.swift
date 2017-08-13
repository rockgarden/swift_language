//: [Previous](@previous)

import UIKit

/*: 
 # Collection Types
 Swift provides three primary collection types, known as arrays, sets, and dictionaries, for storing collections of values. Arrays are ordered collections of values. Sets are unordered collections of unique values. Dictionaries are unordered collections of key-value associations.
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/CollectionTypes_intro_2x.png
 Arrays, sets, and dictionaries in Swift are always clear about the types of values and keys that they can store. This means that you cannot insert a value of the wrong type into a collection by mistake. It also means you can be confident about the type of values you will retrieve from a collection.
 - NOTE:
 Swift’s array, set, and dictionary types are implemented as generic collections.
 - NOTE:
 For more information about using Array with Foundation and Cocoa, see https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/WorkingWithCocoaDataTypes.html#//apple_ref/doc/uid/TP40014216-CH6 in https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/index.html#//apple_ref/doc/uid/TP40014216.
 */
/*: 
 # Mutability of Collections
 If you create an array, a set, or a dictionary, and assign it to a variable, the collection that is created will be mutable. This means that you can change (or mutate) the collection after it is created by adding, removing, or changing items in the collection. If you assign an array, a set, or a dictionary to a constant, that collection is immutable, and its size and contents cannot be changed.
 - NOTE:
 It is good practice to create immutable collections in all cases where the collection does not need to change. Doing so makes it easier for you to reason about your code and enables the Swift compiler to optimize the performance of the collections you create.
 */


/*:
 # Arrays
 操作数组内容时,数组(Array)能提供接近C语言的的性能.
 - NOTE:
 Swift’s Array type is bridged to Foundation’s NSArray class.
 */

/*: 
 ## Array Type Shorthand Syntax
 The type of a Swift array is written in full as Array<Element>, where Element is the type of values the array is allowed to store. You can also write the type of an array in shorthand form as [Element]. Although the two forms are functionally identical, the shorthand form is preferred and is used throughout this guide when referring to the type of an array.
 */

//: ## Creating an Empty Array
do {
    var someInts = [Int]()
    print("someInts is of type [Int] with \(someInts.count) items.")
    someInts.append(3)
    someInts = []
}

//: ## Creating an Array with a Default Value
var threeDoubles = Array(repeating: 0.0, count: 3)

//: ## Creating an Array by Adding Two Arrays Together
do {
    var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
    var sixDoubles = threeDoubles + anotherThreeDoubles
}

//: ## Creating an Array with an Array Literal
/// initialize an array with an array literal: [value 1, value 2, value 3]
var shoppingList: [String] = ["Eggs", "Milk"]
/*:
 - NOTE:
 The shoppingList array is declared as a variable (with the var introducer) and not a constant (with the let introducer) because more items are added to the shopping list in the examples below.
 */
do {
    /// alse can creating like below
    var shoppingList = ["Eggs", "Milk"]
}

//: ## Accessing and Modifying an Array
do {
    print("The shopping list contains \(shoppingList.count) items.")

    shoppingList = ["Eggs", "Pigs"] //Both are the same

    if shoppingList.isEmpty { //Checks if count == 0
        ("The shopping list is empty.")
    } else {
        ("The shopping list is not empty.")
    }

    shoppingList.append("Cow") //At the end of the array
    shoppingList += ["Bird", "Shark"]
    shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

    /// Retrieve a value from the array by using subscript syntax, passing the index of the value you want to retrieve within square brackets immediately after the name of the array.
    var firstItem = shoppingList[0]
/*:
 - NOTE:
 The first item in the array has an index of 0, not 1. Arrays in Swift are always zero-indexed.
 */
    /// 0 替换
    shoppingList[0] = "Six eggs"
    shoppingList[0...2] = ["Bananas", "Apples", "Strawberries"]
    shoppingList
    /// Replace several items at once 只能确定替换的起始元素,结束序号由替换的数组长度决定,被替换的元素后移
    shoppingList[0...1] = ["Bananas", "Apples", "Strawberries"]
    shoppingList
    shoppingList[0...6] = ["Bananas", "Apples"]
    shoppingList
/*:
 - NOTE:
 You can’t use subscript syntax to append a new item to the end of an array.
 */

    shoppingList.insert("Maple Syrup", at: 0) //Inserts element at index

    let mapleSyrup = shoppingList.remove(at: 0) //Returns removed item
/*:
 - NOTE:
 If you try to access or modify a value for an index that is outside of an array’s existing bounds, you will trigger a runtime error. You can check that an index is valid before using it by comparing it to the array’s count property. Except when count is 0 (meaning the array is empty), the largest valid index in an array will always be count - 1, because arrays are indexed from zero.
 */
    var sl = shoppingList
    firstItem = sl[0]
    let Firstone = sl.removeFirst()
    let lastone = sl.removeLast()
    /// Pops the last item, removing it from the array and also returning it. Note that if the array is empty, the returned value is nil.
    sl.popLast()
    sl.removeAll()
}

//: ## Iterating Over an Array
do {
    for item in shoppingList {
        print(item)
    }

    for (index, value) in shoppingList.enumerated() {
        print("Item \(index + 1): \(value)")
    }

    var reversedShoppingList: [String] = shoppingList.reversed()
}
do {
    var food=["f1:apple","f2:orange","f3:banana","v1:tomato","v2:potato"]
    for fruit in food { //fruit为Let类型
        if fruit.hasPrefix("f"){
            print("f_fruit: \(fruit)")
        }
        if fruit.hasSuffix("o"){
            print("fruit_o: \(fruit)")
        }
    }
}

//: ## Array Example
do {
    var a10 = Array(0 ... 10) //包含10
    a10 = Array(0 ..< 10) //小于10
    let a10x = (0 ..< 10).map { i in i*i }
    a10x
    let indexOf6 = a10x.index(of:6)
    let indexOf81 = a10x.index(of:81)
    let indexOfFirstGreaterThanFive = a10x.index{$0 > 15}
    (indexOfFirstGreaterThanFive)
    let indexOfFirstGreaterThanOneHundred = a10x.index{$0 > 100}
    var filtered = a10.filter { $0 == 3 }  // <= returns [3]
    filtered
    a10.filter { $0 == 3 }.count > 0
    a10.contains(11) == true

    let chars = Array("howdy".characters)
    let kvs = Array(["hey": "ho", "nonny": "nonny no"])
    let strings: [String?] = Array(repeating: nil, count: 10)
}

/*:
 ### 判定两个数组是否共用相同元素
 通过使用恒等运算符(identity operators)( == and !=)来判定两个数组共用相同的储存空间或元素.
 */
do {
    let a = [1,3,4], b = [2,3,7], c = [1,3,4]
    a == b
    a != c
}

/*:
 ### Map
 map函数能够被数组调用，它接受一个闭包作为参数，作用于数组中的每个元素。闭包返回一个变换后的元素，接着将所有这些变换后的元素组成一个新的数组
 */
do {
    // 可以看到我们甚至可以不再定义可变的数组直接用不可变的就可以
    let numbers = [1,2,3]
    let sumNumbers = numbers.map { (number: Int) -> Int in
        return number + number
    }
    // 简便写法 因为map闭包里面的类型可以自动推断所以可以省略
    let sumNumbers1 = numbers.map { number in
        return number + number
    }
    // 可以省了return 但是循环次数多了一次 目前不知道这是什么原因(循环次数是3次这是4次) 结果是一样的
    let sumNumbers2 = numbers.map { number in number + number }
    print(sumNumbers2) // [2,4,6]
    // 最终简化写法
    let sumNumbers3 = numbers.map { $0 + $0 }
}
do {
    let arr = [String?]()
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
    print(arr)
}
do {
    let anim = CAKeyframeAnimation(keyPath:"position") // dummy
    let (oldP,p1,p2,newP) = (CGPoint.zero,CGPoint.zero,CGPoint.zero,CGPoint.zero) // dummy
    let points = [oldP,p1,p2,newP]
    anim.values = points.map {NSValue(cgPoint:$0)}
    print(anim.values)
    anim.values = points
    anim.values

    do {
        let sec = 0
        let ct = 10
        print(Array(0..<ct).map {IndexPath(row:$0, section:sec)})
        (0..<ct).map {IndexPath(row:$0, section:sec)}
        sec
    }
}

do { /// Map函数返回数组的元素类型不一定要与原数组相同
    let fruits = ["apple", "banana", "orange", ""]
    // 这里数组中存在一个""的字符串 为了后面来比较 map 和 flatMap
    let counts = fruits.map { fruit -> Int? in
        let length = fruit.characters.count
        guard length > 0 else {
            return nil
        }
        return length
    }
    // [Optional(5), Optional(6), Optional(6), nil]
    print(counts)

    let arr = [Any]()
    let arr2: [String] = arr.map {
        if $0 is String {
            return $0 as! String
        } else {
            return ""
        }
    }
    _ = arr2

    let array = [1,2,3,4,5,6]
    let isEven = array.map { $0 % 2 == 0 }
    let isEven1 = array.map { num in
        return num % 2 == 0
    }
    // [false, true, false, true, false, true]
    print(isEven)
}

/*:
 ### FlatMap
 flatMap 与 map 不同之处是:
 - 1. flatMap返回后的数组中不存在 nil 同时它会把Optional safely unwraps 解包(unwraps Optionals safely while eliminating nils);
 - 2. flatMap还能把数组中存有数组的数组 一同打开变成一个新的数组 ;
 - 3. flatMap也能把两个不同的数组合并成一个数组 这个合并的数组元素个数是前面两个数组元素个数的乘积
 */
do { // 1.
    let fruits = ["apple", "banana", "orange", ""]
    let counts = fruits.flatMap { fruit -> Int? in
        let length = fruit.characters.count
        guard length > 0 else {
            return nil
        }
        return length
    }
    // [5,6,6]
    print(counts)

    do {
        let arr: [String?] = ["Manny", nil, nil, "Moe", nil, "Jack", nil]
        let arr2 = arr.flatMap { $0 }
        (arr2)
    }
}
do {// 2.
    let array = [[1,2,3], [4,5,6], [7,8,9]]
    let arrayMap = array.map { $0 }
    // [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    print(arrayMap)
    let arrayFlatMap = array.flatMap { $0 }
    // [1, 2, 3, 4, 5, 6, 7, 8, 9]
    print(arrayFlatMap)
}
do {// 3.
    let fruits = ["apple", "banana", "orange"]
    let counts = [1, 2, 3]
    let fruitCounts = counts.flatMap { count in
        fruits.map { fruit in
            //        title + "(index)"
            // 也可以返回元组
            (fruit, count)
        }
    }
    // [("apple", 1), ("banana", 1), ("orange", 1), ("apple", 2), ("banana", 2), ("orange", 2), ("apple", 3), ("banana", 3), ("orange", 3)]
    print(fruitCounts)
}

/*:
 ### filter
 filter 可以取出数组中符合条件的元素 重新组成一个新的数组
 */
do {
    let numbers = [1,2,3,4,5,6]
    let evens = numbers.filter { $0 % 2 == 0 }
    // [2, 4, 6]
    print(evens)
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
    print(arr2)
}

/*:
 ### Reduce
 map,flatMap和filter方法都是通过一个已存在的数组，生成一个新的、经过修改的数组。然而有时候我们需要把所有元素的值合并成一个新的值 那么就用到了Reduce
 */
do {// 获得一个数组中所有元素的和
    let numbers = [1,2,3,4,5]
    let sum = numbers.reduce(0) { $0 + $1 }
    let sum1 = numbers.reduce(0) { total, num in
        return total + num
    }
    // 15
    print(sum)
}
do {// 合并成的新值不一定跟原数组中元素的类型相同
    let numbers = [1,5,1,8,8,8,8,8,8,8,8]
    // reduce 函数第一个参数是返回值的初始化值, 通过 "" 推导 是 String
    let tel = numbers.reduce("") { "\($0)" + "\($1)" }
    // 15188888888
    print(tel)
}
do {
    let arr = [[1, 2], [3, 4], [5, 6]]
    let flat = arr.reduce([], +) // [1, 2, 3, 4, 5, 6]
    print(flat)
}
do {
    // interesting misuse of `reduce`: implement each_cons
    // this is probably incredibly inefficient but it was fun to write
    let arr = [1,2,3,4,5,6,7,8]
    let clump = 2
    let cons : [[Int]] = arr.reduce([[Int]]()) {
        memo, cur in
        var memo = memo
        if memo.count == 0 {
            return [[cur]]
        }
        if memo.count < arr.count - clump + 1 {
            memo.append([])
        }
        return memo.map {
            if $0.count == clump {
                return $0
            }
            var arr = $0
            arr.append(cur)
            return arr
        }
    }
    print(cons)
}

extension Array {
    
    func mMap<U> (transform: (Element) -> U) -> [U] {
        return reduce([], { $0 + [transform($1)] })
    }

    func mFilter (includeElement: (Element) -> Bool) -> [Element] {
        return reduce([]) { includeElement($1) ? $0 + [$1] : $0 }
    }
}


/*:
 ### partition
 partition 会根据条件把集合里的元素重新排序，符合条件的元素移动到最后，返回一个两个部分分界元素的索引, 再通过prefix和suffix可以分别获得集合的两段元素。
 */
do {
    var numbers = [30, 40, 20, 30, 30, 60, 10]
    let p = numbers.partition(by: { $0 > 30 })
    // p == 5
    // numbers == [30, 10, 20, 30, 30, 60, 40]

    let head = numbers.prefix(upTo: p)
    // head == [30, 10, 20, 30, 30]
    let end = numbers.suffix(from: p)
    // end == [60, 40]
}

/*:
 ### sequence(first: next: )

 根据next里的闭包来生成下一个元素，和reduce完全相反。特别的是这个函数返回的是一个 UnfoldSequence ，即里面的值是lazy的，只要在访问时才生成，这也可能是一个无限的队列。

 似乎特别适合用来寻祖，当next闭包返回的是nil时队列就终止了:

    for view in sequence(first: someView, next: { $0.superview }) {
        // someView, someView.superview, someView.superview.superview, ...
    }
 */
do {
    for x in sequence(first: 0.1, next: { $0 * 2 }).prefix(while: { $0 < 4 }) {
        print(x)// 0.1, 0.2, 0.4, 0.8, ...
    }
}

/*:
 ### lexicographicallyPrecedes
 
 返回一个布尔值，指示序列在词典（字典）排序中是否先于另一个序列，使用小于运算符（<）来比较元素。


 lexicographic 是词典的意思。这个方法声明在 AnyCollection 里。会按照顺序比较两个集合元素的大小。
 */
extension String {
    func versionToInt() -> [Int] {
        return self.characters.split(separator: ".").map { Int.init(String($0)) ?? 0 }
    }
}
do {
    let storeVersion = "3.14.10"
    let currentVersion = "3.130.10"

    storeVersion.versionToInt()
    currentVersion.versionToInt()
    //true
    storeVersion.versionToInt().lexicographicallyPrecedes(currentVersion.versionToInt())

    /// 此示例使用词典预测法来测试字符串排序中的哪个整数数组是第一个。
    let a = [1, 2, 2, 2]
    let b = [1, 2, 3, 4]

    print(a.lexicographicallyPrecedes(b))
    // Prints "true"
    print(b.lexicographicallyPrecedes(b))
    // Prints "false"
}

/*:
 ### reserveCapacity

 如果明确的知道一个数组的容量大小，可以调用这个方法告诉系统这个数组至少需要的容量，避免在数组添加元素过程中重复的申请内存。
 */
do {
    var alphabet = [String]()
    alphabet.reserveCapacity(26)
}

/*:
 ### sort
 */
do {
    var arr = [4,3,5,2,6,1]
    arr.sort()
    arr.sort {$0 > $1} // *** [1, 2, 3, 4, 5, 6]
    arr = [4,3,5,2,6,1]
    arr.sort(by:>) // *** [1, 2, 3, 4, 5, 6]
}

/*:
 ### joined
 Returns the elements of this collection of collections, concatenated. 返回集合集合的元素，连接。
 */
do {
    /// In this example, an array of three ranges is flattened so that the elements of each range can be iterated in turn. 将三个范围的数组变平，以便依次迭代每个范围的元素。
    let ranges = [0..<3, 8..<10, 15..<17]

    // A for-in loop over 'ranges' accesses each range:
    for range in ranges {
        print(range)
    }
    // Prints "0..<3"
    // Prints "8..<10"
    // Prints "15..<17"

    // Use 'joined()' to access each element of each range:
    for index in ranges.joined() {
        print(index, terminator: " ")
    }
    // Prints: "0 1 2 8 9 15 16"
}


//: # Sets
/*:
 - NOTE:
 Swift’s Set type is bridged to Foundation’s NSSet class.
 */

//: ## Hash Values for Set Types
/*:
 A type must be hashable in order to be stored in a set—that is, the type must provide a way to compute a hash value for itself. A hash value is an Int value that is the same for all objects that compare equally, such that if a == b, it follows that a.hashValue == b.hashValue.
 All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default, and can be used as set value types or dictionary key types. Enumeration case values without associated values (as described in Enumerations) are also hashable by default.
 - NOTE:
 You can use your own custom types as set value types or dictionary key types by making them conform to the Hashable protocol from Swift’s standard library. Types that conform to the Hashable protocol must provide a gettable Int property called hashValue. The value returned by a type’s hashValue property is not required to be the same across different executions of the same program, or in different programs.
 Because the Hashable protocol conforms to Equatable, conforming types must also provide an implementation of the equals operator (==). The Equatable protocol requires any conforming implementation of == to be an equivalence relation. That is, an implementation of == must satisfy the following three conditions, for all values a, b, and c:
 a == a (Reflexivity 自反性)
 a == b implies b == a (Symmetry 对称性)
 a == b && b == c implies a == c (Transitivity 传递性)
 For more information about conforming to protocols, see [Next](@https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID267.)
 */

//: ## Set Type Syntax
//: The type of a Swift set is written as Set<Element>, where Element is the type that the set is allowed to store. Unlike arrays, sets do not have an equivalent shorthand form.

//: ## Creating and Initializing an Empty Set
do {
    var letters = Set<Character>()
    /// The type of the letters variable is inferred to be Set<Character>, from the type of the initializer.
    print("letters is of type Set<Character> with \(letters.count) items.")
    letters.insert("a")
    // letters now contains 1 value of type Character
    letters = []
    // letters is now an empty set, but is still of type Set<Character>
}

//: ## Creating a Set with an Array Literal
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
do {
    /// A set type cannot be inferred from an array literal alone, so the type Set must be explicitly declared. However, because of Swift’s type inference, you don’t have to write the type of the set if you’re initializing it with an array literal containing values of the same type. The initialization of favoriteGenres could have been written in a shorter form instead:
    var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
}

//: ## Accessing and Modifying a Set
do {
    print("I have \(favoriteGenres.count) favorite music genres.")

    if favoriteGenres.isEmpty {
        print("As far as music goes, I'm not picky.")
    } else {
        print("I have particular music preferences.")
    }

    favoriteGenres.insert("Jazz")

    if let removedGenre = favoriteGenres.remove("Rock") {
        print("\(removedGenre)? I'm over it.")
    } else {
        print("I never much cared for that.")
    }

    if favoriteGenres.contains("Funk") {
        print("I get up on the good foot.")
    } else {
        print("It's too funky in here.")
    }
}

//: ## Iterating Over a Set 迭代
do {
    for genre in favoriteGenres {
        print("\(genre)")
    }
    for genre in favoriteGenres.sorted() {
        print("\(genre)")
    }
}

//: ## Set to Array
do {
    var s = Set<Int>()
    s.insert(1)
    let arr = Array(s)
    let nsArr = Array(s) as NSArray
    print(nsArr)
}

//: ## Example
do {
    let arr = [1,2,1,3,2,4,3,5]
    let set = Set(arr)
    let arr2 = Array(set) // [5,2,3,1,4], perhaps
}

do {
    let set : Set = [1,2,3,4,5]
    let set2 = Set(set.map {$0+1}) // {6, 5, 2, 3, 4}, perhaps
}

do {
    let opts = UIViewAnimationOptions(rawValue:0b00011000)
    _ = opts
}

do {
    let val = UIViewAnimationOptions.autoreverse.rawValue | UIViewAnimationOptions.repeat.rawValue
    let opts = UIViewAnimationOptions(rawValue: val)
    print(opts)
}

do {
    let opts : UIViewAnimationOptions = [.autoreverse, .repeat]
    print(opts)
}

do {
    var opts = UIViewAnimationOptions.autoreverse
    _ = opts.insert(.repeat)
    print(opts)
}

do {
    UIView.animate(withDuration:0.4, delay: 0, options: [.autoreverse, .repeat],
                   animations: {
                    // ...
    })
}

do {
    let RECENTS = "recents"
    let PIXCOUNT = 20
    func test() {
        let ud = UserDefaults.standard
        var recents = ud.object(forKey:RECENTS) as? [Int]
        if recents == nil {
            recents = []
        }
        var forbiddenNumbers = Set(recents!)
        let legalNumbers = Set(1...PIXCOUNT).subtracting(forbiddenNumbers)
        let newNumber = Array(legalNumbers)[
            Int(arc4random_uniform(UInt32(legalNumbers.count)))
        ]
        forbiddenNumbers.insert(newNumber)
        ud.set(Array(forbiddenNumbers), forKey:RECENTS)
    }
}

do {
    class MyTableViewCell : UITableViewCell {
        override func didTransition(to state: UITableViewCellStateMask) {
            let editing = UITableViewCellStateMask.showingEditControlMask.rawValue
            if state.rawValue & editing != 0 {
                // ... the ShowingEditControlMask bit is set ...
            }
            if state.contains(.showingEditControlMask) {
                // ... the ShowingEditControlMask bit is set ...
            }
        }
    }
}

//: # Performing Set Operations

//: ## Fundamental Set Operations
/*:
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/setVennDiagram_2x.png
 - Use the intersection(_:) method to create a new set with only the values common to both sets.
 - Use the symmetricDifference(_:) method to create a new set with values in either set, but not both.
 - Use the union(_:) method to create a new set with all of the values in both sets.
 - Use the subtracting(_:) method to create a new set with values not in the specified set.
 */
do {
    let oddDigits: Set = [1, 3, 5, 7, 9]
    let evenDigits: Set = [1, 2, 4, 6, 8]
    let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

    oddDigits.union(evenDigits).sorted()
    // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    oddDigits.intersection(evenDigits).sorted()
    // []
    oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
    // [1, 9]
    /// 对称差分
    oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
    // [1, 2, 9]
}

//: ## Set Membership and Equality
/*:
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/setEulerDiagram_2x.png
 - Use the “is equal” operator (==) to determine whether two sets contain all of the same values.
 - Use the isSubset(of:) method to determine whether all of the values of a set are contained in the specified set.
 - Use the isSuperset(of:) method to determine whether a set contains all of the values in a specified set.
 - Use the isStrictSubset(of:) or isStrictSuperset(of:) methods to determine whether a set is a subset or superset, but not equal to, a specified set.
 - Use the isDisjoint(with:) method to determine whether two sets have any values in common.
 */
do {
    let houseAnimals: Set = ["🐶", "🐱"]
    let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
    let cityAnimals: Set = ["🐦", "🐭"]

    houseAnimals.isSubset(of: farmAnimals)
    farmAnimals.isSuperset(of: houseAnimals)
    farmAnimals.isDisjoint(with: cityAnimals)
}


//: # Dictionaries
//: Swift’s Dictionary type is bridged to Foundation’s NSDictionary class.
/*
 ## Dictionary Type Shorthand Syntax
 The type of a Swift dictionary is written in full as Dictionary<Key, Value>, where Key is the type of value that can be used as a dictionary key, and Value is the type of value that the dictionary stores for those keys.
 - NOTE:
 A dictionary Key type must conform to the Hashable protocol, like a set’s value type.
 You can also write the type of a dictionary in shorthand form as [Key: Value]. Although the two forms are functionally identical, the shorthand form is preferred and is used throughout this guide when referring to the type of a dictionary.
 */

//: ## Creating an Empty Dictionary
var namesOfIntegers = [Int: String]() //Its keys are of type Int, and its values are of type String.
do {
    namesOfIntegers[16] = "sixteen"
    // namesOfIntegers now contains 1 key-value pair
    namesOfIntegers = [:]
    // namesOfIntegers is once again an empty dictionary of type [Int: String]
    namesOfIntegers[10] = "ten"
    namesOfIntegers[16] = nil
    print(namesOfIntegers[16])
}

//: ## Creating a Dictionary with a Dictionary Literal
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
do {
    var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

    let personErr = ["age":18,"name":"Jack","height":178] as [String : Any]

    var dict = Dictionary<String,Int>()
    dict["age"] = 16

    var scores: [String: Int]
    scores = Dictionary<String,Int>(minimumCapacity: 5)
}

//: ## Accessing and Modifying a Dictionary
do {
    print("The airports dictionary contains \(airports.count) items.")

    if airports.isEmpty {
        print("The airports dictionary is empty.")
    } else {
        print("The airports dictionary is not empty.")
    }

    /// add a new item to a dictionary with subscript syntax. 前提是key不存在,则自动添加k-v对, 否则change the value.
    airports["LHR"] = "London"
    /// use subscript syntax to change the value associated with a particular key:
    airports["LHR"] = "London Heathrow"

    /// use a dictionary’s updateValue(_:forKey:) method to set or update the value for a particular key.
    /// Updates or creates the value. Returns optional w/ previous value 返回 old key-value, if key 不存在 return nil
    if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
        print("The old value for DUB was \(oldValue).")
    }

    /// use subscript syntax to retrieve a value from the dictionary for a particular key.
    /// Subscript always returns optional in case value is not set.
    if let airportName = airports["DUB"] {
        print("The name of the airport is \(airportName).")
    } else {
        print("That airport is not in the airports dictionary.")
    }

    /// use subscript syntax to remove a key-value pair from a dictionary by assigning a value of nil for that key
    airports["APL"] = "Apple International"
    // "Apple International" is not the real airport for APL, so delete it
    airports["APL"] = nil
    // APL has now been removed from the dictionary
    airports.removeValue(forKey:"APL")
    //Both remove the key-value pair
}

//: ## Iterating Over a Dictionary
do {
    for (airportCode, airportName) in airports {
        print("\(airportCode): \(airportName)")
    }
    for airportCode in airports.keys {
        print("Airport code: \(airportCode)")
    }
    for airportName in airports.values {
        print("Airport name: \(airportName)")
    }

    /// If you need to use a dictionary’s keys or values with an API that takes an Array instance, initialize a new array with the keys or values property:
    let airportCodes = [String](airports.keys)
    let airportNames = [String](airports.values)
}
/*:
 - NOTE:
 Swift’s Dictionary type does not have a defined ordering. To iterate over the keys or values of a dictionary in a specific order, use the sorted() method on its keys or values property.
 */

//: ## Example
do {
    class Dog {}
    class NoisyDog : Dog {}

    let dog1 : Dog = NoisyDog()
    let dog2 : Dog = NoisyDog()
    let d = ["fido": dog1, "rover": dog2]
    let d2 = d as! [String : NoisyDog]
    print(d2)
}

do {
    let d = ["CA": "California", "NY": "New York"]
    for s in d.keys {
        print(s)
    }

    let keys = Array(d.keys)

    for (abbrev, state) in d {
        print("\(abbrev) stands for \(state)")
    }

    let arr = Array(d) // [(key: "NY", value: "New York"), (key: "CA", value: "California")]
    print(arr)
}



do {
    var d1 = ["NY":"New York", "CA":"California"]
    let d2 = ["MD":"Maryland"]
    let mutd1 = NSMutableDictionary(dictionary:d1)
    mutd1.addEntries(from:d2)
    d1 = mutd1 as! [String:String]
    // d1 is now ["MD": "Maryland", "NY": "New York", "CA": "California"]
    print(d1)
}

extension Dictionary {
    mutating func addEntries(from d:[Key:Value]) {
        for (k,v) in d {
            self[k] = v
        }
    }
}
do {
    var d1 = ["NY":"New York", "CA":"California"]
    let d2 = ["MD":"Maryland"]
    d1.addEntries(from:d2)
    print(d1)
}

do {
    let d : [String:Int] = ["one":1, "two":2]
    let sum = d.values.reduce(0, +) // ***
    print(sum)

    let min = d.values.min()
    print(min) // Optional(1)

    let arr = Array(d.values.filter{$0 < 2})
    print(arr)

    let keysSorted = d.keys.sorted()
    print(keysSorted)
}

do {
    class ViewController: UIViewController {

        var progress = 0.0

        override func viewDidLoad() {
            super.viewDidLoad()

            let nc = NotificationCenter.default
            let test = Notification.Name("test")
            nc.addObserver(self, selector:#selector(notificationArrived), name: test, object: nil)
            nc.post(name:test, object: self, userInfo: ["junk":"nonsense"])
            nc.post(name:test, object: self, userInfo: ["progress":"nonsense"])
            nc.post(name:test, object: self, userInfo: ["progress":3])
        }

        func notificationArrived(_ n:Notification) {
            let prog = (n.userInfo?["progress"] as? NSNumber)?.doubleValue
            if prog != nil {
                self.progress = prog!
                print("at last! \(self.progress)")
            } else {
                print("invalid notification")
            }
        }
        
        func anotherWay(n:Notification) {
            if let prog = n.userInfo?["progress"] as? Double { // chapter 10
                self.progress = prog
            }
        }
    }
}

//: [Next](@next)
