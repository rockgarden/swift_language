//: [Previous](@previous)
import Foundation
import MediaPlayer
//: # THE BASICS
/*: 
 ## 变量var和常量let
 不能包含数学符号,箭头,连线与制表符,不能以数字开头
 */
let 你好 = "nihao"
var 😊 = "笑"
("\u{02197}") //颜字符
var 眼睛 = "👀"
var str = "Hello, playground"
let hello = "Hola, qué tal"
//var b11=a11=20  不支持连续赋值
//一行中声明多个变量或者常量，用逗号隔开
var a = 3, b = 4, c = 5, d = "反斜杠"
("占位符: \(d)")
//: ## 类型转换
let a1: UInt8 = 10
let b1: UInt16 = 100
("\(UInt16(a1) + b1)")

let sa = 3
let pi = 3.1415
let add = Double(sa) + pi
(add)
/*:
 ## Reserved words
 can be used as variables or constants using ``
 */
let `private` = "private word"
var word = `private`
/*: 
 ## 基本数据类型
 Int整型 Double/Float浮点型 
 Bool布尔值 
 String文本型数据
 Array数组 Dictionary字典
 Padding numbers with "_" makes them more readable
 */
var paddedInteger = 1_000_000

/*:
 显式类型如整型,在使用时要显式转换
 Explicit conversion must be made when working with explicit types.
 For any other case, use the Int class
 */
let thousand: UInt16 = 1_000
let one: UInt8 = 1
let thousandAndOne = thousand + UInt16(one)

//: 类型标注
let anotherNumber: Int = Int(UINT32_MAX)
var Who: String

//: 声明变量同时赋了初始值,则不必须进行类型标注
var cc = "rockgarden"

//: 类型推断默认是int Inferred as Int by default
let number = 6745
let result = anotherNumber + number

//: ## Tuple 元组
//: Tuples can be of any kind and of any number of elements
let success = (200, "Success")
typealias Success = (Int, String) //用typealias定义
let exito: Success = success
//: If you receive a response in this format, it can be conveniently stored like this.
let (code, message) = success
//: 分解时候要忽略的部分用 _ 表示 If you just need one value.
let (response, _) = success
("The code is \(response)")
("\(success.0)")
do {
    let pair = (1, "One")
    let (_, s) = pair // now s is "One"
    _ = s
}
//: Values can be accessed like indexes:
success.0
success.1
/*: 
 定义元组的时候,给单个元素命名
 names can be added upon declaration
 Invalid redeclaration of name 不能多次命名
 */
let someTuple = (number: 456, assertion: "Yes")
someTuple.number
someTuple.assertion

var scorKey:(math:Int, english:Int, assessment:String)
scorKey = (english:80, math:89, assessment:"A")

var peopleRec:(Int,String,(Int,Int))
peopleRec = (10,"元组元组",(28,32))
(peopleRec.2.0)
//: 通过解构元组交换变量
var aa=1, bb=2
(aa,bb) = (bb,aa)
aa
bb
do {
    var s1 = "Hello"
    var s2 = "world"
    (s1, s2) = (s2, s1) // now s1 is "world" and s2 is "Hello"
}
//: ### Use Example
do {
    let pair : (Int, String) = (1, "One")
    _ = pair
}
do {
    let pair = (1, "One")
}
do {
    var ix: Int
    var s: String
    (ix, s) = (1, "One")
    _ = ix
    _ = s
}
do {
    let (ix, s) = (1, "One") // can use let or var here
    _ = ix
    _ = s
}


do {
    let s = "hello"
    for (ix,c) in s.characters.enumerate() {
        print("character \(ix) is \(c)")
    }
}
do {
    var pair = (1, "One")
    let ix = pair.0 // now ix is 1
    pair.0 = 2 // now pair is (2, "One")
    (pair)
    _ = ix
}
do {
    let pair : (first:Int, second:String) = (1, "One")
    _ = pair
}
do {
    let pair = (first:1, second:"One")
    _ = pair
}
do {
    var pair = (first:1, second:"One")
    let x = pair.first // 1
    pair.first = 2
    let y = pair.0 // 2
    _ = x
    _ = y
}
do {
    let pair = (1, "One")
    let pairWithNames : (first:Int, second:String) = pair
    let ix = pairWithNames.first // 1
    _ = pair
    _ = pairWithNames
    _ = ix
}
do {
    var pairWithoutNames = (1, "One")
    pairWithoutNames = (first:2, second:"Two")
    (pairWithoutNames)
    // let ix = pairWithoutNames.first // compile error, we stripped the names
}
do {
    func tupleMaker() -> (first:Int, second:String) {
        return (1, "One")
    }
    let ix = tupleMaker().first // 1
    (ix)
}


