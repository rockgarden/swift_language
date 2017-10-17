/*:
 
 ## All About Concurrency in Swift - Part 1: The Present Playground
 
 Read the post at [uraimo.com](https://ww.uraimo.com/2017/05/07/all-about-concurrency-in-swift-1-the-present/)
 
 */


//: [Previous - Primitives](@previous)

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 # GCD - Grand Central Dispatch
 
 Grand Central Dispatch (GCD) 其实就是一个基于队列的 API，允许你在工作池中执行闭包。
 也就是说，闭包包含需要执行的任务，然后闭包将会被添加到队列中，队列将会使用一系列串行或者并行的线程执行它们，串行或并行执行取决于队列的配置选项。但是不管是那种类型的队列，任务的执行都遵从 FIFO 原则，意味着任务的执行顺序都会按照进入的顺序进行，完工时间取决于每个任务的持续时间。
 这是一个通用的处理并发的模式，在每一个现代语言的运行时中都会看到。线程池是一种简单的方式，管理，查看和控制一系列的空闲或者未连接的线程。
 */


/*:
 ### Dispatch Queues 调度队列
 
 A Thread pool that executes your jobs submitted as closures
 */

//: Create a new queue or use one of the default queues
/// 创建一个基本的串行队列，只需要提供一个字符串标签参数来识别它，通常推荐使用一个反向排序的域名前缀，用于在栈序列中查找队列的所有者。
let serialQueue = DispatchQueue(label: "com.uraimo.Serial1")  //attributes: .serial
/// 并行队列，意味着这个队列使用线程中的可用线程来执行它包含的任务。在这种情况下，执行的顺序不可预测，不要假设闭包的完成顺序和插入顺序有任何的联系。
let concurrentQueue = DispatchQueue(label: "com.uraimo.Concurrent1", attributes: .concurrent)
/// 主队列是一个顺序执行的队列，用于处理 iOS 和 macOS 可视化应用中的主事件循环，响应事件并且更新用户界面。众所周知，每一个对于用于界面的修改都将会在此队列中执行，每一个长时间的操作都会在此线程中绘制用户界面，这样用户界面会响应不及时。
let mainQueue = DispatchQueue.main

let globalDefault = DispatchQueue.global()

/*:
 不同级别的优先级定义在 DispatchQoS类（译者注：DispatchQoS 是一个结构体，内含一个枚举类型表示优先级）中，从高到低如下：
 .userInteractive
 .userInitiated
 .default
 .utility
 .background
 .unspecified
 需要重点注意的是，在手机设备上，提供低电量模式，在低电量情况下，后台队列会被挂起。
 */
let backgroundQueue = DispatchQueue.global(qos: .background)

let serialQueueHighPriority = DispatchQueue(label: "com.uraimo.SerialH", qos: .userInteractive)

/*:
 Executing closures on a specific queue
 任务以闭包的方式存在，可以使用两种方式将任务提交到队列中：
 使用sync方法进行同步操作，或者使用async方法进行异步操作。
 当使用前者时，sync调用将会被阻塞，换句话说，当闭包完成时，sync方法才会完成（当需要等待闭包完成情况下，这种方式是有效的，但是有更好的方法），而前者会将闭包加入到队列中，安排闭包延迟执行，并且允许当前的函数继续执行。
 */

globalDefault.async {
    print("Async on MainQ, first?")
}

globalDefault.sync {
    print("Sync in MainQ, second?")
}

/// 多个分发的调用可能会被嵌套，在一个设定好的队列上执行后台的，低优先级的操作，然后需要更新主队列的用户界面。
DispatchQueue.global(qos: .background).async {
    // Some background work here
    
    DispatchQueue.main.async {
        // It's time to update the UI
        print("UI updated on main queue")
    }
}

//: Delayed execution
/// 使用 DispatchTimeInterval枚举中的 4 个时间单位来组合不同的时间间隔：.seconds(Int), .milliseconds(Int), .microseconds(Int)和 .nanoseconds(Int).
globalDefault.asyncAfter(deadline: .now() + .seconds(3)) {
    print("After 3 seconds")
}

//: Shortcut for multiple concurrent calls
/// 如果想同时执行一个相同的闭包多次（类似于使用 dispatch_apply的那样），可以使用concurrentPerform(iterations:execute:)来实现，需要注意的是，这些闭包可能会在当前的队列中并行执行，所以请记住把这个调用的方法包含在一个支持并发队列的同步和异步调用中。
globalDefault.sync {
    DispatchQueue.concurrentPerform(iterations: 5) {
        print("\($0) times")
    }
}


