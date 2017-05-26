//: [Previous](@previous)

import Foundation

struct FirstName {
    let value: String

    init(value: String) {
        self.value = value
    }
}

struct LastName {
    let value: String

    init(value: String) {
        self.value = value
    }
}

//: The struct Person must implement the Hashable protocol, which inherits from the Equatable protocol to be used with sets.
//: Additionally, the struct Person implements the CustomStringConvertible protocol for displaying purposes.
class Person : NSObject {
    let firstName: FirstName
    let lastName: LastName

    init(firstName: FirstName, lastName: LastName) {
        self.firstName = firstName
        self.lastName = lastName
    }

    // Hashable protocol implementation.
    override var hashValue: Int {
        get {
            return firstName.value.hashValue
        }
    }

    // CustomStringConvertible protocol implementation.
    override var description: String {
        get {
            return "[\(firstName.value) \(lastName.value)]"
        }
    }

    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

}

//: This function implements the Equatable protol.
//: Weired, but the == function must be defined globally, i.e. outside the Person struct.


let person1 = Person(firstName: FirstName(value: "John"), lastName: LastName(value: "Foe"))
let person2 = Person(firstName: FirstName(value: "David"), lastName: LastName(value: "White"))
let person3 = Person(firstName: FirstName(value: "Brian"), lastName: LastName(value: "Westwood"))
let person4 = Person(firstName: FirstName(value: "Adrian"), lastName: LastName(value: "Westwood"))
let person6 = Person(firstName: FirstName(value: "Adrian"), lastName: LastName(value: "xxx"))


var personsSet = Set<Person>()

//: Initialising an unsorted set.
personsSet.insert(person3)
personsSet.insert(person2)
personsSet.insert(person1)
personsSet.insert(person4)
personsSet.insert(person6)

var personsSet2 = Set<Person>()
personsSet2.insert(person4)

personsSet.filter(<#T##isIncluded: (Person) throws -> Bool##(Person) throws -> Bool#>)

func filterByArray() -> [Person] {
    let array: [Person] =  personsSet.filter { (Person) -> Bool in
        for id in personsSet2 {
            let v = Person.firstName.value
            let b = id.firstName.value
            if v != b  {
                return true
            }
        }
        return false
    }
    return array
}
print(filterByArray())

print(personsSet.intersection(personsSet2))
print(personsSet.subtracting(personsSet2))

//: Printing set's unsorted elements.
print("*** Unsorted set ***\n", personsSet)

//: Sorting set by last and first name ascending.
let ascendingSortedSet = personsSet.sorted { (first, second) -> Bool in
    return (first.lastName.value + first.firstName.value < second.lastName.value + second.firstName.value)
}
print("*** Set sorted by last and first name ascending ***\n", ascendingSortedSet)

//: [Next](@next)
