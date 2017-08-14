import UIKit
import Accelerate

/// guard - 是一个新的条件声明，表示如果条件不满足时退出当前 block, 任何被声明成 guard 的 optional 绑定在其他函数或 block 中都是可用的, 并强制在 else 中用 return 来退出函数\continue 或 break 退出循环, 或者用一个类似 fatalError() 的 @noreturn 函数来退出，以离开当前的上下文

enum ConversionError : ErrorType {
    case InvalidFormat, OutOfBounds, Unknown
}

extension UInt8 {
    init(fromString string: String) throws {
        // check the string's format
        guard let _ = string.range(of: "^\\d+$")
            //.rangeOfString("^\\d+$", options: [.RegularExpressionSearch])
            else { throw ConversionError.InvalidFormat }
        // make sure the value is in bounds
        guard string.compare("\(UInt8.max)", options: [.NumericSearch]) != NSComparisonResult.OrderedDescending
            else { throw ConversionError.OutOfBounds }
        // do the built-in conversion
        guard let value = UInt(string)
            else { throw ConversionError.Unknown }
        self.init(value)
    }
}

UInt8.init("kllkk")

func checkInt8(_ string: String) -> Int8 {
    guard let _ = string.rangeOfString("^\\d+$", options: [.RegularExpressionSearch])
        else {
            print(ConversionError.InvalidFormat)
            return 0
    }
    // make sure the value is in bounds
    guard string.compare("\(UInt8.max)", options: [.NumericSearch]) != NSComparisonResult.OrderedDescending
        else {
            print(ConversionError.OutOfBounds)
            return 0
    }
    // do the built-in conversion
    guard let value = UInt(string)
        else {
            print(ConversionError.Unknown)
            return 0
    }
    return Int8(value)
}
checkInt8("999999")

func check(_ person: [String: String]) {
    guard let id = person ["id"] else {
        debugPrint("no id)")
        return
    }
    guard let passCard = person ["passCard"] else {
        debugPrint("no passCard")
        return
    }
    // guard 解包的值可用
    debugPrint("id:\(id), pass card:\(passCard)")
}

check(["id":"3232"])
