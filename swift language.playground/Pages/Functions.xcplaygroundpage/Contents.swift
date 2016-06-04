//: [Previous](@previous)

import Foundation

func sayHello(personName: String) -> String{
    return "Hello \(personName)!"
}
sayHello("Juan")

//In this case we return a tuple
func minMax(array: [Int]) -> (min: Int, max:Int)? {
    if array.isEmpty {return nil}
    return (0,1)
}
minMax([])

//Note: returning void translates in returning an empty tuple: ()

//外部和本地参数名称
//Here we are using external and local params names.
//最后一个参数是预先定义的,这意味着我们可以在调用该函数时省略它.
//注意外部名称将自动提供给每一个预定义的参数.
func join(string s1: String, toString s2: String, withJoiner joiner: String = "only")
    -> String {
        return s1 + joiner + s2
}
join(string: "Hello", toString: "World", withJoiner: "New")
join(string: "", toString: "")

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
debugPrint("factorial Result:\(factorial(6))") //注意不要Int超界


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
    debugPrint("MathResult:\(mathFunction(a,b))")
}
printMathResult(multiplyInts,a: 2,b: 3)

//定义类型函数的变量
var stringFunction: (String) -> String = sayHello


//nested functions
//可以使用函数类型作为返回函数。
//在这里，我们也定义嵌套函数,只能通过父函数访问这些函数,但可作为返回值传递.
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


