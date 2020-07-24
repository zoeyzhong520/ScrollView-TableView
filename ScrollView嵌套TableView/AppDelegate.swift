//
//  AppDelegate.swift
//  ScrollView嵌套TableView
//
//  Created by Joe on 2020/7/24.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
}

