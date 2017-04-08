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

do {
    class Person {
        var residence: Residence?
    }

    class Residence {
        var numberOfRooms = 1
    }

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
 ## Accessing Properties Through Optional Chaining
 */

let bob = OtherPerson()

if let roomCount = bob.residence?.numberOfRooms {
    ("John's residence has \(roomCount) room(s).")
} else {
    ("Unable to retrieve the number of rooms.")
}

/*:
 In next example, the attempt to set the address property of john.residence will fail, because john.residence is currently nil.
 The assignment is part of the optional chaining, which means none of the code on the right hand side of the = operator is evaluated.
 */

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
bob.residence?.address = someAddress

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

bob.residence?.address = createAddress() //不执行createAddress()
bob.residence = otherResidence
bob.residence?.address = createAddress() //now run createAddress()

/*:
 If you call this method on an optional value with optional chaining, the method’s return type will be Void?, not Void, because return values are always of an optional type when called through optional chaining.
 This enables you to use an if statement to check whether it was possible to call the printNumberOfRooms() method, even though the method does not itself define a return value.
 */

if let void = bob.residence?.printNumberOfRooms() {
    ("It was possible to print the number of rooms.")
    bob.residence?.numberOfRooms
} else {
    ("It was not possible to print the number of rooms.")
}

/*:
 Any attempt to set a property through optional chaining returns a value of type Void?, which enables you to compare against nil to see if the property was set successfully:
 */

if (bob.residence?.address = someAddress) != nil {
    ("It was possible to set the address.")
} else {
    ("It was not possible to set the address.")
}

/*:
 ## Accessing Subscripts Through Optional Chaining
 */

if let firstRoomName = bob.residence?[0].name {
    ("The first room name is \(firstRoomName).")
} else {
    ("Unable to retrieve the first room name.")
}

bob.residence?.rooms.append(Room(name: "Bathroom"))


/*:
 Accessing Subscripts of Optional Type
 */

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72

// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
testScores["Dave"]
testScores["Bev"]

/*:
 - If you try to retrieve an Int value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used.
 - Similarly, if you try to retrieve an Int? value through optional chaining, an Int? is always returned, no matter how many levels of chaining are used.
 */

if let bobsStreet = bob.residence?.address?.street {
    ("Bob's street name is \(bobsStreet).")
} else {
    ("Unable to retrieve the address.")
}

/*:
 Chaining on Methods with Optional Return Values
 */

if let beginsWithThe =
    bob.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        ("John's building identifier begins with \"The\".")
    } else {
        ("John's building identifier does not begin with \"The\".")
    }
}

//: [Next](@next)
