//: [Previous](@previous)

import UIKit

//: # Functions
/*: 
 ## Defining and Calling Functions
 these DO just illustrates some declaration syntax
 - All of this information is rolled up into the function’s definition, which is prefixed with the func keyword. 
 - You indicate the function’s return type with the return arrow -> (a hyphen followed by a right angle bracket), which is followed by the name of the type to return.
 */
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}
print(greet(person: "Anna"))
print(greet(person: "Brian"))

func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))

do {
    func sum(_ x:Int, _ y:Int) -> Int {
        let result = x + y
        return result
    }
    sum(4,5)
    let x = 4
    let y = 5
    let z = sum(y,x)
    //let _ = sum(4,5) + "howdy" // compile error
    let z2 = sum(4,sum(5,6))
}

do {
    func reverseString(string: String) -> String {
        return String(string.characters.reversed())
    }
    reverseString(string: "test reverseString")
}

//: Closures Functions
do {
    typealias VoidVoid1 = () -> ()
    typealias VoidVoid2 = (Void) -> Void
}

do {
    func echo(_ s:String, times:Int) -> String {
        var result = ""
        for _ in 1...times { result += s }
        return result
    }

    func echo2(string s:String, times n:Int) -> String {
        var result = ""
        for _ in 1...n { result += s}
        return result
    }

    let s = echo("hi ", times:3)
    print(s)

    let s2 = echo2(string: "hi ", times:3)
    print(s2)
}

//: 类方法调用
do {
    let s = "hello" //String
    let s2 = s.replacingOccurrences(of: "ell", with:"ipp")
    // s2 is now "hippo"
    print(s2)
}

//: @discardableResult this is how to prevent the unused result warning
do {
    @discardableResult
    func greet(_ unused: Void) -> String { return "howdy" }
    greet()
}


//: ## Function Parameters and Return Values

//: ### Functions Without Parameters
do {
    func sayHelloWorld() -> String {
        return "hello, world"
    }
    print(sayHelloWorld())
}

//: ### Functions With Multiple Parameters
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))

//: ### Functions Without Return Values
/*:
 - NOTE:
 Strictly speaking, this version of the greet(person:) function does still return a value, even though no return value is defined. Functions without a defined return type return a special value of type Void. This is simply an empty tuple, which is written as ().
 */
do {
    /// 相当于 -> ()
    func greet(person: String) {
        print("Hello, \(person)!")
    }
    print(greet(person: "Dave"))
}
/*:
 - NOTE:
 Return values can be ignored, but a function that says it will return a value must always do so. A function with a defined return type cannot allow control to fall out of the bottom of the function without returning a value, and attempting to do so will result in a compile-time error.
 */
do {
    func printAndCount(string: String) -> Int {
        print(string)
        return string.characters.count
    }
    func printWithoutCounting(string: String) {
        let _ = printAndCount(string: string)
    }
    printAndCount(string: "hello, world")
    printWithoutCounting(string: "hello, world")
    // prints "hello, world" but does not return a value
}

//: ### Functions with Multiple Return Values
do {
    /// returns a tuple containing two Int values.
    func minMax(array: [Int]) -> (min: Int, max: Int) {
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
    print("min is \(bounds.min) and max is \(bounds.max)")
}

//: ### Optional Tuple Return Types
/*:
 - NOTE:
 An optional tuple type such as (Int, Int)? is different from a tuple that contains optional types such as (Int?, Int?). With an optional tuple type, the entire tuple is optional, not just each individual value within the tuple.
 */
do {
    func minMax(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty { return nil }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
        print("min is \(bounds.min) and max is \(bounds.max)")
    }
}


//: ## Function Argument Labels and Parameter Names
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(firstParameterName: 1, secondParameterName: 2)

//: ### Specifying Argument Labels
/*:
 外部参数名称 external and local params names.
 - 外部参数名,是为了调用该函数时让其参数更为有表现力,更为通顺，同时还保持了函数体是可读的和有明确意图的,让别人阅读整段代码时更方便
 */
do {
    /// write an argument label before the parameter name, separated by a space:
    func someFunction(argumentLabel parameterName: Int) {
        // In the function body, parameterName refers to the argument value
        // for that parameter.
    }
    func greet(person: String, from hometown: String) -> String {
        return "Hello \(person)!  Glad you could visit from \(hometown)."
    }
    print(greet(person: "Bill", from: "Cupertino"))
}

//: ### Omitting Argument Labels
do {
    func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
        // In the function body, firstParameterName and secondParameterName
        // refer to the argument values for the first and second parameters.
    }
    someFunction(1, secondParameterName: 2)
}

