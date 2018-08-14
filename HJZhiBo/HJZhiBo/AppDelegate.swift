//
//  AppDelegate.swift
//  HJZhiBo
//
//  Created by Jermy on 2018/8/14.
//  Copyright © 2018年 Jermy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
        
        //统一设置导航栏颜色
        UINavigationBar.appearance().barTintColor = UIColor.black
        
        return true
    }
}

