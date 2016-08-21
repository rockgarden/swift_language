//: [Previous](@previous)

/*:
 # CLOSURES 匿名函数
 闭包可以捕获和存储其所在上下文中任意常量和变量的引用,这就是所谓的闭合并包裹着这些常量和变量,俗称闭包.
 Swift会为您管理在捕获过程中涉及到的所有内存操作。
 闭包采取如下三种形式之一：
 - 全局函数是一个有名字但不会捕获任何值的闭包
 - 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
 - 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
 闭包表达式:
 { (parameters) -> returnType in
 statements
 }
 */
/*:
 ## INLINE CLOSURES
 内联闭包
 */
let array = ["John", "Tim", "Steve", "Wangkan"]
// (@noescape isOrderedBefore: (Self.Generator.Element, Self.Generator.Element) -> Bool) -> [Self.Generator.Element]
var reversed = array.sort({(s1: String, s2: String) -> Bool in return s1 > s2})
reversed
/*:
 ### 闭包特性一: 类型推断
 - 使用类型推断,可以省略参数类型和返回类型;
 - Using type inference, can omit the params and return types.
 - This is true when passing closures as params to a function.
 */
reversed = array.sort({s1, s2 in return s1 < s2})
reversed

/*:
 ### 闭包特性二: 单个表达式闭包,返回值是隐式的,因此可以省略返回表达式.
 In case of single-expression closures, the return value is implicit,
 thus the return expression can be omitted.
 包函数体内如果是单一表达式,还可以省去return语句
 */
reversed = array.sort({s1, s2 in s1 == s2})
reversed

/*:
 ### 闭包特性三: 参数名称缩写
 In the previous examples, the names of the closure's params were explicit.
 You can use the $X variables to refer to params for the closure.
 This eliminates the need for the first params list, which makes the body the only relevant part.
 若对闭包的参数的显示声明,则可消除对应的参数列表
 当使用参数名称缩写的时候可以省去in
 */
reversed = array.sort({$0 == $1}) //Sorting function with inline closure:
reversed

/*:
 We can even take this to an extreme.
 String defines its own implementation for the ">" operator,which is really all the closure does.
 运算符函数（Operator Functions）起作用还可以简写
 */
reversed = array.sort(>)

// 利用上下文推断类型
var squreContent1: (Int) -> Int = {(num) in return num * num}
var squreContent2: (Int) -> Int = {num in return num * num}
var squreContent3: (Int) -> Int = {$0 * $0}
squreContent1(100)
squreContent2(100)
squreContent3(100)

/*:
 ## TRAILING CLOSURES
 闭包特性四:尾随（Trailing）闭包语法
 如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数,可以使用尾随闭包来增强函数的可读性.
 尾随闭包是一个书写在函数括号之后的闭包表达式,函数支持将其作为最后一个参数调用.
 */
func someFunctionThatTakesAClosure(closure: () -> ()) {
    // function body goes here
}

func someFunc(num:Int,fn:(Int)->()){}
//someFunc(20 , {})
//someFunc(20){}

func makeArr(ele: String) -> () -> [String] {
    var arr: [String] = []
    func addElement() -> [String]{
        arr.append(ele)
        return arr
    }
    return addElement
}
//Closures which are too long to be defined inline.
//闭包太长,可被定义为内联
//here's how you call this function without using a trailing closure:
//如何调用这个函数,而不使用一个尾随闭包
someFunctionThatTakesAClosure({
    // closure's body goes here
})
// here's how you call this function with a trailing closure instead:
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}

//Note: In case the function doesn't take any params other than a trailing closure,
//there's no need for parenthesis.

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let stringsArray = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        //Note how the optional value returned from the dic subscript is force-unwrapped,
        //since a value is guaranteed.
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

/*
 ## 捕获值
 闭包可以在其定义的上下文中捕获常量或变量.
 即使定义这些常量和变量的原域已经不存在,闭包仍然可以在闭包函数体内引用和修改这些值.
 闭包是引用类型,但是注意,当一个嵌套函数内的函数作为返回值的时候实际上是创建了一个新的函数.
 */
// 全局函数
var str = "Hello, playground"
func test(a: String = "") -> String {
    return str
}
test()
str = "Hello";
test()
// 嵌套函数
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
incrementByTen()

// 由于是创建了一个新函数..所以会像下面显示
let incrementBySeven = makeIncrementor(forIncrement: 7)
incrementBySeven()
incrementByTen()

// 由于是引用类型.所以
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()

//: ## 示例
func doThis(f:()->()) { // f : Void -> Void
    f()
}
doThis { // no parentheses!
    ("Howdy")
}

func sayHowdy() -> String {
    return "Howdy"
}
func performAndPrint(f:()->String) {
    let s = f()
    (s)
}
performAndPrint {
    sayHowdy() // meaning: return sayHowdy()
}

import UIKit
func imageOfSize(size:CGSize, _ whatToDraw:() -> ()) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    whatToDraw()
    let result = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return result
}
let image = imageOfSize(CGSizeMake(45,20), {
    let p = UIBezierPath(
        roundedRect: CGRectMake(0,0,45,20), cornerRadius: 8)
    p.stroke()
})

func makeRoundedRectangle(sz:CGSize) -> UIImage {
    let image = imageOfSize(sz) {
        let p = UIBezierPath(
            roundedRect: CGRect(origin:CGPointZero, size:sz),
            cornerRadius: 8)
        p.stroke()
    }
    return image
}

// 嵌套函数 f
func makeRoundedRectangleMakerPrelim(sz:CGSize) -> () -> UIImage {
    func f () -> UIImage {
        let im = imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPointZero, size:sz),
                cornerRadius: 8)
            p.stroke()
        }
        return im
    }
    return f
}


func makeRoundedRectangleMakerPrelim2(sz:CGSize) -> () -> UIImage {
    func f () -> UIImage {
        return imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPointZero, size:sz),
                cornerRadius: 8)
            p.stroke()
        }
    }
    return f
}

func makeRoundedRectangleMakerPrelim3(sz:CGSize) -> () -> UIImage {
    return {
        return imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPointZero, size:sz),
                cornerRadius: 8)
            p.stroke()
        }
    }
}

func makeRoundedRectangleMaker(sz:CGSize) -> () -> UIImage {
    return {
        imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPointZero, size:sz),
                cornerRadius: 8)
            p.stroke()
        }
    }
}

// stop hard-coding the radius
func makeRoundedRectangleMaker2(sz:CGSize, _ r:CGFloat) -> () -> UIImage {
    return {
        imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPointZero, size:sz),
                cornerRadius: r)
            p.stroke()
        }
    }
}

// explicit curry
func makeRoundedRectangleMaker3(sz:CGSize) -> (CGFloat) -> UIImage {
    return {
        r in
        imageOfSize(sz) {
            let p = UIBezierPath(
                roundedRect: CGRect(origin:CGPointZero, size:sz),
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


func test(h:(Int, Int, Int) -> Int) {}
test {
    _ in // showing that _ can mean "ignore _all_ parameters"
    return 0
}

let arr = [2, 4, 6, 8]
func doubleMe(i:Int) -> Int {
    return i*2
}
let arr2 = arr.map(doubleMe) // [4, 8, 12, 16]
(arr2)
let arr3 = arr.map {$0*2} // it doesn't get any Swiftier than this
(arr3)
//: [Next](@next)
