//
//  main.swift
//  Simple
//
//  Created by CarolWang on 14/12/10.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

import Foundation


var a11:Int
var a = 3, b = 4, c = 5, d = "反斜杠"


//MARK:- 运算符
var c1=19/4 //4
let con = 100;
var avi = 30;
avi = 40


var ww = 4.0/0.0
var fff = 0.0/0.0 //非数

var g = -5.2
var h = -3.1
var mod = g%h //求余结果正负取决于被除数

var a111 = 5
var b111 = a111++ + 6 //先计算再自增
var c111 = ++a111 + 6 //自增再计算

// 溢出运算符 &+,&-,&*,&/,&%
var cmin=UInt8.min
//var f=cmin-1
cmin = cmin &- 1 //下溢
let a1111 = 20
//let b1111 = a1111 &/ 0

// 浮点数求余
var rem=10%2.3
print(rem)





// 特征运算符
/*相等===与特征不等!==*/
//var c = a === b //ab指向的类型实例相同时c为ture

// 三目运算符
var ab = a>b ? "a>b":"a<b"


//MARK:- 字符操作
// 字符串插值
var apples = 10
var oranges = 4
print("I have \(apples + oranges) fruits")

// 字符串连接
var i = 200
var strI = "Hello Swift" as NSString // 转成Foundation
strI = "\(strI),\(i)"
print(strI)

strI.substringWithRange(NSRange(location: 0, length: 5))

//注释 多行注释可以嵌套
/*

 /*
 第一层注释
 第二层注释
 */

 */


// 类型转换
let a1: UInt8 = 10
let b1: UInt16 = 100
print("\(UInt16(a1) + b1)")

let sa = 3
let pi = 3.1415
let add = Double(sa) + pi
print(add)

// 可选类型:处理值可能缺失的情况
let Str = "1234"
let convertNumber = Int(Str)
print(convertNumber) //convertNumber 是 optional Int 或者 Int?
if convertNumber != nil{
    print(convertNumber!)//可选值的强制解析 可去除optional
}
// 可选绑定:可以用在if和while语句中来对可选类型的值进行判断并把值赋给一个常量或者变量。
if let  actualNumber = Int(Str){
    print(actualNumber)
}
// nil表示一个确定的值,表示值缺失
var serverCode: Int? = 404
serverCode = nil //现在serverCode不包含值
var suuny: String?

// 隐式解析可选类型:第一次被赋值之后,可以确定一个可选类型总会有值,不要在变量没有值的时候使用
var possibleStr: String! = "value"
print(possibleStr)


// 字符串
var str1="aa"
var str2="bb"
var str3=String()//初始化字符串
str1 += "cc"
print("\n\(str1)")

let char:Character="!"
var s:Character="\u{22}"
str1.append(char)
str1.append(s)
print(str1)
print("str1 has \(str1.characters.count) chars")

var strRepeat = String(count:40, repeatedValue: Character("w"))
var strRepeatU = String(count:40, repeatedValue: UnicodeScalar("\u{3423}"))
strRepeat += strRepeatU
var sum = strRepeat.characters.count
print(strRepeat, "strPepeat has \(sum) characters")

let quotation="same"
let sameQu="same"
if quotation==sameQu{
    print("ture")
}


//MARK:- func
func sayHello(personName:String)->String{
    return "hello,"+personName+"!"
}
print(sayHello("Jack"))

func lNumber(start:Int,end:Int)->Int{
    return end - start
}
print(lNumber(1,end: 10))

// 外部参数
func join(s1 s1:String,toString s2:String,withJoiner joiner:String)->String{
    return s1+joiner+s2
}
print(join(s1: "hello", toString: "world", withJoiner: ","))

// 可变参数
func sum (numbers: Int...) -> Int{
    var total: Int = 0
    for num in numbers {
        total += num
    }
    print("\(total)")
    return total
}
sum(1,2,3,4,5,6,7)

// 默认参数
func sayHi(msg:String, name:String = "wangkan") {
    print("\(name),\(msg)")
}
sayHi("王任洲")
sayHi("王任洲",name: "王侃")

//FIXME:常量形参和变量形参,默认参数是常量,Swift 3.0 不可用
func factorial(var number: Int) -> Int {
    var result: Int = 1
    while number > 1 {
        result = result * number
        number -= 1
    }
    return result
}
print(factorial(6)) //注意不要超界

// 赋值
func swap(inout a:Int , inout b: Int) {
    let tmp = a
    a = b
    b = tmp
}
swap(&a, &b)
print("after swap: a=\(a),b=\(b)")