//: ### Default Parameter Values
/*:
 - 预定义参数, 这意味着我们可以在调用该函数时省略它.
 */
do {
    func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
        // If you omit the second argument when calling this function, then
        // the value of parameterWithDefault is 12 inside the function body.
    }
    someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
    someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12

    func join(string s1: String, toString s2: String, withJoiner joiner: String = "only")
        -> String {
            return s1 + joiner + s2
    }
    join(string: "Hello", toString: "World", withJoiner: "New")
    join(string: "", toString: "")
}

//: ### Variadic Parameters
/*:
 - NOTE:
 A function may have at most one variadic parameter.
 */
do {
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    arithmeticMean(1, 2, 3, 4, 5)
    arithmeticMean(3, 8.25, 18.75)
}


//: ### In-Out Parameters
/*:
 - NOTE:
 In-out parameters cannot have default values, and variadic parameters cannot be marked as inout.
 */
do {
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    var someInt = 3
    var anotherInt = 107
    swapTwoInts(&someInt, &anotherInt)
    print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
}
/*:
 - NOTE:
 In-out parameters are not the same as returning a value from a function. The swapTwoInts example above does not define a return type or return a value, but it still modifies the values of someInt and anotherInt. In-out parameters are an alternative way for a function to have an effect outside of the scope of its function body.
 输入 - 输出参数与从函数返回值不同。 上面的swapTwoInts示例没有定义返回类型或返回值，但它仍然修改someInt和anotherInt的值。 输入 - 输出参数是函数具有超出函数体范围仍有效的替代方法。
 */





do {
    class Dog {
        //: Default Parameter
        func say(_ s:String, times:Int = 1) {
            for _ in 1...times {
                print(s)
            }
        }

        func doThing (a:Int = 0, b:Int = 3) {}

        //: variadic parameter lists, 可以获取指定类型的多个值
        func sayStrings(_ arrayOfStrings:String ...) {
            for s in arrayOfStrings { print(s) }
        }
        // new in beta 6, variadic can go anywhere

        func sayStrings(_ arrayOfStrings:String ..., times:Int) {
            for _ in 1...times {
                for s in arrayOfStrings { print(s) }
            }
        }
    }

    let d = Dog()
    d.say("woof") // same as saying d.say("woof", times:1)
    d.say("woof", times:3)
    d.sayStrings("hey", "ho", "nonny nonny no")
    d.sayStrings("Manny", "Moe", "Jack", times:3)
    // print is now variadic
    print("Manny", 3, true) // Manny 3 true
    print("Manny", "Moe", separator:", ", terminator: ", ")
    print("Jack")

    // ignored
    func say(_ s:String, times:Int, loudly _:Bool) {Dog().say(s, times:times)}
    func say2(_ s:String, times:Int, _:Bool) {Dog().say(s, times:times)}

    say("hi", times:3, loudly:true)
    say2("hi", times:3, true)
}


/*:
 ### var modifiable Parameters
 1. copy let Parameter then new var
 2. Key word inout
 声明函数时, 在参数前面用inout修饰, 表示传的是对象引用, 从而实现在函数内部实现改变外部参数
 - 传入的时候, 要在变量名字前面用&符号修饰, 表示传递给inout参数, 声明这个变量在参数内部是可以被改变的.
 - 只能传入变量，不能传入常量和字面量，因为这些是不能变的一旦定义.
 - inout修饰的参数是不能有默认值的，有范围的参数集合也不能被修饰，另外，一个参数一旦被inout修饰，就不能再被var和let修饰了
 */
//: var can't define parameter, because it is, after all, rather misleading
/*
 func say(s:String, times:Int, var loudly:Bool) {
 func removeFromStringNot(var s:String, character c:Character) -> Int {
 */
