import Foundation

// 可选类型:处理值可能缺失的情况
let Str = "1234"
let convertNumber = Int(Str)
print(convertNumber as Any) //convertNumber 是 optional Int 或者 Int?
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

var strRepeat = String(repeating: "w", count: 40)
var strRepeatU = String(repeating: "\u{3423}", count: 40)
strRepeat += strRepeatU
var sum = strRepeat.characters.count
print(strRepeat, "strPepeat has \(sum) characters")

let quotation="same"
let sameQu="same"
if quotation==sameQu{
    print("ture")
}
