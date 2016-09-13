//: [Previous](@previous)

/*:
 # Stored Properties of Constant Structure Instances
 - If you create an instance of a structure and assign that instance to a constant, you cannot modify the instance’s properties, even if they were declared as variable properties.
 - This behavior is due to structures being value types. When an instance of a value type is marked as a constant, so are all of its properties.
 - The same is not true for classes, which are reference types. If you assign an instance of a reference type to a constant, you can still change that instance’s variable properties.
 */

import UIKit
import CoreBluetooth

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
    //These are both stored and computed global variables, or "type" variables. They will apply to all instances of this struct, including their value.
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        // return an Int value here
        get {
            //This is how type vars are accessed, by calling the class
            print(FixedLengthRange.storedTypeProperty)
            return self.computedTypeProperty
        }
        set {
            self.computedTypeProperty = newValue
        }
    }
}

class Moi {
    let first = "Matt"
    let last = "Neuburg"
    // let whole = self.first + " " + self.last // compile error
    // let whole = first + " " + last // different compiler error
}

class Moi2 {
    let first = "Matt"
    let last = "Neuburg"
    var whole : String {
        return self.first + " " + self.last
    }
}

class Moi3 {
    let first = "Matt"
    let last = "Neuburg"
    lazy var whole : String = self.first + " " + self.last
}

class Moi4 {
    let first = "Matt"
    let last = "Neuburg"
    // var whole : String = self.wholeName() // compile error
    func wholeName() -> String {
        return self.first + " " + self.last
    }
}

class Moi5 {
    let first = "Matt"
    let last = "Neuburg"
    var whole : String { return self.wholeName() }
    func wholeName() -> String {
        return self.first + " " + self.last
    }
}

class Moi6 {
    let first = "Matt"
    let last = "Neuburg"
    lazy var whole : String = self.wholeName()
    func wholeName() -> String {
        return self.first + " " + self.last
    }
}

class Moi7 {
    let first = "Matt"
    let last = "Neuburg"
    lazy var whole : String = { // "lazy" or we won't compile
        var s = self.first
        s.appendContentsOf(" ")
        s.appendContentsOf(self.last)
        return s
    }()
}

class Dog {
    let name : String
    let license : Int
    init(name:String, license:Int) {
        self.name = name
        self.license = license
    }
}

struct Greeting {
    static let friendly = "hello there"
    static let hostile = "go away"
    static let ambivalent = friendly + " but " + hostile // legal!
    // static let ambivalent2 = self.friendly + " but " + self.hostile // compile error
    static let ambivalent2 = Greeting.friendly + " but " + Greeting.hostile
    static var ambivalent3 : String {
        return self.friendly + " but " + self.hostile // legal!
    }
    //    static var ambivalent4 : String = {
    //        return self.friendly + " but " + self.hostile // compile error
    //        }()

}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        let fido = Dog(name:"Fido", license:1234)
        let spot = Dog(name:"Spot", license:1357)
        let aName = fido.name // "Fido"
        let anotherName = spot.name // "Spot"


        _ = aName
        _ = anotherName
        
    }
    
}


class DataImporter {
    /*
     DataImporter is a class to import data from an external file.
     The class is assumed to take a non-trivial amount of time to initialize.
     */
    var fileName = "data.txt"
    var cont: ViewController = ViewController()
    func doSomething() -> Void {
    }
    // the DataImporter class would provide data importing functionality here
}

class test: UIViewController {
    //This is a "Stored Property". It simply provides a value and the ability to set it back.
    var prop = "Hello"
    //This is a "Computed Property". Its value is calculated in real-time, and provides getters and setters.
    var someCalculation: Int {
        get {
            return 1 + 1
        }
        set {
            self.someCalculation = newValue
        }
    }
    //This property has observers for when the the value will and did set
    var propWithObserver: Int = 0 {
        willSet {
            print(newValue)
        }
        didSet {
            print(oldValue)
        }
        //Note that if the didSet sets the value of the property, it doesn't call the setter again
    }
    //This is a "Computed Property" with just a getter (read-only).
    var someFixedCalculatedProperty: Double {
        return 3 * 3
    }
    /*This is a type variable for the class ViewController (it'll apply for all instances). It's weirdly declared with the word "class"
     Class var中声明的变量是所有对象共享的，而实例字段是每个对象都有各自的副本。
     Class var声明可以通过以下方式终止。
     1.另一个Class var或var
     2.过程或函数声明
     3.属性声明
     4.构造器，析构器声明
     5.变量范围标识符
     */
    class var computedTypeProperty: Int {
        // return an Int value here
        get {
            return 1 + 1
        }
        set {
            self.computedTypeProperty = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
        // this range represents integer values 0, 1, 2, and 3
        
        rangeOfFourItems.firstValue = 6
        // this will report an error, even though firstValue is a variable property
        
        //Here, importer won't be instantiated until we use it for the first time.
        // lazy var importer = DataImporter()
    }

}

//: [Next](@next)
