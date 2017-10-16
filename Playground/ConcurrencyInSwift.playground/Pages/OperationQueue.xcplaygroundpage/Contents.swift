/*:
 
 ## All About Concurrency in Swift - Part 1: The Present Playground
 
 Read the post at [uraimo.com](https://ww.uraimo.com/2017/05/07/all-about-concurrency-in-swift-1-the-present/)
 
 任务组隔离：线程可以从执行流程角度模块化应用，不同线程用可预测的方式执行同类的一组任务，隔离应用中其他执行流程，这样对应用当前的状态更加可控。
 数据独立并行计算：多个软件线程，无论是基于硬件线程还是不基于软件线程，都通过并行处理同一个任务的多个拷贝，这个任务作用于原始输入数据结构的其中某个子集。
 更加清晰的方式等待竞争或I/O：使用阻塞 I/O 或执行某种类型的阻塞操作时，后台线程会等待这些操作的完成。使用线程，可以增强应用的设计，并且让处理阻塞的调用更加常见。
 
 并发编程将面临一些额外的挑战，不得不去处理一些共同的问题：
 - 竞争条件：当多线程操作同样的数据时，读和写数据同时进行，这一系列执行操作结果在不同的线程操作顺序下，变得不可预测。
 - 资源冲突：多线程会执行多个任务，需要安全的访问相同的资源时，将会增加额外的时间，这些延迟获取资源的时间，可能会导致不可预期的行为或者使得应用程序处理这些资源的数据结构变得复杂。
 - 死锁：多线程互相等待需要资源或锁的释放，然后永远阻塞这些线程的执行。
 - 饥饿：一个线程无法获取资源或者一个特定排序的资源，需要各种条件获取资源或者尝试获取资源永远失败。
 - 优先级反转：低优先级线程可能不断持有资源，需要这个资源的高优先级线程可能被其他不需要此资源的低优先级线程反转。
 - 不可预期和公平：不能假设在什么时候或者什么顺序下，一个线程能获取到线程资源，延迟时间不会被优先级所决定https://en.wikipedia.org/wiki/Unbounded_nondeterminism，但是会被冲突的数量所影响。一个线程不可能独立获得资源。但是并发原语用来保证临界区是公平的，或者说，为了公平，所有线程等待访问临界区的顺序都是依据等待顺序而来
 */


//: [Previous - GCD](@previous)

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


/*: 
# OperationQueue
*/


/*:
 ### Operation Queue Basics
 */

var queue = OperationQueue()
queue.name = "My Custom Queue"
queue.maxConcurrentOperationCount = 2

var mainqueue = OperationQueue.main //Refers to the queue of the main thread

queue.addOperation {
    print("Op1")
}
queue.addOperation {
    print("Op2")
}


//: Operations

var op3 = BlockOperation(block: {
    print("Op3")
})
op3.queuePriority = .veryHigh
op3.completionBlock = {
    if op3.isCancelled {
        print("Someone cancelled me.")
    }
    print("Completed Op3")
}


var op4 = BlockOperation {
    print("Op4 always after Op3")
    OperationQueue.main.addOperation{
        print("I'm on main queue!")
    }
}

//: Dependencies between operations

op4.addDependency(op3)

queue.addOperation(op4)  // op3 will complete before op4, always
queue.addOperation(op3)

//: Operation status

op3.isReady       //Ready for execution?
op3.isExecuting   //Executing now?
op3.isFinished    //Finished naturally or cancelled?
op3.isCancelled   //Manually cancelled?

//: Cancel operations

queue.cancelAllOperations()

op3.cancel()

//: Suspend or check suspension status

queue.isSuspended = true











