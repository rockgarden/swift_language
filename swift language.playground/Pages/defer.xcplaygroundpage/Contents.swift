//: [Previous](@previous)
import UIKit, Accelerate
/// defer译为延缓、推迟之意。那么在Swift2.0中它将被应用于什么位置呢？比如，读取某目录下的文件内容并处理数据，你需要首先定位到文件目录，打开文件夹，读取文件内容以及处理数据，关闭文件以及文件夹。倘若一切顺利，只需按照设定好的程序流程走一轮即可；不过考虑事情要面面俱到，倘若中间某个环节失败，比如读取文件内容失败、处理数据失败等等，还需要进行一些后续收尾工作，即关闭文件或关闭文件夹(当然就算顺利执行，也是要关闭的)。

/// defer的作用域: 函数结束时开始执行defer栈推出操作，而是每当一个作用域结束就进行该作用域defer执行。调用顺序——即一个作用域结束，该作用域中的defer语句自下而上调用。
do {
    func lookforSomething(name:String) throws{
        //这里是作用域1 整个函数作用域
        print("1-1")
        if name == ""{
            //这里是作用域2 if的作用域
            print("2-1")
            defer{
                print("2-2")
            }
            print("2-3")
        }
        print("1-2")
        defer{
            print("1-3")
        }
        print("1-4")

        if name == "hello"{
            //作用域3
            print("3-1")
            defer{
                print("3-2")
            }
            print("3-3")
            defer{
                print("3-4")
            }
        }
    }
    //有兴趣的看看依次输出什么
    //try! lookforSomething("")
    //调出 debug Area 快捷键 shift+ command + y
    try! lookforSomething("hello")
}

/// defer - guard+throw 语法代替嵌套 if 的处理方式, 可尽早返回错误, 但是已经被初始化（可能也正在被使用）的资源必须在返回前被处理干净, 关键字 defer 为此提供了安全又简单的处理方式: 声明一个 block，当前代码执行的闭包退出时会执行该 block.

let which = 0

func testDefer() {
    print("starting")
    defer {
        print("ending")
    }
    if which == 1 {
        print("returning")
        return
    }
    print("last line")
}

func testDeferWithThrow() throws {
    print("starting2")
    defer {
        print("ending2")
    }
    throw NSError(domain: "Ouch", code: 1, userInfo: nil)
}

func testDeferWithThrow2() {
    print("starting2")
    do {
        defer {
            print("ending2")
        }
        print("throwing")
        throw NSError(domain: "Ouch", code: 1, userInfo: nil)
    } catch {
        print("caught: \(error)")
    }
}

// finally, let's also try other kinds of block

func testDeferWithOtherBlocks() {
    print("entering func")
    defer {
        print ("exiting func")
    }
    test: while true {
        print ("entering while")
        defer {
            print ("exiting while")
        }
        if which == 1 {
            print ("entering if")
            defer {
                print ("exiting if")
            }
            print ("breaking from if")
            break test
        }
        print ("breaking from while")
        break test
    }
}

do {
    try testDeferWithThrow()
} catch {
    print("catching")
}

//func imageResizeVImage(imageURL: NSURL, scalingFactor: Double) -> UIImage? {
//
//    let image = UIImage(contentsOfFile: imageURL.path!)!
//
//    // create a source buffer
//    var format = vImage_CGImageFormat(bitsPerComponent: 8,
//                                      bitsPerPixel: 32,
//                                      colorSpace: nil,
//                                      bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.First.rawValue),
//                                      version: 0,
//                                      decode: nil,
//                                      renderingIntent: CGColorRenderingIntent.RenderingIntentDefault)
//    var sourceBuffer = vImage_Buffer()
//    defer {
//        sourceBuffer.data.dealloc(Int(sourceBuffer.height) * Int(sourceBuffer.height) * 4)
//    }
//    var error: vImage_Error
//
//    error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, image.CGImage!, numericCast(kvImageNoFlags))
//    guard error == kvImageNoError else { return nil }
//
//    // 占用资源较多的Unsafe对象适合用 defer 来释放
//    let scale = UIScreen.mainScreen().scale
//    let destWidth = Int(image.size.width * CGFloat(scalingFactor) * scale)
//    let destHeight = Int(image.size.height * CGFloat(scalingFactor) * scale)
//    let bytesPerPixel = CGImageGetBitsPerPixel(image.CGImage) / 8
//    let destBytesPerRow = destWidth * bytesPerPixel
//    let destData = UnsafeMutablePointer<UInt8>.alloc(destHeight * destWidth * bytesPerPixel)
//    // defer block 紧接着 alloc() 出现, 但会等到当前上下文结束的时候才真正执行
//    defer {
//        destData.dealloc(destHeight * destBytesPerRow)
//    }
//    var destBuffer = vImage_Buffer(data: destData, height: vImagePixelCount(destHeight), width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)
//
//    // create a CGImage from vImage_Buffer
//    guard let destCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, nil, nil, numericCast(kvImageNoFlags), &error)?.takeRetainedValue()
//        else { return nil }
//    guard error == kvImageNoError else { return nil }
//
//    // create a UIImage
//    let scaledImage = UIImage(CGImage: destCGImage, scale: 0.0, orientation: image.imageOrientation)
//    return scaledImage
//}

//: [Next](@next)