//: Inactive DispatchQueue
/// 通常一个队列在创建后就会执行它的闭包，但是也可以手动的启动任务
let inactiveQueue = DispatchQueue(label: "com.uraimo.inactiveQueue", attributes: [.concurrent, .initiallyInactive])
inactiveQueue.async {
    print("Done!")
}
print("Not yet...")
inactiveQueue.activate()
print("Gone!")
/*:
 任务可以使用继承自 DispatchObject 的方法来挂起或者恢复任务的执行：
 inactiveQueue.suspend()
 inactiveQueue.resume()
 setTarget(queue:) 方法可以用来配置非活跃队列的优先级（使用它来设置活跃队列将导致崩溃），调用此方法，把队列的优先级设置为作为参数传入队列的优先级。
 */


/*:
 Execution with a final completion barrier 屏障
 在添加一系列闭包到指定的队列中（在不同的间隔）之后，这时想在所有异步任务完成之后执行一个任务。就需要使用屏障(Barriers)来做事。
 屏障还被用于强制指定并发队列的执行顺序，不想让那些已经注册任务的执行按照一个重复的方式进行。
 分发屏障不能作用与串行队列或者任何一种类型的全局并行队列)，如果你想使用它，就必须自定义一个全新的并行队列。
 */
/// 添加 20 个任务（每个任务将休眠一秒钟再执行）到之前创建的并发队列中，使用屏障在所有任务完成时打印一些东西，在最后一个 async 调用时候指定一个 DispatchWorkItemFlags.barrier 标识，20 个任务将会并行乱序执行，可以看到打印消息会成组出现，打印数量是 Mac 系统的执行内核的个数，但是最后一个调用将会在最后执行。
concurrentQueue.async {
    DispatchQueue.concurrentPerform(iterations: 20) { (id:Int) in
        sleep(1)
        print("Async on concurrentQueue, 5 times: "+String(id))
    }
}

concurrentQueue.async (flags: .barrier) {
    print("All 20 concurrent tasks completed")
}

//: Dispatch_once and Singletons

/// Swift 确保使用原子化的方式进行全局变量初始化，如果你确认常量不会在初始化后改变它的值，这两个特征确保全局常量是一个很好的实现单例 dispatch_once 的方式：
final class Singleton {
    public static let sharedInstance: Singleton = Singleton()
    private init() { }
}
/// 添加类的final修饰确保没有子类可以继承它，并且把指定构造器设置为私有，这样就没有可能通过其他方式手动创建这个类的实例了。全局静态常量将会是 Singleton 唯一访问入口，用于获取单独的，共享的实例。

//: Leveraging atomic initialization property of variables

func runMe() {
    struct Inner {
        static let i: () = {
            print("Once!")
        }()
    }
    Inner.i
}

runMe()
runMe()
runMe()


//: With a proper extension to DispatchQueue
/// 重现 dispatch_once 所提供的功能，可使用一个扩展在同步模块区域添加代码。
public extension DispatchQueue {
    
    private static var onceTokens = [Int]()
    private static var internalQueue = DispatchQueue(label: "dispatchqueue.once")
    
    public class func once(token: Int, closure: ()->Void) {
        internalQueue.sync {
            if onceTokens.contains(token) {
                return
            } else {
                onceTokens.append(token)
            }
            closure()
        }
    }
}

let t = 1
DispatchQueue.once(token: t) {
    print("only once!")
}
DispatchQueue.once(token: t) {
    print("Two times!?")
}
DispatchQueue.once(token: t) {
    print("Three times!!?")
}


/*:
 DispatchGroups 调度组, group together jobs on different queues
 如果你有多个任务，想添加到多个不同的队列中，并且想等待它们的完工，你可以把它们进行分组，添加到一个调度组中。
 */
let mygroup = DispatchGroup()

for i in 0..<5 {
    globalDefault.async(group: mygroup){
        sleep(UInt32(i))
        print("Group async on globalDefault:"+String(i))
    }
}

//: A notification is triggered when all jobs complete or ....
/// 任务将在 globalDefault 里面执行，但是可以注册一个 mygroup 的回调，一旦所有任务完成以后，将会在队列中执行一个闭包，wait()方法用于执行阻塞等待。
print("Waiting for completion...")
mygroup.notify(queue: globalDefault) {
    print("Notify received, done waiting.")
}
mygroup.wait()
print("Done waiting.")

//: When there are no more members in the group

print("Waiting again for completion...")
mygroup.notify(queue: mainQueue) {
    print("Notify received, done waiting on mainQueue.")
}
/// 另外一种跟踪组任务方式是，手动在运行队列代码调用中进入和离开一个组，替换指定的方式
for i in 0..<5 {
    mygroup.enter()
    sleep(UInt32(i))
    print("Group async on mainQueue:"+String(i))
    mygroup.leave()
}

/*:
 DispatchWorkItems 调度工作项
 闭包不是队列中指定任务实现的唯一方式，有时可能需要一个容器类型来跟踪执行的状态，这个时候 DispatchWorkItem 就派上了用场，工作项的每一个方法，都包括一个闭包作为它的参数。
 */
/// 工作项封装了一个队列线程池执行的闭包，通过 perform() 来执行这个闭包：
let workItem = DispatchWorkItem {
    print("Done!")
}

