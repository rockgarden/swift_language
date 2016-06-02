

import Foundation

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
