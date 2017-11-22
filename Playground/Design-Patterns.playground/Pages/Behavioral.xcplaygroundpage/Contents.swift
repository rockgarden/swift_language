//: Behavioral |
//: [Creational](Creational) |
//: [Structural](Structural)
/*:
 Behavioral
 ==========
 行为型模式设计到算法和对象间的职责分配，不仅描述对象或类的模式，还描述它们之间的通信方式，刻划了运行时难以跟踪的复杂的控制流，它们将你的注意力从控制流转移到对象间的关系上来。行为型类模式采用继承机制在类间分派行为，例如Template Method 和Interpreter；行为对象模式使用对象复合而不是继承。一些行为对象模式描述了一组相互对等的对象如何相互协作以完成其中任何一个对象都单独无法完成的任务，如Mediator、Chain of Responsibility、Strategy；其它的行为对象模式常将行为封装封装在一个对象中，并将请求指派给它。

 常见行为型模式有11种：CCIIMM（Chain of Responsibility职责链、Command命令、Interpreter解释器、Iterator迭代、Mediator中介者、Memento备忘录），OSSTV（Observer观察者、State状态、Strategy策略、Template Method模版方法、Visitor访问者）。

 >In software engineering, behavioral design patterns are design patterns that identify common communication patterns between objects and realize these patterns. By doing so, these patterns increase flexibility in carrying out this communication.
 >在软件工程中，行为设计模式是识别对象之间常见通信模式的设计模式，并实现这些模式。 通过这样做，这些模式增加了进行此通信的灵活性。
 >**Source:** [wikipedia.org](http://en.wikipedia.org/wiki/Behavioral_pattern)
 */
import Swift
import Foundation
/*:
 🐝 Chain Of Responsibility
 --------------------------
 **责任链模式**
 -------------
 The chain of responsibility pattern is used to process varied requests, each of which may be dealt with by a different handler.

 百度百科：在责任链模式里，很多对象由每一个对象对其下家的引用而连接起来形成一条链。请求在这个链上传递，直到链上的某一个对象决定处理此请求。发出这个请求的客户端并不知道链上的哪一个对象最终处理这个请求，这使得系统可以在不影响客户端的情况下动态地重新组织和分配责任。
 使多个对象都有机会处理请求，从而避免请求的发送者和接收者之间的耦合关系。职责链可简化对象的相互连接，它们仅需保持一个指向后继者的引用，而不需要保持所有候选者的引用，链中对象不用知道链的结构，接受者和发送者都没有对方的明确信息。可以通过在运行时刻动态的增加或修改链来动态的改变处理一个请求的职责；不能保证请求一定被接受，一个请求也可能因链没有被正确配置而得不到处理。

 设计模式分类：行为型模式

 http://www.cnblogs.com/doit8791/archive/2012/05/08/2490989.html
 
 参与者：

 （1）Handler：定义一个实现请求的接口。

 （2）ConcreteHandler：处理它负责的请求，可访问它的后继者；如果可处理请求就处理，否则将请求转发给它的后后继者。

 （3）Client：向链上的具体处理者对象提交请求。

 协作：当客户提交一个请求时，请求沿着链传递直至有一个ConcreteHandler对象负责处理它或者到链末。

 ### Example:
 */
final class MoneyPile {

    let value: Int
    var quantity: Int
    var nextPile: MoneyPile?

    init(value: Int, quantity: Int, nextPile: MoneyPile?) {
        self.value = value
        self.quantity = quantity
        self.nextPile = nextPile
    }

    func canWithdraw(amount: Int) -> Bool {

        var amount = amount

        func canTakeSomeBill(want: Int) -> Bool {
            return (want / self.value) > 0
        }

        var quantity = self.quantity

        while canTakeSomeBill(want: amount) {
            if quantity == 0 {
                break
            }
            amount -= self.value
            quantity -= 1
        }

        guard amount > 0 else {
            return true
        }

        if let next = self.nextPile {
            return next.canWithdraw(amount: amount)
        }

        return false
    }
}

