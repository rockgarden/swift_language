//: [Previous](@previous)

import UIKit
import Foundation

/// A type that provides sequential, iterated access to its elements.
///
/// A sequence is a list of values that you can step through one at a time. The
/// most common way to iterate over the elements of a sequence is to use a
/// `for`-`in` loop:
///
///     let oneTwoThree = 1...3
///     for number in oneTwoThree {
///         print(number)
///     }
///     // Prints "1"
///     // Prints "2"
///     // Prints "3"
///
/// While seemingly simple, this capability gives you access to a large number
/// of operations that you can perform on any sequence. As an example, to
/// check whether a sequence includes a particular value, you can test each
/// value sequentially until you've found a match or reached the end of the
/// sequence. This example checks to see whether a particular insect is in an
/// array.
///
///     let bugs = ["Aphid", "Bumblebee", "Cicada", "Damselfly", "Earwig"]
///     var hasMosquito = false
///     for bug in bugs {
///         if bug == "Mosquito" {
///             hasMosquito = true
///             break
///         }
///     }
///     print("'bugs' has a mosquito: \(hasMosquito)")
///     // Prints "'bugs' has a mosquito: false"
///
/// The `Sequence` protocol provides default implementations for many common
/// operations that depend on sequential access to a sequence's values. For
/// clearer, more concise code, the example above could use the array's
/// `contains(_:)` method, which every sequence inherits from `Sequence`,
/// instead of iterating manually:
///
///     if bugs.contains("Mosquito") {
///         print("Break out the bug spray.")
///     } else {
///         print("Whew, no mosquitos!")
///     }
///     // Prints "Whew, no mosquitos!"
///
/// Repeated Access
/// ===============
///
/// The `Sequence` protocol makes no requirement on conforming types regarding
/// whether they will be destructively consumed by iteration. As a
/// consequence, don't assume that multiple `for`-`in` loops on a sequence
/// will either resume iteration or restart from the beginning:
///
///     for element in sequence {
///         if ... some condition { break }
///     }
///
///     for element in sequence {
///         // No defined behavior
///     }
///
/// In this case, you cannot assume either that a sequence will be consumable
/// and will resume iteration, or that a sequence is a collection and will
/// restart iteration from the first element. A conforming sequence that is
/// not a collection is allowed to produce an arbitrary sequence of elements
/// in the second `for`-`in` loop.
///
/// To establish that a type you've created supports nondestructive iteration,
/// add conformance to the `Collection` protocol.
///
/// Conforming to the Sequence Protocol
/// ===================================
///
/// Making your own custom types conform to `Sequence` enables many useful
/// operations, like `for`-`in` looping and the `contains` method, without
/// much effort. To add `Sequence` conformance to your own custom type, add a
/// `makeIterator()` method that returns an iterator.
///
/// Alternatively, if your type can act as its own iterator, implementing the
/// requirements of the `IteratorProtocol` protocol and declaring conformance
/// to both `Sequence` and `IteratorProtocol` are sufficient.
///
///
/// Expected Performance
/// ====================
///
/// A sequence should provide its iterator in O(1). The `Sequence` protocol
/// makes no other requirements about element access, so routines that
/// traverse a sequence should be considered O(*n*) unless documented
/// otherwise.


//过滤数组中的数字
//extension Sequence{
//    typealias Element = Self.Iterator.Element
//    func partitionBy(fu: (Element)->Bool)->([Element],[Element]){
//        var first=[Element]()
//        var second=[Element]()
//        for el in self {
//            if fu(el) {
//                first.append(el)
//            }else{
//                second.append(el)
//            }
//        }
//        return (first,second)
//    }
//}
//let part = [82, 58, 76, 49, 88, 90].partitionBy{$0 < 60}
//part // ([58, 49], [82, 76, 88, 90])


do {
    struct Countdown: Sequence, IteratorProtocol {
        var count: Int

        mutating func next() -> Int? {
            if count == 0 {
                return nil
            } else {
                defer { count -= 1 }
                return count
            }
        }
    }

    let threeToGo = Countdown(count: 3)
    for i in threeToGo {
        print(i)
    }
    // Prints "3"
    // Prints "2"
    // Prints "1"
}



/*:
 Sequence 就离不开IteratorProtocol这个protocol，它是Sequence的基础。
    public protocol IteratorProtocol {
        associatedtype Element
        public mutating func next() -> Self.Element?
    }
 */
class ReverseIterator: IteratorProtocol{

    var element:Int

    init<T>(array:[T]) {
        self.element = array.count-1
    }

    func next() ->Int?{
        let result:Int? = self.element < 0 ? nil : element
        element -= 1
        return result
    }
}


let arr = ["A","B","C","D","E"]

let itertator = ReverseIterator(array:arr)
while let i = itertator.next(){
    print("element \(i) of the array is \(arr[i])")
}

do {

    // 图书
    struct Book {
        var name: String
    }

    // 书架
    class BookShelf {
        //图书集合
        private var books: [Book] = []

        //添加新书
        func append(book: Book) {
            self.books.append(book)
        }

        //创建Iterator
        func makeIterator() -> AnyIterator<Book> {
            var index : Int = 0
            return AnyIterator<Book> {
                defer {
                    index = index + 1
                }
                return index < self.books.count ? self.books[index] : nil
            }
        }
    }


    let bookShelf1 = BookShelf()
    bookShelf1.append(book: Book(name: "平凡的世界"))
    bookShelf1.append(book: Book(name: "活着"))
    bookShelf1.append(book: Book(name: "围城"))
    bookShelf1.append(book: Book(name: "三国演义"))

    //外文书架
    let bookShelf2 = BookShelf()
    bookShelf2.append(book: Book(name: "The Kite Runner"))
    bookShelf2.append(book: Book(name: "Cien anos de soledad"))
    bookShelf2.append(book: Book(name: "Harry Potter"))

    //创建两个书架图书的交替序列
    for book in sequence(state: (false, bookShelf1.makeIterator(), bookShelf2.makeIterator()),
                         next: { (state:inout (Bool,AnyIterator<Book>,AnyIterator<Book>)) -> Book? in
                            state.0 = !state.0
                            return state.0 ? state.1.next() : state.2.next()
    }) {
        print(book.name)
    }
}


//: [Next](@next)
