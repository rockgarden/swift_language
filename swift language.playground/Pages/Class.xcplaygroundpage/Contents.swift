//: [Previous](@previous)

import Foundation
//: # 子类型（Subtypes）和超类型（Supertypes）
class Animal {}

class Cat: Animal {}

do {
    let animal: Animal = Cat() //子类型通常能够替代超类型
    //let cat: Cat = Animal() //Error: cannot convert value of type 'Animal' to specified type 'Cat'

    func animalF() -> Animal {
        return Animal()
    }
    func catF() -> Cat {
        return Cat()
    }

    let returnsAnimal: () -> Animal = catF  //闭包返回子类型
    //let returnsCat: () -> Cat = animalF  //error: cannot convert value of type '() -> Animal' to specified type '() -> Cat'

    func catCatF(inCat: Cat) -> Cat {
        return inCat
    }
    //let animalAnimal: Animal -> Animal = catCatF //error: single argument function types require parentheses
    //let animalAnimal: (Animal) -> Animal = catCatF //error: cannot convert value of type '(Cat) -> Cat' to specified type '(Animal) -> Animal'
    let animalAnimal: (Cat) -> Animal = catCatF
    do {
        let animalAnimal: (Cat) -> Cat = catCatF
    }
}

//: # 重写（Override）方法
class Person {
    func purchaseAnimal() -> Animal {
        return Animal()
    }
    func pet(animal: Animal) {}
}

class CrazyCatLady: Person {
    /// Animal -> Cat 这破坏了 Liskov 替换原则：此时的 CrazyCatLady 并不能在任意的地方替代 Person 的使用。
    override func purchaseAnimal() -> Cat {
        return Cat()
    }
    /// 子类型用于重写方法的参数类型是不正确的，事实上，重写方法时你需要超类型（Supertype）。举一个例子，假设 Animal 是 Thing 的子类，那么当我们重写 pet 方法时，参数类型变为 Thing。
}
//: Liskov 替换原则被用于指导何时该使用子类。简明扼要的来说，它指出任何子类的实例总是能够替代父类的实例。
//: 函数的返回值可以换成原类型的子类型，在层级上降了一级；反之函数的参数可以换成原类型的超类型，在层级上升了一级。

http://swift.gg/2015/12/24/friday-qa-2015-11-20-covariance-and-contravariance/
http://swift.gg/2016/10/10/swift-associated-types/

//: [Next](@next)
