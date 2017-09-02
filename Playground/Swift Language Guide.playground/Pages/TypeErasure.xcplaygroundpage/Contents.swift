//: [Previous](@previous)

//: # Type Erasure 类型擦除

protocol Flier {
    associatedtype Other //指定的泛型约束 or 占位符
    func flockTogetherWith(_ other: Other)
}

do {
    struct Bird: Flier {
        typealias Other = Insect
        func flockTogetherWith(_ other: Other) {
            ("tweet tweet, I'm flocking with some \(type(of: other))")
        }
    }

    /// 昆虫
    struct Insect: Flier {
        typealias Other = Insect
        func flockTogetherWith(_ other: Other) {
            ("buzz buzz, I'm flocking with some \(type(of: other))")
        }
    }

    struct Helicopter : Flier {
        typealias Other = Helicopter
        func flockTogetherWith(_ other: Other) {
            ("whrrrrrrrrr!")
        }
    }

    struct FlierStruct1<T> {
        init<FlierAdopter: Flier>(_ flierAdopter: FlierAdopter) {
            ("FlierStruct1")
        }
    }

    struct FlierStruct2<T> {
        init<FlierAdopter: Flier>(_ flierAdopter: FlierAdopter) where T == FlierAdopter.Other {
        }
    }

    struct FlierStruct<T>: Flier {
        // let flierAdopter : Flier // can't make a wrapper like this
        // let flierAdopter : Flier where T == FlierAdopter.Other // or like this
        // but we _can_ store a function reference taken from the init parameter Flier!

        let flockFunction : (T) -> ()
        init<FlierAdopter : Flier>(_ flierAdopter:FlierAdopter) where FlierAdopter.Other == T {
            self.flockFunction = flierAdopter.flockTogetherWith
        }
        func flockTogetherWith(_ other:T) {
            self.flockFunction(other)
        }
    }

    do {
        /// error: protocol 'Flier' can only be used as a generic constraint because it has Self or associated type requirements. 协议“Flier”只能用作通用约束，因为它具有自身或相关类型的要求
        //let aFlier : Flier = Bird() // no, Flier is not a type in this sense. Flier在这个意义上不是一种类型
    }

    do {
        let aFlier : FlierStruct1 = FlierStruct1<Insect>(Bird())
    }

    do {
        let aFlier : FlierStruct2 = FlierStruct2(Bird())
    }

    do {
        let fliers : [Any] = [Bird(), Insect()]
        //fliers.forEach {$0.flockTogetherWith(Insect())} // (in which case we can't send flockTogetherWith to it)
    }

    do {
        // the solution is our FlierStruct
        let fliers = [FlierStruct(Bird()), FlierStruct(Insect())]
        fliers.forEach {$0.flockTogetherWith(Insect())}

        /// 占位符解析类型被保留.the placeholder resolution type is preserved! so - error: cannot convert value of type 'Bird' to expected argument type 'Bird.Other' (aka 'Insect')
        //fliers.forEach {$0.flockTogetherWith(Bird())}
    }

    do {
        /// error: heterogeneous collection literal could only be inferred to '[Any]'; add explicit type annotation if this is intentional
        //let fliers = [FlierStruct(Bird()), FlierStruct(Helicopter())]
        /// can't do that either, because they resolve Other differently.
    }

    do {
        let rangeOfInt = 1...3
        let arrayOfInt = [4,5,6]

        /// error: protocol 'Sequence' can only be used as a generic constraint because it has Self or associated type requirements
        //let arr : [Sequence] = [rangeOfInt, arrayOfInt]

        let arr = [AnySequence(rangeOfInt), AnySequence(arrayOfInt)]
        var sums = arr.map {$0.reduce(0,+)} //+ 相当于
        (sums)
        let addTwo: (Int, Int) -> Int = { x, y in x + y }
        sums = arr.map {$0.reduce(0, addTwo)}
        (sums)
    }
}

protocol Flier1 {
    associatedtype Other
    func fly()
}
do {
    struct Bird : Flier1 {
        let noise : String
        typealias Other = Insect
        func fly() { print(self.noise) }
    }
    struct Insect : Flier1 {
        let noise : String
        typealias Other = Bird
        func fly() { print(self.noise) }
    }
    struct FlierStruct /* : Flier */ {
        let flierAdopterFlyMethod : (Void) -> Void
        init<FlierAdopter:Flier1>(_ flierAdopter:FlierAdopter) {
            self.flierAdopterFlyMethod = flierAdopter.fly
        }
        func fly() {
            self.flierAdopterFlyMethod()
        }
    }

    let b = Bird(noise:"flap flap flap")
    let f = FlierStruct(b)
    f.fly() //print: flap flap flap
    let i = Insect(noise:"whirrrrr")
    let f2 = FlierStruct(i)
    f2.fly() //print: whirrrrr
}

protocol Flier2 {
    associatedtype Other
    func fly()
    func flockTogetherWith(other: Other)
}
do {
    struct Bird : Flier2 {
        let noise : String
        typealias Other = Insect
        func fly() { print(self.noise) }
        func flockTogetherWith(other: Other) {
            print("\(self.noise), I'm flocking with some \(type(of:other))")
        }
    }

    struct Insect : Flier2 {
        let noise : String
        typealias Other = Bird
        func fly() { print(self.noise) }
        func flockTogetherWith(other: Other) {
            print("\(self.noise), I'm flocking with some \(type(of:other))")
        }
    }

    struct FlierStruct<Other> : Flier2 {
        let flierAdopterFlyMethod : (Void) -> Void
        let flierAdopterFlockMethod : (Other) -> Void

        init<FlierAdopter:Flier2>(_ flierAdopter:FlierAdopter) where Other == FlierAdopter.Other {
            self.flierAdopterFlyMethod = flierAdopter.fly
            self.flierAdopterFlockMethod = flierAdopter.flockTogetherWith
        }

        func fly() {
            self.flierAdopterFlyMethod()
        }
        func flockTogetherWith(other: Other) {
            self.flierAdopterFlockMethod(other)
        }
    }

    var fB = FlierStruct(Bird(noise:"flap flap flap"))
    // 此时 FlierAdopter.Other = Insect
    fB.flockTogetherWith(other:Insect(noise:"whirrrrr"))

    /// error: cannot convert value of type 'Bird' to expected argument type 'Bird.Other' (aka 'Insect')
    //f.flockTogetherWith(other:Bird(noise:"flap flap flap"))

    var fI = FlierStruct(Insect(noise:"whirrrrr"))
    fI.flockTogetherWith(other:Bird(noise:"flap flap flap"))
}

//: [Next](@next)
