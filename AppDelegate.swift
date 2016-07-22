//
//  AppDelegate.swift
//  BinjCollectionHoriRoll
//
//  Created by binj on 16/7/21.
//  Copyright © 2016年 binj. All rights reserved.
//  由于我没有加入运行启动图片，所以会出现

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        
        let mainViewVC = BJmainViewController()
        let mainNav = UINavigationController(rootViewController: mainViewVC)
        
        window?.rootViewController = mainNav
        window?.makeKeyAndVisible()
        
        return true
    }
}

