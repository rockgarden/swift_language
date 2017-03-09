//: [Previous](@previous)

import Foundation

//// Fibonacci Sequence
//public struct FibonacciSequenceO : Sequence {
//
//    public func generate() -> AnyIterator<UInt> {
//        var last: (UInt, UInt) = (0, 1)
//
//        return AnyIterator<UInt> {
//            let next = last.0
//            last = (last.1, last.0 + last.1)
//            return next
//        }
//    }
//}



/// An iterable Sequence representing the famous Fibonacci Sequence.
///
/// - author: Christopher Durham
///
public struct FibonacciSequence: Sequence {

    fileprivate let stop: StoppingPoint

    /// Construct the Fibonacci Sequence up to a given maximum.
    ///
    /// - parameter upTo: The maximum value (inclusive) that this Sequence will generate.
    ///
    public init(upTo max: Int) {
        self.stop = .value(max)
    }

    /// Construct a certain number of terms of the Fibonacci Sequence.
    ///
    /// - parameter terms: The number of terms this Sequence will generate.
    public init(terms: Int) {
        self.stop = .term(terms)
    }

    public func makeIterator() -> AnyIterator<Int> {
        var a = 0
        var b = 1
        var term = 0
        return AnyIterator {
            b = b + a
            a = b - a
            term += 1

            switch(self.stop) {
            case .term(let x):
                return term > x ? nil : a
            case .value(let x):
                return a > x ? nil : a
            }
        }
    }

    fileprivate enum StoppingPoint {
        case value(Int)
        case term(Int)
    }
}

extension FibonacciSequence: CustomDebugStringConvertible, CustomStringConvertible {
    public var debugDescription: String {
        return "FibonacciSequence(\(stop))"
    }

    public var description: String {
        return String(describing: Array(self))
    }
}


//: [Next](@next)
