//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Invision. All rights reserved.
//

import UIKit
import IQKeyboardManager
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        return true
    }
}

