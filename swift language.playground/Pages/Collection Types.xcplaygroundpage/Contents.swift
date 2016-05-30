//: [Previous](@previous)

// Collection Types

import UIKit

// Arrays and dictionaries in swift use generics and can be mutable or immutable
// depending on whether they are assigned to a var or let
// Structs are VALUE types, which means that when working with mutating functions, you'll need to store them in "var". Everytime the struct is "mutated", a new struct will be created and stored in that var.

//Arrays
var shoppingList: [String] = ["Eggs", "Pigs"]
shoppingList = ["Eggs", "Pigs"] //Both are the same

if shoppingList.isEmpty { //Checks if count == 0
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}

shoppingList.append("Cow") //At the end of the array
shoppingList += ["Bird", "Shark"]
shoppingList[0...2] = ["Bananas", "Apples", "Strawberries"] //0-4替换添加
shoppingList
shoppingList[0...1] = ["Bananas", "Apples", "Strawberries"] //Replace several items at once 只能确定替换的起始元素,结束序号由替换的数组长度决定,被替换的元素后移
shoppingList

shoppingList.insert("Maple Syrup", atIndex: 0) //Inserts element at index

let mapleSyrup = shoppingList.removeAtIndex(0) //Returns removed item

var emptyArray = [Int]() //Initialize empty array
emptyArray = [] //Also valid
var array = [Int](count: 3, repeatedValue: 0) //Initalizes an array of lenght 3 with zeros

var compoundArray = array + emptyArray

var reversedShoppingList: [String] = shoppingList.reverse()

reversedShoppingList.removeLast() //Removes last item. Remove the first with removeFirst(). No returned value.
reversedShoppingList.popLast() //Pops the last item, removing it from the array and also returning it. Note that if the array is empty, the returned value is nil.
reversedShoppingList.removeFirst()
reversedShoppingList.removeAll()

var myArr = Array<String>()
var num = Array<Int>(count: 3, repeatedValue: 6)
var arr:[Int] = [1,2,3]
var someInt=[Int]()

var nsObjectArray = ["Eggs",123,true] //推断为NSObject数组

var food=["f1:apple","f2:orange","f3:banana","v1:tomato","v2:potato"]
for fruit in food { //fru为Let类型
    if fruit.hasPrefix("f"){
        print("f_fruit: \(fruit)")
    }
    if fruit.hasSuffix("o"){
        print("fruit_o: \(fruit)")
    }
}
food[3]

var a10 = Array(0 ... 10) //包含10
a10 = Array(0 ..< 10) //小于10
let a10x = (0 ..< 10).map { i in i*i }

//斐波纳契序列
struct FibonacciSequence : SequenceType {
    let upperBound: Int
    func generate() -> AnyGenerator<Int> {
        var current = 1
        var next = 1
        return AnyGenerator {
            if current > self.upperBound {
                return nil
            }
            let result = current
            current = next
            next += result
            return result
        };
    }
}
let fibseq = FibonacciSequence(upperBound: 100)
let aFibseq = Array(fibseq)

var nsArray: NSArray = [1,2,3,4,5] //Foundation类型
nsArray.componentsJoinedByString("-")



//Dictionaries

var airports: [String: String] = ["JFK": "John F. Kennedy", "SCL": "Arturo Merino Benitez"]
airports = ["JFK": "John F. Kennedy", "SCL": "Arturo Merino Benitez"] //Also valid
airports["JFK"] = "New York"

airports.updateValue("Los Angeles", forKey:"LAX") //Updates or creates the value. Returns optional w/ previous value 返回 old key-value, if key 不存在 return nil
airports

if let airportName = airports["LAX"] { //Subscript always returns optional in case value is not set.
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}

airports["LAX"] = nil
airports.removeValueForKey("LAX") //Both remove the key-value pair
airports["HZ"] = "Hang Zhou" //不存在的Key设置Value,dict自动添加k-v对

//迭代
//Iterating over the whole dictionary
for (key, value) in airports {
    print("\(key): \(value)")
}
//Iterating on Keys
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
//Iterating on Values
for airportName in airports.values {
    print("Airport name: \(airportName)")
}

//空字典
//Empty Dictionaries
var numbers = [Int: String]()
numbers = [:] //Both do the same
numbers[16] = "sixteen"
var emptyDic: [String:Double] = [:]
emptyDic.isEmpty
emptyDic=[:]

var personErr = ["age":18,"name":"Jack","height":178] //NSObject类型
var person = ["age":"18","name":"Jack","height":"178"] //String类型

person["age"]

var height:String? = person["height"]
if height != nil {
    print(height)
}

var dict = Dictionary<String,Int>()
dict["age"] = 16

var scores: [String: Int]
scores = Dictionary<String,Int>(minimumCapacity: 5)

let keyArr = [String](person.keys)
let keyValue = [String](person.values)


// NOTE

// You can use your own custom types as dictionary key types by making
// them conform to the Hashable protocol from Swift’s standard library.
// Types that conform to the Hashable protocol must provide a
// gettable Int property called hashValue, and must also provide an
// implementation of the “is equal” operator (==). The value returned by a
// type’s hashValue property is not required to be the same across different
// executions of the same program, or in different programs.

// All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default


//: [Next](@next)
