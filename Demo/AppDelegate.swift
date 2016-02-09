//
//  AppDelegate.swift
//  Demo
//
//  Created by Adrian Mateoaea on 30.01.2016.
//  Copyright © 2016 Wonderkiln. All rights reserved.
//

import UIKit
import WKAwesomeMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let rootVC = MainTableViewController()
        let rootNC = UINavigationController(rootViewController: rootVC)
        
        let menuVC = MenuTableViewController()
        
        var options = WKAwesomeMenuOptions.defaultOptions()
        options.backgroundImage = UIImage(named: "bg")
        let awesomeMenu = WKAwesomeMenu(rootViewController: rootNC, menuViewController: menuVC, options: options)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = awesomeMenu
        self.window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().tintColor = Color.appTintColor
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        UINavigationBar.appearance().shadowImage = Image.shadow
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: Font.buttonFont,
            NSForegroundColorAttributeName: Color.appTitleColor
        ]
        
        return true
    }

}
