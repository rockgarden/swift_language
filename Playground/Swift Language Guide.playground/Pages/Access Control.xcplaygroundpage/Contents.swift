//: [Previous](@previous)

import UIKit

/*:
 # Access Control
 
 Access control restricts access to parts of your code from code in other source files and modules. This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used. 访问控制限制从其他源文件和模块中的代码访问代码的部分。此功能使您可以隐藏代码的实现细节，并指定可以访问和使用该代码的首选接口。

 You can assign specific access levels to individual types (classes, structures, and enumerations), as well as to properties, methods, initializers, and subscripts belonging to those types. Protocols can be restricted to a certain context, as can global constants, variables, and functions. 您可以为各种类型（类，结构和枚举）以及属于这些类型的属性，方法，初始值和下标分配特定的访问级别。协议可以被限制在特定的上下文中，全局常量，变量和函数也是如此。

 In addition to offering various levels of access control, Swift reduces the need to specify explicit access control levels by providing default access levels for typical scenarios. Indeed, if you are writing a single-target app, you may not need to specify explicit access control levels at all. 除了提供各种级别的访问控制外，Swift还减少了为典型场景提供默认访问级别来指定显式访问控制级别的需求。实际上，如果您正在编写单一目标应用程序，则可能根本不需要指定显式的访问控制级别。

 - NOTE:
 The various aspects of your code that can have access control applied to them (properties, types, functions, and so on) are referred to as “entities” in the sections below, for brevity.
 */

/*:
 # Modules and Source Files
 Swift’s access control model is based on the concept of modules and source files. Swift的访问控制模型基于模块和源文件的概念。

 A module is a single unit of code distribution—a framework or application that is built and shipped as a single unit and that can be imported by another module with Swift’s import keyword.

 Each build target (such as an app bundle or framework) in Xcode is treated as a separate module in Swift. If you group together aspects of your app’s code as a stand-alone framework—perhaps to encapsulate and reuse that code across multiple applications—then everything you define within that framework will be part of a separate module when it is imported and used within an app, or when it is used within another framework.

 A source file is a single Swift source code file within a module (in effect, a single file within an app or framework). Although it is common to define individual types in separate source files, a single source file can contain definitions for multiple types, functions, and so on.
 */

