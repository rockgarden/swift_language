//: [Previous](@previous)
import UIKit
/*:
 # Optional Chaining
 Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil. If the optional contains a value, the property, method, or subscript call succeeds; if the optional is nil, the property, method, or subscript call returns nil. Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is nil.

 - NOTE:
 Optional chaining in Swift is similar to messaging nil in Objective-C, but in a way that works for any type, and that can be checked for success or failure. Swift中的可选链接类似于Objective-C中的消息传递，但以某种方式适用于任何类型，并且可以检查成功或失败。


 # Optional Chaining as an Alternative to Forced Unwrapping

 可选链接作为强制展开的替代方案

 You specify optional chaining by placing a question mark (?) after the optional value on which you wish to call a property, method or subscript if the optional is non-nil. This is very similar to placing an exclamation mark (!) after an optional value to force the unwrapping of its value. The main difference is that optional chaining fails gracefully when the optional is nil, whereas forced unwrapping triggers a runtime error when the optional is nil. 您可以在可选的值（？）之后放置一个问号（？）来指定可选链接，如果可选的值为非零，则可以调用属性，方法或下标。这与在可选值之后放置感叹号（！）非常相似，以强制解除其值。主要区别在于可选链接在可选项为nil时正常失败，而当可选为nil时，强制解除触发器会触发运行时错误。

 To reflect the fact that optional chaining can be called on a nil value, the result of an optional chaining call is always an optional value, even if the property, method, or subscript you are querying returns a nonoptional value. You can use this optional return value to check whether the optional chaining call was successful (the returned optional contains a value), or did not succeed due to a nil value in the chain (the returned optional value is nil). 为了反映可以在nil值上调用可选链接的事实，可选链接调用的结果始终是可选的值，即使正在查询的属性，方法或下标返回非可选值。您可以使用此可选返回值来检查可选链接调用是否成功（返回的可选项包含值）或由于链中的零值（返回的可选值为nil）而未成功。

 Specifically, the result of an optional chaining call is of the same type as the expected return value, but wrapped in an optional. A property that normally returns an Int will return an Int? when accessed through optional chaining. 具体来说，可选链接调用的结果与预期返回值的类型相同，但是包含在可选项中。通常返回Int的属性将返回Int？当通过可选链接访问时。

 The next several code snippets demonstrate how optional chaining differs from forced unwrapping and enables you to check for success.
 */


class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

do {
    let john = Person()
    //let roomCount = john.residence!.numberOfRooms

    if let roomCount = john.residence?.numberOfRooms {
        print("John's residence has \(roomCount) room(s).")
    } else {
        print("Unable to retrieve the number of rooms.")
    }
    // Prints "Unable to retrieve the number of rooms."

    john.residence = Residence()
    if let roomCount = john.residence?.numberOfRooms {
        print("John's residence has \(roomCount) room(s).")
    } else {
        print("Unable to retrieve the number of rooms.")
    }
    // Prints "John's residence has 1 room(s)."
}
do {
    class ViewController: UIViewController {
        override func viewDidLoad() {
            // longer chain - still just one Optional results
            _ = self.view.window?.rootViewController?.view.frame
        }
    }
}


/*:
 # Defining Model Classes for Optional Chaining
 You can use optional chaining with calls to properties, methods, and subscripts that are more than one level deep. This enables you to drill down into subproperties within complex models of interrelated types, and to check whether it is possible to access properties, methods, and subscripts on those subproperties. 您可以使用可选链接调用多个级别的属性，方法和下标。 这使您能够深入到相关类型的复杂模型中的子属性，并检查是否可以访问这些子属性的属性，方法和下标。
 */
class OtherPerson {
    var residence: OtherResidence?
}

class OtherResidence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        ("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?

    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

var otherResidence = OtherResidence()
otherResidence.rooms.append(Room(name: "Living Room"))
var room = otherResidence[0]


/*:
 # Accessing Properties Through Optional Chaining
 */
let john = OtherPerson()
do {
    if let roomCount = john.residence?.numberOfRooms {
        print("John's residence has \(roomCount) room(s).")
    } else {
        print("Unable to retrieve the number of rooms.")
    }

    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    john.residence?.address = someAddress
}
/*:
 The assignment is part of the optional chaining, which means none of the code on the right hand side of the = operator is evaluated. In the previous example, it’s not easy to see that someAddress is never evaluated, because accessing a constant doesn’t have any side effects. The listing below does the same assignment, but it uses a function to create the address. The function prints “Function was called” before returning a value, which lets you see whether the right hand side of the = operator was evaluated.
 */
do {
    func createAddress() -> Address {
        print("Function was called.")

        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"

        return someAddress
    }
    /// You can tell that the createAddress() function isn’t called, because nothing is printed.
    john.residence?.address = createAddress()
}


/*:
 # Calling Methods Through Optional Chaining
 */
do {
    let numberOfRooms = john.residence?.numberOfRooms
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }

    if john.residence?.printNumberOfRooms() != nil {
        print("It was possible to print the number of rooms.")
    } else {
        print("It was not possible to print the number of rooms.")
    }
    // Prints "It was not possible to print the number of rooms."
}

