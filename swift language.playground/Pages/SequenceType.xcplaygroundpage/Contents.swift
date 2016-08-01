//: [Previous](@previous)

import CoreData
import Foundation
import UIKit
//: # Sequences and Generators
/*: 
 有限序列和无限序列
 ---
 Read the original post at [http://swift.gg/2016/03/10/experimenting-with-swift-2-sequencetype-generatortype/](http://www.uraimo.com/2015/11/12/experimenting-with-swift-2-sequencetype-generatortype/)
*/

//过滤数组中的数字
extension SequenceType{
    typealias Element = Self.Generator.Element
    func partitionBy(fu: (Element)->Bool)->([Element],[Element]){
        var first=[Element]()
        var second=[Element]()
        for el in self {
            if fu(el) {
                first.append(el)
            }else{
                second.append(el)
            }
        }
        return (first,second)
    }
}
let part = [82, 58, 76, 49, 88, 90].partitionBy{$0 < 60}
part // ([58, 49], [82, 76, 88, 90])
extension SequenceType{
    func anotherPartitionBy(fu: (Self.Generator.Element)->Bool)->([Self.Generator.Element],[Self.Generator.Element]){
        return (self.filter(fu),self.filter({!fu($0)}))
    }
}
let part2 = [82, 58, 76, 49, 88, 90].anotherPartitionBy{$0 < 60}
part2 // ([58, 49], [82, 76, 88, 90])
//构建了包含两个分区的结果元组,一次一个元素,使用过滤函数测试初始序列中的每个元素,并根据过滤结果追加该元素到第一或第二分区数组中,即分区数组通过追加被构建
var part3 = [82, 58, 76, 49, 88, 90].reduce( ([],[]), combine: {
    (a:([Int],[Int]),n:Int) -> ([Int],[Int]) in
    (n<60) ? (a.0+[n],a.1) : (a.0,a.1+[n])
})
part3 // ([58, 49], [82, 76, 88, 90])

//在数组中查找最值
//Find the minimum of an array of Ints
[10,-22,753,55,137,-1,-279,1034,77].sort().first
[10,-22,753,55,137,-1,-279,1034,77].reduce(Int.max, combine: min)
[10,-22,753,55,137,-1,-279,1034,77].minElement()
//Find the maximum of an array of Ints
[10,-22,753,55,137,-1,-279,1034,77].sort().last
[10,-22,753,55,137,-1,-279,1034,77].reduce(Int.min, combine: max)
[10,-22,753,55,137,-1,-279,1034,77].maxElement()

//埃拉托斯特尼筛法-例:查找所有的素数直到给定的上限n
var n = 50
var primes = Set(2...n)
//使用外部范围来迭代我们要检查的整数,并且对于每一个整数我们使用stride(through:Int by:Int)计算出数字的倍数的序列,那些序列然后从Set中减去,Set用所有从2到n的整数初始化
(2...Int(sqrt(Double(n)))).forEach{primes.subtractInPlace((2*$0).stride(through:n, by:$0))}
primes.sort()

var sameprimes = Set(2...n)
sameprimes.subtractInPlace((2...Int(sqrt(Double(n))))
    .flatMap{(2*$0).stride(through:n, by:$0)})
sameprimes.sort()



//swift 数组\struct\enum是值类型 速度快 但数据变化频繁 用NS 引用类型数据
var array = [1,2,3]
var array2 = array
array2.append(4)
array

//NSArray(Foundation)是引用类型
var nsArray: NSMutableArray = [1,2,3]
var nsArray2 = nsArray
nsArray2.addObject(4)
nsArray

/*:
 ## Generator
 这个简单的协议只包含了一个 next() 方法，该方法用来返回生成器管理的下一个元素。至关重要的一点是，当序列遍历到最后时，生成器应该返回 nil。
 Let's build a simple generator that produces numbers from the well known Fibonacci sequence
 */
//
class FibonacciGenerator : GeneratorType {
    var last = (0,1)
    var endAt: Int
    var lastIteration = 0

    init(end:Int){
        endAt = end
    }

    func next() -> Int?{
        guard lastIteration<endAt else {
            return nil
        }
        lastIteration += 1

        let next = last.0
        last = (last.1,last.0+last.1) //Tuple
        return next
    }
}
//: To return a finite sequence we need an additional constructor that we'll use to specify the sequence length and return *nil* instead of a new element when we reach it. There is not much else to see here other than the tuple swap trick that save us a few lines, but let's see how to use this generator:
var fg = FibonacciGenerator(end:10)
while let fib = fg.next() {
    (fib)
}

