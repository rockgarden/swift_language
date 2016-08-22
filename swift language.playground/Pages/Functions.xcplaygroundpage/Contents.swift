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

//: 使用元组作为返回参数,返回多个参数
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

//: ## var modifiable Parameters
//: This will go away, because it is, after all, rather misleading
/*
 func say(s:String, times:Int, var loudly:Bool) {
 loudly = true // can't do this without "var"
 }
 */
// instead, write this:
func say(s:String, times:Int, loudly:Bool) {
    var loudly = loudly
    loudly = true
    _ = loudly
}
// This will go away, because it is, after all, rather misleading
/*
 func removeFromStringNot(var s:String, character c:Character) -> Int {
 var howMany = 0
 while let ix = s.characters.indexOf(c) {
 s.removeRange(ix...ix)
 howMany += 1
 }
 return howMany
 }
 */
// instead, write this:
func removeFromStringNot(s:String, character c:Character) -> Int {
    var s = s
    var howMany = 0
    while let ix = s.characters.indexOf(c) {
        s.removeRange(ix...ix)
        howMany += 1
    }
    return howMany
}
let sStringNot = "hello"
print(removeFromStringNot(sStringNot, character:Character("l")))
print(sStringNot) // no effect on s
//: 传类 Parameters 就可 modifiable
class Dog {
    var name = ""
}
func changeNameOfDog(d:Dog, to tostring:String) {
    d.name = tostring // no "var", no "inout" needed
}

/*:
 ## inout
 inout传的是对象引用
 声明函数时，在参数前面用inout修饰，在函数内部实现改变外部参数;
 注意，这里只能传入变量，不能传入常量和字面量，因为这些是不能变的一旦定义，当我们传入的时候，在变量名字前面用&符号修饰表示，传递给inout参数，表明这个变量在参数内部是可以被改变的
 注意：inout修饰的参数是不能有默认值的，有范围的参数集合也不能被修饰，另外，一个参数一旦被inout修饰，就不能再被var和let修饰了
 */
func removeFromString(inout s:String, character c:Character) -> Int {
    var howMany = 0
    while let ix = s.characters.indexOf(c) {
        s.removeRange(ix...ix)
        howMany += 1
    }
    return howMany
}
var someString = "swift func inout"
removeFromString(&someString, character: "i")
var sInout = "hello"
(removeFromString(&sInout, character:Character("l")))
sInout // this is the important part!
//: inout跨线程调用
func myTest(inout a: Int, inout arr: [Int]) {
    a += 1
    arr[0] += 1
    arr = [0, 0, 0]
    }
// 然后在任一函数中对myTest进行如下调用：
var x = 10
var y = [1, 2, 3]
myTest(&x, arr: &y)

// 调用完之后，x值为11，y的值为[0, 0, 0]，没有任何问题。
// 然后，如果使用内嵌闭包，也没有问题：
func test(inout t:[String]){
    {
        t = ["1","2","3"]
        print("\(t)")
    }()
}
// 调用
var tempData:[String] = []
test(&tempData)
// 异步tempData 异常
func testAsync(inout t:[String]){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)) { () -> Void in
        t = ["1","2","3"]
        print("\(t)")
        print("\(tempData)")
    }
}
// 所以问题出在dispatch一个线程的时候，当前主线程的闭包执行上下文没有映射到新用户线程的上下文中去
// 把dispatch_async 改成dispatch_sync（异步改为同步），之后再log 所需要的tempData，就会发现输出正常，下面是我的代码：
print("tempData  : \(tempData)")
func testAync(inout t:[String]){
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)) { () -> Void in
        t = ["1","2","3"]
        print("\(t)")
    }
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


//: 函数作参数
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
//: 函数作返回值: 可以使用函数类型作为返回函数。
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
("getMathFunc result:\(mathFunc(5))")
//: 在这里，我们也定义嵌套函数,只能通过父函数访问这些函数,但可作为返回值传递.
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward : stepForward
}
var stepFunction = chooseStepFunction(true)
("chooseStepFunction result: \(stepFunction(5))")

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
/*:
 ## 函数重载
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
//: [Next](@next)


