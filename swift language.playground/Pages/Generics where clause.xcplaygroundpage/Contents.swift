//: [Previous](@previous)

protocol Walker { }
struct Kiwi: Walker { }
class Dog { }
class NoisyDog: Dog { }

//: ## Where Clauses
protocol Wieldable { }
struct Sword: Wieldable { }
struct Bow: Wieldable { }
protocol Superfighter {
    associatedtype Weapon: Wieldable
}
protocol Fighter: Superfighter {
    associatedtype Enemy: Superfighter
    func steal(weapon: Self.Enemy.Weapon, from: Self.Enemy)
}
struct Soldier: Fighter {
    typealias Weapon = Sword
    typealias Enemy = Archer
    func steal(weapon: Bow, from: Archer) {
    }
}
struct Archer: Fighter {
    typealias Weapon = Bow
    typealias Enemy = Soldier
    func steal (weapon: Sword, from: Soldier) {
    }
}
struct Camp<T: Fighter> {
    var spy: T.Enemy?
}
do {
    var c = Camp<Soldier>()
    c.spy = Archer()
    var c2 = Camp<Archer>()
    c2.spy = Soldier()
}

class Cat { }
class FlyingDog: Cat, Flier { }
protocol Flier { }
protocol Generic {
    associatedtype T: Flier, Walker // T must adopt Flier and Walker
    // associatedtype U where U:Flier // no where clauses on associatedtype
    associatedtype U: Cat, Flier // legal: this is basically an inheritance declaration!
}
func flyAndWalk<T where T: Walker, T: Flier> (f: T) { }
func flyAndWalk2<T : protocol<Walker, Flier>> (f: T) { }
func flyAndWalk3<T where T: Flier, T: Cat> (f: T) { }
// func flyAndWalk4<T where T == Cat> (f:T) {}
struct Bird: Flier, Walker { }

struct S: Generic {
    typealias T = Bird
    typealias U = FlyingDog
}
do {
    flyAndWalk(Bird())
    flyAndWalk2(Bird())
    flyAndWalk3(FlyingDog())
}

//: ## exploring types of where clause expression

// ==== colon and protocol
protocol Flier1 {
    associatedtype Other
}
struct Bird1: Flier1{
    typealias Other = String
}
struct Insect: Flier1 {
    typealias Other = Bird1
}
func flockTogether<T: Flier1 where T.Other: Equatable> (f: T) { }
do {
    flockTogether(Bird1()) // okay
    // flockTogether(Insect()) // nope
}

// ==== colon and class
struct Pig: Flier1 {
    typealias Other = Dog
}
struct Pig2: Flier1 {
    typealias Other = NoisyDog
}
func flockTogether2<T: Flier1 where T.Other: Dog> (f: T) { }
do {
    flockTogether2(Pig()) // okay
    flockTogether2(Pig2()) // okay
}

// ==== equality and protocol
struct Bird3: Flier1 {
    typealias Other = Kiwi
}
struct Insect3: Flier1 {
    typealias Other = Walker
}
func flockTogether3 < T: Flier1 where T.Other == Walker > (f: T) { }
do {
    // flockTogether3(Bird3()) // nope
    flockTogether3(Insect3()) // okay
}

// ==== equality and class
func flockTogether4 < T: Flier1 where T.Other == Dog > (f: T) { }
do {
    flockTogether4(Pig()) // okay
    // flockTogether4(Pig2()) // nope
}

// ==== equality and two associated type chains
struct Bird4: Flier1 {
    typealias Other = String
}
struct Insect4: Flier1 {
    typealias Other = Int
}
func flockTwoTogether < T: Flier1, U: Flier1 where T.Other == U.Other >
    (f1: T, _ f2: U) { }
do {
    flockTwoTogether(Bird4(), Bird4())
    flockTwoTogether(Insect4(), Insect4())
    // flockTwoTogether(Bird4(), Insect4()) // nope
}

//: [Next](@next)
