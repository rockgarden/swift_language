//: [Previous](@previous)

import Foundation
import UIKit

/*:
 # 传值
 Swift常用的四种传值方法：单例、代理、闭包、通知
 */

let Val = "test message"

/*:
 # 单例传值
 */
class AppDelegate: UIResponder, UIApplicationDelegate {
    var SingletonColor: UIColor?
}

class FirstVC: UIViewController {

    override func viewDidLoad() {
        setSingleton()
    }

    // 通过AppDelegate创建单例对象
    func setSingleton() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.SingletonColor = UIColor.blue
    }
}

class SecondVC: UIViewController {

    // 调用单例的变量完成数值的传递
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        view.backgroundColor = appDelegate.SingletonColor
    }
}

/*:
 # 代理传值
 */
protocol GetMessageDelegate: NSObjectProtocol {
    // 回调方法  传入一个String类型的值
    func getMessage(_ controller: UIViewController, string:String)
}

class AgentSecondVC: UIViewController {
    var delegate: GetMessageDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        sendVal()
    }

    func sendVal() {
        // 调用代理方法
        if ((delegate) != nil) {
            delegate?.getMessage(self, string: Val)
            navigationController?.popViewController(animated: true)
        }
    }
}

class AgentFristVC: UIViewController,GetMessageDelegate {
    var message: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setAgent()
    }

    func setAgent() {
        let vc = AgentSecondVC()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // 接收传过来的值
    func getMessage(_ controller: UIViewController, string: String) {
        message = string
    }
}

/*:
 # 闭包传值
 */

// 定义闭包
typealias InputClosureType = (String)->Void

class ClosureSecondVC: UIViewController {
    var backClosure: InputClosureType?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeClosure()
    }

    func makeClosure() {
        // 创建闭包方法
        if self.backClosure != nil {
            self.backClosure!(Val)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

class ClosureFristVC: UIViewController {
    var message: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        sendVal()
    }

    func sendVal() {
        let vc = ClosureSecondVC()
        // 获取回调的数据
        vc.backClosure = {
            (backStr: String)->Void in
            self.message = backStr
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

/*:
 # 通知传值
 */

class NotificationFristVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 接受通知
        NotificationCenter.default.addObserver(self, selector: #selector(NotificationFristVC.getVal(_:)), name: NSNotification.Name(rawValue: "NotificationIdentifier"), object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 删除通知
        NotificationCenter.default.removeObserver(self)
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: "NotificationIdentifier", object: nil)
    }

    @objc func getVal(_ notification: Notification) {
        // 获取词典中的值
        let name = (notification.object as AnyObject).value(forKey: "name") as? String
        // 通知名称
        let nameNotification = notification.name
        // notification.userInfo 接收object 对象 一些信息 例如入键盘的一些信息
        print(nameNotification)
        print(name as Any)
    }
}

class NotificationSecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        sendVal()
    }

    func sendVal() {
        let dict = ["name":"hello"]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "NotificationIdentifier"), object: dict, userInfo: dict)
        self.navigationController?.popViewController(animated: true)
    }
}

//: [Next](@next)