do {
    /// instead copy let then new var
    func say(s:String, times:Int, loudly:Bool) {
        var loudly = loudly
        loudly = true
        _ = loudly
    }
    func removeCharacterNot(_ c:Character, from s:String) -> Int {
        var s = s
        var howMany = 0
        while let ix = s.characters.index(of:c) {
            s.remove(at:ix)
            howMany += 1
        }
        return howMany
    }
    /// inout key word: 定义传递的参数的值可以被修改,这将反映在函数定义的原始变量上。
    func removeCharacter(_ c:Character, from s: inout String) -> Int {
        var howMany = 0
        while let ix = s.characters.index(of:c) {
            s.remove(at:ix)
            howMany += 1
        }
        return howMany
    }
    do {
        let s = "hello"
        let result = removeCharacterNot("l", from:s)
        print(result)
        print(s) // no effect on s
    }
    do {
        var s = "hello"
        let result = removeCharacter("l", from:&s)
        print(result)
        print(s)

        /// INOUT参数是一定变化的, proving that the inout parameter is always changed
        var ss = "testing" {didSet {print("did")}}
        _ = removeCharacter("X", from:&ss) // "did", even though no change
    }
    do {
        func swapTwoInts(_ a: inout Int, b: inout Int) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, b: &anotherInt)
    }
    do {
        let myRect = CGRect.zero
        var arrow = CGRect.zero
        var body = CGRect.zero
        struct Arrow {
            static let ARHEIGHT : CGFloat = 0
        }
        // but the whole example may fall to the ground...
        // as they may be blocking access to the original C functions entirely
        // the won't let me write this:
        // let r = CGRectDivide(myRect, &arrow, &body, Arrow.ARHEIGHT, .minYEdge)
        // but they do seem to let me access it as a kind of method!
        // seed 4, dodged a bullet; they renamified it but they didn't kill it
        // seed 6, they renamified it further; I hope they don't totally kill it...
        myRect.__divided(slice: &arrow, remainder: &body, atDistance: Arrow.ARHEIGHT, from: .minYEdge)
        // hmm, maybe I can subsitute this example:
        let c = UIColor.purple
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 0
        c.getRed(&r, green: &g, blue: &b, alpha: &a)
        print(r,g,b,a)
    }
    do {
        func myTest(_ a: inout Int, arr: inout [Int]) {
            a += 1
            arr[0] += 1
            arr = [0, 0, 0]
        }
        var x = 10
        var y = [1, 2, 3]
        myTest(&x, arr: &y)
        // 调用完之后，x值为11，y的值为[0, 0, 0]
        x
        y
    }
    /// 阶乘积:常量形参和变量形参,默认参数是常量,Swift 3.0 不可用
    func factorial(_ max: Int) -> Int {
        var result: Int = 1
        var number = max
        while number > 1 {
            result = result * number
            number -= 1
        }
        return result
    }
    ("factorial Result:\(factorial(10))") //注意不要Int超界
}
//: proving that a class instance parameter is mutable in a function without "inout"
do {
    class Dog {
        var name = ""
    }
    // class parameters no "var", no "inout" needed
    func changeName(of d:Dog, to newName:String) {
        d.name = newName
    }
    let d = Dog()
    d.name = "Fido"
    print(d.name) // "Fido"
    changeName(of:d, to:"Rover")
    print(d.name) // "Rover"

    // Example
    class ViewController: UIViewController,UIPopoverPresentationControllerDelegate {
        var button : UIButton!, button2 : UIButton!
        func popoverPresentationController(_ popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverTo rect: UnsafeMutablePointer<CGRect>, in view: AutoreleasingUnsafeMutablePointer<UIView>) {
            print("reposition")
            if view.pointee == self.button {
                rect.pointee = self.button2.bounds
                view.pointee = self.button2
            }
        }
    }
}

