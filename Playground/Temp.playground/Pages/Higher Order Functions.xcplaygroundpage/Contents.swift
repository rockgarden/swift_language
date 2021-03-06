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
// 初始值 initial 为 0，每次遍历数组元素，执行 + 操作, + 作为一个 combinator 函数是有效的，它仅仅是对 lhs（Left-hand side，等式左侧） 和 rhs（Right-hand side，等式右侧） 做加法处理，最后返回结果值.
array.reduce(0, combine: +)
// "test" is starting value
let reduced1 = array.reduce("test", combine: ({ "\($0)\($1)"}))
reduced1
// Can be mathematics function 
// 初始值 initial 为 1，每次遍历数组元素，执行 * 操作
array.reduce(1, combine: *)
// 反转数组: $0 指累加器（accumulator），$1 指遍历数组得到的一个元素
let reduced2 = array.reduce([Int](), combine: { [$1] + $0 })
reduced2
func combinator(accumulator: Int, current: Int) -> Int {
    return accumulator + current*current
}
array.reduce(0, combine: combinator)

/* 划分（Partition）处理
 为元组定义个别名，此外 Acc 也是闭包传入的 accumulator 的类型
 */
typealias Acc = (l: [Int], r: [Int])
func partition(lst: [Int], criteria: (Int) -> Bool) -> Acc {
    return lst.reduce((l: [Int](), r: [Int]()), combine: { (ac: Acc, o: Int) -> Acc in
        if criteria(o) {
            return (l: ac.l + [o], r: ac.r)
        } else {
            return (r: ac.r + [o], l: ac.l)
        }
    })
}
var resultPartition = partition([1, 2, 3, 4, 5, 6, 7, 8, 9], criteria: { $0 % 2 == 0 })
resultPartition

/* Minimum
 返回列表中的最小项。
 */
array.minElement()
// 初始值为 Int.max，传入闭包为 min：求两个数的最小值
// min 闭包传入两个参数：1. 初始值 2. 遍历列表时的当前元素
// 倘若当前元素小于初始值，初始值就会替换成当前元素
// 示意写法： initial = min(initial, elem)
array.reduce(Int.max, combine: min)

/* Unique
 剔除列表中重复的元素。当然，最好的解决方式是使用集合（Set）。
 */
[1, 2, 5, 1, 7].reduce([], combine: { (a: [Int], b: Int) -> [Int] in
    if a.contains(b) {
        return a
    } else {
        return a + [b]
    }
})

/*: 
 ### Group By 分组
 遍历整个列表，通过一个鉴别函数对列表中元素进行分组，将分组后的列表作为结果值返回。
 问题中的鉴别函数返回值类型需要遵循 Hashable 协议，这样我们才能拥有不同的键值。此外保留元素的排序，而组内元素排序则不一定被保留下来。*/
func groupby<T, H: Hashable>(items: [T], f: (T) -> H) -> [H: [T]] {
    return items.reduce([:], combine: { (acc: [H: [T]], o: T) -> [H: [T]] in
        var ac = acc
        // o 为遍历序列的当前元素
        let h = f(o) // 通过 f 函数得到 o 对应的键值
        if var c = ac[h] { // 说明 o 对应的键值已经存在，只需要更新键值对应的数组元素即可
            c.append(o)
            ac.updateValue(c, forKey: h)
        } else { // 说明 o 对应的键值不存在，需要为字典新增一个键值，对应值为 [o]
            ac.updateValue([o], forKey: h)
        }
        return ac
    })
}
(groupby([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], f: { $0 % 3 }))
// prints: [2: [2, 5, 8, 11], 0: [3, 6, 9, 12], 1: [1, 4, 7, 10]]
(groupby(["Carl", "Cozy", "Bethlehem", "Belem", "Brand", "Zara"], f: { $0.characters.first! }))
// prints: ["C" : ["Carl" , "Cozy"] , "B" : ["Bethlehem" , "Belem" , "Brand"] , "Z" : ["Zara"]]

