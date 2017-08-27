//: [Previous](@previous)

import UIKit

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


/*:
 ### 闭包特性三: 参数名称缩写
 In the previous examples, the names of the closure's params were explicit.
 You can use the $X variables to refer to params for the closure.
 This eliminates the need for the first params list, which makes the body the only relevant part.
 若对闭包的参数的显示声明,则可消除对应的参数列表
 当使用参数名称缩写的时候可以省去in
 */
//reversed = array.sort({$0 == $1}) //Sorting function with inline closure:
//reversed
//[1, 2, 3, nil, 5]
//    .flatMap { $0 }     // remove nils
//    .filter { $0 < 3 }  // filter numbers that are greater than 2
//    .map { $0 * 100 }   // multiply each value by 100
// [100, 200]
/*:
 We can even take this to an extreme.
 String defines its own implementation for the ">" operator,which is really all the closure does.
 运算符函数（Operator Functions）起作用还可以简写
 */
//reversed = array.sort(>)

// 利用上下文推断类型
var squreContent1: (Int) -> Int = {(num) in return num * num}
var squreContent2: (Int) -> Int = {num in return num * num}
var squreContent3: (Int) -> Int = {$0 * $0}
squreContent1(100)
squreContent2(100)
squreContent3(100)

func someFunctionThatTakesAClosure(closure: () -> ()) {
    // function body goes here
}
// 不使用一个尾随闭包: here's how you call this function without using a trailing closure:
someFunctionThatTakesAClosure({
    // closure's body goes here
})
// 使用一个尾随闭包: here's how you call this function with a trailing closure instead:
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}

func say(message: String, completion: () -> Void) {
    print(message)
    completion()
}
say("Hello", completion: {})
say("Hello") {} // Trailing closures

func someFunc(num:Int,fn:(Int)->()){}
someFunc(20, fn: {_ in })
someFunc(20){_ in }

func makeArr(ele: String) -> () -> [String] {
    var arr: [String] = []
    func addElement() -> [String]{
        arr.append(ele)
        return arr
    }
    return addElement
}

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

//: - Note: In case the function doesn't take any params other than a trailing closure, there's no need for parenthesis. 如果函数除了trailing closure不接受任何参数，就不需要括号。
let stringsArray = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        // Note how the optional value returned from the dic subscript is force-unwrapped,since a value is guaranteed.
        number /= 10
    }
    return output
}
stringsArray

var resultContent: Int = {
    var result = 1
    for i in 1...$1 {
        result *= $0
    }
    return result
}(4,3)
resultContent

//: ## Return Self
// extension UIView
//func withBackgroundColor(color: UIColor) -> Self {
//    backgroundColor = color
//    return self
//}
//func withCornerRadius(radius: CGFloat) -> Self {
//    layer.cornerRadius = 3
//    return self
//}
//let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
//    .withBackgroundColor(.blackColor())
//    .withCornerRadius(3)
/*:
 ## 捕获值 closure Capture
 闭包可以在其定义的上下文中捕获常量或变量.
 即使定义这些常量和变量的原域已经不存在,闭包仍然可以在闭包函数体内引用和修改这些值.
 闭包是引用类型,但是注意,当一个嵌套函数内的函数作为返回值的时候实际上是创建了一个新的函数.
 */
//: ### 全局函数
// Demo1
func pass100 (f:(Int)->()) {
    f(100)
}
var x = 0
(x)
func setX(newX: Int) {
    x = newX
}
pass100(setX)
(x)

// Demo2
var str = "Hello, playground"
func test(a: String = "") -> String {
    return str
}
test()
str = "Hello"
test()

//: ### 嵌套函数
// Demo1:
func countAdder(f:()->()) -> () -> () { // last () = () -> Void
    var ct = 0
    return {
        ct = ct + 1
        print("count is \(ct)")
        f()
    }
}
func greet () {
    print("howdy")
}
do {
    let countedGreet = countAdder(greet)
    let countedGreet2 = countAdder(greet)
    countedGreet() //count is 1
    countedGreet() //count is 2
    countedGreet2() //count is 1
}
do { // showing that functions are reference types
    let countedGreet = countAdder(greet)
    let countedGreet2 = countedGreet
    countedGreet() // count is 1
    countedGreet2() // count is 2
}

// Demo2: 函数作为返回值
func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount   //runningTotal
        return runningTotal
    }
    return incrementor
}
let incrementByTen = makeIncrementor(forIncrement: 10)
incrementByTen()
incrementByTen()

// 由于是创建了一个新函数..所以会像下面显示
let incrementBySeven = makeIncrementor(forIncrement: 7)
incrementBySeven()
incrementByTen()

// 由于是引用类型.所以
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()


//: [Next](@next)