//: ### inout线程调用
do {
    /// 使用内嵌闭包
    func test(_ t: inout [String]) {
        {
            t = ["1","2","3"]
            print("\(t)")
        }()
    }
    var tempData:[String] = []
    test(&tempData)
    //／ async 异步调用异常
    /// error: escaping closures can only capture inout parameters explicitly by value
    func testAsync(_ t: inout [String]) {
        //        DispatchQueue.global(qos: .default).async {() -> Void in
        //            t = ["1","2","3"]
        //            print("\(t)")
        //            print("\(tempData)")
        //        }
    }
    /// 问题出在dispatch一个线程的时候，当前主线程的闭包执行上下文没有映射到新用户线程的上下文中去，把dispatch_async 改成 dispatch_sync（异步改为同步），就会输出正常
    print("tempData  : \(tempData)")
    func testAync(_ t:inout[String]){
        DispatchQueue.global(qos: .default).sync {() -> Void in
            t = ["1","2","3"]
            print("\(t)")
        }
    }
    /// In Swift 3, inout parameters are no longer allowed to be captured by @escaping closures, which eliminates the confusion of expecting a pass-by-reference. Instead you have to capture the parameter by copying it, by adding it to the closure's capture list. see https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Expressions.html#//apple_ref/swift/grammar/superclass-expression
    func foo(val: inout String, completion: @escaping (String) -> Void) {
        DispatchQueue.main.async { [val] in // copies val
            var val = val // mutable copy of val
            val += "foo"
            completion(val)
        }
        // mutate val here, otherwise there's no point in it being inout
    }
}