/* Interpose
 函数给定一个 items 数组，每隔 count 个元素插入 element 元素，返回结果值。
 下面的实现确保了 element 仅在中间插入，而不会添加到数组尾部。
 */
func interpose<T>(items: [T], element: T, count: Int = 1) -> [T] {
    // cur 为当前遍历元素的索引值 cnt 为计数器，当值等于 count 时又重新置 1
    typealias Acc = (ac: [T], cur: Int, cnt: Int)
    return items.reduce((ac: [], cur: 0, cnt: 1), combine: { (a: Acc, o: T) -> Acc in
        switch a {
        // 此时遍历的当前元素为序列中的最后一个元素
        case let (ac, cur, _) where (cur+1) == items.count: return (ac + [o], 0, 0)
        // 满足插入条件
        case let (ac, cur, c) where c == count:
            return (ac + [o, element], cur + 1, 1)
        // 执行下一步
        case let (ac, cur, c):
            return (ac + [o], cur + 1, c + 1)
        }
    }).ac
}
(interpose([1, 2, 3, 4, 5], element: 9))
// : [1, 9, 2, 9, 3, 9, 4, 9, 5]
(interpose([1, 2, 3, 4, 5], element: 9, count: 2))
// : [1, 2, 9, 3, 4, 9, 5]

/* Interdig
 该函数允许你有选择从两个序列中挑选元素合并成为一个新序列返回。
 */
func interdig<T>(list1: [T], list2: [T]) -> [T] {
    // Zip2Sequence 返回 [(list1, list2)] 是一个数组，类型为元组
    // 也就解释了为什么 combinator 闭包的类型是 (ac: [T], o: (T, T)) -> [T]
    return Zip2Sequence(list1, list2).reduce([], combine: { (ac: [T], o: (T, T)) -> [T] in
        return ac + [o.0, o.1]
    })
}
(interdig([1, 3, 5], list2: [2, 4, 6]))
// : [1, 2, 3, 4, 5, 6]

/* Chunk
 该函数返回原数组分解成长度为 n 后的多个数组.
 */
func chunk<T>(list: [T], length: Int) -> [[T]] {
    typealias Acc = (stack: [[T]], cur: [T], cnt: Int)
    let l = list.reduce((stack: [], cur: [], cnt: 0), combine: { (ac: Acc, o: T) -> Acc in
        if ac.cnt == length {
            return (stack: ac.stack + [ac.cur], cur: [o], cnt: 1)
        } else {
            return (stack: ac.stack, cur: ac.cur + [o], cnt: ac.cnt + 1)
        }
    })
    return l.stack + [l.cur]
}
(chunk([1, 2, 3, 4, 5, 6, 7], length: 2))
// : [[1, 2], [3, 4], [5, 6], [7]]
// 函数中使用一个更为复杂的 accumulator，包含了 stack、current list 以及 count 。


/*:
 ### Reduce 实现
 重新定义一个 map 函数
 */
func rmap(elements: [Int], transform: (Int) -> Int) -> [Int] {
    return elements.reduce([Int](), combine: { (acc: [Int], obj: Int) -> [Int] in
        var accvar = acc //内部定义, 最好外部定义
        accvar.append(transform(obj))
        return accvar
    })
}
var resultRmap = (rmap([1, 2, 3, 4], transform: { $0 * 3}))
resultRmap
/*
 首先，elements 序列调用 reduce 方法：elements.reduce...。
 然后，我们传入初始值给累加器（Accumulator），即一个 Int 类型空数组（[Int]()）。
 接着，我们传入 combinator 闭包，它接收两个参数：第一个参数为 accumulator，即 acc: [Int]；第二个参数为从序列中取得的当前对象 obj: Int（对序列进行遍历，每次取到其中的一个对象 obj）。
 combinator 闭包对 obj 做变换处理，然后添加到累加器 accumulator 中。
 最后返回 accumulator 对象。
 相比较调用 map 方法，这种实现代码看起来有点冗余。
 */
