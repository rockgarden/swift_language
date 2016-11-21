//: [Previous](@previous)

import UIKit

/*:
 # CLOSURES 闭包 
 = unnamed functions 匿名函数
 
 闭包
 - 闭合并包裹着常量和变量, 俗称闭包.
 - 是一个很轻量但是功能十分强大的函数, 可以捕获和存储其所在上下文中任意常量和变量的引用, 常用于类间的值传递, 闭包通常作为函数的参数来使用, 当然也可以作为变量.
 - Swift会为您管理在捕获过程中涉及到的所有内存操作。
 
 闭包采取如下三种形式之一：
 - 全局函数是一个有名字但不会捕获任何值的闭包
 - 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
 - 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
 闭包表达式: { (parameters) -> returnType in statements }
 eg. () -> Void
 */
do {
    func animateWithDuration(duration: TimeInterval, animations: () -> Void) {}

    var button = UIButton()
    UIView.animate(withDuration: 1, animations: {
        button.alpha = 0
    })
}

/*:
 ## 闭包特性 - 类型推断
 - 使用类型推断, 可以省略参数类型和返回类型;
 - Using type inference, can omit the params and return types.
 - This is true when passing closures as params to a function.
 */
do {
    let array = ["John", "Tim", "Steve", "Wangkan"]
    array.sorted(by: {(s1: String, s2: String) -> Bool in return s1 > s2})
    array.sorted(by: {(s1, s2) -> Bool in return s1 > s2})
    array
}

/*:
 ## 闭包特性 - 单个表达式闭包, 返回值是隐式的, 因此可以省略返回表达式.
 In case of single-expression closures, the return value is implicit,
 thus the return expression can be omitted.
 包函数体内如果是单一表达式, 还可以省去return语句
 */
do {
    var array = ["John", "Wangkan", "Steve", "Wangkan"]
    array.sort(by: {(s1, s2) in s1 == s2})
    array.sort(by: {s1, s2 in s1 == s2})
    array.sort(by: ==)
    array
}

/*: 
 swift 2: 如果一个闭包中有一个或多个参数，Swift 允许我们通过参数名来访问参数.
 swift 3: ?! like down
 
 这下面的例子中，我们的尾部闭包中有一个名为goodbye的String型参数，Xcode会将这个参数放到一个元组中，然后紧跟着一个类型代表返回值，最后再加上in关键字来代表参数的结束。
*/
do {
    func say(_ message: String, completion: (String, String, Int) -> Void) {
        (message)
        completion("Goodbye", "wk", 40)
    }
//    say("Hi", completion: {("Goodbye", "wk", 40) -> Void in
//        print($0,$1,$2)
//    })
    /// () -> Void in 可省略.
    say("good") { print($0,$1,$2) }
}

/*:
 ## INLINE CLOSURES
 内联闭包
 */
do {
    let array = ["John", "Tim", "Steve", "Wangkan"]
    /// func sorted new [Element]
    array.sorted()
    array
    array.sorted(by: > )
    array
    var arr = array
    /// mutating func sort - so let "array" can't use
    arr.sort(by: <)
}

/*:
 ## TRAILING CLOSURES
 方法中最后一个参数是闭包，顾名思义，称之为尾部(Trailing)闭包。
 尾部闭包允许我们省略参数名，并且能放置在参数表括号以外，进一步简洁代码。

 当闭包太长, 不适合定义为内联. Closures which are too long to be defined inline.

 如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数, 可以使用尾随闭包来增强函数的可读性.

 尾随闭包是一个书写在函数括号之后的闭包表达式, 函数支持将其作为最后一个参数调用.
 */
do { }

//: - Note: In case the function doesn't take any params other than a trailing closure, there's no need for parenthesis.如果函数除了trailing closure不接受任何参数，就不需要括号。
do {
    let array = ["John", "Tim", "Steve", "Wangkan"]
    array.sorted{(s1, s2) -> Bool in return s1 > s2}
    array
    var arr = array
    arr.sort{(s1, s2) -> Bool in return s1 > s2}
    arr
}

