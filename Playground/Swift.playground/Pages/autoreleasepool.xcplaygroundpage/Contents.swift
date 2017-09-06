//: [Previous](@previous)

import UIKit

/*:
 To simplify the use of autorelease pools, and to bring them under the control of the compiler, a new kind of statement is available in Objective-C. It is written @autoreleasepool followed by a compound-statement, i.e. by a new scope delimited by curly braces. Upon entry to this block, the current state of the autorelease pool is captured. When the block is exited normally, whether by fallthrough or directed control flow (such as return or break), the autorelease pool is restored to the saved state, releasing all the objects in it. When the block is exited with an exception, the pool is not drained.

 @autoreleasepool may be used in non-ARC translation units, with equivalent semantics.
 
 http://www.jianshu.com/p/32265cbb2a26
 
 */
do {
    let path = Bundle.main.path(forResource: "001", ofType: "png")!
    for j in 0 ..< 50 {
        /// 在@autoreleasepool中创建的变量，会在@autoreleasepool结束的时候执行一次release，进行释放。
        autoreleasepool {
            for i in 0 ..< 10 {
                let im = UIImage(contentsOfFile: path)
            }
        }
    }

    for j in 0 ..< 50 {
        for i in 0 ..< 10 {
            let im = UIImage(contentsOfFile: path)
        }
    }
}

/*:
 自动释放池@autorelease面试频率可能会吧release还要高。
 （1）在自动释放池@autoreleasepool{}中alloc一个对象后（如p1），仍然需要用[p1 autorelease];只是这个语句和[p1 release];不同，后者表示把p1的retainCount-1，而前者仅仅表示把p1放到自动释放池中返回一个self，自动释放池结束销毁时，统一对里面的对象引用计数retainCount-1。
 （2）@autoreleasepool{}可以随意创建，也可以嵌套使用。
 （3）不管这个对象是在自动释放池内还是外创建的，只要在自动释放池内写一个[p1 autorelease];p1就会被放到自动释放池中。注意autorelease是一个方法，且只有在自动释放池中使用才有效。
 （4）如果把一个对象重复加到自动释放池如[p1 autorelease];[p1 autorelease];，那么会出错。原因是：加载几次，届时自动释放池就会用[p1 release];释放几次，但是由于这两个加载的对象其实是一个对象同样地址，所以第一次自动释放正确，第二次自动释放时发现已经被释放了，所以p1就变成了野指针。
 （5）以下是自动释放池嵌套的使用规则和注意点。
 #import <Foundation/Foundation.h>
 #import "Person.h"
 int main(int argc, const char * argv[]) {
 Person *p1=[[Person alloc]init];
 @autoreleasepool {
 @autoreleasepool {
 [p1 autorelease];
 }//在执行到此处时，p1被自动释放
 }

 //以下代码有错误
 @autoreleasepool {
 [p1 autorelease];//此时p1被加入进来
 @autoreleasepool {
 [p1 autorelease];//被重复加载进来，但仍然同一个
 }//此处，p1被自动释放了，所以第一次加进来的那个也被释放了，因为是同一个对象
 }//所以此处在调用[p1 release];时就出现报错：野指针

 return 0;
 }
 （6）@autoreleasepool的应用：如果需要在方法中创建对象，并把这个对象作为返回值，那么可以在这个方法中使用[*** autorelease];把它加入到自动释放池中，否则，直接用[*** release];来匹配alloc的话，在该方法中就已经把这个对象alloc和release了一遍相当于释放了，那么所谓的返回对象返回的时一个野指针（没有指向任何对象）。当然，调用这个方法的代码页需要写在自动释放池作用域内才生效。
 （7）接上面。返回对象的那个方法中，创建对象不建议直接用类名，而是用self，否则如果存在子类调用会崩溃。如Car *car1=[[self alloc]init];
 （8）其实诸如NSString *str1=[NSString stringWithFormat:@"%@",@"hello"];也是调用了一个方法，并且返回了一个字符串对象。比照（6）和（7）我们得知这个stringWithFormat应该也是顺便返回了一个autorelease。
 （9）在ARC机制中，我们用@property声明的成员变量，建议用strong代替之前手动管理内存时的retain，虽然后者仍然可以使用。因为我们在ARC中内存管理就是看是否有强指针指向对象，如有就不回收，如没有就回收。所以强指针是strong，相反是weak。而基本数据类型我们还是习惯用assign。
 （10）虽然Xcode提供了非ARC转换成ARC的，很少有把整个非ARC转换成ARC的。如果我们导入第三方库时，需要非ARC和ARC共存，即我们系统默认是ARC，我们需要让系统不要去管这个非ARC的第三方库，如下设置：双击响应的.m文件，输入-fno-objc-arc回车即可。
 */

//: [Next](@next)