/*:
 # Access Levels

 Swift provides five different access levels for entities within your code. These access levels are relative to the source file in which an entity is defined, and also relative to the module that source file belongs to.

 Open access and public access enable entities to be used within any source file from their defining module, and also in a source file from another module that imports the defining module. You typically use open or public access when specifying the public interface to a framework. The difference between open and public access is described below. 开放访问和公共访问使得实体可以在其定义模块的任何源文件中使用，并且还可以在另一个导入定义模块的模块的源文件中使用。指定框架的公共接口时，通常使用公开或公开的访问。开放和公共访问之间的区别如下所述:
 - Internal access enables entities to be used within any source file from their defining module, but not in any source file outside of that module. You typically use internal access when defining an app’s or a framework’s internal structure. 内部访问使实体可以在其定义模块中的任何源文件中使用，但不能在该模块之外的任何源文件中使用。在定义应用程序或框架的内部结构时，通常使用内部访问。
 - File-private access restricts the use of an entity to its own defining source file. Use file-private access to hide the implementation details of a specific piece of functionality when those details are used within an entire file. 文件专用访问将实体的使用限制在其自己的定义源文件中。当在整个文件中使用这些细节时，使用文件专用访问来隐藏特定功能的实现细节。
 - Private access restricts the use of an entity to the enclosing declaration. Use private access to hide the implementation details of a specific piece of functionality when those details are used only within a single declaration. 私有访问将实体的使用限制在封闭声明中。当这些细节仅在单个声明中使用时，使用私有访问来隐藏特定功能的实现细节。
 
 Open access is the highest (least restrictive) access level and private access is the lowest (most restrictive) access level. 开放访问是最高（最少限制）的访问级别，私有访问是最低（最严格的）访问级别。

 Open access applies only to classes and class members, and it differs from public access as follows: 开放访问仅适用于类和类成员，它与公共访问不同如下：

 - Classes with public access, or any more restrictive access level, can be subclassed only within the module where they’re defined. 具有公共访问权限或任何更多限制性访问级别的类可以仅在其定义的模块中进行子类化。
 - Class members with public access, or any more restrictive access level, can be overridden by subclasses only within the module where they’re defined. 具有公共访问或任何更多限制性访问级别的类成员可以仅在它们被定义的模块内的子类覆盖。
 - Open classes can be subclassed within the module where they’re defined, and within any module that imports the module where they’re defined. 开放类可以被子类化，在其定义模块中，并在任何导入模块定义的模块中进行子类化。
 - Open class members can be overridden by subclasses within the module where they’re defined, and within any module that imports the module where they’re defined. 开放类成员可以被模块定义的子类覆盖，并且可以在任何导入模块定义的模块中覆盖。

 Marking a class as open explicitly indicates that you’ve considered the impact of code from other modules using that class as a superclass, and that you’ve designed your class’s code accordingly. 将类标记为open，表示您已经考虑了使用该类作为超类的其他模块的代码的影响，并且相应地设计了类的代码。
 
 权限则依次为：open->public->internal->fileprivate->private
 
 fileprivate
 在原有的swift中的 private其实并不是真正的私有，如果一个变量定义为private，在同一个文件中的其他类依然是可以访问到的。这个场景在使用extension的时候很明显。
 这样带来了两个问题：
 - 当我们标记为private时，意为真的私有还是文件内可共享呢？
 - 当我们如果意图为真正的私有时，必须保证这个类或者结构体在一个单独的文件里。否则可能同文件里其他的代码访问到。
 由此，在swift 3中，新增加了一个 fileprivate来显式的表明，这个元素的访问权限为文件内私有。过去的private对应现在的fileprivate。现在的private则是真正的私有，离开了这个类或者结构体的作用域外面就无法访问。
 
 open
 open则是弥补public语义上的不足。现在的pubic有两层含义：
 - 这个元素可以在其他作用域被访问
 - 这个元素可以在其他作用域被继承或者override
 继承是一件危险的事情。尤其对于一个framework或者module的设计者而言。在自身的module内，类或者属性对于作者而言是清晰的，能否被继承或者override都是可控的。但是对于使用它的人，作者有时会希望传达出这个类或者属性不应该被继承或者修改。这个对应的就是 final。
 final的问题在于在标记之后，在任何地方都不能override。而对于lib的设计者而言，希望得到的是在module内可以被override，在被import到其他地方后其他用户使用的时候不能被override。
 这就是open产生的初衷。通过open和public标记区别一个元素在其他module中是只能被访问还是可以被override。
 
 ## Guiding Principle of Access Levels

 Access levels in Swift follow an overall guiding principle: No entity can be defined in terms of another entity that has a lower (more restrictive) access level.

 For example:

 - A public variable cannot be defined as having an internal, file-private, or private type, because the type might not be available everywhere that the public variable is used. 公共变量不能被定义为具有内部，文件私有或私有类型，因为在使用公共变量的地方，该类型可能不可用。
 - A function cannot have a higher access level than its parameter types and return type, because the function could be used in situations where its constituent types are not available to the surrounding code. 函数不能具有比其参数类型和返回类型更高的访问级别，因为该函数可用于其组成类型不可用于周围代码的情况。
 
 The specific implications of this guiding principle for different aspects of the language are covered in detail below.
 
 ## Default Access Levels

 All entities in your code (with a few specific exceptions, as described later in this chapter) have a default access level of internal if you do not specify an explicit access level yourself. As a result, in many cases you do not need to specify an explicit access level in your code. 您的代码中的所有实体（具有本章后面所述的一些特殊例外）具有内部的默认访问级别，如果您没有自己指定显式访问级别。因此，在许多情况下，您不需要在代码中指定显式的访问级别。

 ## Access Levels for Single-Target Apps 单目标应用的访问级别

 When you write a simple single-target app, the code in your app is typically self-contained within the app and does not need to be made available outside of the app’s module. The default access level of internal already matches this requirement. Therefore, you do not need to specify a custom access level. You may, however, want to mark some parts of your code as file private or private in order to hide their implementation details from other code within the app’s module. 当您编写一个简单的单目标应用程序时，应用程序中的代码通常在应用程序中是独立的，不需要在应用程序模块之外提供。内部的默认访问级别已经符合此要求。因此，您不需要指定自定义访问级别。但是，您可能会将代码的某些部分标记为私有或私有文件，以便将应用程序模块中的其他代码隐藏其实现细节。

 ## Access Levels for Frameworks 框架访问级别

 When you develop a framework, mark the public-facing interface to that framework as open or public so that it can be viewed and accessed by other modules, such as an app that imports the framework. This public-facing interface is the application programming interface (or API) for the framework. 当您开发框架时，将公开面向对象的界面标记为公开或公开，以便其他模块（例如导入框架的应用程序）可以查看和访问框架。这个面向公众的界面是框架的应用程序编程接口（或API）。

 - NOTE:
 Any internal implementation details of your framework can still use the default access level of internal, or can be marked as private or file private if you want to hide them from other parts of the framework’s internal code. You need to mark an entity as open or public only if you want it to become part of your framework’s API. 您的框架的任何内部实现细节仍然可以使用内部的默认访问级别，或者如果要将其隐藏在框架内部代码的其他部分，则可以将其标记为私有或私有的。您只需要将其作为您的框架API的一部分，将其标记为公开或公开。

 ## Access Levels for Unit Test Targets

 When you write an app with a unit test target, the code in your app needs to be made available to that module in order to be tested. By default, only entities marked as open or public are accessible to other modules. However, a unit test target can access any internal entity, if you mark the import declaration for a product module with the @testable attribute and compile that product module with testing enabled.
 */