final class ATM {
    private var hundred: MoneyPile
    private var fifty: MoneyPile
    private var twenty: MoneyPile
    private var ten: MoneyPile

    private var startPile: MoneyPile {
        return self.hundred
    }

    init(hundred: MoneyPile,
         fifty: MoneyPile,
         twenty: MoneyPile,
         ten: MoneyPile) {

        self.hundred = hundred
        self.fifty = fifty
        self.twenty = twenty
        self.ten = ten
    }

    func canWithdraw(amount: Int) -> String {
        return "Can withdraw: \(self.startPile.canWithdraw(amount: amount))"
    }
}
/*:
 ### Usage
 */
// Create piles of money and link them together 10 < 20 < 50 < 100.**
let ten = MoneyPile(value: 10, quantity: 6, nextPile: nil)
let twenty = MoneyPile(value: 20, quantity: 2, nextPile: ten)
let fifty = MoneyPile(value: 50, quantity: 2, nextPile: twenty)
let hundred = MoneyPile(value: 100, quantity: 1, nextPile: fifty)

// Build ATM.
var atm = ATM(hundred: hundred, fifty: fifty, twenty: twenty, ten: ten)
atm.canWithdraw(amount: 310) // Cannot because ATM has only 300
atm.canWithdraw(amount: 100) // Can withdraw - 1x100
atm.canWithdraw(amount: 165) // Cannot withdraw because ATM doesn't has bill with value of 5
atm.canWithdraw(amount: 30)  // Can withdraw - 1x20, 2x10
/*:
 >**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Chain-Of-Responsibility)
 */
/*:
 👫 Command
 -----------
 **命令模式**
 -----------

 The command pattern is used to express a request, including the call to be made and all of its required parameters, in a command object. The command may then be executed immediately or held for later use.
在软件系统中，“行为请求者”与“行为实现者”通常呈现一种“紧耦合”。但在某些场合，比如要对行为进行“记录、撤销/重做、事务”等处理，这种无法抵御变化的紧耦合是不合适的。在这种情况下，如何将“行为请求者”与“行为实现者”解耦？将一组行为抽象为对象，实现二者之间的松耦合。这就是命令模式（Command Pattern）。

 ### 模式结构
 Command：
 定义命令的接口，声明执行的方法。
 ConcreteCommand：
 命令接口实现对象，是“虚”的实现；通常会持有接收者，并调用接收者的功能来完成命令要执行的操作。
 Receiver：
 接收者，真正执行命令的对象。任何类都可能成为一个接收者，只要它能够实现命令要求实现的相应功能。
 Invoker：
 要求命令对象执行请求，通常会持有命令对象，可以持有很多的命令对象。这个是客户端真正触发命令并要求命令执行相应操作的地方，也就是说相当于使用命令对象的入口。
 Client：
 创建具体的命令对象，并且设置命令对象的接收者。注意这个不是我们常规意义上的客户端，而是在组装命令对象和接收者，或许，把这个Client称为装配者会更好理解，因为真正使用命令的客户端是从Invoker来触发执行。

 ### 模式协作
 1. Client创建一个ConcreteCommand对象并指定他的Receiver对象
 2. 某个Invoker对象存储该ConcreteCommand对象
 3. 该Invoker通过调用Command对象的Execute操作来提交一个请求。若该命令是可撤销的，ConcreteCommand就在执行Execute操作之前存储当前状态以用于取消该命令
 4. ConcreteCommand对象对调用它的Receiver的一些操作以执行该请求

 ### 模式分析
 1.命令模式的本质是对命令进行封装，将发出命令的责任和执行命令的责任分割开。
 2.每一个命令都是一个操作：请求的一方发出请求，要求执行一个操作；接收的一方收到请求，并执行操作。
 3.命令模式允许请求的一方和接收的一方独立开来，使得请求的一方不必知道接收请求的一方的接口，更不必知道请求是怎么被接收，以及操作是否被执行、何时被执行，以及是怎么被执行的。
 4.命令模式使请求本身成为一个对象，这个对象和其他对象一样可以被存储和传递。
 5.命令模式的关键在于引入了抽象命令接口，且发送者针对抽象命令接口编程，只有实现了抽象命令接口的具体命令才能与接收者相关联。

 ### Example:
 */
