//: [Previous](@previous)
import Foundation
//: # Array

//: Array map
do {
    let arr = [1, 2, 3]
    let arr2 = arr.map { $0 * 2 }
    let arr3 = arr.map { Double($0) }
    
    let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    let lowercaseNames = cast.map { $0.lowercased() }
    lowercaseNames
    let letterCounts = cast.map { $0.characters.count }
    letterCounts
}

//: Array forEach
do {
    let cast = ["Vivien", "Marlon", "Kim", "Karl"]
    cast.forEach { print($0) } //TODO: 5 times
    cast.enumerated().forEach { print("cast \($0.0) is \($0.1)") }
}

//: Array enumerated
do {
    for (n, c) in "Swift".characters.enumerated() {
        ("\(n): '\(c)'")
    }
    
    do {
        let pepboys = ["Manny", "Moe", "Jack"]
        
        for pepboy in pepboys {
            (pepboy)
        }
        
        for (ix, pepboy) in pepboys.enumerated() {
            ("Pep boy \(ix) is \(pepboy)")
        }
    }
    
    let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
    var shorterIndices: [SetIndex<String>] = []
    /// indices 对集合下标生成有效的递增顺序索引。
    for (i, name) in zip(names.indices, names) {
        if name.characters.count <= 5 {
            shorterIndices.append(i)
        }
    }
    for i in shorterIndices {
        (names[i])
    }
    
}

//: Array zip
do {
    /// 从两个基础序列构建的成对序列。
    let words = ["one", "two", "three", "four"]
    let numbers = 1...4
    
    for (word, number) in zip(words, numbers) {
        ("\(word): \(number)")
    }
    
    let naturalNumbers = 1...Int.max
    let zipped = Array(zip(words, naturalNumbers))
}
//: Array filter
do {
    let names = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
    let arr = names.filter { $0.hasPrefix("M") }
    arr
}

//: Array reduce
do {
    let arrr = [1, 4, 9, 13, 112]
    _ = arrr.reduce(0) { $0 + $1 }
    _ = arrr.reduce(0, +)
}

/*:
 ## Objects Array
 */
protocol Flier { }
struct Bird : Flier { var name = "Tweety" }
struct Insect : Flier { }
class Dog { }
class NoisyDog : Dog { }

do {
    /// homogeneous collection
    let dogs = [Dog(), NoisyDog()] //Dog
    
    /// heterogenous collection
    /// literal could only be inferred to '[Any]' add explicit type annotation if this is intentional 异构集合 msust use Any
    let objs = [1, "howdy"] as [Any]
    let arrr = [Insect(), Bird()] as [Flier]
    let arr: [Flier] = [Insect(), Bird()]
    
    do {
        let arr2: [Flier] = [Insect()]
        /// Maybe crash at runtime: Use array-casting to cast down from protocol type to adopter type 使用数组转换从协议类型转换为适配器类型
        let arr3 = arr2 as! [Insect]
        _ = arr2
    }
    do {
        let arr2: [Flier] = [Insect()]
        /// instead of above, to cast down, must cast individual elements down
        let arr3 = arr2.map { $0 as! Insect }
    }
}
/*:
 ## Extension
 - remove [int]
 */
extension Array {
    mutating func remove(at ixs:Set<Int>) -> () {
        for i in Array<Int>(ixs).sorted(by:>) {
            self.remove(at:i)
        }
    }
}

do {
    var arr = [1,2,3,4]
    arr.remove(at:[0,2])
}

//: # NSArray
/*:
 - sortedArray(comparator)
 */
do {
    let arr = ["Manny", "Rock", "Jack", "Tidy"]
    
    func sortByLastCharacter(_ s1: Any,
                             _ s2: Any, _ context: UnsafeMutableRawPointer?) -> Int {
        let c1 = (s1 as! String).characters.last
        let c2 = (s2 as! String).characters.last
        return ((String(describing: c1)).compare(String(describing: c2))).rawValue
    }
    
    let arr2 = (arr as NSArray).sortedArray(sortByLastCharacter, context: nil)
    
    let arr3 = (arr as NSArray).sortedArray({
        s1, s2, context in
        let c1 = (s1 as! String).characters.first
        let c2 = (s2 as! String).characters.first
        return ((String(describing: c1)).compare(String(describing: c2))).rawValue
    }, context:nil)
}

//: [Next](@next)
