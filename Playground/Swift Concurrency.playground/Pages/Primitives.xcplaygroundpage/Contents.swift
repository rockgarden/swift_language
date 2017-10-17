/*: 
 
 ## All About Concurrency in Swift - Part 1: The Present Playground

 Read the post at [uraimo.com](https://ww.uraimo.com/2017/05/07/all-about-concurrency-in-swift-1-the-present/)

*/

/*:
 # Contents
 
 * [Timer and Concurrency Primitives](#)
 * [GCD- Grand Central Dispatch](@next)
 * [NSOperationQueue](@last)
 */

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

/*:
# Timer and Concurrency Primitives 多线程和并发启蒙
*/

/*: 
### Timer

 Printing a message after 5 seconds with a Timer
*/
class Handler : NSObject{
    @objc func after5Sec(timer:Timer){
        print("Called after 5 seconds!")
        if let userInfo = timer.userInfo as? [String:String] {
            print("Invoked with param: " + userInfo["param1"]!)
        }
        timer.invalidate() //Always invalidate the current timer
    }
}

let h = Handler()

let timer = Timer.scheduledTimer(timeInterval: 5,
                                 target: h,
                                 selector: #selector(Handler.after5Sec(timer:)),
                                 userInfo: ["param1":"value1"],
                                 repeats: false)

// To stop the timer from firing
//timer.invalidate()
/*:
 ### Threads and concurrency primitives
 Foudation 库提供了一个 Thread 类，内部继承自 pthread，可以用来创建线程和执行闭包。
 Sleeping for 2 seconds and then printing
 */

class MyThread : Thread {
    override func main(){
        print("Thread started, sleep for 2 seconds...")
        Thread.sleep(forTimeInterval: 2)
        print("Done sleeping, exiting thread")
    }
}

var t = MyThread()
t.stackSize = 1024 * 16
t.start()               //Time needed to spawn a thread aroun 100us
/// 可以调用exit()来终止线程，但这不推荐使用，因为这样不能保证当前任务能清理完成，大多数情况下，需要自己编写停止逻辑，或者使用cancel()方法，在主闭包中使用isCancelled属性来判断线程是否需要在自然结束之前终止当前任务。

/*:
 ## Synchronization Primitives 同步原语
 */
/*:
 ### NSLock
 
 A simple lock
 当一个线程尝试对一个对象进行加锁时，可能会发生两件事情，线程会在这个锁没有被其他线程持有时，获得这个锁，或者线程将阻塞，等到锁的拥有者释放锁。从另外个角度讲，锁只能同时被一个线程所持有，这种机制非常适合作用于临界区的监控访问。
 NSLock 和其它的 Foundation 中锁是不公平的，意味着当一些线程想获取锁时，不会按照它们访问锁的顺序来获取锁。
 不能假设一个执行顺序，在一个高度线程冲突的环境中，当有许多线程尝试获取资源是，一些线程有可能会被置为饥饿，永远不能获取它们等待的锁（或者不能及时地获取资源）。
 没有竞争的情况下，获取一个锁需要的时间是 100 纳秒，但是当超过一个线程尝试获取锁资源时，耗费的时间将迅速增长。所以从性能的角度来说，锁不是解决资源分配最好的方式。
 当决定使用锁机制时，需要附加一些警告。迟早会对并发程序进行调试，这种情况下，记得限制对一些需要排序数据结构去使用锁，在代码中尽量不在多个地方直接引用一个锁。
 当调试一个并发问题时，检查有少量入口的同步数据结构的状态，要比随时关注锁在代码中的具体位置，并且需要记住在不同函数中锁状态来讲，要愉快的多。需要额外的工作，使得并发代码的结构更加合理。
 */

let lock = NSLock()

class LThread : Thread {
    var id:Int = 0
    
    convenience init(id:Int){
        self.init()
        self.id = id
    }
    
    override func main(){
        lock.lock()
        print(String(id)+" acquired lock.")
        lock.unlock()
        if lock.try() {
            print(String(id)+" acquired lock again.")
            lock.unlock()
        }else{  // If already locked move along.
            print(String(id)+" couldn't acquire lock.")
        }
        print(String(id)+" exiting.")
    }
}


var t1 = LThread(id:1)
var t2 = LThread(id:2)
t1.start()
t2.start()

/*:
 ### NSRecursiveLock
 
 A lock that can be acquired multiple times by the same thread without blocking
 递归锁可以在一个线程已经持有这个锁的情况下，在后面的代码中获取多次，在递归函数和调用多个需要顺序检查同一个锁的函数时，需要用到这种锁。递归锁和基本锁不能共用。
 */

let rlock = NSRecursiveLock()

class RThread : Thread {
    
    override func main(){
        rlock.lock()
        print("Thread acquired lock")
        callMe()
        rlock.unlock()
        print("Exiting main")
    }
    
