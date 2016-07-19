/*:
 
 # NSLocalizedString from a Swift perspective
 
 (*If you open the left panel, you can take a look at the Resources folder where you can find the string tables used on this Playground*)
 
 First difference: I use `String` as raw value and the fact that Swift 3.0 is able to generate raw values directly from the case labels.
 
 */
import UIKit

enum Options: String {
    case Cancel
    case Accept
    case New
    case LongOption = "This is a long string"
}
/*:
 Now we can implement the `CustomStringConvertible` protocol to make transparent the translation process. We use a little trick here: `self.dynamicType` let us construct the translation table name from the enum's name, so we can remove one customization string.
 */
extension Options: CustomStringConvertible {
    var description : String {
        let tableName = "\(self.dynamicType)"
        /// Returns a localized string, using the main bundle if one is not specified.
        return NSLocalizedString(self.rawValue, tableName: tableName, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}
/*:
 With this code in place you can use the enum *as usual* in your code and get the localized version.
 */
(Options.LongOption)
(Options.Cancel) //返回原值
(Options.New)
/*:
 If at any point you need to access the no-translated value, it's available as rawValue
 */
(Options.LongOption.rawValue)
/*:
 But we can do it better [Next](@next)
 */



