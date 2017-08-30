//: [Previous](@previous)

import UIKit

do {
    ///一个全局队列进行一些操作后切换到主线程配置UI
    /// public class func global(qos: DispatchQoS.QoSClass = default) -> DispatchQueue
    DispatchQueue.global().async {
        // 全局-异步
        DispatchQueue.main.async {
            // 主线程中-异步
        }
    }
    
    DispatchQueue.global().sync {
        // 同步执行
    }
}

/*:
 ## 优先级：QoS
 现在则改为了QoSClass枚举
     public enum QoSClass {
         case background
         case utility //LOW
         case `default`
         case userInitiated
         case userInteractive
         case unspecified
         public init?(rawValue: qos_class_t)
         public var rawValue: qos_class_t { get }
     }
 */

do {
    // 同步队列
    let serialQueue = DispatchQueue(label: "queuename")
    
    // 并发队列
    let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
    
    let delay = DispatchTime.now() + DispatchTimeInterval.seconds(60)
    
    do {
        //public func +(time: DispatchTime, seconds: Double) -> DispatchTime
        let three = DispatchTime.now() + 3.0
    }
    
    DispatchQueue.main.asyncAfter(deadline: delay) {
        // 延迟执行
    }
}

/*:
 ## DispatchGroup
 如果想在dispatch_queue中所有的任务执行完成后再做某种操作可以使用DispatchGroup。
 */
do {
    let group = DispatchGroup()
    
    let queueBook = DispatchQueue(label: "book")
    queueBook.async(group: group) {
        // 下载图书
    }
    let queueVideo = DispatchQueue(label: "video")
    queueVideo.async(group: group) {
        // 下载视频
    }
    
    group.notify(queue: DispatchQueue.main) {
        // 下载完成
    }
    /// DispatchGroup会在组里的操作都完成后执行notify。
    
    /// 如果有多个并发队列在一个组里，我们想在这些操作执行完了再继续，调用wait
    group.wait()

}

/*:
 ## DispatchWorkItem
 在DispatchQueue执行操作除了直接传了一个() -> Void类型的闭包外，还可以传入一个DispatchWorkItem。
    public func sync(execute workItem: DispatchWorkItem)
    public func async(execute workItem: DispatchWorkItem)
 
 DispatchWorkItem的初始化方法可以配置Qos和DispatchWorkItemFlags，但是这两个参数都有默认参数，所以也可以只传入一个闭包。
 
     public init(qos: DispatchQoS = default, flags: DispatchWorkItemFlags = default, block: @escaping @convention(block) () -> ())
     
     let workItem = DispatchWorkItem {
     // TODO:
     }
 DispatchWorkItemFlags枚举中assignCurrentContext表示QoS根据创建时的context决定。
 值得一提的是DispatchWorkItem也有wait方法，使用方式和group一样。调用会等待这个workItem执行完。
 */
do {
    let myQueue = DispatchQueue(label: "my.queue", attributes: .concurrent)
    let workItem = DispatchWorkItem {
        sleep(1)
        print("done")
    }
    myQueue.async(execute: workItem)
    print("before waiting")
    workItem.wait()
    print("after waiting")
}

/*:
 ## barrier
 假设我们有一个并发的队列用来读写一个数据对象。如果这个队列里的操作是读的，那么可以多个同时进行。如果有写的操作，则必须保证在执行写入操作时，不会有读取操作在执行，必须等待写入完成后才能读取，否则就可能会出现读到的数据不对。在之前我们用dipatch_barrier实现。
 现在属性放在了DispatchWorkItemFlags里。
 */
do {
    let wirte = DispatchWorkItem(flags: .barrier) {
        // write data
    }
    let dataQueue = DispatchQueue(label: "data", attributes: .concurrent)
    dataQueue.async(execute: wirte)
}

/*:
 ## 信号量
 为了线程安全的统计数量，我们会使用信号量作计数。原来的dispatch_semaphore_t现在用DispatchSemaphore对象表示。
 初始化方法只有一个，传入一个Int类型的数。
 */
do {
    let semaphore = DispatchSemaphore(value: 5)
    
    // 信号量减一
    semaphore.wait()
    
    //信号量加一
    semaphore.signal()
}

//: [Next](@next)