workItem.perform()
/// DispatchWorkItem 同样提供其它有用的方法，比如: 和组的定义一样，notify方法将会在指定的队列执行完成以后执行一个闭包
workItem.notify(queue: DispatchQueue.main) {
    print("Notify on Main Queue!")
}

globalDefault.async(execute: workItem)
/// 也可以等待闭包执行结束，或者在队列尝试调用cancel()方法（这不是取消执行中的闭包）之前标记它删除
//workItem.cancel()
//workItem.wait()


/*:
 DispatchSemaphore 调度信号量
 调度信号量是一种锁，根据当前计数的值，可以被多个线程获取。
 线程会等待一个信号量，直到信号量减到 0 时，就可以获取它了。
 访问信号量的槽将对等待线程释放，等待线程调用signal方法将会增加计数。
 */

let sem = DispatchSemaphore(value: 2)

// The semaphore will be held by groups of two pool threads 
globalDefault.sync {
    DispatchQueue.concurrentPerform(iterations: 10) { (id:Int) in
        sem.wait(timeout: DispatchTime.distantFuture)
        sleep(1)
        print(String(id)+" acquired semaphore.")
        sem.signal()
    }
}



/*:
 Dispatch assertions 调度断言
 assertions to verify that we are on the right queue.
 用于在当前执行上下文中进行断言，用于验证一个闭包是否在预期的队列中被执行了。使用 DispatchPredicate 枚举的是三个值来断言执行的情况：.onQueue, 验证闭包是否执行在一个指定队列中，.notOnQueue, 验证相反的情况，.onQueueAsBarrier，验证当前闭包或者工作项是否作为一个队列的屏障存在。
 */

// Uncomment to crash!
//dispatchPrecondition(condition: .notOnQueue(mainQueue))
//dispatchPrecondition(condition: .onQueue(queue))


/*:
 ## Dispatch Sources
 调度资源是一种处理系统级异步事件的方式，包括内核信号，系统，文件或者 socket 相关使用事件处理的事件。
 有以下几种类型可用的调度资源，归类如下：
 - Timer Dispatch Sources : 用作产生与时间或者周期相关的事件（DispatchSourceTimer）。
 - Signal Dispatch Sources : 用于处理 UNIX 信号（DispatchSourceSignal）。
 - Memory Dispatch Sources: 用于注册与内存使用状态相关的通知（DispatchSourceMemoryPressure）。
 - Descriptor Dispatch Sources: 用于注册文件和socket相关的不同事件（DispatchSourceFileSystemObject, DispatchSourceRead, DispatchSourceWrite）。
 - Process dispatch sources: 用于监控外部进程相关执行状态的时间（DispatchSourceProcess）。
 - Mach related dispatch sources: 用于处理 Mach 内核的 IPC 工具相关的事件（DispatchSourceMachReceive, DispatchSourceMachSend）。
 也可以在需要的时候自定义调度资源。所有的调度资源都遵从DispatchSourceProtocol 协议，需要定义注册处理器的基本操作，修改调度资源的激活状态等。
 */

/*:
 举一个 DispatchSourceTimer 的例子来理解如何使用这些对象。
 使用 DispatchSource 的工具函数来创建资源对象，在下面代码中使用 makeTimerSource， 指定需要执行处理的调度队列。
 时间资源没有其它参数，只需要指定队列来创建资源，调度资源可以处理多个时间，通常需要指定处理事件的标识符。
 */
let timerSource = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
timerSource.setEventHandler{ print("!") }
timerSource.schedule(deadline: .now(), repeating: .seconds(5), leeway: .seconds(1))
timerSource.activate()
/*:
 资源建立以后，使用setEventHandler(closure:)注册一个时间处理器，如果没有其它配置了，使用activate()开启调度资源（前一个版本的libDispatch 使用的是 resume()方法）。
 调度资源初始是不激活的，意味着不会立刻执行事件。当一切准备情绪后，资源将使用activate()激活分发事件，也可以使用suspend()挂起和使用resume()恢复。
 */
timerSource.schedule(deadline: .now(), repeating: .seconds(5), leeway: .seconds(1))
/// 当完成一个调度资源时，想完全阻止调度事件，可以使用cancel()来完成，这样可以停止资源事件，取消已经设置的处理器，并且进行一些清理操作，比如注销处理器等。
timerSource.cancel()

/*:
 初始化读取资源
 */
/// 处理在一个建立连接的 socket 的异步写
//let readerSource = DispatchSource.makeReadSource(fileDescriptor: socket.socketfd,
//                                             queue: socketReaderQueue(fd: socket.socketfd))
//readerSource.setEventHandler() {
//    _ = self.handleRead()
//}
//readerSource.setCancelHandler(handler: self.handleCancel)
//readerSource.resume()


//: [Next - NSOperationQueue](@next)
