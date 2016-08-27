//: [Previous](@previous)

//: # Type Alias 类型别名
//: Famous Type Aliasestypealias is a convenient way to refer to another type in a contextual way.
//: ## Famous Type Aliases
typealias Void = ()
typealias NSTimeInterval = Double
typealias AudioResolution = UInt16
AudioResolution.min

//: 简化闭包: 多个函数间相互传递同一个复杂闭包
typealias TripleThreat = (Int, String, Double) -> (Int, String, Double)
func dance(dance: TripleThreat) { }
func act(act: TripleThreat) { }
func sing(sing: TripleThreat) { }

//: [Next](@next)
