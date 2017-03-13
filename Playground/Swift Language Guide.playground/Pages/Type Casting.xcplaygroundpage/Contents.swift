//: [Previous](@previous)

import UIKit
/*: 
 # Type Casting
 类型转换
 Type casting is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy.
 类型转换是一种检查实例类型的方法，或者将该实例视为来自其自身类层次结构中的其他地方的不同超类或子类。
 Type casting in Swift is implemented with the is and as operators. These two operators provide a simple and expressive way to check the type of a value or cast a value to a different type.
 Swift中的类型转换使用is和as运算符实现。 这两个操作符提供了一种简单和表达方式来检查值的类型或将值转换为不同类型。
 You can also use type casting to check whether a type conforms to a protocol, as described in Checking for Protocol Conformance.
 您还可以使用类型转换来检查类型是否符合协议，如检查协议一致性中所述。
 */
/*: 
 # Defining a Class Hierarchy for Type Casting
 You can use type casting with a hierarchy of classes and subclasses to check the type of a particular class instance and to cast that instance to another class within the same hierarchy.
 */
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

/*:
 The type of the library array is inferred by initializing it with the contents of an array literal.
 Swift’s type checker is able to deduce that Movie and Song have a common superclass of MediaItem,
 and so it infers a type of [MediaItem] for the library array.
 The items stored in library are still Movie and Song instances behind the scenes.
 However, if you iterate over the contents of this array, the items you receive back are typed as MediaItem, and not as Movie or Song. In order to work with them as their native type, you need to check their type, or downcast them to a different type, as described below.
 */


/*:
 # Checking Type
 类型判断
 Use the type check operator (is) to check whether an instance is of a certain subclass type.
 通过 is 来判断一个实例是否属于指定类或者其子类.类似以 OC 中的 isKindOfClass.
 */
do {
    var movieCount = 0
    var songCount = 0

    for item in library {
        if item is Movie {
            movieCount += 1
        } else if item is Song {
            songCount += 1
        }
    }
    print("Media library contains \(movieCount) movies and \(songCount) songs")
}
/*
 # Downcasting 
 向下转型
 A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes. Where you believe this is the case, you can try to downcast to the subclass type with a type cast operator (as? or as!).
 Because downcasting can fail, the type cast operator comes in two different forms. The conditional form, as?, returns an optional value of the type you are trying to downcast to. The forced form, as!, attempts the downcast and force-unwraps the result as a single compound action.
 Use the conditional form of the type cast operator (as?) when you are not sure if the downcast will succeed. This form of the operator will always return an optional value, and the value will be nil if the downcast was not possible. This enables you to check for a successful downcast.
 Use the forced form of the type cast operator (as!) only when you are sure that the downcast will always succeed. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.
 可以用类型转换操作符 as 尝试将某个实例转换到它的子类型.
 转换没有真的改变实例或它的值.
 转型的实例保持不变,只是简单地把它作为它被转换成的类来使用。
 */
do {
    for item in library {
        if let movie = item as? Movie {
            print("Movie: '\(movie.name)', dir. \(movie.director)")
        } else if let song = item as? Song {
            print("Song: '\(song.name)', by \(song.artist)")
        }
    }
}

/*:
 - NOTE:
 Casting does not actually modify the instance or change its values. The underlying instance remains the same; it is simply treated and accessed as an instance of the type to which it has been cast.
 转型不会实际修改实例或更改其值。 底层实例保持不变; 它被简单地处理和访问作为它已经被转换的类型的实例。
 */

/*
 # Type Casting for Any and AnyObject
 Swift provides two special type aliases for working with non-specific types:
  - AnyObject can represent an instance of any class type. 可以代表任何class类型的实例.
  - Any can represent an instance of any type at all, including function types. 可以表示任何类型, 包括方法类型function types.
 */


//: ## AnyObject

let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]

for movie in someObjects as! [Movie] {
    ("Movie: '\(movie.name)', dir. \(movie.director)")
}

//: ## Any

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

/*:
 You can use the is and as operators in a switch statement’s cases to discover the specific type of a constant or variablen that is known only to be of type Any or AnyObject.
 */
for thing in things {
    switch thing {
    case 0 as Int:
        ("zero as an Int")
    case 0 as Double:
        ("zero as a Double")
    case let someInt as Int:
        ("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        ("a positive double value of \(someDouble)")
    case is Double: // Here it's valid to use is, since the only thing being queried is the type. Other case statements store values in vars, so they use as.
        ("some other double value that I don't want to print")
    case let someString as String:
        ("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        ("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        ("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        (stringConverter("Michael"))
    default:
        ("something else")
    }
}

/*:
 - NOTE:
 The Any type represents values of any type, including optional types. Swift gives you a warning if you use an optional value where a value of type Any is expected. If you really do need to use an optional value as an Any value, you can use the as operator to explicitly cast the optional to Any, as shown below.
 */

let optionalNumber: Int? = 3
things.append(optionalNumber)//警告
things.append(optionalNumber as Any)//没有警告

//: [Next](@next)
