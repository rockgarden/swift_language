/*:
# Playground Help
*/

//import Cocoa //FIXME:xcplaygroundpage中无法引用,Playground中才可引用
//import XCPlaygroud

import UIKit

/*:
 - Important: Sources 放到此目录下的源文件会被编译成模块(module)并自动导入到 Playground 中,并且这个编译只会进行一次(或者我们对该目录下的文件进行修改的时候),可提高代码执行的效率.由于此目录下的文件都是被编译成模块导入的，只有被设置成 public 的类型，属性或方法才能在 Playground 中使用.
 */

/*: 
 - Note: 读取独立资源文件: 
   - 每个 Playground 都有独立的 Resources 目录,放置到此目录下的资源是可直接通过代码获取.
   - 其中图片文件,可直接使用UIImage(named:)获取
 */
let path = NSBundle.mainBundle().pathForResource("import-summary", ofType: "txt")
let lines = try? String(contentsOfFile: path!).characters.split{$0 == "\n"}.map(String.init)
if let lines=lines {
    lines[0]
    lines[1]
    lines[2]
    lines[3]
    lines[4]
    lines[5]
    lines[6]
}

/*:
 - Note: 获取共享资源
   - 共享资源的目录是放在用户目录的 Documents 目录下的,在代码中可以直接使用XCPlaygroundSharedDataDirectoryURL 来获取共享资源目录的 URL(需要先导入 XCPlayground 模块).
   - 需要创建~/Documents/Shared Playground Data目录,并将资源放到此目录下,才能在 Playground 中获取到
 */

//let sharedFileURL = XCPlaygroundSharedDataDirectoryURL.URLByAppendingPathComponent("example.json")

//指定页跳转：
//: ["Go to The End"](PageName)
//PageName 代表目标页面的名称，如果页面名称中有空格，则需要使用%20来代替，这是 ASCII 中空格的符号。如下：
//: ["Go to The End"](Last%20Page)