/*:
 # Accessing Subscripts Through Optional Chaining
 You can use optional chaining to try to retrieve and set a value from a subscript on an optional value, and to check whether that subscript call is successful.
 - NOTE:
 When you access a subscript on an optional value through optional chaining, you place the question mark before the subscript’s brackets, not after. The optional chaining question mark always follows immediately after the part of the expression that is optional. 当您通过可选链接访问可选值的下标时，将问号放在下标的括号之前，而不是之后。 可选的链接问号总是紧跟在可选的表达式的部分之后。
 */
do {
    if let firstRoomName = john.residence?[0].name {
        print("The first room name is \(firstRoomName).")
    } else {
        print("Unable to retrieve the first room name.")
    }
    // Prints "Unable to retrieve the first room name."

    john.residence?[0] = Room(name: "Bathroom") //This subscript setting attempt also fails, because residence is currently nil.
}
do {
    let johnsHouse = OtherResidence()
    johnsHouse.rooms.append(Room(name: "Living Room"))
    johnsHouse.rooms.append(Room(name: "Kitchen"))
    john.residence = johnsHouse

    if let firstRoomName = john.residence?[0].name {
        print("The first room name is \(firstRoomName).")
    } else {
        print("Unable to retrieve the first room name.")
    }
    // Prints "The first room name is Living Room."
}
/*:
 ## Accessing Subscripts of Optional Type
 If a subscript returns a value of optional type—such as the key subscript of Swift’s Dictionary type—place a question mark after the subscript’s closing bracket to chain on its optional return value: 如果下标返回可选类型的值，例如Swift字典类型的键下标，则在下标的关闭括号之后放置一个问号，以链接其可选返回值：
 */
do {
    var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
    testScores["Dave"]?[0] = 91
    testScores["Bev"]?[0] += 1
    testScores["Brian"]?[0] = 72
    // the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
    print(testScores)
}

/*:
 # Linking Multiple Levels of Chaining
 You can link together multiple levels of optional chaining to drill down to properties, methods, and subscripts deeper within a model. However, multiple levels of optional chaining do not add more levels of optionality to the returned value. 您可以链接多个级别的可选链接，以深入了解模型中更深入的属性，方法和下标。 但是，多级可选链接不会为返回值添加更多级别的可选性。

 To put it another way:

 - If the type you are trying to retrieve is not optional, it will become optional because of the optional chaining. 如果您尝试检索的类型不是可选的，则由于可选链接，它将变为可选项。
 - If the type you are trying to retrieve is already optional, it will not become more optional because of the chaining. 如果您尝试检索的类型已经是可选的，则由于链接，它不会变得更加可选
 
 Therefore:

 - If you try to retrieve an Int value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used. 如果您尝试通过可选链接检索Int值，Int？ 总是返回，无论使用多少级别的链接。
 - Similarly, if you try to retrieve an Int? value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used. 同样，如果您尝试检索Int？ 价值通过可选链接，一个Int？ 总是返回，无论使用多少级别的链接。
 */
do {
    if let johnsStreet = john.residence?.address?.street {
        print("John's street name is \(johnsStreet).")
    } else {
        print("Unable to retrieve the address.")
    }
    // Prints "Unable to retrieve the address."
}
do {
    let johnsAddress = Address()
    johnsAddress.buildingName = "The Larches"
    johnsAddress.street = "Laurel Street"
    john.residence?.address = johnsAddress

    if let johnsStreet = john.residence?.address?.street {
        print("John's street name is \(johnsStreet).")
    } else {
        print("Unable to retrieve the address.")
    }
    // Prints "John's street name is Laurel Street."
}

/*:
 # Chaining on Methods with Optional Return Values
 You can also use optional chaining to call a method that returns a value of optional type, and to chain on that method’s return value if needed. 您还可以使用可选链接来调用返回可选类型值的方法，并根据需要链接该方法的返回值。
 */
do {
    if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
        print("John's building identifier is \(buildingIdentifier).")
    }
    // Prints "John's building identifier is The Larches."
}
//: If you want to perform further optional chaining on this method’s return value, place the optional chaining question mark after the method’s parentheses:
do {
    if let beginsWithThe =
        john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        if beginsWithThe {
            print("John's building identifier begins with \"The\".")
        } else {
            print("John's building identifier does not begin with \"The\".")
        }
    }
    // Prints "John's building identifier begins with "The"."
}
/*:
 - NOTE:
 In the example above, you place the optional chaining question mark after the parentheses, because the optional value you are chaining on is the buildingIdentifier() method’s return value, and not the buildingIdentifier() method itself.
 */


//: [Next](@next)
