//: [Previous](@previous)

//: # 协变（Convariance）和逆变（Contravariance）
/*:
 - 协变（Convariance）指可接受子类型。重写只读的属性是「协变的」。
 - 逆变（Contravariance）指可接受超类型。重写方法中的参数是「逆变的」。
 - 不变（Invariance）指既不接受子类型，又不接受超类型。Swift 中泛型是「不变的」。
 - 双向协变（Bivariate）指既接受子类型，又接受超类型。我想不到在 Objective-C 或 Swift 中的任何例子。
 */
import Foundation
import UIKit

//: ## 子类型（Subtypes）和超类型（Supertypes）
class Biology {}
class Animal: Biology {}
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

//: ## 重写（Override）方法
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

    //override func pet(animal: Cat) {} // error: method does not override any method from its superclass
    /// 子类型用于重写方法的参数类型是不正确的，事实上，重写方法时你需要超类型（Supertype）。举一个例子，Animal 是 Biology 的子类，那么当我们重写 pet 方法时，参数类型变为 Biology。
    override func pet(animal: Biology) {}
}

do {
    let person: Person = CrazyCatLady()
    let animal: Animal = person.purchaseAnimal()
    person.pet(animal: animal)
}
//: Liskov替换原则：被用于指导何时该使用子类。简明扼要的来说，它指出任何子类的实例总是能够替代父类的实例。https://en.wikipedia.org/wiki/Liskov_substitution_principle
//: 函数的返回值可以换成原类型的子类型，在层级上降了一级；反之函数的参数可以换成原类型的超类型，在层级上升了一级。

//: ## 单独的函数（Standalone functions）
//: 事实上，你可以把函数想象成是非常小的（mini-objects）、只有一个方法的对象，同样适用Liskov替换原则。
//: 当你有两个不同的对象类型时，怎么做才能够让这两个对象也遵循我们的原则呢？只有当原对象类型是后者类型的子类型就可以了。那什么时候函数是另一个函数的子类型呢？正如上面所见，当前者的参数是后者的超类型并且返回值是后者的子类型即可。
//: Robustness原则：一个函数若是另外一个函数的子类型，那么它的参数是原函数参数的超类型，返回值是原函数返回值的子类型。http://www.wikiwand.com/en/Robustness_principle
//: let f1: A -> B = ...   let f1: Animal -> Animal
//: let f2: C -> D = f1    let f2: Cat -> Thing = f1

//: 属性（Property）
//: 只读的属性：子类的属性必须是父类属性的子类型。只读的属性本质上是一个不接收参数而返回成员值的函数，所以上述的规则依旧适用。
//: 可读可写的属性：子类的属性必须和父类的属性类型相同。一个可读可写的属性其实由一对函数组成。Getter 是一个不接收参数而返回成员值的函数，Setter 则是一个需要传入一个参数但无需返回值的函数。
do {
    var animal: Animal
    // 这等价于：
    func getAnimal() -> Animal {
        return Animal()
    }
    func setAnimal(animal: Animal) {}
}
//: 'override' can only be specified on class members
//: Func的参数和返回值的类型是固定的，所以都不能被改变。

//: ## 泛型（Generics）
/*:
 那如果是泛型呢？给定泛型类型的参数，什么时候又是正确的呢？
 - let var1: SomeType<A> = ...
 - let var2: SomeType<B> = var1
 
 理论上来说，这要看泛型参数是如何使用的。一个泛型类型参数本身并不做什么事情，但是它会被用作于属性的类型、函数方法的参数类型和返回类型。
 
 如果泛型参数仅仅被用作函数返回值的类型和只读属性身上，那么 B 需要是 A 的超类型：
 - let var1: SomeType<Cat> = ...
 - let var2: SomeType<Animal> = var1
 
 如果泛型参数仅被用作于函数方法的参数类型，那么 B 需要是 A 的子类型：
 - let var1: SomeType<Animal> = ...
 - let var2: SomeType<Cat> = var1
 
 如果泛型参数在上述提到的两方面都被使用了，那么当且仅当 A 和 B 是相同类型的时候才是有效的。这也同样适用于当泛型参数作为可读可写属性的情况。
 
 这就是理论部分，看上去有些复杂但其实很简短。与此同时，Swift 寻求到了其简便的解决之道。对于两个需要相互匹配的泛型类型，Swift 要求它们的泛型参数的类型也需要相同，可理解为 Swift 中的泛型的确是「不变的（Invariance）」；子类型和超类型都是不被允许的，尽管理论上可行。
 
 Objective-C 事实上比 Swift 更好一些。一个在 Objective-C 中的泛型参数可以在声明时增加 __covariant 关键字来表示它能够接受子类型，而在声明时增加 __contravariant 关键字来表示它能够接受超类型。这在 NSArray 和其他的类的接口中有所体现：
 - @interface NSArray<__covariant ObjectType> : NSObject ...
 */
//: Swift 标准库中的 Collection - Array 类型通常情况下是「协变的（Convariance）」
do {
    class Thing<T> { // 亦可以使用结构体 struct 声明
        var thing: T
        init(_ thing: T) { self.thing = thing }
    }
    var foo: Thing<UIView> = Thing(UIView())
    var bar: Thing<UIButton> = Thing(UIButton())
    //foo = bar // 报错：error: cannot assign value of type 'Thing<UIButton>' to type 'Thing<UIView>'
    
    // Array 则不会报错
    var views: Array<UIView> = [UIView()]
    var buttons: Array<UIButton> = [UIButton()]
    views = buttons
}

//: ## 协议 Protocol
/*:
 Swift 中的 Protocol 不支持这里的类型改变。如果某个协议是继承自另外一个协议而且尝试着「重写」父协议的方法，Swift 会把它当做是另外一个方法。举个例子：
 */
protocol SuperP {
    func f(animal: Animal) -> Animal
}
protocol SubP1: SuperP {
    func f(thing: Biology) -> Cat
}
protocol SubP2: SuperP {
    func f(cat: Cat) -> Biology
}
class ImplementsSubP1: SubP1 {
    func f(animal: Animal) -> Animal {return Animal()}
    func f(thing: Biology) -> Cat {return Cat()}
}
//class ImplementsSubP2: SubP2 {func f(cat: Cat) -> Biology {return Biology()}} //error: type 'ImplementsSubP2' does not conform to protocol 'SuperP'
class ImplementsSubP2: SubP2 {
    func f(animal: Animal) -> Animal {return Animal()}
    func f(cat: Cat) -> Biology {return Biology()}
}

//http://swift.gg/2016/10/10/swift-associated-types/

//: [Next](@next)