// 函数作参数
func addInts(a:Int,b:Int)->Int{
    return a+b
}
func multiplyInts(a:Int,b:Int)->Int{
    return a*b
}
var mathFunction:(Int,Int)->Int = addInts
print("***\(mathFunction(2,3))")
func printMathResult(mathFunction:(Int,Int)->Int,a:Int,b:Int){
    print(mathFunction(a,b))
}
printMathResult(multiplyInts,a: 3,b: 5)

// 函数作返回值
func squre(num: Int) -> Int {
    return num*num
}
func cube(num: Int) -> Int {
    return num*num*num
}
func getMateFunc(type type: String) -> (Int) -> Int {
    switch(type){
    case "squre":
        return squre
    default:
        return cube
    }
}
var mathFunc = getMateFunc(type: "other")
print(mathFunc(5))

// MARK: - 函数重载
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
var result:Void=test(msg:"wangkan")
var result1:String=test("wangkan")
// 局部参数名不能算reload
//func test(msg1:String){
//    print("reload return void")
//}


// MARK: - func嵌套
func getMathFunc(type type:String)->(Int)->Int{
    func squre(num: Int) -> Int { //外部squre无效
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
var mathFunc1=getMateFunc(type: "squre")
print(mathFunc1(4))
var mathFunc2=getMateFunc(type: "other")
print(mathFunc2(4))


// MARK: - 闭包
func getMathFuncC(type type:String)->(Int)->Int{
    func squre(num: Int) -> Int { //外部squre无效
        return num*num
    }
    func cube(num: Int) -> Int {
        return num*num*num
    }
    switch(type){
    case "squre":
        return {(num: Int) -> Int in
            return num*num
        }
    default:
        return {(num: Int) -> Int in
            return num*num*num
        }
    }
}
var mathFunc3=getMathFuncC(type: "squre")
print(mathFunc3(5))
var mathFunc4=getMathFuncC(type: "other")
print(mathFunc4(5))

//利用上下文推断类型
var squreContent1: (Int) -> Int = {(num) in return num * num}
var squreContent2: (Int) -> Int = {num in return num * num}
var squreContent3: (Int) -> Int = {$0 * $0}
print(squreContent1(10))
print(squreContent2(100))
print(squreContent3(1000))

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


// MARK: - enum
enum season {
    case spring
    case summer
    case fall
    case winter
}
enum season1 {
    case spring,summer,fall,winter
}
var weather: season
weather = .summer
print(weather)

var chooseDay = season.fall
switch(chooseDay){
case .spring:
    print(season.spring)
case .summer:
    print(season.summer)
case .fall:
    print(season.fall)
case .winter:
    print(season.winter)
    //default:
    //    print("seaseon")
}

// 赋值
enum season2:Character{
    case spring="春"
    case summer="夏"
    case fall="秋"
    case winter="冬"
}
// 赋值推断
enum weekday: Int{
    case mon,tur,wen=3,thur,fri,sat,sum //杖举值的类型为整型时才可
}
print(weekday.sum.rawValue) //获取原始值

// 取值
var mySeason = season2(rawValue: "秋")
if mySeason != nil{
    switch(mySeason!){
    case .spring:
        print("info")
    case .summer:
        print("info")
    case .fall,.winter:
        print("infoinfo")
    }
}

//关联值
enum planet {
    case earth(weight: Double, name: String)
    case mars(density: Double, name: String, weight: Double)
    case venus(Double, String)
    case saturn
    case neptune
}
var p1 = planet.earth(weight: 1.0, name: "地球")
var p3 = planet.mars(density: 3.95, name: "火星", weight: 0.1)

switch(p3){
case planet.earth(var weight, var name):
    print("earth \(weight)")
case let planet.mars(density:d, name:n, weight:w):
    print("\(n)\(w)\(d)")
default:
    break
}


// MARK: - Class
// required deinit
class Person{
    var name = "tina"
    var age = 19
    var height = 172.2
    func produce(){
        age += 1
    }
    func say(content: String){
        print(content)
    }

}

var p: Person
p = Person()
print(p.name)
p.say("hello")
var p2=p
p2.name = "rock"
print(p.name)

class user{
    var name:String
    var age:Int
    init(name:String,age:Int){
        self.name = name
        self.age = age
    }
    func info(){
        print("\(name) \(age)")
    }
}
var u1 = user(name: "jerry", age: 6)
var u2 = user(name: "tom", age: 36)
print(u1===u2) //引用比较
print(u1 !== u2)
var u3 = u1
print(u3 === u1)
var u4 = user(name:"lily", age:10)
u4.info()


class pm {
    var name:String!
    init?(name:String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}
class subPM:pm {
    var grade: Int!
    init!(name:String, grade: Int) {
        super.init(name: name)
        print("---super.init(name:\(name))---")
        if grade < 1 {
            return nil
        }
        self.grade = grade
    }
}
let subPM1 = subPM(name: "tom", grade: 4)
print(subPM1)
let subPM2 = subPM(name: "jerry", grade: 0)
print(subPM2 == nil)
let subPM3 = subPM(name: "", grade: 3)
print(subPM3 == nil)


class myDog{
    func jump(){
        print("it's jump")
    }
    func run(){
        self.jump()
        print("it's run")
    }
}


class Bird {
    var name:String!
    init(){}
    init?(name:String){
        if name.isEmpty{
            return nil
        }
        self.name = name
    }
    func fly() {

    }
}
class Sparrow:Bird {
    var weight:Double!
    init?(name: String, weight: Double) { //init?可调用super.init?
        super.init(name: name)
        if weight <= 0 {
            return nil
        }
        self.weight = weight
        self.name = name
    }
    override init(name:String) { //普通init不能调用super.init?
        super.init()
        if name.isEmpty {
            super.name = "麻雀"
        }
        self.name = name
    }
    override func fly() {
        print("fly bird")
    }
}
let sp1 = Sparrow(name: "")
let sp2 = Sparrow(name: "", weight: 2.2)
let sp3 = Sparrow(name: "小黄嘴", weight: 0)
print(sp1.name, sp2 == nil, sp3 == nil)


class Fruit {
    var name = ""
    var weight: Double
    init(name: String) {
        self.name = name
        self.weight = 0.0
    }
    convenience init(name:String, weight:Double){
        self.init(name:name)
        self.weight = weight
    }
    convenience init(n name: String, w weight: Double){
        self.init(name:name)
    }
    convenience init() {
        self.init(name:"水果")
        self.weight = 1.0
    }
    deinit{
        print("deinit Fruit")
    }
}
class Apple: Fruit {
    var color = ""
    // 指定构造器
    init(name: String, weight: Double, color: String) {
        self.color = color
        super.init(name: name)
        self.weight = weight
    }
    init(name: String, weight: Double) {
        self.color = ""
        super.init(name: name)
        self.weight = weight
    }
    init(color: String) {
        self.color = color
        self.color = "red"
        super.init(name: "rose")
        super.name = "apple"
        self.weight = 0.0
    }
    init() { //重写父类的便利构造器
        self.color = ""
        super.init(name: "")
        self.weight = 0.0
    }

    // 便利构造器必须调用其它构造器
    convenience init(name:String, color:String){
        self.init(name: name, weight: 0.0, color: color)
        self.weight = weight
    }
    convenience init(n name: String, c color: String) {
        self.init(name: name, color:color)
    }
    convenience init(n name:String, w weight:Double){
        self.init(name: name, weight: weight, color: "")
    }
    deinit{
        print("deinit Apple")
    }
}
var app1:Apple? = Apple(n: "red apple", w: 0.5) //Apple?必须加不然无法赋nil
app1 = nil
var app2 = Apple(name: "yellow", weight: 0.6)

class sonApple:Apple {
    var vitamin:Double = 0.21
}

var anyArray:[Any] = [ // AnyObject只能存放对象
    "swift",
    29,
    ["ios":89,"android":92],
    Fruit(name: "is fruit", weight: 2.2),
    Apple(name: "is apple", weight: 0.2)
]
for element in anyArray{
    if let f = element as? Fruit{
        print(f.name,f.weight)
    }
}


// 重写下标与属性final防止重写
class Base {
    subscript(idx:Int)->Int{
        get{
            print("父类下标的get方法")
            return idx + 10
        }
    }
    var speed:Double = 0
    var speed1:Double = 0
    final var name:String = ""
    final func say(content:String) {
        print(content)
    }
}
class Sub: Base {
    override subscript(idx:Int)->Int{
        get{
            return idx * idx
        }
        set{
            print(newValue)
        }
    }
    override var speed:Double{
        get{
            return super.speed
        }
        set{
            super.speed = newValue * newValue
        }
    }
    override var speed1:Double{
        didSet{
            print(oldValue)
            super.speed1 *= speed1
        }
    }
}
var base1 = Base()
print(base1[7])
var sub = Sub()
print(sub[7])
sub[7] = 90
sub.speed = 20
print(sub.speed)

// 向上转型子类附给父类＝用父类编译子类
var base2: Base = Sub()

// is运算符
let hello:NSObject = "hello"
print(hello is NSString)
print(hello is NSDate)

// as类型转换
let obj:NSObject = "hello"
let objStr:NSString = obj as! NSString //NSObject是编译时类型,NSString是运行时类型
let objPri:NSObject = 5 // 运行时类型为NSNumber
//let strPri:NSString = objPri as! NSString


// MARK: - struct
struct Dog {
    var name:String
    var age:Int
    func run(){
        print(name)
    }
}

var dog = Dog(name: "rock", age: 2)
print(dog.name)
dog.run()
var dog2 = dog
dog2.name = "snoopy"
print(dog2.name)
print(dog.name)


//struct in extension
extension String {
    static var data:[String:Any] = [:]
    var lengthAll: Int {
        get{
            return self.characters.count
        }
        set{
            let originLength = self.characters.count
            if newValue > originLength {
                for _ in 1...newValue - originLength {
                    self += " "
                }
                print(self)
            }else if newValue < originLength{
                var tmp = ""
                var count = 0
                for ch in self.characters {
                    tmp = "\(tmp)\(ch)"
                    count += 1
                    if count == newValue{
                        break
                    }
                }
                self = tmp
            }
        }
    }
}

String.data["swift"] = 89
String.data["oc"] = 92
var sE = "swift.oc"
sE.lengthAll = 5
print(sE)


extension Array {
    // 定义用于计算数组的交集
    mutating func retainAll(array:[Element], compartor:(Element,Element)->Bool){
        var tmp=[Element]()
        for ele in self {
            for target in array {
                if compartor(ele,target){
                    tmp.append(ele)
                    break
                }
            }
        }
        self = tmp
    }
}
var books = ["iOS","Android","Swift","Java","Ruby"]
books.retainAll(["Android","iOS","C"]) {
    return $0 == $1
}
print(books)


//MARK:- 扩展构造器
// 系统默认init
struct SomeStruct {
    var name:String
    var count:Int
}
// 扩展添加init
extension SomeStruct{
    init(name:String){
        self.name = name
        self.count = 0
    }
    init(count:Int){
        self.count = count
        self.name = ""
    }
}
var sc1 = SomeStruct(name: "jj", count: 5)
var sc2 = SomeStruct(name: "crazyjj")
var sc3 = SomeStruct(count: 20)
print(sc1,sc2,sc3)


//MARK:- 扩展添加下标
extension String {
    subscript(idx:Int) -> String {
        get {
            if idx > -1 && idx < self.characters.count{
                var count = 0
                var result = ""
                for ch in self.characters{
                    if count == idx {
                        result = "\(ch)"
                    }
                    count += 1
                }
                return result
            }else {
                return ""
            }
        }
        set {
            var result = ""
            var count = 0
            for ch in self.characters{
                if count == idx {
                    result += newValue
                } else {
                    result += "\(ch)"
                }
                count += 1
            }
            self = result
        }
    }
    subscript(start:Int, end:Int) -> String {
        if start > -1 && start < self.characters.count && end > -1 && end <= self.characters.count && start < end {
            var result = ""
            var count = 0
            for ch in self.characters{
                if count >= start && count < end {
                    result.append(ch)
                }
                count += 1
            }
            return result
        }else{
            return ""
        }
    }
}
var strSubscript = "long long code is trouble"
print(strSubscript[5])
strSubscript[0] = "w"
strSubscript[6] = "k"
print(strSubscript[0,10])


// MARK:- 扩展添加嵌套类型
extension String {
    enum suit: String{
        case diamond = "♦︎"
        case club = "♣︎"
        case heart = "♥︎"
        case spade = "♠︎"
    }
    static func judgeSuits(s:String) -> suit? {
        switch(s){
        case "♦︎":
            return .diamond
        case "♣︎":
            return .club
        case "♥︎":
            return .heart
        case "♠︎":
            return .spade
        default:
            return nil
        }
    }
}
var strEnum: String.suit? = String.judgeSuits("♣︎")
print(strEnum)
var strEnum1: String.suit? = String.judgeSuits("j")
print(strEnum1)


//MARK:- protocol
protocol Strokable {
    var strokeWidth: Double {get set}
}

protocol Fullable {
    var fullColor: Color? {get set}
}
enum Color { //fullColor协议属性的类型定义
    case red,green,blue,yellow,cyan
}

protocol HasArea: Fullable, Strokable {//协议多继承
    var area: Double {get}
}
protocol Mathable {
    static var pi: Double {get}
    static var e: Double {get}
}

struct Rect: HasArea, Mathable {
    var width: Double
    var height: Double
    init(width:Double, height:Double){
        self.width = width
        self.height = height
    }
    var fullColor: Color?
    var strokeWidth: Double = 0.0
    var area: Double {
        get{
            return width * height
        }
    }
    static var pi:Double = 3.14159535
    static var e:Double = 2.71828
}