//: parameter list in function call is actually a tuple
// however, new in Swift 2.2, these two calls now get a warning:
// "Passing 2 arguments to a callee as a single tuple value is deprecated"
// so is this "feature" going away? If so, you could _store_ as a tuple ...
// ...but _pass_ as individual arguments
func f (i1:Int, _ i2:Int) -> () {}
func f2 (i1 i1:Int, i2:Int) -> () {}
do {
    let tuple = (1,2)
    f(tuple)
}
do {
    let tuple = (i1:1, i2:2)
    f2(tuple)
}
do {
    //            var tuple = (i1:1, i2:2)
    //            f2(tuple) // compile error
}
do { // examples from the dev forums
    var array: [(Int, Int)] = []
    // Error - literals
    // array.append(1, 1)
    // Error - let integer
    // let int_const = 1
    // array.append(int_const, 1)
    
    // OK - let tuple
    let const_tuple: (Int, Int) = (1, 1)
    array.append(const_tuple)
    
    // NOK - var integer
    // var int_var = 1
    // array.append(int_var, 1)
    
    // OK - var tuple
    var var_tuple: (Int, Int) = (1, 1)
    array.append(var_tuple)
}
do {
    var array: [(Int, Int)] = []
    // OK - literals
    array.append((1,1))
    // OK - let integer
    let int_const = 1
    array.append((int_const, 1))
    // OK - let tuple
    let const_tuple: (Int, Int) = (1, 1)
    array.append(const_tuple)
    // OK - var integer
    var int_var = 1
    array.append((int_var, 1))
    // OK - var tuple
    var var_tuple: (Int, Int) = (1, 1)
    array.append(var_tuple)
    // shut the compiler up
    int_var = 0
    var_tuple = (0,0)
}
/*:
 ## Optionals
 Optionals whether have a value or not.
 can be nil or the number they store, if any.
 */
var optionalInteger: Int?
optionalInteger = 42

let optional: Int? = 2
if optional != nil {
    "It's not nil!"
    optional!
} else {
    "It's nil"
}

//: You can use optional binding as well
if let value = optional {
    "It's not nil!"
    value
}else {
    "It's nil"
}

/*:
 You can also use implicitly unwrapped optionals
 Value becomes accessible automatically once a value has been set
 */
let knownString: Int! = 10
if knownString != nil {
    "It's got a value"
    knownString // No need for explicit unwrapping
}

//: ## 断言
let age2 = 10
assert(age2 >= 0, "年龄要大于0") //<0时可触发
assert(true == true, "True isn't equal to false")
//: ## computed Variables
var now : String {
get {
    return NSDate().description
}
set {
    print(newValue)
}
}
now = "Howdy"
(now)

var now2 : String { // showing you can omit "get" if there is no "set"
    return NSDate().description
}

var mp : MPMusicPlayerController {
    return MPMusicPlayerController.systemMusicPlayer()
}

// typical "facade" structure
private var _p : String = ""
var p : String {
get {
    return _p //在类里加self._p
}
set {
    _p = newValue
}
}
p="test"

// observer
var s = "whatever" {
willSet {
    print(newValue)
}
didSet {
    print(oldValue)
    // self.s = "something else"
}
}
s = "Hello"
s = "Bonjour"

private var myBigDataReal : NSData! = nil
var myBigData : NSData! {
set (newdata) {
    myBigDataReal = newdata
}
get {
    if myBigDataReal == nil {
        let fm = NSFileManager()
        let f = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("myBigData")
        if fm.fileExistsAtPath(f) {
            print("loading big data from disk")
            myBigDataReal = NSData(contentsOfFile: f)
            do {
                try fm.removeItemAtPath(f)
                print("deleted big data from disk")
            } catch {
                print("Couldn't remove temp file")
            }
        }
    }
    return myBigDataReal
}
}

//: 注释 多行注释可以嵌套
/*
 /*
 第一层注释
 第二层注释
 */
 */

//: [Next](@next)
