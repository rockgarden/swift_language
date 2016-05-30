import UIKit
import Accelerate

/// guard - 是一个新的条件声明，表示如果条件不满足时退出当前 block, 任何被声明成 guard 的 optional 绑定在其他函数或 block 中都是可用的, 并强制在 else 中用 return 来退出函数\continue 或 break 退出循环, 或者用一个类似 fatalError() 的 @noreturn 函数来退出，以离开当前的上下文

enum ConversionError : ErrorType {
    case InvalidFormat, OutOfBounds, Unknown
}

extension UInt8 {
    init(fromString string: String) throws {
        // check the string's format
        guard let _ = string.rangeOfString("^\\d+$", options: [.RegularExpressionSearch])
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

func checkInt8(string: String) -> Int8 {
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

func check(person: [String: String]) {
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


/// defer - guard+throw 语法代替嵌套 if 的处理方式, 可尽早返回错误, 但是已经被初始化（可能也正在被使用）的资源必须在返回前被处理干净, 关键字 defer 为此提供了安全又简单的处理方式: 声明一个 block，当前代码执行的闭包退出时会执行该 block.

func imageResizeVImage(imageURL: NSURL, scalingFactor: Double) -> UIImage? {

    let image = UIImage(contentsOfFile: imageURL.path!)!

    // create a source buffer
    var format = vImage_CGImageFormat(bitsPerComponent: 8,
                                      bitsPerPixel: 32,
                                      colorSpace: nil,
                                      bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.First.rawValue),
                                      version: 0,
                                      decode: nil,
                                      renderingIntent: CGColorRenderingIntent.RenderingIntentDefault)
    var sourceBuffer = vImage_Buffer()
    defer {
        sourceBuffer.data.dealloc(Int(sourceBuffer.height) * Int(sourceBuffer.height) * 4)
    }
    var error: vImage_Error

    error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, image.CGImage!, numericCast(kvImageNoFlags))
    guard error == kvImageNoError else { return nil }

    // 占用资源较多的Unsafe对象适合用 defer 来释放
    let scale = UIScreen.mainScreen().scale
    let destWidth = Int(image.size.width * CGFloat(scalingFactor) * scale)
    let destHeight = Int(image.size.height * CGFloat(scalingFactor) * scale)
    let bytesPerPixel = CGImageGetBitsPerPixel(image.CGImage) / 8
    let destBytesPerRow = destWidth * bytesPerPixel
    let destData = UnsafeMutablePointer<UInt8>.alloc(destHeight * destWidth * bytesPerPixel)
    // defer block 紧接着 alloc() 出现, 但会等到当前上下文结束的时候才真正执行
    defer {
        destData.dealloc(destHeight * destBytesPerRow)
    }
    var destBuffer = vImage_Buffer(data: destData, height: vImagePixelCount(destHeight), width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)

    // create a CGImage from vImage_Buffer
    guard let destCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, nil, nil, numericCast(kvImageNoFlags), &error)?.takeRetainedValue()
        else { return nil }
    guard error == kvImageNoError else { return nil }

    // create a UIImage
    let scaledImage = UIImage(CGImage: destCGImage, scale: 0.0, orientation: image.imageOrientation)
    return scaledImage
}