func rmapA(elements: [Int], transform: (Int) -> Int) -> [Int] {
    // $0 表示第一个传入参数，$1 表示第二个传入参数，依次类推...
    return elements.reduce([Int](), combine: {$0 + [transform($1)]})
}
var resultRmapA = (rmapA([1, 2, 3, 4], transform: { $0 * 3}))
resultRmapA
/*
 + 运算符能够对两个序列进行加法操作。因此 [0, 1, 2] + [transform(4)] 表达式将左序列和右序列进行相加，其中右序列由转换后的元素构成。
 这里有个地方需要引起注意：[0, 1, 2] + [4] 执行速度要慢于 [0, 1, 2].append(4)。倘若你正在处理庞大的列表，应取代集合 + 集合的方式，转而使用一个可变的 accumulator 变量进行递增：rmap 效率更高。
 */
func rflatMap(elements: [Int], transform: (Int) -> Int?) -> [Int] {
    return elements.reduce([Int](), combine: {
        guard let m = transform($1)
            else { return $0 }
        return $0 + [m]})
}
var resultRflatMap = (rflatMap([1, 2, 3, 4], transform: { guard $0 != 3 else { return nil }; return $0 * 3}))
resultRflatMap

func rFilter(elements: [Int], filter: (Int) -> Bool) -> [Int] {
    return elements.reduce([Int](),
                           combine: { guard filter($1) else { return $0 }
                            return $0 + [$1]})
}
var resultRFilter = (rFilter([1, 3, 4, 6], filter: { $0 % 2 == 0}))
resultRFilter

/*:
 ## Reduce vs. 链式结构
 reduce 除了较强的灵活性之外，还具有另一个优势：通常情况下，map 和 filter 所组成的链式结构会引入性能上的问题，因为它们需要多次遍历你的集合才能最终得到结果值，这种操作往往伴随着性能损失:
 */
// 这里要遍历 3次
array = Array(0...100)
array.map({ $0 + 3}).filter({ $0 % 2 == 0}).reduce(0, combine: +)
// 这里只需要遍历 1 次序列
array.reduce(0, combine: { (ac: Int, r: Int) -> Int in
    if (r + 3) % 2 == 0 {
        return ac + r + 3
    } else {
        return ac
    }
})
// reduce效率接近for-loop
var ux = 0
for i in array {
    if (i + 3) % 2 == 0 {
        ux += (i + 3)
    }
}
array.map({ $0 + 3}).reverse().prefix(3)
// 0.027 Seconds
array.reduce([], combine: { (ac: [Int], r: Int) -> [Int] in
    var acvar = ac
    acvar.insert(r + 3, atIndex: 0)
    return acvar
}).prefix(3)
// 2.927 Seconds，因为从 reduce 的语义上来说，传入闭包的参数（如果可变的话，即 mutated），会对底层序列的每个元素都产生一份 copy，这意味着 accumulator 参数 ac 将为 0…10000 范围内的每个元素都执行一次复制操作。

/*
 ## reduce infoFromState 函数
 */
func infoFromStateReduce(state state: String, persons: [[String: AnyObject]])
    -> (count: Int, age: Float) {
        // 在函数内定义别名让函数更加简洁
        typealias Acc = (count: Int, age: Float)
        // reduce 结果暂存为临时的变量
        let u = persons.reduce((count: 0, age: 0.0)) {
            (ac: Acc, p) -> Acc in
            // 获取地区和年龄
            guard let personState = (p["city"] as? String)?.componentsSeparatedByString(", ").last,
                personAge = p["age"] as? Int
                // 确保选出来的是来自正确的洲
                where personState == state
                // 如果缺失年龄或者地区，又或者上者比较结果不等，返回
                else { return ac }
            // 最终累加计算人数和年龄
            return (count: ac.count + 1, age: ac.age + Float(personAge))
        }
        // 我们的结果就是上面的人数和除以人数后的平均年龄
        return (age: u.age / Float(u.count), count: u.count)
}
infoFromStateReduce(state: "CA", persons: persons)

//: [Next](@next)
