//: [Previous](@previous)
//: # A collection of unique `Element` instances with no defined ordering
do {
    let set : Set<Int> = [1, 2, 3, 4, 5]
}
do {
    let set : Set = [1, 2, 3, 4, 5]
}
do {
    let arr = [1,2,1,3,2,4,3,5]
    let set = Set(arr)
    let arr2 = Array(set) // [5,2,3,1,4], perhaps
}
do {
    let set : Set = [1,2,3,4,5]
    let set2 = Set(set.map {$0+1}) // {6, 5, 2, 3, 4}, perhaps
    (set2)
}
import UIKit
do{//???: what
    do {
        let opts = UIViewAnimationOptions(rawValue:0b00011000)
    }
    do {
        let val = UIViewAnimationOptions.Autoreverse.rawValue | UIViewAnimationOptions.Repeat.rawValue
        let opts = UIViewAnimationOptions(rawValue: val)
    }
    do {
        let opts : UIViewAnimationOptions = [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat]
    }
    do {
        var opts = UIViewAnimationOptions.Autoreverse
        opts.insert(.Repeat)
    }
    do {
        let opts : UIViewAnimationOptions = [.Autoreverse, .Repeat]
    }
    
    do {
        UIView.animateWithDuration(0.4, delay: 0, options: [.Autoreverse, .Repeat],
                                   animations: {
                                    // ...
            }, completion: nil)
    }
}
do {
    let types : UIUserNotificationType = [.Alert, .Sound]
    let category = UIMutableUserNotificationCategory()
    category.identifier = "coffee"
    // ...
    let settings = UIUserNotificationSettings(forTypes: types, categories: [category])
}
do{//???: what
    class ViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            let t = touches.first // an Optional wrapping a UITouch
            print(t)
        }
    }
    class MyTableViewCell : UITableViewCell {
        override func didTransitionToState(state: UITableViewCellStateMask) {
            let editing = UITableViewCellStateMask.ShowingEditControlMask.rawValue
            if state.rawValue & editing != 0 {
                // ... the ShowingEditControlMask bit is set ...
            }
        }
    }
    class MyTableViewCell2 : UITableViewCell {
        override func didTransitionToState(state: UITableViewCellStateMask) {
            if state.contains(.ShowingEditControlMask) {
                // ... the ShowingEditControlMask bit is set ...
            }
        }
    }
}
//: [Next](@next)