protocol DoorCommand {
    func execute() -> String
}

class OpenCommand : DoorCommand {
    let doors:String

    required init(doors: String) {
        self.doors = doors
    }

    func execute() -> String {
        return "Opened \(doors)"
    }
}

class CloseCommand : DoorCommand {
    let doors:String

    required init(doors: String) {
        self.doors = doors
    }

    func execute() -> String {
        return "Closed \(doors)"
    }
}

class HAL9000DoorsOperations {
    let openCommand: DoorCommand
    let closeCommand: DoorCommand

    init(doors: String) {
        self.openCommand = OpenCommand(doors:doors)
        self.closeCommand = CloseCommand(doors:doors)
    }

    func close() -> String {
        return closeCommand.execute()
    }

    func open() -> String {
        return openCommand.execute()
    }
}
/*:
 ### Usage:
 */
let podBayDoors = "Pod Bay Doors"
let doorModule = HAL9000DoorsOperations(doors:podBayDoors)

doorModule.open()
doorModule.close()

/*:
 🎶 Interpreter
 --------------
 ## 解释器

 The interpreter pattern is used to evaluate sentences in a language.
 Interpreter(解释器)模式是一种特殊的设计模式，它建立一个解释器（Interpreter），对于特定的计算机程序设计语言，用来解释预先定义的文法。简单地说，Interpreter模式是一种简单的语法解释器构架。

 ### Example
 */

protocol IntegerExpression {
    func evaluate(_ context: IntegerContext) -> Int
    func replace(character: Character, integerExpression: IntegerExpression) -> IntegerExpression
    func copied() -> IntegerExpression
}

final class IntegerContext {
    private var data: [Character:Int] = [:]

    func lookup(name: Character) -> Int {
        return self.data[name]!
    }

    func assign(expression: IntegerVariableExpression, value: Int) {
        self.data[expression.name] = value
    }
}

final class IntegerVariableExpression: IntegerExpression {
    let name: Character

    init(name: Character) {
        self.name = name
    }

    func evaluate(_ context: IntegerContext) -> Int {
        return context.lookup(name: self.name)
    }

    func replace(character name: Character, integerExpression: IntegerExpression) -> IntegerExpression {
        if name == self.name {
            return integerExpression.copied()
        } else {
            return IntegerVariableExpression(name: self.name)
        }
    }

    func copied() -> IntegerExpression {
        return IntegerVariableExpression(name: self.name)
    }
}

final class AddExpression: IntegerExpression {
    private var operand1: IntegerExpression
    private var operand2: IntegerExpression

    init(op1: IntegerExpression, op2: IntegerExpression) {
        self.operand1 = op1
        self.operand2 = op2
    }

    func evaluate(_ context: IntegerContext) -> Int {
        return self.operand1.evaluate(context) + self.operand2.evaluate(context)
    }

    func replace(character: Character, integerExpression: IntegerExpression) -> IntegerExpression {
        return AddExpression(op1: operand1.replace(character: character, integerExpression: integerExpression),
                             op2: operand2.replace(character: character, integerExpression: integerExpression))
    }

    func copied() -> IntegerExpression {
        return AddExpression(op1: self.operand1, op2: self.operand2)
    }
}
/*:
 ### Usage
 */
var context = IntegerContext()

var a = IntegerVariableExpression(name: "A")
var b = IntegerVariableExpression(name: "B")
var c = IntegerVariableExpression(name: "C")

