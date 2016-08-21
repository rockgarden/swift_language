//: [Previous](@previous)
import UIKit

var content = NSMutableAttributedString()

func imperative() {
    let para = NSMutableParagraphStyle()
    para.headIndent = 10
    para.firstLineHeadIndent = 10
    // ... more configuration of para ...
    content.addAttribute(
        NSParagraphStyleAttributeName,
        value:para, range:NSMakeRange(0,1))
}

func functional() {
    content.addAttribute(
        NSParagraphStyleAttributeName,
        // define and call
        value: {
            let para = NSMutableParagraphStyle()
            para.headIndent = 10
            para.firstLineHeadIndent = 10
            // ... more configuration of para ...
            return para
        }(),
        range:NSMakeRange(0,1))
    
}


//: [Next](@next)
