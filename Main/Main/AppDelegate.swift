//
//  AppDelegate.swift
//  Main
//
//  Created by wangkan on 2017/5/24.
//  Copyright © 2017年 rockgarden. All rights reserved.
//

import UIKit

//@UIApplicationMain
/// 'UIApplicationMain' attribute cannot be used in a module that contains top-level code, use main.swift instead.
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = window ?? UIWindow()
        window!.backgroundColor = .red
        window!.rootViewController = ViewController()
        self.window!.makeKeyAndVisible()
        return true
    }

}