/*:
 # Access Control Syntax

 Define the access level for an entity by placing one of the open, public, internal, fileprivate, or private modifiers before the entity’s introducer:
*/
public class SomePublicClass {}

internal class SomeInternalClass {}
//class SomeInternalClass {}              // implicitly internal

fileprivate class SomeFilePrivateClass {}

private class SomePrivateClass {}

public var somePublicVariable = 0

internal let someInternalConstant = 0
//let someInternalConstant = 0            // implicitly internal

fileprivate func someFilePrivateFunction() {}

private func somePrivateFunction() {}

/*:
 # Custom Types

 If you want to specify an explicit access level for a custom type, do so at the point that you define the type. The new type can then be used wherever its access level permits. For example, if you define a file-private class, that class can only be used as the type of a property, or as a function parameter or return type, in the source file in which the file-private class is defined. 如果要为自定义类型指定显式访问级别，请在定义类型的位置执行此操作。然后可以在其访问级别允许的任何地方使用新的类型。例如，如果定义了一个file-private类，则该类只能用作定义file-private类的源文件中的属性类型或函数参数或返回类型。

 The access control level of a type also affects the default access level of that type’s members (its properties, methods, initializers, and subscripts). If you define a type’s access level as private or file private, the default access level of its members will also be private or file private. If you define a type’s access level as internal or public (or use the default access level of internal without specifying an access level explicitly), the default access level of the type’s members will be internal. 类型的访问控制级别还会影响该类型成员（其属性，方法，初始化程序和下标）的默认访问级别。如果将类型的访问级别定义为私有或文件私有，则其成员的默认访问级别也将是私有的或文件私有的。如果您将类型的访问级别定义为内部或公共（或使用内部的默认访问级别，而不明确指定访问级别），则类型成员的默认访问级别将是内部的。

 - IMPORTANT:
 A public type defaults to having internal members, not public members. If you want a type member to be public, you must explicitly mark it as such. This requirement ensures that the public-facing API for a type is something you opt in to publishing, and avoids presenting the internal workings of a type as public API by mistake. 公共类型默认为内部成员，而不是公共成员。如果你想要一个类型成员是公开的，你必须明确地标记它。此要求可确保类型的面向公众的API是您选择发布的内容，并避免错误地将类型的内部运行作为公共API呈现。
 */

