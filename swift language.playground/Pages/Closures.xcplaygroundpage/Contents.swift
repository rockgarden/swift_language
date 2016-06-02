//: [Previous](@previous)

/*:
 ===============
 INLINE CLOSURES
 ===============
 */

let array = ["John", "Tim", "Steve", "Wangkan"]

var reversed = array.sort({(s1: String, s2: String) -> Bool in return s1 > s2})
debugPrint(reversed)

/*:
 类型推断
 - 使用类型推断,可以省略参数类型和返回类型;
 - Using type inference, can omit the params and return types.
 - This is true when passing closures as params to a function.
 */
reversed = array.sort({s1, s2 in return s1 < s2})
debugPrint(reversed)

//单个表达式闭包,返回值是隐式的,因此可以省略返回表达式.
//In case of single-expression closures, the return value is implicit,
//thus the return expression can be omitted.
reversed = array.sort({s1, s2 in s1 == s2})
debugPrint(reversed)

//In the previous examples, the names of the closure's params were explicit.
//You can use the $X variables to refer to params for the closure.
//This eliminates the need for the first params list, which makes the body the only relevant part.
//若对闭包的参数的显示声明,则可消除对应的参数列表
reversed = array.sort({$0 == $1})
debugPrint(reversed)

//We can even take this to an extreme.
//String defines its own implementation for the ">" operator,
//which is really all the closure does.
reversed = array.sort(>)

//利用上下文推断类型
var squreContent1: (Int) -> Int = {(num) in return num * num}
var squreContent2: (Int) -> Int = {num in return num * num}
var squreContent3: (Int) -> Int = {$0 * $0}
print(squreContent1(100))
print(squreContent2(100))
print(squreContent3(100))

/*##### TRAILING CLOSURES #####*/
func someFunctionThatTakesAClosure(closure: () -> ()) {
    // function body goes here
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

//Sorting function with inline closure:
array.sort() {$0 == $1}
debugPrint(reversed)

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
    for i in 1...$1{
        result *= $0
    }
    return result
}(4,3)
print(resultContent)

// 尾随闭包
func someFunc(num:Int,fn:(Int)->()){

}
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

//: [Next](@next)
