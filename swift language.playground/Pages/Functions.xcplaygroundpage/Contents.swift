//: [Previous](@previous)
import UIKit
//: # Functions

func sayHello(personName: String) -> String{
    return "Hello \(personName)!"
}
sayHello("Juan")

func sum (x:Int, _ y:Int) -> Int {
    let result = x + y
    return result
}

//使用元组作为返回参数,返回多个参数
func count(string: String) -> (vowels: Int, consonants: Int, others: Int) {
    var vowels = 0, consonants = 0, others = 0
    for character in string.characters { // 也可通过extension String: SequenceType {}
        switch String(character).lowercaseString {
        case "a", "e", "i", "o", "u":
            vowels += 1

        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            consonants += 1
        default:
            others += 1
        }
    }
    return (vowels, consonants, others)
}

func reverseString(string: String) -> String {
    return String(string.characters.reverse())
}

// In this case we return a tuple
func minMax(array: [Int]) -> (min: Int, max:Int)? {
    if array.isEmpty {return nil}
    return (0,1)
}

/*:
 ## Void
 returning void translates in returning an empty tuple: ()
 没有定义返回类型的函数会返回特殊的值Void,它其实是一个空的元组tuple,没有任何元素,也可简写成()
 Void声明语法:illustrates some declaration syntax
 */
func say1(s:String) -> Void { print(s) }
func say2(s:String) -> () { print(s) }
func say3(s:String) { print(s) }
say3("sss")

let pointless : Void = say1("howdy")
print(pointless)
func greet1(unused:Void) -> String { return "howdy" }
func greet2() -> String { return "howdy" }
func greeet1(unused:Void) -> Void { print("howdy") }
func greeet2() -> () { print("howdy") }
func greeet3() { print("howdy") }
let v : Void = () //passing a void is the same as no parameters
greet1(v)
greet2(v)

func repeatString(s:String, times:Int) -> String {
    var result = ""
    for _ in 1...times { result += s }
    return result
}
let s = repeatString("hi", times:3)
s
func repeatString2(s:String, times n:Int) -> String {
    var result = ""
    for _ in 1...n { result += s}
    return result
}
let s2 = repeatString2("hi", times:3)
s2
func say2(s:String, _ times:Int) {
    for _ in 1...times {
        print(s)
    }
}
say2("woof", 3)

do {
    let s = "hello"
    let s2 = s.stringByReplacingOccurrencesOfString("ell", withString:"ipp")
    // s2 is now "hippo"
    print(s2)
}
/*:
 ## 外部和本地参数名称
 Here we are using external and local params names.
 - 外部参数名,是为了调用该函数时让其参数更为有表现力,更为通顺，同时还保持了函数体是可读的和有明确意图的,让别人阅读整段代码时更方便
 - 注意外部名称将自动提供给每一个预定义的参数.
 - 下面join最后一个参数是预先定义的,这意味着我们可以在调用该函数时省略它.
 */
func join(string s1: String, toString s2: String, withJoiner joiner: String = "only")
    -> String {
        return s1 + joiner + s2
}
join(string: "Hello", toString: "World", withJoiner: "New")
join(string: "", toString: "")

var red:CGFloat = 0.0,green:CGFloat=0.0,blue:CGFloat=0.0,alpha:CGFloat=0.0
UIColor.redColor().getRed(&red, green: &green, blue: &blue, alpha: &alpha)
red
green
blue
alpha

//variadic param 可变的参数,可以获取指定类型的多个值.
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total/Double(numbers.count)
}
arithmeticMean(4,5,6,7)

//赋值:前缀定义传递的参数的值可以被修改,这将反映在函数定义的原始变量上。
func swapTwoInts(inout a: Int, inout b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, b: &anotherInt)

//FIXME:常量形参和变量形参,默认参数是常量,Swift 3.0 不可用
func factorial( max: Int) -> Int {
    var result: Int = 1
    var number = max
    while number > 1 {
        result = result * number
        number -= 1
    }
    return result
}
("factorial Result:\(factorial(6))") //注意不要Int超界


// 函数作参数
func addInts(a:Int,b:Int)->Int{
    return a+b
}
var mathFunction:(Int,Int)->Int = addInts
debugPrint("addInts Result:\(mathFunction(2,3))")

func multiplyInts(a:Int,b:Int)->Int{
    return a*b
}

func printMathResult(mathFunction:(Int,Int)->Int,a:Int,b:Int){
    ("MathResult:\(mathFunction(a,b))")
}
printMathResult(multiplyInts,a: 2,b: 3)

//定义类型函数的变量
var stringFunction: (String) -> String = sayHello


//: ## nested functions
//: 可以使用函数类型作为返回函数。
//: 在这里，我们也定义嵌套函数,只能通过父函数访问这些函数,但可作为返回值传递.
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward : stepForward
}
var stepFunction = chooseStepFunction(true)
debugPrint("chooseStepFunction result: \(stepFunction(5))")

//函数作返回值
func squre(num: Int) -> Int {
    return num*num
}
func cube(num: Int) -> Int {
    return num*num*num
}
func getMathFunc(type: String) -> (Int) -> Int {
    switch(type){
    case "squre":
        return squre
    default:
        return cube
    }
}
var mathFunc = getMathFunc("other")
debugPrint("getMathFunc result:\(mathFunc(5))")


/*:
 函数重载
 - 外部参数可reload
 - 局部参数不能reload
 */
func test(){
    print("return void")
}
func test(msg:String){
    print("reload return void")
}
func test(msg:String)->String{
    print("reload return void")
    return "test"
}
func test(msg msg:String){
    print("reload test(),外部参数为\(msg)")
}
test()
var result: Void = test(msg:"swift")
var result1: String = test("swfit")
//func test(msg1:String){} //Error


/*:
 func嵌套
 */
func getMathFunc(type type:String)->(Int)->Int{
    func squre(num: Int) -> Int {
        return num*num
    }
    func cube(num: Int) -> Int {
        return num*num*num
    }
    switch(type){
    case "squre":
        return squre
    default:
        return cube
    }
}
var mathFunc1=getMathFunc(type: "squre")
(mathFunc1(4))
var mathFunc2=getMathFunc(type: "other")
(mathFunc2(4))


//: [Next](@next)