var expression = AddExpression(op1: a, op2: AddExpression(op1: b, op2: c)) // a + (b + c)

context.assign(expression: a, value: 2)
context.assign(expression: b, value: 1)
context.assign(expression: c, value: 3)

var result = expression.evaluate(context)
/*:
 >**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Interpreter)
 */
/*:
 🍫 Iterator
 -----------
 ## 迭代器模式
 The iterator pattern is used to provide a standard interface for traversing a collection of items in an aggregate object without the need to understand its underlying structure.

 定义为：提供一种方法访问一个容器（container）对象中各个元素，而又不需暴露该对象的内部细节。 从定义可见，迭代器模式是为容器而生。很明显，对容器对象的访问必然涉及到遍历算法。你可以一股脑的将遍历方法塞到容器对象中去；或者根本不去提供什么遍历算法，让使用容器的人自己去实现去吧。这两种情况好像都能够解决问题。

 https://en.wikipedia.org/wiki/Iterator_pattern

 迭代器模式由以下角色组成：
 1) 迭代器角色（Iterator）：迭代器角色负责定义访问和遍历元素的接口。
 2) 具体迭代器角色（Concrete Iterator）：具体迭代器角色要实现迭代器接口，并要记录遍历中的当前位置。
 3) 容器角色（Container）：容器角色负责提供创建具体迭代器角色的接口。
 4) 具体容器角色（Concrete Container）：具体容器角色实现创建具体迭代器角色的接口——这个具体迭代器角色与该容器的结构相关。

 从结构上可以看出，迭代器模式在客户与容器之间加入了迭代器角色。迭代器角色的加入，就可以很好的避免容器内部细节的暴露，而且也使得设计符合“单一职责原则”。
 注意，在迭代器模式中，具体迭代器角色和具体容器角色是耦合在一起的——遍历算法是与容器的内部细节紧密相关的。为了使客户程序从与具体迭代器角色耦合的困境中脱离出来，避免具体迭代器角色的更换给客户程序带来的修改，迭代器模式抽象了具体迭代器角色，使得客户程序更具一般性和重用性。这被称为多态迭代。

 ### Example:
 */
struct Novella {
    let name: String
}

struct Novellas {
    let novellas: [Novella]
}

struct NovellasIterator: IteratorProtocol {

    private var current = 0
    private let novellas: [Novella]

    init(novellas: [Novella]) {
        self.novellas = novellas
    }

    mutating func next() -> Novella? {
        defer { current += 1 }
        return novellas.count > current ? novellas[current] : nil
    }
}

extension Novellas: Sequence {
    func makeIterator() -> NovellasIterator {
        return NovellasIterator(novellas: novellas)
    }
}
/*:
 ### Usage
 */
let greatNovellas = Novellas(novellas: [Novella(name: "The Mist")] )

for novella in greatNovellas {
    print("I've read: \(novella)")
}
/*:
 💐 Mediator
 -----------
 ## 调停者模式

 The mediator pattern is used to reduce coupling between classes that communicate with each other. Instead of classes communicating directly, and thus requiring knowledge of their implementation, the classes send messages via a mediator object.

 https://en.wikipedia.org/wiki/Mediator_pattern

 ### Example
 */
struct Programmer {

    let name: String

    init(name: String) {
        self.name = name
    }

    func receive(message: String) {
        print("\(name) received: \(message)")
    }
}

protocol MessageSending {
    func send(message: String)
}

final class MessageMediator: MessageSending {

    private var recipients: [Programmer] = []

    func add(recipient: Programmer) {
        recipients.append(recipient)
    }

    func send(message: String) {
        for recipient in recipients {
            recipient.receive(message: message)
        }
    }
}
/*:
 ### Usage
 */
func spamMonster(message: String, worker: MessageSending) {
    worker.send(message: message)
}

let messagesMediator = MessageMediator()

