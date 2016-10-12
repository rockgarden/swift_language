//: [Previous](@previous)

import UIKit

enum MyFirstError: ErrorType {
    case FirstMinorMistake
    case FirstMajorMistake
    case FirstFatalMistake
}
enum MySecondError: ErrorType {
    case SecondMinorMistake(i: Int)
    case SecondMajorMistake(s: String)
    case SecondFatalMistake
}

struct SomeStruct: ErrorType { }
do {
    let err = SomeStruct()
    (err._domain)
    (err._code)
}
struct SomeClass: ErrorType { }

test: do {
    break test // labeled break to a do is legal
}

do {
    let f = "nonexistent" // path to some file, maybe
    let s = try String(contentsOfFile: f, encoding: NSUTF8StringEncoding)
    (s) // we won't get here
} catch NSCocoaError.FileReadNoSuchFileError {
    ("no such file")
} catch {
    (error)
}

// new better way in beta 6
do {
    let f = "nonexistent" // path to some file, maybe
    if let s = try? String(contentsOfFile: f, encoding: NSUTF8StringEncoding) {
        (s) // won't happen
    } else {
        ("I guess there was no such file, eh?")
    }
}

lab: do {
    // okay, I'm sick of failing, let's succeed for once :)
    let f = NSBundle.mainBundle().pathForResource("testing", ofType: "txt")!
    guard let s = try? String(contentsOfFile: f, encoding: NSUTF8StringEncoding)
        else { print("still no file"); break lab }
    (s)
    // if we get here, s is our string
}

do {
    for what in 1...7 {
        do {
            ("throwing!")
            switch what {
            case 1: throw MyFirstError.FirstMinorMistake
            case 2: throw MyFirstError.FirstMajorMistake
            case 3: throw MyFirstError.FirstFatalMistake
            case 4: throw MySecondError.SecondMinorMistake(i: -3)
            case 5: throw MySecondError.SecondMinorMistake(i: 4)
            case 6: throw MySecondError.SecondMajorMistake(s: "ouch")
            case 7: throw MySecondError.SecondFatalMistake
            default: break
            }
        } catch MyFirstError.FirstMinorMistake {
            ("first minor mistake")
        } catch let err as MyFirstError {
            // will never be called, just testing the syntax
            print("first mistake, not minor \(err)")
        } catch MySecondError.SecondMinorMistake(let i) where i < 0 {
            ("my second minor mistake \(i)")
        } catch {
            if case let MySecondError.SecondMajorMistake(s) = error {
                ("my second major mistake \(s)")
            } else {
                print(error as NSError) // showing how it appears to Objective-C
            }
            // the integer correlative of the case is the code number
            // but where does the local description come from?
            // "The operation couldn't be completed." Can I change that?
        }
    }
}

do {
    enum NotLongEnough: ErrorType {
        case ISaidLongIMeantLong
    }
    var ok = true
    
    func giveMeALongString(s: String) throws {
        if s.characters.count < 8 {
            throw NotLongEnough.ISaidLongIMeantLong
        }
        print("thanks for the string")
        // ignore the rest; I'm just testing legality of guard syntax
        test: if s.characters.count < 8 {
            guard s.characters.count >= 12 else {
                break test // guard is legal with shortcircuiting
            }
            throw NotLongEnough.ISaidLongIMeantLong
        }
        guard s.characters.count >= 8 else {
            throw NotLongEnough.ISaidLongIMeantLong // guard is legal with throwing
        }
        guard s.characters.count >= 8 else {
            print("I'm out of here")
            fatalError("this is nuts") // guard is legal with fatalError
        }
        while true {
            guard !ok else {
                break // guard is legal with unlabeled break / continue
            }
        }
        let optionalString: String? = "howdy"
        guard let _ = optionalString else {
            return
        }
    }
    
    func stringTest() {
        do {
            try giveMeALongString("test")
        } catch {
            print("I guess it wasn't long enough: \(error)")
        }
    }
    
    func stringTest2() {
        try! giveMeALongString("okay okay")
    }
    
    stringTest()
    stringTest2()
    
    // ===== just testing the call syntax and legality
    func receiveThrower(f: (String) throws -> ()) { }
    
    func callReceiveThrower() {
        receiveThrower(giveMeALongString)
    }
    
    func callReceiveThrowerr() {
        receiveThrower {
            s in
            if s.characters.count < 8 {
                throw NotLongEnough.ISaidLongIMeantLong
            }
            print("thanks for the string")
        }
    }
    
    // ===== now let's show how it works with an actual call
    func receiveThrower2(f: (String) throws -> ()) throws {
        try f("ok?")
    }
    func receiveThrower3(f: (String) throws -> ()) rethrows {
        try f("ok?")
    }
    
    func callReceiveThrower2() throws {
        try receiveThrower2(giveMeALongString)
        try receiveThrower3(giveMeALongString)
    }
    
    func callReceiveThrowerr2() throws {
        try receiveThrower2 {
            s in if s.characters.count < 5 {
                throw NotLongEnough.ISaidLongIMeantLong
            }
            ("thanks for the string")
        }
        receiveThrower3 { // NB if the callee `rethrows` and we don't actually throw, no `try` needed
            s in ("thanks for the string")
        }
    }
    
    //TODO: how to use
    try callReceiveThrowerr2()
    
}

do {
    // https://nomothetis.svbtle.com/type-variance-in-swift
    class Dog {}
    class NoisyDog : Dog {}
    
    typealias VoidVoidThrower = () throws -> ()
    typealias VoidVoid = () -> ()
    
    typealias DogTaker = (Dog) -> ()
    typealias NoisyDogTaker = (NoisyDog) -> ()
    
    typealias DogMaker = () -> Dog
    typealias NoisyDogMaker = () -> NoisyDog
    
    func test() {
        func f1 (d: Dog) -> () { }
        func f2 (d: NoisyDog) -> () { }
        var v1: DogTaker
        var v2: NoisyDogTaker
        v1 = f1
        v2 = f2
        // v1 = f2 // not legal!!
        v2 = f1 // legal!!
        _ = v1
        _ = v2
    }
    
    func test2() {
        func f1 () -> Dog { return Dog() }
        func f2 () -> NoisyDog { return NoisyDog() }
        var v1: DogMaker
        var v2: NoisyDogMaker
        v1 = f1
        v2 = f2
        v1 = f2 // legal
        // v2 = f1 // not legal
        _ = v1
        _ = v2
    }
    
    func test3() {
        func f1 () throws -> () { }
        func f2 () -> () { }
        var v1: VoidVoidThrower
        var v2: VoidVoid
        v1 = f1
        v2 = f2
        v1 = f2 // legal
        // v2 = f1 // not legal
        _ = v1
        _ = v2
    }
    
}


//: [Next](@next)