/*:
 ## SequenceType
 此标准协议在官方文档中被定义为一种简单的数据类型，该类型可以用 for...in 来循环遍历。
 协议中关联了另一个 GeneratorType 协议类型（Swift 让协议泛型化的独特方式）。当我们要自定义序列的时候，我们同时也要自定义一个实现这个协议的生成器，保证我们自定义的 SequenceType 在调用 generate() 方法时能够返回指定元素类型的生成器。
 This way we'll iterate on the generator elements until *nil* is returned.
 Implementing a **SequenceType** for this generator is straightforward: */

class FibonacciSequence : SequenceType {
    var endAt:Int

    init(end:Int){
        endAt = end
    }

    func generate() -> FibonacciGenerator{
        return FibonacciGenerator(end: endAt)
    }
}

let arr = Array(FibonacciSequence(end:10))

for f in FibonacciSequence(end: 10) {
    print(f)
}


//: But there is no need to declare the generator as a separated entity, we can use the **anyGenerator** utility method with the **AnyGenerator<T>** class to make this example more compact:

class CompactFibonacciSequence : SequenceType {
    var endAt:Int

    init(end:Int){
        endAt = end
    }

    func generate() -> AnyGenerator<Int> {
        var last = (0,1)
        var lastIteration = 0

        return AnyGenerator{
            guard lastIteration<self.endAt else {
                return nil
            }
            lastIteration += 1

            let next = last.0
            last = (last.1,last.0+last.1)
            return next
        }
    }
}

for f in CompactFibonacciSequence(end: 10) {
    print(f)
}

//: In some circumstances, a simple sequence generated with **anyGenerator()** could be more than enough for what we want to do.
//: Let's create a sequence with the first 10 numbers of the [Lucas sequence](https://en.wikipedia.org/wiki/Lucas_number) (clearly not *that* Lucas), a numeric series similar to Fibonacci sequence that starts with *2,1* instead of *0,1*, using a generator and initialize an array with it:

var last = (2,1)
var c = 0

let lucas = AnyGenerator{
    ()->Int? in
    guard c<10 else {
        return nil
    }

    c += 1
    let next = last.0
    last = (last.1,last.0+last.1)
    return next
}

let a = Array(lucas) //[2, 1, 3, 4, 7, 11, 18, 29, 47, 76]


//: Definitely not bad, we removed a lot of boilerplate, but since we can improve our algorithm further with a formula involving the [golden ratio](https://en.wikipedia.org/wiki/Golden_ratio), let's do it:

import Darwin

let Phi = (sqrt(5)+1.0)/2
let phi = 1/Phi

func luc(n:Int)->Int {
    return Int(pow(Phi, Double(n))+pow(-phi,Double(n)))
}

c = 0
var compactLucas = AnyGenerator{ c<10 ? luc(c+1): nil }

let a2 = Array(compactLucas) //[2, 1, 3, 4, 7, 11, 18, 29, 47, 76]

//: To try out some of the functional(ish) facilities that **SequenceType** provide, we'll now build a derived sequence that will only return *even* numbers from the Lucas sequence:

c = 0
var evenCompactLucas = AnyGenerator{ c<10 ? luc(c+1): nil }.filter({$0 % 2 == 0})

let a3 = Array(evenCompactLucas) //[2, 4, 18, 76]

//: But now, what it we remove the nil termination requirement described above to build an infinite sequence of all the possible Lucas numbers?

c = 0
var infiniteLucas = AnyGenerator{luc(c+1)}


let a4 = Array(infiniteLucas.prefix(10)) //[2, 1, 3, 4, 7, 11, 18, 29, 47, 76]

for var f in infiniteLucas.prefix(10){
    print(f)
}

//: But let's go a step further and again apply a *filter* to our sequence, to obtain a sequence of even Lucas numbers:
//:
//: Remove ".lazy" and grab a coffee...
var onlyEvenLucas = infiniteLucas.lazy.filter({$0 % 2 == 0})
for var f in onlyEvenLucas.prefix(10){
    print(f)
}


//: Let's see visually what's happening if we remove *.lazy* using a more verbose infinite sequence of integers that will print some text every time a value is requested from the generator:
class InfiniteSequence :SequenceType {
    func generate() -> AnyGenerator<Int> {
        var i = 0
        return AnyGenerator{
            print("# Returning "+String(i))
            i += 1
            return i
        }
    }
}

//: Again, remove ".lazy" and grab a coffee...
var fs = InfiniteSequence().lazy.filter({$0 % 2 == 0}).generate()

for i in 1...5 {
    print(fs.next())
}

//: [Next](@next)
