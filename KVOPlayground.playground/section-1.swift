// Playground - noun: a place where people can play

import UIKit



/*
 From Swift, create a KeyValueObserver instance with the object being observed, the key path to observe and a closure to be called. 
 As long as this instance remains alive, observations will be reported to the closure. 
 To remove the observer, release the KeyValueObserver instance (so assign it to an optional so you can assign that to nil to release it).
 */

typealias KVObserver = (kvo: KeyValueObserver, change: [NSObject : AnyObject]) -> Void
/// KeyValueObserver instance is marshalled unretained into an UnsafeMutablePointer<KeyValueObserver> and passed as the context to addObserver:forKeyPath:options:context:
class KeyValueObserver {
    let source: NSObject
    let keyPath: String
    private let observer: KVObserver

    init(source: NSObject, keyPath: String, options: NSKeyValueObservingOptions, observer: KVObserver) {
        self.source = source
        self.keyPath = keyPath
        self.observer = observer
        source.addObserver(defaultKVODispatcher, forKeyPath: keyPath, options: options, context: self.pointer)
    }

    func __conversion() -> UnsafeMutablePointer<KeyValueObserver> { return pointer }

    private lazy var pointer: UnsafeMutablePointer<KeyValueObserver> = {
        return UnsafeMutablePointer<KeyValueObserver>(Unmanaged<KeyValueObserver>.passUnretained(self).toOpaque())
    }()

    private class func fromPointer(pointer: UnsafeMutablePointer<KeyValueObserver>) -> KeyValueObserver {
        return Unmanaged<KeyValueObserver>.fromOpaque(COpaquePointer(pointer)).takeUnretainedValue()
    }

    class func observe(pointer: UnsafeMutablePointer<KeyValueObserver>, change: [NSObject : AnyObject]) {
        let kvo = fromPointer(pointer)
        kvo.observer(kvo: kvo, change: change)
    }

    /**
     Note that the KeyValueObserver is not retained when it is passed as the context or when it is extracted again - KeyValueObserver.deinit removes the observer so observeValueForKeyPath() should never be called with a deallocated instance.
     */
    deinit {
        source.removeObserver(defaultKVODispatcher, forKeyPath: keyPath, context: self.pointer)
    }
}

/// uses a global singleton NSObject subclass KVODispatcher dispatcher as the observer.
class KVODispatcher : NSObject {
    /**
     KVODispatcher.observeValueForKeyPath() retrieves the KeyValueObserver instance from the context pointer and invokes the closure.
     */
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [String : AnyObject]!, context: UnsafeMutablePointer<()>) {
        KeyValueObserver.observe(UnsafeMutablePointer<KeyValueObserver>(context), change: change)
    }
}
private let defaultKVODispatcher = KVODispatcher()


let button = UIButton()
KeyValueObserver(source: button, keyPath: "selected", options: .New) {
    (kvo, change) in
    NSLog("OBSERVE 1 %@ %@", kvo.keyPath, change)
}
button.selected = true
button.selected = false

/// save the observer in an optional member and release it in the observation closure to implement a single-shot observation.
var kvo: KeyValueObserver? = KeyValueObserver(source: button, keyPath: "selected", options: .New) {
    (kvo, change) in
    NSLog("OBSERVE 2 %@ %@", kvo.keyPath, change)
}
button.selected = true
button.selected = false
kvo = nil //When you have finished observing, assign your KeyValueObserver optional to nil to remove the observer.
button.selected = true
