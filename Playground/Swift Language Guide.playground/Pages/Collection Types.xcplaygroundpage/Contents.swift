//: [Previous](@previous)

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

//: ## Example
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
}

/*:
 ## 判定两个数组是否共用相同元素
 通过使用恒等运算符(identity operators)( == and !=)来判定两个数组共用相同的储存空间或元素.
 */
do {
    let a = [1,3,4], b = [2,3,7], c = [1,3,4]
    a == b
    a != c
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
 For more information about conforming to protocols, see https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID267.
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
    let evenDigits: Set = [0, 2, 4, 6, 8]
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


//: [Next](@next)