public class SomePublicClass_CT {                  // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

class SomeInternalClass_CT {                       // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

fileprivate class SomeFilePrivateClass_CT {        // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

private class SomePrivateClass_CT {                // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}

/*:
 ## Tuple Types

 The access level for a tuple type is the most restrictive access level of all types used in that tuple. For example, if you compose a tuple from two different types, one with internal access and one with private access, the access level for that compound tuple type will be private. 元组类型的访问级别是该元组中使用的所有类型的最严格的访问级别。 例如，如果您从两种不同的类型组成一个元组，一个具有内部访问权限，另一个使用私有访问权限，该复合元组类型的访问级别将是私有的。

 - NOTE:
 Tuple types do not have a standalone definition in the way that classes, structures, enumerations, and functions do. A tuple type’s access level is deduced automatically when the tuple type is used, and cannot be specified explicitly. 元组类型不具有类，结构，枚举和函数的独立定义。 元组类型的访问级别是在使用元组类型时自动推出的，不能被明确指定。
 */


/*:
 ## Function Types

 The access level for a function type is calculated as the most restrictive access level of the function’s parameter types and return type. You must specify the access level explicitly as part of the function’s definition if the function’s calculated access level does not match the contextual default. 函数类型的访问级别被计算为函数参数类型和返回类型的最严格的访问级别。如果函数的计算访问级别与上下文默认值不匹配，则必须将该访问级别明确指定为函数定义的一部分。

 The example below defines a global function called someFunction(), without providing a specific access-level modifier for the function itself. You might expect this function to have the default access level of “internal”, but this is not the case. In fact, someFunction() will not compile as written below:

    func someFunction() -> (SomeInternalClass, SomePrivateClass) {
        // function implementation goes here
    }
 The function’s return type is a tuple type composed from two of the custom classes defined above in Custom Types. One of these classes was defined as “internal”, and the other was defined as “private”. Therefore, the overall access level of the compound tuple type is “private” (the minimum access level of the tuple’s constituent types).

 Because the function’s return type is private, you must mark the function’s overall access level with the private modifier for the function declaration to be valid:

    private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
        // function implementation goes here
    }
 It is not valid to mark the definition of someFunction() with the public or internal modifiers, or to use the default setting of internal, because public or internal users of the function might not have appropriate access to the private class used in the function’s return type.
 
 ## Enumeration Types

 The individual cases of an enumeration automatically receive the same access level as the enumeration they belong to. You cannot specify a different access level for individual enumeration cases. 枚举的个别情况自动获得与其所属的枚举相同的访问级别。 您不能为单个枚举情况指定不同的访问级别。

 In the example below, the CompassPoint enumeration has an explicit access level of “public”. The enumeration cases north, south, east, and west therefore also have an access level of “public”:

    public enum CompassPoint {
        case north
        case south
        case east
        case west
    }

 ### Raw Values and Associated Values

 The types used for any raw values or associated values in an enumeration definition must have an access level at least as high as the enumeration’s access level. You cannot use a private type as the raw-value type of an enumeration with an internal access level, for example. 在枚举定义中用于任何原始值或关联值的类型必须具有至少与枚举的访问级别一样高的访问级别。 例如，您不能使用私有类型作为具有内部访问级别的枚举的原始值类型。

 ## Nested Types

 Nested types defined within a private type have an automatic access level of private. Nested types defined within a file-private type have an automatic access level of file private. Nested types defined within a public type or an internal type have an automatic access level of internal. If you want a nested type within a public type to be publicly available, you must explicitly declare the nested type as public. 在私有类型中定义的嵌套类型具有私有的自动访问级别。 在文件 - 私有类型中定义的嵌套类型具有文件私有的自动访问级别。 在公共类型或内部类型中定义的嵌套类型具有内部自动访问级别。 如果您希望公共类型中的嵌套类型可以公开使用，则必须将该嵌套类型显式声明为public。
 */


/*:
 # Subclassing

 You can subclass any class that can be accessed in the current access context. A subclass cannot have a higher access level than its superclass—for example, you cannot write a public subclass of an internal superclass. 您可以对当前访问上下文中可以访问的任何类进行子类化。子类不能具有比其超类更高的访问级别，例如，您不能写个内部超类的公共子类。

 In addition, you can override any class member (method, property, initializer, or subscript) that is visible in a certain access context.

 An override can make an inherited class member more accessible than its superclass version. In the example below, class A is a public class with a file-private method called someMethod(). Class B is a subclass of A, with a reduced access level of “internal”. Nonetheless, class B provides an override of someMethod() with an access level of “internal”, which is higher than the original implementation of someMethod():

    public class A {
        fileprivate func someMethod() {}
    }

    internal class B: A {
        override internal func someMethod() {}
    }

 It is even valid for a subclass member to call a superclass member that has lower access permissions than the subclass member, as long as the call to the superclass’s member takes place within an allowed access level context (that is, within the same source file as the superclass for a file-private member call, or within the same module as the superclass for an internal member call):

    public class A {
        fileprivate func someMethod() {}
    }

    internal class B: A {
        override internal func someMethod() {
            super.someMethod()
        }
    }

 Because superclass A and subclass B are defined in the same source file, it is valid for the B implementation of someMethod() to call super.someMethod().
 */

/*:
 # Constants, Variables, Properties, and Subscripts 常数，变量，属性和下标

 A constant, variable, or property cannot be more public than its type. It is not valid to write a public property with a private type, for example. Similarly, a subscript cannot be more public than either its index type or return type. 常数，变量或属性不能比其类型更公开。例如，写私有类型的公共属性是无效的。类似地，下标不能比其索引类型或返回类型更公开。

 If a constant, variable, property, or subscript makes use of a private type, the constant, variable, property, or subscript must also be marked as private:

    private var privateInstance = SomePrivateClass()
 
 ## Getters and Setters

 Getters and setters for constants, variables, properties, and subscripts automatically receive the same access level as the constant, variable, property, or subscript they belong to. 常量，变量，属性和下标的Getters和setter自动接收与它们所属的常量，变量，属性或下标相同的访问级别。

 You can give a setter a lower access level than its corresponding getter, to restrict the read-write scope of that variable, property, or subscript. You assign a lower access level by writing fileprivate(set), private(set), or internal(set) before the var or subscript introducer. 您可以给设置者比其相应的getter低的访问级别，以限制该变量，属性或下标的读写范围。您可以通过在var或下标引导器之前编写fileprivate（set），private（set）或internal（set）来分配较低的访问级别。

 - NOTE:

 This rule applies to stored properties as well as computed properties. Even though you do not write an explicit getter and setter for a stored property, Swift still synthesizes an implicit getter and setter for you to provide access to the stored property’s backing storage. Use fileprivate(set), private(set), and internal(set) to change the access level of this synthesized setter in exactly the same way as for an explicit setter in a computed property.

 The example below defines a structure called TrackedString, which keeps track of the number of times a string property is modified:

 */
do {
    struct TrackedString {
        /// Although you can query the current value of the numberOfEdits property from within another source file, you cannot modify the property from another source file. This restriction protects the implementation details of the TrackedString edit-tracking functionality, while still providing convenient access to an aspect of that functionality. 虽然可以从另一个源文件中查询numberOfEdits属性的当前值，但是您不能从另一个源文件修改该属性。此限制保护了TrackedString编辑跟踪功能的实现细节，同时仍然可以方便地访问该功能的一个方面。
        private(set) var numberOfEdits = 0
        var value: String = "" {
            didSet {
                numberOfEdits += 1
            }
        }
    }

    var stringToEdit = TrackedString()
    stringToEdit.value = "This string will be tracked."
    stringToEdit.value += " This edit will increment numberOfEdits."
    stringToEdit.value += " So will this one."
    print("The number of edits is \(stringToEdit.numberOfEdits)")
    // Prints "The number of edits is 3"
}

do {
    /// The structure’s members (including the numberOfEdits property) therefore have an internal access level by default. You can make the structure’s numberOfEdits property getter public, and its property setter private, by combining the public and private(set) access-level modifiers. 使用public的显式访问级别定义了结构。因此，默认情况下，结构的成员（包括numberOfEdits属性）具有内部访问级别。您可以通过组合public和private（set）访问级别修饰符来使结构的numberOfEdits属性getter public，其属性setter private
    public struct TrackedStringP {
        public private(set) var numberOfEdits = 0
        public var value: String = "" {
            didSet {
                numberOfEdits += 1
            }
        }
        public init() {}
    }
}

/*:
 # Initializers

 Custom initializers can be assigned an access level less than or equal to the type that they initialize. The only exception is for required initializers (as defined in Required Initializers). A required initializer must have the same access level as the class it belongs to.

 As with function and method parameters, the types of an initializer’s parameters cannot be more private than the initializer’s own access level. 与函数和方法参数一样，初始化程序参数的类型不能比初始化程序自身的访问级别更私有。

 ## Default Initializers

 As described in Default Initializers, Swift automatically provides a default initializer without any arguments for any structure or base class that provides default values for all of its properties and does not provide at least one initializer itself.

 A default initializer has the same access level as the type it initializes, unless that type is defined as public. For a type that is defined as public, the default initializer is considered internal. If you want a public type to be initializable with a no-argument initializer when used in another module, you must explicitly provide a public no-argument initializer yourself as part of the type’s definition. 默认的初始化程序具有与初始化类型相同的访问级别，除非该类型被定义为public。对于定义为public的类型，默认的初始值设定器被认为是内部的。如果您希望在另一个模块中使用无参数初始化器可以初始化公共类型，那么您必须自己显式提供一个公共无参数初始值设置，作为类型定义的一部分。

 ## Default Memberwise Initializers for Structure Types 结构类型的默认成员初始化器

 The default memberwise initializer for a structure type is considered private if any of the structure’s stored properties are private. Likewise, if any of the structure’s stored properties are file private, the initializer is file private. Otherwise, the initializer has an access level of internal.

 As with the default initializer above, if you want a public structure type to be initializable with a memberwise initializer when used in another module, you must provide a public memberwise initializer yourself as part of the type’s definition. 与上面的默认初始化程序一样，如果您希望在另一个模块中使用成员初始化程序来初始化公共结构类型，那么您必须自己提供一个公共成员初始化程序作为类型定义的一部分.

 */

/*:
 # Protocols

 If you want to assign an explicit access level to a protocol type, do so at the point that you define the protocol. This enables you to create protocols that can only be adopted within a certain access context.

 The access level of each requirement within a protocol definition is automatically set to the same access level as the protocol. You cannot set a protocol requirement to a different access level than the protocol it supports. This ensures that all of the protocol’s requirements will be visible on any type that adopts the protocol.

 - NOTE:
 If you define a public protocol, the protocol’s requirements require a public access level for those requirements when they are implemented. This behavior is different from other types, where a public type definition implies an access level of internal for the type’s members. 如果您定义了一个公共协议，协议的要求在实现时需要这些要求的公共访问级别。这种行为与其他类型不同，其中公共类型定义意味着类型成员的内部访问级别。

 ## Protocol Inheritance

 If you define a new protocol that inherits from an existing protocol, the new protocol can have at most the same access level as the protocol it inherits from. 如果您定义了从现有协议继承的新协议，则新协议最多可以具有与其继承的协议相同的访问级别。 You cannot write a public protocol that inherits from an internal protocol, for example.

 ## Protocol Conformance

 A type can conform to a protocol with a lower access level than the type itself. 类型可以符合具有比类型本身更低的访问级别的协议。For example, you can define a public type that can be used in other modules, but whose conformance to an internal protocol can only be used within the internal protocol’s defining module.

 The context in which a type conforms to a particular protocol is the minimum of the type’s access level and the protocol’s access level. If a type is public, but a protocol it conforms to is internal, the type’s conformance to that protocol is also internal. 类型符合特定协议的上下文是类型的访问级别和协议访问级别的最小值。如果一个类型是公共的，但它符合的协议是内部的，则该类型与该协议的一致性也是内部的。

 When you write or extend a type to conform to a protocol, you must ensure that the type’s implementation of each protocol requirement has at least the same access level as the type’s conformance to that protocol. For example, if a public type conforms to an internal protocol, the type’s implementation of each protocol requirement must be at least “internal”.

 - NOTE:
 In Swift, as in Objective-C, protocol conformance is global—it is not possible for a type to conform to a protocol in two different ways within the same program. 在Swift中，如Objective-C一样，协议一致性是全局的 - 在同一程序中，类型不可能以两种不同的方式符合协议。
 */

/*:
 # Extensions

 You can extend a class, structure, or enumeration in any access context in which the class, structure, or enumeration is available. Any type members added in an extension have the same default access level as type members declared in the original type being extended. If you extend a public or internal type, any new type members you add have a default access level of internal. If you extend a file-private type, any new type members you add have a default access level of file private. If you extend a private type, any new type members you add have a default access level of private. 您可以在类，结构或枚举可用的任何访问上下文中扩展类，结构或枚举。在扩展中添加的任何类型成员具有与要扩展的原始类型中声明的类型成员相同的默认访问级别。如果扩展公共或内部类型，您添加的任何新类型成员都具有内部的默认访问级别。如果扩展文件私有类型，则您添加的任何新类型成员都具有默认的文件私有访问级别。如果您扩展一个私有类型，您添加的任何新类型成员的默认访问级别都是私有的。

 Alternatively, you can mark an extension with an explicit access-level modifier (for example, private extension) to set a new default access level for all members defined within the extension. This new default can still be overridden within the extension for individual type members. 或者，您可以使用显式访问级别修饰符（例如，私有扩展名）标记扩展名，为扩展中定义的所有成员设置新的默认访问级别。这个新的默认值仍然可以在扩展中为单个类型成员覆盖。

 ## Adding Protocol Conformance with an Extension

 You cannot provide an explicit access-level modifier for an extension if you are using that extension to add protocol conformance. Instead, the protocol’s own access level is used to provide the default access level for each protocol requirement implementation within the extension. 如果您使用该扩展添加协议一致性，则不能为扩展提供显式的访问级别修饰符。相反，协议自身的访问级别用于为扩展中的每个协议要求实现提供默认访问级别。
 */
/*:
 # Generics

 The access level for a generic type or generic function is the minimum of the access level of the generic type or function itself and the access level of any type constraints on its type parameters. 通用类型或通用函数的访问级别是通用类型或函数本身的访问级别的最小值以及对其类型参数的任何类型约束的访问级别。
 */

/*:
 # Type Aliases

 Any type aliases you define are treated as distinct types for the purposes of access control. A type alias can have an access level less than or equal to the access level of the type it aliases. For example, a private type alias can alias a private, file-private, internal, public, or open type, but a public type alias cannot alias an internal, file-private, or private type. 您定义的任何类型的别名都将被视为不同类型，用于访问控制。类型别名的访问级别可以小于或等于其别名类型的访问级别。例如，私有类型别名可以隐藏私有，文件 - 私有，内部，公共或公开类型，但是公用类型别名不能别名为内部，文件私有或私有类型。

 - NOTE:
 This rule also applies to type aliases for associated types used to satisfy protocol conformances. 此规则也适用于用于满足协议一致性的关联类型的类型别名。
 */


//: [Next](@next)
