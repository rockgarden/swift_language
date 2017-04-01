//: [Previous](@previous)

import UIKit

/*:
 # Deinitialization
 A deinitializer is called immediately before a class instance is deallocated. You write deinitializers with the deinit keyword, similar to how initializers are written with the init keyword. Deinitializers are only available on class types.

 # How Deinitialization Works

 Swift automatically deallocates your instances when they are no longer needed, to free up resources. Swift handles the memory management of instances through automatic reference counting (ARC), as described in Automatic Reference Counting. Typically you don’t need to perform manual cleanup when your instances are deallocated. However, when you are working with your own resources, you might need to perform some additional cleanup yourself. For example, if you create a custom class to open a file and write some data to it, you might need to close the file before the class instance is deallocated.

 Class definitions can have at most one deinitializer per class. The deinitializer does not take any parameters and is written without parentheses: 类定义每个类最多只能有一个deinitializer。取消初始化程序不带任何参数，并且无括号写入：

     deinit { // perform the deinitialization }

 Deinitializers are called automatically, just before instance deallocation takes place. You are not allowed to call a deinitializer yourself. Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end of a subclass deinitializer implementation. Superclass deinitializers are always called, even if a subclass does not provide its own deinitializer.

 Because an instance is not deallocated until after its deinitializer is called, a deinitializer can access all properties of the instance it is called on and can modify its behavior based on those properties (such as looking up the name of a file that needs to be closed). 因为在调用deinitializer之前，实例不会释放，所以deinitializer可以访问所调用的实例的所有属性，并可以根据这些属性修改其行为（例如查找需要关闭的文件的名称）。
 */
/*:
 # Deinitializers in Action

 Here’s an example of a deinitializer in action. This example defines two new types, Bank and Player, for a simple game. The Bank class manages a made-up currency, which can never have more than 10,000 coins in circulation. There can only ever be one Bank in the game, and so the Bank is implemented as a class with type properties and methods to store and manage its current state:
 */
do {
    class Bank {
        static var coinsInBank = 10_000
        static func distribute(coins numberOfCoinsRequested: Int) -> Int {
            let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
            coinsInBank -= numberOfCoinsToVend
            return numberOfCoinsToVend
        }
        static func receive(coins: Int) {
            coinsInBank += coins
        }
    }

    class Player {
        var coinsInPurse: Int
        init(coins: Int) {
            coinsInPurse = Bank.distribute(coins: coins)
        }
        func win(coins: Int) {
            coinsInPurse += Bank.distribute(coins: coins)
        }
        deinit {
            Bank.receive(coins: coinsInPurse)
        }
    }

    var playerOne: Player? = Player(coins: 100)
    print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
    // Prints "A new player has joined the game with 100 coins"
    print("There are now \(Bank.coinsInBank) coins left in the bank")
    // Prints "There are now 9900 coins left in the bank"

    playerOne!.win(coins: 2_000)
    print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
    // Prints "PlayerOne won 2000 coins & now has 2100 coins"
    print("The bank now only has \(Bank.coinsInBank) coins left")
    // Prints "The bank now only has 7900 coins left"

    playerOne = nil
    print("PlayerOne has left the game")
    // Prints "PlayerOne has left the game"
    print("The bank now has \(Bank.coinsInBank) coins")
    // Prints "The bank now has 10000 coins"
}

//: [Next](@next)
