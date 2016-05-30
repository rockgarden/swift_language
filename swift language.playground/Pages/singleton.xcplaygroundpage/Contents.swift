//: [Previous](@previous)

import Foundation

class TestObject {
    private static let testObject = TestObject()
    static var sharedInstance: TestObject {
        return testObject
    }
    private init(){

    }
}

class UserDefault: NSObject {
    struct Static {
        static var token: dispatch_once_t = 0
        static var instance: UserDefault?
    }
    class var instance: UserDefault {
        dispatch_once(&Static.token) { Static.instance = UserDefault() }
        return Static.instance!
    }
    var defaults : NSUserDefaults!
    override init() {
        super.init()
        self.defaults = NSUserDefaults.standardUserDefaults()
}

//: [Next](@next)