    func callMe(){
        rlock.lock()
        print("Thread acquired lock")
        rlock.unlock()
        print("Exiting callMe")
    }
}


var tr = RThread()
tr.start()

/*:
 ### NSConditionLock
 
 A lock with multiple internal sublocks related different conditions or states
 条件锁提供了附加的子锁，子锁可以独立地被加锁和被解锁，用来支持复杂的加锁步骤（比如：消费者-提供者场景）。
 同时可以用一个全局锁（不管什么具体的场景都可以加锁），这种锁的行为和经典的 NSLock 一样。
 下面的例子使用一个条件锁来保护共享整型，提供者每次更新整型，消费者都会在终端打印整型。
 */

let NO_DATA = 1
let GOT_DATA = 2
let clock = NSConditionLock(condition: NO_DATA)
var SharedInt = 0


class ProducerThread : Thread {
    
    override func main(){
        for i in 0..<5 {
            /// 方法在条件成立的情况下获得一个锁，或者等待另外一个线程使用unlock(withCondition:)释放锁并且设置这个值。
            clock.lock(whenCondition: NO_DATA) //Acquire the lock when NO_DATA
            //If we don't have to wait for consumers we could have just done clock.lock()
            SharedInt = i
            clock.unlock(withCondition: GOT_DATA) //Unlock and set as GOT_DATA
        }
    }
}

class ConsumerThread : Thread {
    
    override func main(){
        for i in 0..<5 {
            clock.lock(whenCondition: GOT_DATA) //Acquire the lock when GOT_DATA
            print(i)
            clock.unlock(withCondition: NO_DATA) //Unlock and set as NO_DATA
        }
    }
}

let pt = ProducerThread()
let ct = ConsumerThread()
ct.start()
pt.start()

/*:
 ### NSCondition
 
 A condition lock with wait/signal
 不要混淆了 NSCondition 和条件锁，一个条件提供了更加清晰的等待条件产生的方式。
 当一个已经获得锁的线程需要验证额外的条件（一些需要的资源，一个处于特殊状态的对象等），满足条件才能继续运行的时候，需要一种方式挂起然后在条件成立的时候继续工作。
 在没有 NSCondition 的时候，这种情况通常会被实现为连续地或者周期性地检查条件（繁忙的等待），但是这样的话，线程获取的锁将会怎样？当条件成立希望再次获取他们之前，是应该等待还是释放它们呢？
 NSCondition 提供了一个此问题清晰的解决方案，拥有此锁的线程会将此条件加入了等待列表，当条件成立时，通过另外一个线程的信号唤醒此线程。
 */

let cond = NSCondition()
var available = false
var SharedString = ""

class WriterThread : Thread {
    
    override func main(){
        for _ in 0..<5 {
            cond.lock()
            SharedString = "😅"
            available = true
            cond.signal() // Notify and wake up the waiting thread/s
            cond.unlock()
        }
    }
}

class PrinterThread : Thread {
    
    override func main(){
        for _ in 0..<5 { //Just do it 5 times
            cond.lock()
            while(!available){   //Protect from spurious signals
                cond.wait()
            }
            print(SharedString)
            SharedString = ""
            available = false
            cond.unlock()
        }
    }
}

let writet = WriterThread()
let printt = PrinterThread()
printt.start()
writet.start()


/*:
 ### NSDistributedLock
 
 此锁的目标是在多个应用中共享数据，背后是是用一个文件系统的入口（比如一个简单的文件）。这意味着所有需要用到的应用都应该可以访问这个文件系统。
 使用try()方法来获取锁，这是一个非阻塞的方法，立即会返回一个布尔值来表明是否获取到了锁。获取锁的尝试通常是多次，通常在尝试成功之前都会加上一个合理的延迟。
 使用unlock()方法来释放一个分布式锁。
 */
var dlock = NSDistributedLock(path: "/tmp/MYAPP.lock")
if let dlock = dlock {
    var acquired = false
    while(!acquired){
        print("Trying to acquire the lock...")
        usleep(1000)
        acquired = dlock.try()
    }
    // Do something...
    dlock.unlock()
}

/*:
 ## 同步代码块
 在 Swift 中，不能像 Objective-C 创建一个 @synchronized 块那样去做并发操作，Swift 中没有对应可用的关键字。
 在 Darwin 系统下，可以使用 objc_sync_enter(OBJ) 和 objc_sync_exit(OBJ)实现 @ synchronized 类似的功能，并且存在一个 @objc 的对象监控器。这种方式不推荐使用，还是使用更简单的锁机制来实现并发，更加有效。
 正如接下来讨论 Dispatch Queues 时候会看到的那样，使用队列来实现类似的功能，在一个序列队列里面使用少量代码操作一个同步调用：
 serialQueue.sync {
 // 同时只有一个线程执行
 v += 1
 print("Current value \(v)")
 }
 */
//: [Next - GCD](@next)

