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
 - Open classes can be subclassed within the module where they’re defined, and within any module that imports the module where they’re defined. 开放类可以在定义模块的子类中，并在任何导入模块定义的模块中进行子类化。
 - Open class members can be overridden by subclasses within the module where they’re defined, and within any module that imports the module where they’re defined. 开放类成员可以被模块定义的子类覆盖，并且可以在任何导入模块定义的模块中覆盖。

 Marking a class as open explicitly indicates that you’ve considered the impact of code from other modules using that class as a superclass, and that you’ve designed your class’s code accordingly. 将类标记为open，表示您已经考虑了使用该类作为超类的其他模块的代码的影响，并且相应地设计了类的代码。
 
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




///*:
// Swift provides three different access levels for entities within your code.
// These access levels are relative to the source file in which an entity is defined, and also relative to the module that source file belongs to.
//
// - Public access enables entities to be used within any source file from their defining module,
// and also in a source file from another module that imports the defining module.
// You typically use public access when specifying the public interface to a framework.
//
// - Internal access enables entities to be used within any source file from their defining module,
// but not in any source file outside of that module.
// You typically use internal access when defining an app’s or a framework’s internal structure.
//
// - Private access restricts the use of an entity to its own defining source file.
// Use private access to hide the implementation details of a specific piece of functionality.
//
// Public access is the highest (least restrictive) access level and private access is the lowest (or most restrictive) access level.
//
// - NOTE:
// Private access in Swift differs from private access in most other languages,
// as it’s scoped to the enclosing source file rather than to the enclosing declaration.
// This means that a type can access any private entities that are defined in the same source file as itself,
// but an extension cannot access that type’s private members if it’s defined in a separate source file.
// */
//
//
///*
// ## Guiding Principle of Access Levels
// */
//
///*:
// Access levels in Swift follow an overall guiding principle:
// No entity can be defined in terms of another entity that has a lower (more restrictive) access level.
// */
//
///*:
// ### Default Access Levels
// ---------------------
// All entities in your code (with a few specific exceptions, as described later in this chapter)
// have a default access level of internal if you do not specify an explicit access level yourself.
// As a result, in many cases you do not need to specify an explicit access level in your code.
//
// ### Access Levels for Single-Target Apps
// ------------------------------------
//
// When you write a simple single-target app, the code in your app is typically self-contained within
// the app and does not need to be made available outside of the app’s module.
// The default access level of internal already matches this requirement.
// Therefore, you do not need to specify a custom access level.
// You may, however, want to mark some parts of your code as private
// in order to hide their implementation details from other code within the app’s module.
//
// ### Access Levels for Frameworks
// ----------------------------
//
// When you develop a framework, mark the public-facing interface to that framework as public
// so that it can be viewed and accessed by other modules, such as an app that imports the framework.
// This public-facing interface is the application programming interface (or API) for the framework.
// */
//
//
///*
// ## Access Control Syntax
// */
//
////public class SomePublicClass {}
////internal class SomeInternalClass {}
////private class SomePrivateClass {}
//
//public var somePublicVariable = 0
//internal let someInternalConstant = 0
////private func somePrivateFunction() {}
//
//
///*:
// ## Custom Types
// If you want to specify an explicit access level for a custom type, do so at the point that you define the type.
// The new type can then be used wherever its access level permits.
// For example, if you define a private class, that class can only be used as the type of a property,
// or as a function parameter or return type, in the source file in which the private class is defined.
//
// The access control level of a type also affects the default access level of that type’s members
// (its properties, methods, initializers, and subscripts). If you define a type’s access level as private,
// the default access level of its members will also be private. If you define a type’s access level as internal or public
// (or use the default access level of internal without specifying an access level explicitly),
// the default access level of the type’s members will be internal.
//
// - NOTE:
// As mentioned above, a public type defaults to having internal members, not public members.
// If you want a type member to be public, you must explicitly mark it as such.
// This requirement ensures that the public-facing API for a type is something you opt in to publishing,
// and avoids presenting the internal workings of a type as public API by mistake.
// */
//
//public class SomeOtherPublicClass {          // explicitly public class
//    public var somePublicProperty = 0    // explicitly public class member
//    var someInternalProperty = 0         // implicitly internal class member
//    private func somePrivateMethod() {}  // explicitly private class member
//}
//
//class SomeOtherInternalClass {               // implicitly internal class
//    var someInternalProperty = 0         // implicitly internal class member
//    private func somePrivateMethod() {}  // explicitly private class member
//}
//
//private class SomeOtherPrivateClass {        // explicitly private class
//    var somePrivateProperty = 0          // implicitly private class member
//    func somePrivateMethod() {}          // implicitly private class member
//}
//
//
///*:
// ### Tuple Types
// -----------
// The access level for a tuple type is the most restrictive access level of all types used in that tuple.
// For example, if you compose a tuple from two different types, one with internal access and one with private access,
// the access level for that compound tuple type will be private.
// - NOTE:
// Tuple types do not have a standalone definition in the way that classes, structures, enumerations, and functions do.
// A tuple type’s access level is deduced automatically when the tuple type is used, and cannot be specified explicitly.
// */
//
///*:
// ### Function Types
// --------------
// The access level for a function type is calculated as the most restrictive access level of the function’s parameter types and return type.
// You must specify the access level explicitly as part of the function’s definition
// if the function’s calculated access level does not match the contextual default.
// The function’s return type is a tuple type composed from two of the custom classes defined above in Custom Types.
// One of these classes was defined as “internal”, and the other was defined as “private”.
// Therefore, the overall access level of the compound tuple type is “private” (the minimum access level of the tuple’s constituent types).
// Because the function’s return type is private, you must mark the function’s overall access level with the private modifier for the function declaration to be valid:
// */
//
//private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
//    // function implementation goes here
//    return (SomeInternalClass(), SomePrivateClass())
//}
//
///*:
// ### Enumeration Types
// -----------------
// The individual cases of an enumeration automatically receive the same access level as the enumeration they belong to.
// You cannot specify a different access level for individual enumeration cases.
// */
//
///*
// ## Subclasses
// */
//
///*:
// You can subclass any class that can be accessed in the current access context.
// A subclass cannot have a higher access level than its superclass—for example,
// you cannot write a public subclass of an internal superclass.
// In addition, you can override any class member (method, property, initializer, or subscript) that is visible in a certain access context.
// An override can make an inherited class member more accessible than its superclass version.
// It is even valid for a subclass member to call a superclass member that has lower access permissions than the subclass member,
// as long as the call to the superclass’s member takes place within an allowed access level context
// */
//
//public class A {
//    private func someMethod() {}
//}
//
//internal class B: A {
//    private func someMethod() {
//        super.someMethod()
//    }
//}
//// Because superclass A and subclass B are defined in the same source file,
//// it is valid for the B implementation of someMethod() to call super.someMethod().
//
//
///*:
// ## Constants, Variables, Properties, and Subscripts
// */
//
////: A constant, variable, or property cannot be more public than its type.
////: It is not valid to write a public property with a private type, for example.
////: Similarly, a subscript cannot be more public than either its index type or return type.
//
///* 
// ### Getters and Setters
// -------------------
// Getters and setters for constants, variables, properties,
// and subscripts automatically receive the same access level as the
// constant, variable, property, or subscript they belong to.
// You can give a setter a lower access level than its corresponding getter,
// to restrict the read-write scope of that variable, property, or subscript.
// You assign a lower access level by writing private(set) or internal(set) before the var or subscript introducer.
// */
//
//struct TrackedString {
//    private(set) var numberOfEdits = 0
//    var value: String = "" {
//        didSet {
//            numberOfEdits += 1
//        }
//    }
//}
//
///*:
// The access level for the numberOfEdits property is marked with a private(set) modifier
// to indicate that the property should be settable only from within the same source file
// as the TrackedString structure’s definition. The property’s getter still has the default access level of internal,
// but its setter is now private to the source file in which TrackedString is defined.
// This enables TrackedString to modify the numberOfEdits property internally,
// but to present the property as a read-only property when it is used by other source files within the same module.
// You can make the structure’s numberOfEdits property getter public, and its property setter private,
// by combining the public and private(set) access level modifiers:
// */
//
//public private(set) var numberOfEdits = 0
//
//
///*:
// ## Initializers
// Custom initializers can be assigned an access level less than or equal to the type that they initialize.
// As with function and method parameters, the types of an initializer’s parameters cannot be more private than the initializer’s own access level.
// */
//
///*:
// ### Default Initializers
// --------------------
// A default initializer has the same access level as the type it initializes,
// unless that type is defined as public. For a type that is defined as public,
// the default initializer is considered internal.
// If you want a public type to be initializable with a no-argument initializer when used in another module,
// you must explicitly provide a public no-argument initializer yourself as part of the type’s definition.
// */
//
//
///*
// ## Protocols
// */
//
///*:
// If you want to assign an explicit access level to a protocol type, do so at the point that you define the protocol.
// This enables you to create protocols that can only be adopted within a certain access context.
// The access level of each requirement within a protocol definition is automatically set to the same access level as the protocol.
// You cannot set a protocol requirement to a different access level than the protocol it supports.
// This ensures that all of the protocol’s requirements will be visible on any type that adopts the protocol.
// */
//
///*:
// ### Protocol Inheritance
// --------------------
// If you define a new protocol that inherits from an existing protocol,
// the new protocol can have at most the same access level as the protocol it inherits from.
// You cannot write a public protocol that inherits from an internal protocol, for example.
//
// ### Protocol Conformance
// --------------------
// When you write or extend a type to conform to a protocol, you must ensure that the type’s implementation of each protocol requirement
// has at least the same access level as the type’s conformance to that protocol.
// For example, if a public type conforms to an internal protocol, the type’s implementation of each protocol requirement must be at least “internal”.
// */
//
//
///*
// ## Extensions
//
// Any type members added in an extension have the same default access level as type members declared in the original type being extended.
// If you extend a public or internal type, any new type members you add will have a default access level of internal.
// If you extend a private type, any new type members you add will have a default access level of private.
//
// Alternatively, you can mark an extension with an explicit access level modifier (for example, private extension)
// to set a new default access level for all members defined within the extension.
// This new default can still be overridden within the extension for individual type members.
// */
//
///*:
// ### Adding Protocol Conformance with an Extension
// ---------------------------------------------
//
// The protocol’s own access level is used to provide the default access level for each protocol requirement implementation within the extension.
// */
//
//
///*
// ## Extensions
//
// The access level for a generic type or generic function is the minimum of the access level
// of the generic type or function itself and the access level of any type constraints on its type parameters.
// */
//
//
///*
// ## Type Aliases
// A type alias can have an access level less than or equal to the access level of the type it aliases.
// For example, a private type alias can alias a private, internal, or public type,
// but a public type alias cannot alias an internal or private type.
// */

//: [Next](@next)
