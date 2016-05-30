//: Playground - noun: a place where people can play

import Cocoa

//数组中的每个元素乘以2
(1...1024).map{$0 * 2}

//数组中的元素求和
(1...1024).reduce(0,combine: +)

//验证在字符串中是否存在指定单词
let words = ["Swift","iOS","cocoa","OSX","tvOS"]
let tweet = "This is an example tweet larking about Swift"
let valid = !words.filter({tweet.containsString($0)}).isEmpty
valid
words.contains(tweet.containsString)
tweet.characters
    .split(" ")
    .lazy
    .map(String.init)
    .contains(Set(words).contains)

//读取文件
let path = NSBundle.mainBundle().pathForResource("import-summary", ofType: "txt")
let lines = try? String(contentsOfFile: path!).characters.split{$0 == "\n"}.map(String.init)
if let lines=lines {
    lines[0]
    lines[1]
    lines[2]
    lines[3]
    lines[4]
    lines[5]
    lines[6]
}

//map以及范围和三元运算符的简单使用
let name = "uraimo"
(1...4).forEach{print("Happy Birthday " + (($0 == 3) ? "dear \(name)":"to You"))}

//过滤数组中的数字
extension SequenceType{
    typealias Element = Self.Generator.Element
    func partitionBy(fu: (Element)->Bool)->([Element],[Element]){
        var first=[Element]()
        var second=[Element]()
        for el in self {
            if fu(el) {
                first.append(el)
            }else{
                second.append(el)
            }
        }
        return (first,second)
    }
}
let part = [82, 58, 76, 49, 88, 90].partitionBy{$0 < 60}
part // ([58, 49], [82, 76, 88, 90])
extension SequenceType{
    func anotherPartitionBy(fu: (Self.Generator.Element)->Bool)->([Self.Generator.Element],[Self.Generator.Element]){
        return (self.filter(fu),self.filter({!fu($0)}))
    }
}
let part2 = [82, 58, 76, 49, 88, 90].anotherPartitionBy{$0 < 60}
part2 // ([58, 49], [82, 76, 88, 90])
//构建了包含两个分区的结果元组,一次一个元素,使用过滤函数测试初始序列中的每个元素,并根据过滤结果追加该元素到第一或第二分区数组中,即分区数组通过追加被构建
var part3 = [82, 58, 76, 49, 88, 90].reduce( ([],[]), combine: {
    (a:([Int],[Int]),n:Int) -> ([Int],[Int]) in
    (n<60) ? (a.0+[n],a.1) : (a.0,a.1+[n])
})
part3 // ([58, 49], [82, 76, 88, 90])

//在数组中查找最值
//Find the minimum of an array of Ints
[10,-22,753,55,137,-1,-279,1034,77].sort().first
[10,-22,753,55,137,-1,-279,1034,77].reduce(Int.max, combine: min)
[10,-22,753,55,137,-1,-279,1034,77].minElement()
//Find the maximum of an array of Ints
[10,-22,753,55,137,-1,-279,1034,77].sort().last
[10,-22,753,55,137,-1,-279,1034,77].reduce(Int.min, combine: max)
[10,-22,753,55,137,-1,-279,1034,77].maxElement()

//埃拉托斯特尼筛法-例:查找所有的素数直到给定的上限n
var n = 50
var primes = Set(2...n)
//使用外部范围来迭代我们要检查的整数,并且对于每一个整数我们使用stride(through:Int by:Int)计算出数字的倍数的序列,那些序列然后从Set中减去,Set用所有从2到n的整数初始化
(2...Int(sqrt(Double(n)))).forEach{primes.subtractInPlace((2*$0).stride(through:n, by:$0))}
primes.sort()

var sameprimes = Set(2...n)
sameprimes.subtractInPlace((2...Int(sqrt(Double(n))))
    .flatMap{(2*$0).stride(through:n, by:$0)})
sameprimes.sort()

//通过解构元组交换
var a=1,b=2
(a,b) = (b,a)
a //2
b //1

//swift 数组\struct\enum是值类型 速度快 但数据变化频繁 用NS 引用类型数据
var array = [1,2,3]
var array2 = array
array2.append(4)
array

//NSArray(Foundation)是引用类型
var nsArray: NSMutableArray = [1,2,3]
var nsArray2 = nsArray
nsArray2.addObject(4)
nsArray


