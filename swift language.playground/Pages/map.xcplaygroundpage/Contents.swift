//: [Previous](@previous)

import UIKit

var result = [1,2,3,4,5].flatMap{$0 * 2}
result
result = [1,2,3,4,5,6].map{$0 * 2}
result
result = [1,2,3,4,5,6].filter{$0 > 2}
result

// flatMap过滤nil, map不过滤
var images = (1...7).flatMap{UIImage(named:"\($0).png")}
images.count


//: [Next](@next)
