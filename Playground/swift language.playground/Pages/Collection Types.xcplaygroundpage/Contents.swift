//: [Previous](@previous)

/*: 
 # Collection Types
 Swift provides three primary collection types, known as arrays, sets, and dictionaries, for storing collections of values. Arrays are ordered collections of values. Sets are unordered collections of unique values. Dictionaries are unordered collections of key-value associations.
 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/CollectionTypes_intro_2x.png
 Arrays, sets, and dictionaries in Swift are always clear about the types of values and keys that they can store. This means that you cannot insert a value of the wrong type into a collection by mistake. It also means you can be confident about the type of values you will retrieve from a collection.
 - NOTE:
 Swift’s array, set, and dictionary types are implemented as generic collections.
 */
/*: 
 # Mutability of Collections
 If you create an array, a set, or a dictionary, and assign it to a variable, the collection that is created will be mutable. This means that you can change (or mutate) the collection after it is created by adding, removing, or changing items in the collection. If you assign an array, a set, or a dictionary to a constant, that collection is immutable, and its size and contents cannot be changed.
 - NOTE:
 It is good practice to create immutable collections in all cases where the collection does not need to change. Doing so makes it easier for you to reason about your code and enables the Swift compiler to optimize the performance of the collections you create.
 */


/*:
 # Arrays
 - NOTE:
 Swift’s Array type is bridged to Foundation’s NSArray class.
 For more information about using Array with Foundation and Cocoa, see https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/WorkingWithCocoaDataTypes.html#//apple_ref/doc/uid/TP40014216-CH6 in https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/index.html#//apple_ref/doc/uid/TP40014216.
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












var shoppingList: [String] = ["Eggs", "Pigs"]
shoppingList = ["Eggs", "Pigs"] //Both are the same

if shoppingList.isEmpty { //Checks if count == 0
    ("The shopping list is empty.")
} else {
    ("The shopping list is not empty.")
}

shoppingList.append("Cow") //At the end of the array
shoppingList += ["Bird", "Shark"]
shoppingList[0...2] = ["Bananas", "Apples", "Strawberries"] //0-4替换添加
shoppingList
shoppingList[0...1] = ["Bananas", "Apples", "Strawberries"] //Replace several items at once 只能确定替换的起始元素,结束序号由替换的数组长度决定,被替换的元素后移
shoppingList

shoppingList.insert("Maple Syrup", at: 0) //Inserts element at index

let mapleSyrup = shoppingList.remove(at: 0) //Returns removed item

var emptyArray = [Int]() //Initialize empty array
emptyArray = [] //Also valid
var array = [Int](repeating: 0, count: 3) //Initalizes an array of lenght 3 with zeros

var compoundArray = array + emptyArray

var reversedShoppingList: [String] = shoppingList.reversed()

reversedShoppingList.removeLast() //Removes last item. Remove the first with removeFirst(). No returned value.
reversedShoppingList.popLast() //Pops the last item, removing it from the array and also returning it. Note that if the array is empty, the returned value is nil.
reversedShoppingList.removeFirst()
reversedShoppingList.removeAll()

var myArr = Array<String>()
var num = Array<Int>(repeating: 6, count: 3)
var arr:[Int] = [1,2,3]
var someInt=[Int]()

var nsObjectArray: [Any] = ["Eggs", 123, true] //推断为Any数组

var food=["f1:apple","f2:orange","f3:banana","v1:tomato","v2:potato"]
for fruit in food { //fru为Let类型
    if fruit.hasPrefix("f"){
        ("f_fruit: \(fruit)")
    }
    if fruit.hasSuffix("o"){
        ("fruit_o: \(fruit)")
    }
}
food[3]

var a10 = Array(0 ... 10) //包含10
a10 = Array(0 ..< 10) //小于10
let a10x = (0 ..< 10).map { i in i*i }
a10x
let indexOf6 = a10x.index(of:6)
let indexOf81 = a10x.index(of:81)
let indexOfFirstGreaterThanFive = a10x.index{$0 > 5}
(indexOfFirstGreaterThanFive)
let indexOfFirstGreaterThanOneHundred = a10x.index{$0 > 100}
var filtered = a10.filter { $0 == 3 }  // <= returns [3]
filtered
a10.filter { $0 == 3 }.count > 0
a10.contains(11) == true

//斐波纳契序列
//struct FibonacciSequence : Sequence {
//    let upperBound: Int
//    func generate() -> AnyIterator<Int> {
//        var current = 1
//        var next = 1
//        return AnyGenerator {
//            if current > self.upperBound {
//                return nil
//            }
//            let result = current
//            current = next
//            next += result
//            return result
//        };
//    }
//}
//let fibseq = FibonacciSequence(upperBound: 100)
//let aFibseq = Array(fibseq)
//
//var nsArray: NSArray = [1,2,3,4,5] //Foundation类型
//nsArray.componentsJoinedByString("-")

/*:
 数组类型的赋值和拷贝行为要比字典(Dictionary)类型的复杂的多.
 当操作数组内容时,数组(Array)能提供接近C语言的的性能,并且拷贝行为只有在必要时才会发生.
 如果你将一个数组(Array)实例赋给一个变量或常量,或者将其作为参数传递给函数或方法调用,在事件发生时数组的内容不会被拷贝.
 相反,数组公用相同的元素序列.当你在一个数组内修改某一元素,修改结果也会在另一数组显示.
 对数组来说,拷贝行为仅仅当操作有可能修改数组长度时才会发生:
 - 包括了附加(appending)
 - 插入(inserting)
 - 删除(removing)
 - 使用范围下标(ranged subscript)去替换这一范围内的元素.
 只有当数组拷贝确要发生时,数组内容的行为规则与字典中键值的相同.
 - Note:
 确保数组的唯一性
 在操作一个数组，或将其传递给函数以及方法调用之前是很有必要先确定这个数组是有一个唯一拷贝的。
 通过在数组变量上调用unshare方法来确定数组引用的唯一性。(当数组赋给常量时，不能调用unshare方法)
 如果一个数组被多个变量引用，在其中的一个变量上调用unshare方法，则会拷贝此数组，此时这个变量将会有属于它自己的独立数组拷贝。
 当数组仅被一个变量引用时，则不会有拷贝发生。
 在上一个示例的最后，b和c都引用了同一个数组。此时在b上调用unshare方法则会将b变成一个唯一个拷贝.
 */