do {
    enum HTTPResponse {
        case ok
        case error(Int)
    }

    var responses: [HTTPResponse] = [.error(500), .ok, .ok, .error(404), .error(403)]

    let sortedResponses = responses.sorted {
        switch ($0, $1) {
        // Order errors by code
        case let (.error(aCode), .error(bCode)):
            return aCode < bCode

        // All successes are equivalent, so none is before any other
        case (.ok, .ok): return false

        // Order errors before successes
        case (.error, .ok): return true
        case (.ok, .error): return false
        }
    }
    (sortedResponses)
    (responses)

    responses.sort {
        switch ($0, $1) {
        // Order errors by code
        case let (.error(aCode), .error(bCode)):
            return aCode < bCode

        // All successes are equivalent, so none is before any other
        case (.ok, .ok): return false

        // Order errors before successes
        case (.error, .ok): return true
        case (.ok, .error): return false
        }
    }
    (responses)
}

//: ## closure capture
//: the rule for @escaping is about a function passed in and then passed out so.
do {
    /// this is legal
    func funcCaller(f: ()->()) {
        f()
    }

    func funcMaker() -> () -> () {
        return { print("hello world") }
    }

    /// but this is not legal, without @escaping
    func funcPasser(f: @escaping ()->()) -> () -> () {
        return f
    }

    class ViewController: UIViewController {
        func test() {
            func f() {
                print(presentingViewController!)
            }
            funcCaller(f: f) // okay
            let f2 = funcPasser(f: f) // okay, even though f doesn't say "self"
            // I regard that as a bug (and I think so does Jordan Rose)
            let f3 = funcPasser {
                print(self.presentingViewController!) // self required
            }

            let _ = (f2,f3)
        }

        func pass100 (_ f:(Int)->()) {
            f(100)
        }

        func countAdder(_ f: @escaping ()->()) -> () -> () {
            var ct = 0
            return {
                ct = ct + 1
                print("count is \(ct)")
                f()
            }
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            var x = 0
            print(x)
            func setX(newX:Int) {
                x = newX
            }
            pass100(setX)
            print(x)

            func greet () {
                print("howdy")
            }
            let countedGreet = countAdder(greet)
            countedGreet() // 1
            countedGreet() // 2
            countedGreet() // 3

            do {
                let countedGreet = countAdder(greet)
                let countedGreet2 = countAdder(greet)
                countedGreet() // count is 1
                countedGreet2() // count is 1
            }

            do { // showing that functions are reference types
                let countedGreet = countAdder(greet)
                let countedGreet2 = countedGreet
                countedGreet() // count is 1
                countedGreet2() // count is 2
            }
        }
 
    }

}



class Dog {
    var whatThisDogSays = "woof"
    func bark() {
        print(self.whatThisDogSays)
    }
}
struct Dog2 {
    var whatThisDogSays = "woof"
    func bark() {
        print(self.whatThisDogSays)
    }
}

/// (Void) -> Void) == ()->()
func doThis(_ f: ()->()) { // f : Void -> Void
    f()
}
doThis { // no parentheses!
    print("Howdy")
}

func imageOfSize(_ size:CGSize, _ whatToDraw: () -> ()) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    whatToDraw()
    let result = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return result
}

func makeRoundedRectangle(_ sz:CGSize) -> UIImage {
    let image = imageOfSize(sz) {
        let p = UIBezierPath(
            roundedRect: CGRect(origin:CGPoint.zero, size:sz),
            cornerRadius: 8)
        p.stroke()
    }
    return image
}

//: 嵌套函数 f
func makeRoundedRectangleMakerPrelim(_ sz:CGSize) -> () -> UIImage {
    func f () -> UIImage {
        let im = imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPoint.zero, size:sz),
                cornerRadius: 8)
            p.stroke()
        }
        return im
    }
    return f
}

func makeRoundedRectangleMakerPrelim2(_ sz:CGSize) -> () -> UIImage {
    func f () -> UIImage {
        return imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPoint.zero, size:sz),
                cornerRadius: 8)
            p.stroke()
        }
    }
    return f
}

