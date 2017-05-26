//: [Previous](@previous)

import UIKit

enum Filter {
    case Albums
    case Playlists
    case Podcasts
    case Books
}

do {
    var type = Filter.Albums
    let title: String = {
        switch type {
        case .Albums:
            return "Albums"
        case .Playlists:
            return "Playlists"
        case .Podcasts:
            return "Podcasts"
        case .Books:
            return "Books"
        }
    }()
}

do {
    let arr: [String?] = ["a", nil, "b"]
    do {
        let arr2: [AnyObject] = arr.map { if $0 == nil { return NSNull() } else { return $0! } }
        arr2
    }
    do {
        let arr2 = arr.map { $0 != nil ? $0! : NSNull() }
        arr2
    }
    do {
        let arr2 = arr.map { $0 ?? NSNull() }
        print(arr2)
    }
}

do {
    let arr: [AnyObject] = ["a", 1, "b"]
    do {
        let arr2: [String] = arr.map {
            if $0 is String {
                return $0 as! String
            } else {
                return ""
            }
        }
        arr2
    }
    do {
        let arr2 = arr.map { $0 as? String ?? "" }
        (arr2)
    }
}
do {
    let i1: AnyObject = 1
    let i2: AnyObject = 2
    let someNumber = (i1 as? Int) ?? (i2 as? Int) ?? 0 // i1为空 i2为空 0
}



class ViewController: UIViewController {
    
    var currow: Int? = 0
    var hilite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cell = UITableViewCell()
        let ix = NSIndexPath(forRow: 0, inSection: 0)
        cell.accessoryType =
            ix.row == self.currow ? .Checkmark : .DisclosureIndicator
        
        let purple = UIColor.purpleColor()
        let beige = UIColor.brownColor()
        UIGraphicsBeginImageContext(CGSizeMake(10, 10))
        let context = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(
            context, self.hilite ? purple.CGColor : beige.CGColor)
        UIGraphicsEndImageContext()
    }
    
}


//: [Next](@next)
