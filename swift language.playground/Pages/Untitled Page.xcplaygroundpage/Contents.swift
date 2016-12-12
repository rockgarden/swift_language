//: [Previous](@previous)

import Foundation

//public enum FaintingCouch : ErrorType, CustomDebugStringConvertible {
//    case ClutchPearls(String)
//    case GaspLoudly(String) // uncomment this to see problem
//    
//    public var debugDescription: String {
//        switch self {
//        case .ClutchPearls(let msg):
//            return "FaintingCouch(ClutchPearls(\"\(msg)\")"
//        case .GaspLoudly(let msg):
//            return "FaintingCouch(GaspLoudly(\"\(msg)\")"
//        }
//    }
//}
//
//func foo() throws {
//    throw FaintingCouch.ClutchPearls("Test")
//}
//
//do {
//    try foo()
//} catch {print(error)}
//
////do {
////    try foo()
////} catch {
////    if case FaintingCouch.ClutchPearls(let msg) = error {
////        print(msg)
////    }
////}

static var memberDict: Dictionary<Int, String> =
    [lowWater, lowHeat, gentleCycle, tumbleDry]
        .reduce([:]) {
            var dict = $0
            dict[$1.hashValue] = "\($1)"
            return dict
}

//: [Next](@next)
