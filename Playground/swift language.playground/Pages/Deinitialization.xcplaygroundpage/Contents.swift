//: [Previous](@previous)

import UIKit

/*:
 # Deinitializers
 Deinitializers are only available on class types.
 Deinitializers are called automatically, just before instance deallocation takes place.
 You are not allowed to call a deinitializer yourself.
 Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer
 is called automatically at the end of a subclass deinitializer implementation.
 Superclass deinitializers are always called, even if a subclass does not provide its own deinitializer.
 */
class Bank {
    static var coinsInBank = 10_000
    static func vendCoins(numberOfCoinsToVend: Int) -> Int {
        let numberOfCoinsAllowedToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsAllowedToVend
        return numberOfCoinsAllowedToVend
    }
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    func winCoins(coins: Int) {
        coinsInPurse += Bank.vendCoins(coins)
    }
    deinit {
        Bank.receiveCoins(coinsInPurse)
    }
}
/*:
 An optional variable is used here, because players can leave the game at any point.
 The optional lets you track whether there is currently a player in the game.
 */
var playerOne: Player? = Player(coins: 100)
("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne!.winCoins(2_000)
("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
("The bank now only has \(Bank.coinsInBank) coins left")


playerOne = nil //Just before this happens, its deinitializer is called automatically.
("PlayerOne has left the game")
("The bank now has \(Bank.coinsInBank) coins")


//: [Next](@next)