let user0 = Programmer(name: "Linus Torvalds")
let user1 = Programmer(name: "Avadis 'Avie' Tevanian")
messagesMediator.add(recipient: user0)
messagesMediator.add(recipient: user1)

spamMonster(message: "I'd Like to Add you to My Professional Network", worker: messagesMediator)
/*:
 >**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Mediator)
 */
/*:
 💾 Memento
 ----------

 The memento pattern is used to capture the current state of an object and store it in such a manner that it can be restored at a later time without breaking the rules of encapsulation.

 ### Example
 */
typealias Memento = NSDictionary
/*:
 Originator
 */
protocol MementoConvertible {
    var memento: Memento { get }
    init?(memento: Memento)
}

struct GameState: MementoConvertible {

    private struct Keys {
        static let chapter = "com.valve.halflife.chapter"
        static let weapon = "com.valve.halflife.weapon"
    }

    var chapter: String
    var weapon: String

    init(chapter: String, weapon: String) {
        self.chapter = chapter
        self.weapon = weapon
    }

    init?(memento: Memento) {
        guard let mementoChapter = memento[Keys.chapter] as? String,
            let mementoWeapon = memento[Keys.weapon] as? String else {
                return nil
        }

        chapter = mementoChapter
        weapon = mementoWeapon
    }

    var memento: Memento {
        return [ Keys.chapter: chapter, Keys.weapon: weapon ]
    }
}
/*:
 Caretaker
 */
enum CheckPoint {
    static func save(_ state: MementoConvertible, saveName: String) {
        let defaults = UserDefaults.standard
        defaults.set(state.memento, forKey: saveName)
        defaults.synchronize()
    }

    static func restore(saveName: String) -> Memento? {
        let defaults = UserDefaults.standard

        return defaults.object(forKey: saveName) as? Memento
    }
}
/*:
 ### Usage
 */
var gameState = GameState(chapter: "Black Mesa Inbound", weapon: "Crowbar")

gameState.chapter = "Anomalous Materials"
gameState.weapon = "Glock 17"
CheckPoint.save(gameState, saveName: "gameState1")

gameState.chapter = "Unforeseen Consequences"
gameState.weapon = "MP5"
CheckPoint.save(gameState, saveName: "gameState2")

gameState.chapter = "Office Complex"
gameState.weapon = "Crossbow"
CheckPoint.save(gameState, saveName: "gameState3")

if let memento = CheckPoint.restore(saveName: "gameState1") {
    let finalState = GameState(memento: memento)
    dump(finalState)
}
/*:
 👓 Observer
 -----------

 The observer pattern is used to allow an object to publish changes to its state.
 Other objects subscribe to be immediately notified of any changes.

 ### Example
 */
protocol PropertyObserver : class {
    func willChange(propertyName: String, newPropertyValue: Any?)
    func didChange(propertyName: String, oldPropertyValue: Any?)
}

final class TestChambers {

    weak var observer:PropertyObserver?

    private let testChamberNumberName = "testChamberNumber"

    var testChamberNumber: Int = 0 {
        willSet(newValue) {
            observer?.willChange(propertyName: testChamberNumberName, newPropertyValue: newValue)
        }
        didSet {
            observer?.didChange(propertyName: testChamberNumberName, oldPropertyValue: oldValue)
        }
    }
}

final class Observer : PropertyObserver {
    func willChange(propertyName: String, newPropertyValue: Any?) {
        if newPropertyValue as? Int == 1 {
            print("Okay. Look. We both said a lot of things that you're going to regret.")
        }
    }

    func didChange(propertyName: String, oldPropertyValue: Any?) {
        if oldPropertyValue as? Int == 0 {
            print("Sorry about the mess. I've really let the place go since you killed me.")
        }
    }
}
/*:
 ### Usage
 */
