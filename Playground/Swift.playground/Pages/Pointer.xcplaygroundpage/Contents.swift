//: [Previous](@previous)

import Foundation
/*:
 # UnsafePointer and UnsafeMutablePointer
 
 Swift 中，指针都使用一个特殊的类型来表示，那就是 UnsafePointer<T>。遵循了 Cocoa 的一贯不可变原则，UnsafePointer<T> 也是不可变的。当然对应地，它还有一个可变变体，UnsafeMutablePointer<T>。绝大部分时间里，C 中的指针都会被以这两种类型引入到 Swift 中：C 中 const 修饰的指针对应 UnsafePointer (最常见的应该就是 C 字符串的 const char * 了)，而其他可变的指针则对应 UnsafeMutablePointer。
 
 除此之外，Swift 中存在表示一组连续数据指针的 UnsafeBufferPointer<T>，表示非完整结构的不透明指针 COpaquePointer 等等。另外你可能已经注意到了，能够确定指向内容的指针类型都是泛型的 struct，我们可以通过这个泛型来对指针指向的类型进行约束以提供一定安全性。

 对于一个 UnsafePointer<T> 类型，我们可以通过 pointee 属性对其进行取值，如果这个指针是可变的 UnsafeMutablePointer<T> 类型，我们还可以通过 pointee 对它进行赋值。比如我们想要写一个利用指针直接操作内存的计数器的话，可以这么做：
 */
do {
    func incrementor(_ ptr: UnsafeMutablePointer<Int>) {
        ptr.pointee += 1
    }

    var a = 10
    incrementor(&a)
    a
}
/*:
 这里和 C 的指针使用类似，我们通过在变量名前面加上 & 符号就可以将指向这个变量的指针传递到接受指针作为参数的方法中去。在上面的 incrementor 中我们通过直接操作 memory 属性改变了指针指向的内容。

 与这种做法类似的是使用 Swift 的 inout 关键字。我们在将变量传入 inout 参数的函数时，同样也使用 & 符号表示地址。不过区别是在函数体内部我们不需要处理指针类型，而是可以对参数直接进行操作。
 */
do {
    func incrementor1(_ num: inout Int) {
        num += 1
    }

    var b = 10
    incrementor1(&b)
    b
}
/*:
 虽然 & 在参数传递时表示的意义和 C 中一样，是某个“变量的地址”，但是在 Swift 中我们没有办法直接通过这个符号获取一个 UnsafePointer 的实例。需要注意这一点和 C 有所不同：
 */
do {
    // 无法编译
    //let a = 100
    //let b = &a
}

/*:
 # 指针初始化和内存管理
 在 Swift 中不能直接取到现有对象的地址，我们还是可以创建新的 UnsafeMutablePointer 对象。与 Swift 中其他对象的自动内存管理不同，对于指针的管理，是需要我们手动进行内存的申请和释放的。一个 UnsafeMutablePointer 的内存有三种可能状态：

 - 内存没有被分配，这意味着这是一个 null 指针，或者是之前已经释放过
 - 内存进行了分配，但是值还没有被初始化
 - 内存进行了分配，并且值已经被初始化

 其中只有第三种状态下的指针是可以保证正常使用的。UnsafeMutablePointer 的初始化方法 (init) 完成的都是从其他类型转换到 UnsafeMutablePointer 的工作。我们如果想要新建一个指针，需要做的是使用 alloc: 这个类方法。该方法接受一个 num: Int 作为参数，将向系统申请 num 个数的对应泛型类型的内存。下面的代码申请了一个 Int 大小的内存，并返回指向这块内存的指针：
 */
do {
    var intPtr = UnsafeMutablePointer<Int>.allocate(capacity: 1)

    /// 指针的内容进行初始化
    intPtr.initialize(to: 10)
    intPtr.pointee

    intPtr.deinitialize()
    intPtr.pointee
    intPtr.deallocate(capacity: 1)
    //intPtr = nil // error: nil cannot be assigned to type 'UnsafeMutablePointer<Int>'
    intPtr.pointee
}
/*:
 - NOTE:
 所以没有特殊考虑的话，不论内存中到底是什么，保证 initialize 和 destroy 配对会是一个好习惯。
 */