var a = [1, 2, 3]
var b = a
var c = a
//: 如果通过下标语法修改数组中某一元素的值，那么a,b,c中的相应值不会都会发生改变。请注意当你用下标语法修改某一值时，并没有拷贝行为伴随发生，因为下表语法修改值时没有改变数组长度的可能：
a[0] = 42
(a[0])
(b[0])
(c[0])
/*: 
 然而，当你给a附加新元素时，数组的长度会改变。当附加元素这一事件发生时，Swift 会创建这个数组的一个拷贝。从此以后，a将会是原数组的一个独立拷贝。
 拷贝发生后，如果再修改a中元素值的话，a将会返回与b，c不同的结果，因为后两者引用的是原来的数组：
 */
a.append(4)
a[0] = 777
(a[0])
(b[0])
(c[0])
/*:
 判定两个数组是否共用相同元素
 我们通过使用恒等运算符(identity operators)( === and !==)来判定两个数组或子数组共用相同的储存空间或元素。
 */
import UIKit
/*: 
 Arrays and dictionaries in swift use generics and can be mutable or immutable
 depending on whether they are assigned to a var or let
 Structs are VALUE types, which means that when working with mutating functions, you'll need to store them in "var". Everytime the struct is "mutated", a new struct will be created and stored in that var.
 */


//: ## Dictionaries

var airports: [String: String] = ["JFK": "John F. Kennedy", "SCL": "Arturo Merino Benitez"]
airports = ["JFK": "John F. Kennedy", "SCL": "Arturo Merino Benitez"] //Also valid
airports["JFK"] = "New York"

airports.updateValue("Los Angeles", forKey:"LAX") //Updates or creates the value. Returns optional w/ previous value 返回 old key-value, if key 不存在 return nil
airports

if let airportName = airports["LAX"] { //Subscript always returns optional in case value is not set.
    ("The name of the airport is \(airportName).")
} else {
    ("That airport is not in the airports dictionary.")
}

airports["LAX"] = nil
airports.removeValue(forKey:"LAX") //Both remove the key-value pair
airports["HZ"] = "Hang Zhou" //不存在的Key设置Value,dict自动添加k-v对
//: ### 迭代
//Iterating over the whole dictionary
for (key, value) in airports {
    ("\(key): \(value)")
}
//Iterating on Keys
for airportCode in airports.keys {
    ("Airport code: \(airportCode)")
}
//Iterating on Values
for airportName in airports.values {
    ("Airport name: \(airportName)")
}
//: 空字典 Empty Dictionaries
var numbers = [Int: String]()
numbers = [:] //Both do the same
numbers[16] = "sixteen"
var emptyDic: [String:Double] = [:]
emptyDic.isEmpty
emptyDic=[:]

var personErr = ["age":18,"name":"Jack","height":178] as [String : Any]
var person = ["age":"18", "name":"Jack","height":"178"] //String类型
person["age"]
var height:String? = person["height"]
if height != nil {
    (height)
}
var dict = Dictionary<String,Int>()
dict["age"] = 16

var scores: [String: Int]
scores = Dictionary<String,Int>(minimumCapacity: 5)
//: 获取keys或values可用计数
let keyArr = [String](person.keys)
let keyValue = [String](person.values)
/*:
 - NOTE:
 You can use your own custom types as dictionary key types by making them conform to the Hashable protocol from Swift’s standard library.
 Types that conform to the Hashable protocol must provide a gettable Int property called hashValue, and must also provide an implementation of the “is equal” operator (==). The value returned by a type’s hashValue property is not required to be the same across different executions of the same program, or in different programs.
 */
//: All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default


//: [Next](@next)
