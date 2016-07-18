//: [Previous](@previous)

//: # HIGH ORDER FUNCTIONS 高阶函数

import UIKit

var array = [1,2,3,4,5]

//: ## Map
//: each value in array become another value (can become different type also)
let mapped = array.map { (value) -> Int in
    return value + 1
}
let mappedShort = array.map({ "\($0) in String"})
mappedShort

/*: 
 ## flatMap
 support optional and squence of sequence
 过滤nil, map不过滤
 */
var multidimentionalArray: [[Int]?] = [[1,2], [3,5], [4], nil]
let flatmapped: [[Int]?] = multidimentionalArray.flatMap { (array) in
    return array?.count > 1 ? array : []
}
let flatmappedShort = multidimentionalArray.flatMap({ $0 }) //Remove nil
flatmappedShort
var flatMapX2 = array.flatMap{$0 * 2}
var images = array.flatMap{UIImage(named:"\($0).png")}
images.count
let persons: [[String: AnyObject]] = [["name": "Carl Saxon", "city": "New York, NY", "age": 44],
                                      ["name": "Travis Downing", "city": "El Segundo, CA", "age": 34],
                                      ["name": "Liz Parker", "city": "San Francisco, CA", "age": 32],
                                      ["name": "John Newden", "city": "New Jersey, NY", "age": 21],
                                      ["name": "Hector Simons", "city": "San Diego, CA", "age": 37],
                                      ["name": "Brian Neo", "age": 27]] //注意这家伙没有 city 键值
func infoFromState(state state: String, persons: [[String: AnyObject]])
    -> Int {
        // 先进行 flatMap 后进行 filter 筛选
        // $0["city"] 是一个可选值，对于那些没有 city 属性的项返回 nil
        // componentsSeparatedByString 处理键值，例如 "New York, NY"
        // 最后返回的 ["New York","NY"]，last 取到最后的 NY
        return persons.flatMap( { $0["city"]?.componentsSeparatedByString(", ").last })
            .filter({$0 == state})
            .count
}
infoFromState(state: "CA", persons: persons)

//: ## Filter
//: each value in array must passed a rule to append itself into newly made array
let filtered = array.filter { (value) -> Bool in
    return value >= 4
}
let filteredShort = array.filter({ $0 > 2 })
filteredShort
// 验证在字符串中是否存在指定单词
let words = ["Swift", "iOS", "cocoa", "OSX", "tvOS"]
let tweet = "This is an example about Swift"
let valid = words.filter({tweet.containsString($0)}).isEmpty
valid
words.contains(tweet.containsString)
tweet.characters
    .split(" ")
    .lazy
    .map(String.init)
    .contains(Set(words).contains)

/*: 
 ## Reduce
 combining the elements of an array to a single value
 Reduce 是 map、flatMap 或 filter 的一种扩展的形式。Reduce 的基础思想是将一个序列转换为一个不同类型的数据，期间通过一个累加器（Accumulator）来持续记录递增状态。为了实现这个方法，我们会向 reduce 方法中传入一个用于处理序列中每个元素的结合（Combinator）闭包 / 函数 / 方法。
 */
// 0 is starting value
let reduced = array.reduce(0) { (value1, value2) -> Int in
    value1 + value2
}
let reducedShort = array.reduce(0, combine: ({ $0 + $1 }))
reducedShort
array.reduce(0, combine: +)
// "test" is starting value
let reducedShort2 = array.reduce("test", combine: ({ "\($0)\($1)"}))
reducedShort2
// Can be mathematics function
let reducedShorter =  array.reduce(1, combine: *)
func combinator(accumulator: Int, current: Int) -> Int {
    return accumulator + current*current
}
array.reduce(0, combine: combinator)

/*:
 ### Reduce 实现
 重新定义一个 map 函数
 */
func rmap(elements: [Int], transform: (Int) -> Int) -> [Int] {
    return elements.reduce([Int](), combine: { (acc: [Int], obj: Int) -> [Int] in
        var accvar = acc
        accvar.append(transform(obj))
        return accvar
    })
}
(rmap([1, 2, 3, 4], transform: { $0 * 3}))
//var parameters are deprecated and will be removed in swift 3


//: [Next](@next)
