//: [Previous](@previous)


//For

//Index is implicitly declared
for index in 1...5 {
    print("Index is \(index)")
}

//In this case, we don't care about the value.
let base=3
let power=11
var answer=1
for _ in 1..<power { //下划线符号_代替循环中的变量,能够忽略具体的值,并且不对值进行访问
    answer *= base
}

//Use dictionary
let dictionary = ["one": 1, "two": 2, "three": 3]
for (numberName, numberValue) in dictionary {
    print("\(numberName) is \(numberValue)")
}

//Go through a string
var char = "e"
for char in "Yes".characters {
    print("\(char)")
}

//break标签:仅用于for或swith
outer: for i in 0 ..< 5  {
    for j in 0 ..< 3 {
        if j == i {
            break outer
        }
    }
}


//Switches

// No need for break, and every case must have some code.
let someChar = "e"
switch someChar {
case "a", "e", "i", "o", "u":
    print("\(someChar) is a vowel")
default:
    print("\(someChar) is a consonant")
}

//There can also be range matching
let count = 3_000_000_000_000
let countedThings = "stars"
switch count {
case 0...9:
    print("a few")
case 10...10_000:
    print("many")
default:
    print("a lot of")
}

//Use tuples
let coord = (1,1)
switch coord {
case (0,0):
    print("Origin")
case (_, 0):
    print("x axis")
case (0, _):
    print("y axis")
case (-2...2, -3...3):
    print("within boundries")
default:
    print("out of bounds")
}

//Value binding: Assign temp values to variables inside the cases.
let anotherPoint = (0, 0)
var position = ""
switch anotherPoint {
case(0,0):
    position = "原点"
case (let x, 0):
    position = "on the x-axis with an x value of \(x)" //(\(anotherPoint.0),0 位于x轴上)
case (0, let y):
    position = "on the y-axis with a y value of \(y)"
case (0...Int.max,0...Int.max):
    position = "第一象限"
case let (z, w): //This acts as the default case. Since it is only assigning a tuple, any value matches.
    print("somewhere else at (\(z), \(w))") //相当于 default:break
}

switch anotherPoint {
case let (x, y) where x == y:
    print("x = y")
default:
    break
}

var point1 = (x: 1,y: -1)
var position1 = ""
switch point1 {
case(0,0):
    position1 = "原点"
case(var a,0):
    position1 = "(\(a),0 位于x轴上)"
case var (x,y) where x > 0 && y > 0: //条件值绑定
    position1 = "第一象限"
default:
    break
}

// The fallthrough line forces the switch statement to fall into the default case after a previous case.
switch anotherPoint {
case let (x, y) where x == y:
    print("x = y")
    fallthrough
default:
    print(" are equal")
}

//Nesting while, for and switches can be confusing sometimes
//Use labels to better use the break and continue statements
master: while true {
    loop: for rats in 1...5{
        continue master
    }
}

let num1 = 5
var desc = "\(num1)是"
switch num1 {
case 2,3,5,7:
    desc = "质数,而且还是"
fallthrough //=break
case 4,6,8:
    desc = "合数"
default:
    desc += "整数"
}


//: [Next](@next)
