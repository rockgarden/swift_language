//: [Previous](@previous)
import Foundation
//: # Array
do {
    var arr = [Int]()
    _ = arr
    arr = []

    let rs = Array(1...3)
    let chars = Array("howdy".characters)
    let kvs = Array(["hey": "ho", "nonny": "nonny no"])
    let strings: [String?] = Array(repeating: nil, count: 10)
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
