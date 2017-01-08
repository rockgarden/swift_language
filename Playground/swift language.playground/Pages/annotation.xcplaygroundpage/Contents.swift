//: [Previous](@previous)

/*: 
 ## @available
 @available放在函数（方法），类或者协议前面。表明这些类型适用的平台和操作系统。
 特性参数：星号（*），表示包含了所有平台，目前有以下几个平台：
 iOS
 iOSApplicationExtension
 OSX
 OSXApplicationExtension
 watchOS
 watchOSApplicationExtension
 tvOS
 tvOSApplicationExtension
 */
@available(iOS 9, *)
func myMethod() {
    // do something
}
//: [Next](@next)
