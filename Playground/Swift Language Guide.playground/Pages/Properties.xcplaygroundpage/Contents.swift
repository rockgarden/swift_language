//: [Previous](@previous)

/*:
 # Properties
 Properties associate values with a particular class, structure, or enumeration. Stored properties store constant and variable values as part of an instance, whereas computed properties calculate (rather than store) a value. Computed properties are provided by classes, structures, and enumerations. Stored properties are provided only by classes and structures. 属性将值与特定类，结构或枚举相关联。 存储的属性将常量和变量值存储为实例的一部分，而计算的属性计算（而不是存储）值。 计算属性由类，结构和枚举提供。 存储的属性仅由类和结构提供。

 Stored and computed properties are usually associated with instances of a particular type. However, properties can also be associated with the type itself. Such properties are known as type properties. 存储和计算的属性通常与特定类型的实例相关联。 然而，属性也可以与类型本身相关联。 这些属性被称为类型属性。

 In addition, you can define property observers to monitor changes in a property’s value, which you can respond to with custom actions. Property observers can be added to stored properties you define yourself, and also to properties that a subclass inherits from its superclass.

 */

/*:
 # Property Observers

 Property observers observe and respond to changes in a property’s value. Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.

 You can add property observers to any stored properties you define, except for lazy stored properties. You can also add property observers to any inherited property (whether stored or computed) by overriding the property within a subclass. You don’t need to define property observers for nonoverridden computed properties, because you can observe and respond to changes to their value in the computed property’s setter. Property overriding is described in Overriding.

 You have the option to define either or both of these observers on a property:

 - willSet is called just before the value is stored. 将在存储值之前调用willSet。
 - didSet is called immediately after the new value is stored. 在存储新值后立即调用didSet。
 If you implement a willSet observer, it’s passed the new property value as a constant parameter. You can specify a name for this parameter as part of your willSet implementation. If you don’t write the parameter name and parentheses within your implementation, the parameter is made available with a default parameter name of newValue. 如果你实现了一个willSet观察者，它将新的属性值作为一个常量参数传递。您可以为该参数指定一个名称作为您的willSet实现的一部分。如果您不在实现中写入参数名称和括号，则该参数将使用默认参数名称newValue。

 Similarly, if you implement a didSet observer, it’s passed a constant parameter containing the old property value. You can name the parameter or use the default parameter name of oldValue. If you assign a value to a property within its own didSet observer, the new value that you assign replaces the one that was just set. 类似地，如果您实现了一个didSet观察器，它将传递一个包含旧属性值的常量参数。您可以命名参数或使用默认参数名称oldValue。如果您为自己的didSet观察者中的属性分配了一个值，则您分配的新值将替换刚刚设置的值。

 - NOTE:
 The willSet and didSet observers of superclass properties are called when a property is set in a subclass initializer, after the superclass initializer has been called. They are not called while a class is setting its own properties, before the superclass initializer has been called. 在调用超类初始化程序之后，在子类初始化器中设置属性时，将调用willSet和didSet的超类属性。一个类在调用超类初始化器之前设置自己的属性时不会调用它们。

 For more information about initializer delegation, see Initializer Delegation for Value Types https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID215 and Initializer Delegation for Class Types https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID219.
 */
do {
    class StepCounter {
        var totalSteps: Int = 0 {
            willSet(newTotalSteps) {
                print("About to set totalSteps to \(newTotalSteps)")
            }
            didSet {
                if totalSteps > oldValue  {
                    print("Added \(totalSteps - oldValue) steps")
                }
            }
        }
    }
    let stepCounter = StepCounter()
    stepCounter.totalSteps = 200
    // About to set totalSteps to 200
    // Added 200 steps
    stepCounter.totalSteps = 360
    // About to set totalSteps to 360
    // Added 160 steps
    stepCounter.totalSteps = 896
    // About to set totalSteps to 896
    // Added 536 steps
}
/*:
 - NOTE:
 If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called. This is because of the copy-in copy-out memory model for in-out parameters: The value is always written back to the property at the end of the function. For a detailed discussion of the behavior of in-out parameters, see In-Out Parameters https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Declarations.html#//apple_ref/doc/uid/TP40014097-CH34-ID545. 如果将具有观察者的属性作为in-out参数传递给函数，则将始终调用willSet和didSet观察器。 这是因为in-out参数的copy-in copy-out内存模型：该值始终写回函数末尾的属性。 有关in-out参数的行为的详细讨论，请参阅In-Out参数。
 */

//: [Next](@next)