var observerInstance = Observer()
var testChambers = TestChambers()
testChambers.observer = observerInstance
testChambers.testChamberNumber += 1
/*:
 >**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Observer)
 */
/*:
 🐉 State
 ---------

 The state pattern is used to alter the behaviour of an object as its internal state changes.
 The pattern allows the class for an object to apparently change at run-time.

 ### Example
 */
final class Context {
    private var state: State = UnauthorizedState()

    var isAuthorized: Bool {
        get { return state.isAuthorized(context: self) }
    }

    var userId: String? {
        get { return state.userId(context: self) }
    }

    func changeStateToAuthorized(userId: String) {
        state = AuthorizedState(userId: userId)
    }

    func changeStateToUnauthorized() {
        state = UnauthorizedState()
    }

}

protocol State {
    func isAuthorized(context: Context) -> Bool
    func userId(context: Context) -> String?
}

class UnauthorizedState: State {
    func isAuthorized(context: Context) -> Bool { return false }

    func userId(context: Context) -> String? { return nil }
}

class AuthorizedState: State {
    let userId: String

    init(userId: String) { self.userId = userId }

    func isAuthorized(context: Context) -> Bool { return true }

    func userId(context: Context) -> String? { return userId }
}
/*:
 ### Usage
 */
let userContext = Context()
(userContext.isAuthorized, userContext.userId)
userContext.changeStateToAuthorized(userId: "admin")
(userContext.isAuthorized, userContext.userId) // now logged in as "admin"
userContext.changeStateToUnauthorized()
(userContext.isAuthorized, userContext.userId)
/*:
 >**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-State)
 */
/*:
 💡 Strategy
 -----------

 The strategy pattern is used to create an interchangeable family of algorithms from which the required process is chosen at run-time.

 ### Example
 */
protocol PrintStrategy {
    func print(_ string: String) -> String
}

final class Printer {

    private let strategy: PrintStrategy

    func print(_ string: String) -> String {
        return self.strategy.print(string)
    }

    init(strategy: PrintStrategy) {
        self.strategy = strategy
    }
}

final class UpperCaseStrategy: PrintStrategy {
    func print(_ string: String) -> String {
        return string.uppercased()
    }
}

final class LowerCaseStrategy: PrintStrategy {
    func print(_ string:String) -> String {
        return string.lowercased()
    }
}
/*:
 ### Usage
 */
var lower = Printer(strategy: LowerCaseStrategy())
lower.print("O tempora, o mores!")

var upper = Printer(strategy: UpperCaseStrategy())
upper.print("O tempora, o mores!")
/*:
 >**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Strategy)
 */
/*:
 🏃 Visitor
 ----------

 The visitor pattern is used to separate a relatively complex set of structured data classes from the functionality that may be performed upon the data that they hold.

 ### Example
 */
protocol PlanetVisitor {
    func visit(planet: PlanetAlderaan)
    func visit(planet: PlanetCoruscant)
    func visit(planet: PlanetTatooine)
    func visit(planet: MoonJedah)
}

protocol Planet {
    func accept(visitor: PlanetVisitor)
}

class MoonJedah: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}

class PlanetAlderaan: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}

class PlanetCoruscant: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}

class PlanetTatooine: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}



class NameVisitor: PlanetVisitor {
    var name = ""

    func visit(planet: PlanetAlderaan)  { name = "Alderaan" }
    func visit(planet: PlanetCoruscant) { name = "Coruscant" }
    func visit(planet: PlanetTatooine)  { name = "Tatooine" }
    func visit(planet: MoonJedah)     	{ name = "Jedah" }
}

/*:
 ### Usage
 */
let planets: [Planet] = [PlanetAlderaan(), PlanetCoruscant(), PlanetTatooine(), MoonJedah()]

let names = planets.map { (planet: Planet) -> String in
    let visitor = NameVisitor()
    planet.accept(visitor: visitor)
    return visitor.name
}

names
/*:
 >**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Visitor)
 */
