//: [Previous](@previous)
//: # Class type reference
class Dog {
    class var whatDogsSay: String {
        return "Woof"
    }
    func bark() -> String {
        return (self.dynamicType.whatDogsSay)
    }
}
class NoisyDog: Dog {
    override class var whatDogsSay: String {
        return "Woof woof woof"
    }
}
func typeExpecter(whattype: Dog.Type) -> String { return String(whattype) }
do {
    let d = Dog()
    d.bark()
    let nd = NoisyDog()
    nd.bark() // Woof woof woof
    (nd.dynamicType)
    
    typeExpecter(Dog)
    typeExpecter(Dog.self)
    typeExpecter(d.dynamicType)
    typeExpecter(d.dynamicType.self)
    typeExpecter(nd.dynamicType)
    typeExpecter(nd.dynamicType.self)
    
    _ = d
    _ = nd
}

class Dog1 {
    var name: String
    required init(name: String) {
        self.name = name
    }
    class func makeAndName() -> Dog1 {
        let d = self.init(name: "Fido") // newly required in Swift 2.0
        return d
    }
    class func makeAndName2() -> Self {
        let d = self.init(name: "Fido") // newly required in Swift 2.0
        return d
    }
    func havePuppy(name name: String) -> Self {
        return self.dynamicType.init(name: name) // ditto
    }
}
class NoisyDog1: Dog1 { }
func dogMakerAndNamer(whattype: Dog1.Type) -> Dog1 {
    let d = whattype.init(name: "Fido")
    // ditto; compile error, unless `init(name:)` is `required`
    return d
}

func typeTester(d: Dog1, _ whattype: Dog1.Type) -> String {
    // if d.dynamicType is whattype { // compile error, "not a type" (i.e. a not a type literal)
    if d.dynamicType === whattype {
        return ("yep")
    } else {
        return ("nope")
    }
}
do {
    let d = dogMakerAndNamer(Dog1) // d is a Dog1 named Fido
    d.name
    let d2 = dogMakerAndNamer(NoisyDog1) // d2 is a NoisyDog1 named Fido
    let dd = Dog1.makeAndName() // d is a Dog1 named Fido
    let dd2 = NoisyDog1.makeAndName() // d2 is a NoisyDog1 named Fido - but typed as Dog1
    let ddd = Dog1.makeAndName2() // d is a Dog1 named Fido
    let ddd2 = NoisyDog1.makeAndName2() // d2 is a NoisyDog1 named Fido, typed as NoisyDog1
    typeTester(Dog1(name: "fido"), NoisyDog1.self)
    typeTester(Dog1(name: "fido"), Dog1.self)
    typeTester(NoisyDog1(name: "fido"), NoisyDog1.self)
    typeTester(NoisyDog1(name: "fido"), Dog1.self)
}
do {
    let d = Dog1(name: "Fido")
    let d2 = d.havePuppy(name: "Fido Junior")
    let nd = NoisyDog1(name: "Rover")
    let nd2 = nd.havePuppy(name: "Rover Junior")
}

//: [Next](@next)