func makeRoundedRectangleMakerPrelim3(_ sz:CGSize) -> () -> UIImage {
    return {
        return imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPoint.zero, size:sz),
                cornerRadius: 8)
            p.stroke()
        }
    }
}

func makeRoundedRectangleMaker(_ sz:CGSize) -> () -> UIImage {
    return {
        imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPoint.zero, size:sz),
                cornerRadius: 8)
            p.stroke()
        }
    }
}

// stop hard-coding the radius
func makeRoundedRectangleMaker2(_ sz:CGSize, _ r:CGFloat) -> () -> UIImage {
    return {
        imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPoint.zero, size:sz),
                cornerRadius: r)
            p.stroke()
        }
    }
}

// explicit curry
func makeRoundedRectangleMaker3(_ sz:CGSize) -> (CGFloat) -> UIImage {
    return {
        r in
        imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPoint.zero, size:sz),
                cornerRadius: r)
            p.stroke()
        }
    }
}


// implicit curry: deprecated in Swift 2.2, slated for removal in Swift 3

/*

 func makeRoundedRectangleMaker4(sz:CGSize)(_ r:CGFloat) -> UIImage {
 return imageOfSize(sz) {
 let p = UIBezierPath(
 roundedRect: CGRect(origin:CGPointZero, size:sz),
 cornerRadius: r)
 p.stroke()
 }
 }

 */

// There is a difference in what "capture" means
// depending on whether the surrounding is a value type or a reference type
// I don't bring this out in the book, unfortunately
// the tests below are much more extensive than anything I discuss in the book

do {

    // Dog is a class instance

    let d = Dog()
    d.whatThisDogSays = "arf"
    let barkFunction = d.bark
    doThis(barkFunction) // arf
    doThis(d.bark) // arf

    d.whatThisDogSays = "ruff"
    doThis(barkFunction) // ruff
    doThis(d.bark) // ruff


}

do {

    // Dog2 is a struct instance

    var d = Dog2()
    d.whatThisDogSays = "arf"
    let barkFunction = d.bark
    doThis(barkFunction) // arf
    doThis(d.bark) // arf


    d.whatThisDogSays = "ruff" // makes a _different dog_
    doThis(barkFunction) // arf // the old dog is still captured in the closure
    doThis(d.bark) // ruff, because we are now fetching the new dog


}

do {
    func drawing() {
        let p = UIBezierPath(
            roundedRect: CGRect(x:0,y:0,width:45,height:20), cornerRadius: 8)
        p.stroke()
    }
    let image = imageOfSize(CGSize(width:45,height:20), drawing)
    _ = image
}

do {
    let image = imageOfSize(CGSize(width:45,height:20)) {
        let p = UIBezierPath(
            roundedRect: CGRect(x:0,y:0,width:45,height:20), cornerRadius: 8)
        p.stroke()
    }
    _ = image
}

do {
    let sz = CGSize(width:45,height:20)
    let image = imageOfSize(sz) {
        let p = UIBezierPath(
            roundedRect: CGRect(origin:CGPoint.zero, size:sz), cornerRadius: 8)
        p.stroke()
    }
    _ = image
}

var myImageView : UIImageView!, myImageView2: UIImageView!

myImageView.image = makeRoundedRectangle(CGSize(width:45,height:20))

do {
    let maker = makeRoundedRectangleMakerPrelim(CGSize(width:45,height:20))
    _ = maker
}

let maker = makeRoundedRectangleMaker(CGSize(width:45,height:20))
myImageView2.image = maker()


let maker2 = makeRoundedRectangleMaker2(CGSize(width:45,height:20), 8)
_ = maker2

let maker3 = makeRoundedRectangleMaker3(CGSize(width:45,height:20))
myImageView.image = maker3(8)

let image1 = makeRoundedRectangleMaker3(CGSize(width:45,height:20))(8)
_ = image1

//        let maker4 = makeRoundedRectangleMaker4(CGSizeMake(45,20))
//        self.myImageView.image = maker4(8)
//
//        let image2 = makeRoundedRectangleMaker4(CGSizeMake(45,20))(8)
//        _ = image2

//: [Next](@next)