/*:
 # 指向数组的指针
 
 对于一般的接受 const 数组的 C API，其要求的类型为 UnsafePointer，而非 const 的数组则对应 UnsafeMutablePointer。使用时，对于 const 的参数，我们直接将 Swift 数组传入 (上例中的 a 和 b)；而对于可变的数组，在前面加上 & 后传入即可 (上例中的 result)。

 对于传参，Swift 进行了简化，使用起来非常方便。但是如果我们想要使用指针来像之前用 memory 的方式直接操作数组的话，就需要借助一个特殊的类型：UnsafeMutableBufferPointer。Buffer Pointer 是一段连续的内存的指针，通常用来表达像是数组或者字典这样的集合类型。
 */

import Accelerate
do {
    let a: [Float] = [1, 2, 3, 4]
    let b: [Float] = [0.5, 0.25, 0.125, 0.0625]
    var result: [Float] = [0, 0, 0, 0]

    vDSP_vadd(a, 1, b, 1, &result, 1, 4)

    // result now contains [1.5, 2.25, 3.125, 4.0625]
}
do {
    var array = [1, 2, 3, 4, 5]
    var arrayPtr = UnsafeMutableBufferPointer<Int>(start: &array, count: array.count)
    /// baseAddress 是第一个元素的指针 UnsafeMutablePointer<Int>)?
    var basePtr = arrayPtr.baseAddress!
    /// basePtr is UnsafeMutablePointer<Int>)!

    basePtr.pointee
    basePtr.pointee = 10
    basePtr.pointee

    //下一个元素
    var nextPtr = basePtr.successor()
    nextPtr.pointee
}

/*:
 # 指针操作和转换
 ## withUnsafePointer
 Swift 中 对某个变量进行指针操作，我们可以借助 withUnsafePointer 这个辅助方法。这个方法接受两个参数，第一个是 inout 的任意类型，第二个是一个闭包。Swift 会将第一个输入转换为指针，然后将这个转换后的 Unsafe 的指针作为参数，去调用闭包。
 */
do {
    var test = 10
    test = withUnsafeMutablePointer(to: &test, { (ptr: UnsafeMutablePointer<Int>) -> Int in
        ptr.pointee += 1
        return ptr.pointee
    })
    
    test // 11
}

/*:
 ## unsafeBitCast
 unsafeBitCast 是非常危险的操作，它会将一个指针指向的内存强制按位转换为目标的类型。因为这种转换是在 Swift 的类型管理之外进行的，因此编译器无法确保得到的类型是否确实正确，你必须明确地知道你在做什么。
 */
do {
    /// NSArray 是可以存放任意 NSObject 对象的，当我们在使用 CFArrayGetValueAtIndex 从中取值的时候，得到的结果将是一个 UnsafePointer<Void>。由于我们很明白其中存放的是 String 对象，因此可以直接将其强制转换为 CFString。
    let arr = NSArray(object: "meow")
    let str = unsafeBitCast(CFArrayGetValueAtIndex(arr, 0), to: CFString.self)
    str // “meow”
}
/*:
 关于 unsafeBitCast 一种更常见的使用场景是不同类型的指针之间进行转换。因为指针本身所占用的的大小是一定的，所以指针的类型进行转换是不会出什么致命问题的。这在与一些 C API 协作时会很常见。比如有很多 C API 要求的输入是 void *，对应到 Swift 中为 UnsafePointer<Void>。我们可以通过下面这样的方式将任意指针转换为 UnsafePointer。
 */
do {
    var count = 100
    var voidPtr = withUnsafePointer(to: &count, { (a: UnsafePointer<Int>) -> UnsafeRawPointer in
        //return unsafeBitCast(a, to: UnsafeRawPointer.self)
        return UnsafeRawPointer(a)
    })
    /// voidPtr 是 UnsafePointer<Void>。相当于 C 中的 void *

    /// 转换回 UnsafePointer<Int>
    var intPtr = unsafeBitCast(voidPtr,  to: UnsafePointer<Int>.self)
    intPtr.pointee
}


//: [Next](@next)