//: ### 元组作为返回参数
do {
    func count(string: String) -> (vowels: Int, consonants: Int, others: Int) {
        var vowels = 0, consonants = 0, others = 0
        /// 也可通过extension String: SequenceType {}
        for character in string.characters {
            switch String(character).lowercased() {
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
    count(string: "test count")

    do {
        // In this case we return a tuple
        func minMax(array: [Int]) -> (min: Int, max:Int)? {
            if array.isEmpty {return nil}
            return (0,1)
        }
        minMax(array: [12,31,2223,323])
    }
}

//: ### 函数作参数
do {
    func doThis(_ f:()->()) {
        f()
    }
    func whatToDo() {
        print("I did it")
    }
    doThis(whatToDo)
}
do {
    var myButton: UIButton!
    func moveMyButton (sender:AnyObject!) {
        func whatToAnimate() {
            myButton.frame.origin.y += 20
        }
        func whatToDoLater(finished:Bool) {
            print("finished: \(finished)")
        }
        UIView.animate(withDuration: 0.4, animations: whatToAnimate, completion: whatToDoLater)
    }
    func test() {
        let vc = UIViewController()
        func whatToDoLater() {
            print("I finished!")
        }
        vc.present(vc, animated:true, completion:whatToDoLater)
    }
}
do {
    func imageOfSize(_ size:CGSize, _ whatToDraw:() -> ()) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        whatToDraw()
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
    do {
        let size = CGSize(width:45, height:20)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let p = UIBezierPath(
            roundedRect: CGRect(x:0, y:0, width:45, height:20), cornerRadius: 8)
        p.stroke()
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    func drawing() {
        let p = UIBezierPath( // looks like they've finally cut me off from CGRectMake
            roundedRect: CGRect(x:0, y:0, width:45, height:20), cornerRadius: 8)
        p.stroke()
    }
    let image = imageOfSize(CGSize(width:45, height:20), drawing)

    // here, I'll prove we really drew it :)
    let imageView = UIImageView(image:image)
    imageView.frame.origin = CGPoint(x:100,y:100)
}
do {
    class ViewController: UIViewController {

        @IBOutlet weak var myButton: UIButton!

        override func viewDidLoad() {
            super.viewDidLoad()
        }

        @IBAction func moveMyButton (_ sender:Any!) {
            func whatToAnimate() { // self.myButton is a button in the interface
                self.myButton.frame.origin.y += 20
            }
            func whatToDoLater(finished:Bool) {
                print("finished: \(finished)")
            }
            UIView.animate(withDuration:
                0.4, animations: whatToAnimate, completion: whatToDoLater)
        }

        func playingWithFunctionSpecifierSyntax() {
            /*
             Illustrating ways to refer to a function as a value in Swift 2.2 and later.
             You can express the signature, e.g. as a way of disambiguating in case of overload.
             This will also turn out to be essential when using the new #selector syntax.
             You can precede with an explicit instance.
             You can precede with an explicit class. This is because an instance method
             is really a class method; as the calling example shows, this is not the same thing.
             But it will turn out that this can be used the same way in #selector.
             */

            let f = moveMyButton
            let ff = moveMyButton(_:)
            let f2 = self.moveMyButton
            let ff2 = self.moveMyButton(_:)
            let f3 = ViewController.moveMyButton
            let ff3 = ViewController.moveMyButton(_:)

            // let v = viewDidLoad

            f(self.myButton)
            ff(self.myButton)
            f2(self.myButton)
            ff2(self.myButton)
            f3(self)(self.myButton)
            ff3(self)(self.myButton)
        }

        // I should probably now discuss #selector syntax at this point in the book
        let b = UIButton(type: .system)
        func testSelectorSyntax() {
            /// how to crash the compiler warned you, maybe need @objc key work for buttonPressed
            self.b.addTarget(self, action: "buttonPressed", for: .touchUpInside)
            /// the solution:
            self.b.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            self.b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            self.b.addTarget(self, action: #selector(ViewController.buttonPressed(_:)), for: .touchUpInside)
            /// #selector the key point is, you just need to provide enough info, then the compiler can resolve this method reference for you and it will then form the actual Selector for you! no more "unrecognized selector"!
            /// If you can still crash: just specify the wrong target!,like this compiles:
            self.b.addTarget(self.b, action: #selector(ViewController.buttonPressed(_:)), for: .touchUpInside)
            // but it would crash if you ran it and tapped the button
        }
        
        func buttonPressed(_ sender:Any) { // must actually exist, or none of the above will compile
        }
        
    }
}

/*:
 ## parameter Void
 - 无参Function相当于Void参数?
 - passing a void is the same as no parameters
 - Void 可省略
 - Void 多用于 Closures
 return Void
 - translates in returning an empty tuple: ()
 - 没有定义返回类型的函数会返回特殊的值Void,它其实是一个空的元组tuple,没有任何元素,也可简写成()
 */
do {
    func say1(_ s:String) -> Void { (s) }
    func say2(_ s:String) -> () { (s) }
    func say3(_ s:String) { (s) }
    say1("howdy")
    say2("howdy")
    say3("howdy")
    let pointless : Void = say1("howdy") //showing that we actually return void
    ("pointless is \(pointless)") //showing that we captured the returned void
}
do {
    func greet1(_ unused: Void) -> Void { ("howdy") }
    func greet2() -> () { ("howdy") }
    func greet3() { ("howdy") }
    func greet4()-> String { return ("howdy") }
    greet1()
    greet2()
    greet3()
    let v:Void = ()
    greet1(v)
    greet4(v)
}



//: ## 函数变量 function As Value
do {
    func addInts(a:Int,b:Int)->Int {return a+b}
    var mathFunction:(Int,Int)->Int = addInts
    ("addInts Result:\(mathFunction(2,3))")

    func multiplyInts(a:Int,b:Int)->Int {return a*b}
    func printMathResult(_ mathFunction:(Int,Int)->Int,a:Int,b:Int){
        ("MathResult:\(mathFunction(a,b))")
    }
    printMathResult(multiplyInts,a: 2,b: 3)

    //定义类型函数的变量
    func sayHello(personName: String) -> String{
        return "Hello \(personName)!"
    }
    var stringFunction: (String) -> String = sayHello
}

do {
    class Cat {
        func purr () {}
    }

    class Dog {
        let cat = Cat()
        func bark() {print("woof")}
        func bark(_ loudly:Bool) {
            if loudly {
                print("WOOF")
            } else {
                self.bark()
            }
        }
        func test() {
            // let barkFunction = bark
            let barkFunction1 = bark(_:)
            let barkFunction2 = bark as (Void) -> Void
            let barkFunction3 = bark as (Bool) -> Void
            let barkFunction4 : (Bool) -> Void = bark
            let barkFunction5 = self.bark(_:)
            /// Dog === type(of:self)
            let barkFunction6 = type(of:self).bark(_:)
            let barkFunction7 = Dog.bark(_:)

            _ = barkFunction1
            _ = barkFunction2
            _ = barkFunction3
            _ = barkFunction4
            _ = barkFunction5
            _ = barkFunction6
            _ = barkFunction7

            let f = {
                // return bark(_:) // error
                return self.bark(_:)
            }
            _ = f

            let purrFunction1 = cat.purr
            let purrFunction2 = self.cat.purr
            let purrFunction3 = Cat.purr
            
            _ = purrFunction1
            _ = purrFunction2
            _ = purrFunction3
        }
    }
    class NoisyDog : Dog {
        func test2() {
            let barkFunction1 = bark(_:)
            let barkFunction2 = self.bark(_:)
            let barkFunction3 = super.bark(_:)

            _ = barkFunction1
            _ = barkFunction2
            _ = barkFunction3
        }
    }

    class Dog2 {
        func bark() {}
        func bark(_ loudly:Bool) {}
        func bark(_ times:Int) {}
        func test() {
            // let barkFunction1 = bark // ambiguous
            // let barkFunction2 = bark(_:) // still ambiguous
            let barkFunction = bark as (Int) -> Void
            _ = barkFunction
        }
    }

}


//: ### nested functions
//: 函数作返回值: 可以使用函数类型作为返回函数。
do {
    func squre(num: Int) -> Int {
        return num*num
    }
    func cube(num: Int) -> Int {
        return num*num*num
    }
    func getMathFunc(_ type: String) -> (Int) -> Int {
        switch(type){
        case "squre":
            return squre
        default:
            return cube
        }
    }
    var mathFunc = getMathFunc("other")
    ("getMathFunc result:\(mathFunc(5))")
}

//: 在这里，我们也定义嵌套函数,只能通过父函数访问这些函数,但可作为返回值传递.
do {
    func chooseStepFunction(_ backwards: Bool) -> (Int) -> Int {
        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        return backwards ? stepBackward : stepForward
    }
    var stepFunction = chooseStepFunction(true)
    ("chooseStepFunction result: \(stepFunction(100))")
}
do {
    func getMathFunc(type type:String)->(Int)->Int{
        func squre(num: Int) -> Int {return num*num}
        func cube(num: Int) -> Int {return num*num*num}
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
}

/*:
 ## overload 函数重载
 - 外部参数可reload
 - 局部参数不能reload
 */
do {
    //?
}
/// this is legal too, but _calling_ is error, how to call it, trickier!
func say() -> String { return "one" }
func say() -> Int { return 1 }
func giveMeAString(_ s:String) { print("thanks!") }
do {
    //say()//error: ambiguous use of 'say()',therefore illegal
    // but these are fine:
    giveMeAString(say()) //p:thanks!
    let result = say() + "two"
}
/// this is legal
func say (_ what:String) { }
func say (_ what:Int) { }
/// but in DO this is not legal
do {
    func say (_ what:String) { }
    //func say (_ what:Int) { }
}
do {
    class ViewController: UIViewController {
        /// if you delete `@nonobjc`, this is not legal, because Objective-C can't deal with it:
        /// error: method 'sayy(what:)' with Objective-C selector 'sayyWithWhat:' conflicts with previous declaration with the same Objective-C selector
        func sayy (_ what:String) { }
        @nonobjc func sayy (_ what:Int) { }

        override func viewDidLoad() {
            super.viewDidLoad()

            // but overloading is _not_ legal at the local level
            // I take it that is because we have no dynamic dispatch here?
            /*
             func sayyy (what:String) {
             }
             func sayyy (what:Int) {
             }
             */
            print(say("howdy")) //()
            print(say(1)) //()
        }
    }
}


//: ## 扩展类方法
class Thing {
    func crushingInstances(of otherThing: Thing) -> Thing {
        return Thing()
    }
}
extension Thing {
    func makingHash(of otherThing: Thing) -> Thing {return Thing()}
    func makingHash(cornedBeef otherThing:Thing) -> Thing {return Thing()}
    func makingHash(thing otherThing:Thing) -> Thing {return Thing()}
}

//: [Next](@next)


do {
    var red:CGFloat = 0.0,green:CGFloat=0.0,blue:CGFloat=0.0,alpha:CGFloat=0.0
    UIColor.red.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    red
    green
    blue
    alpha
}
