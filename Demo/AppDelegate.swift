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
    
    var awesomeMenu: WKAwesomeMenu!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let rootVC = UIViewController()
        rootVC.view.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1)
        rootVC.title = "YOUR PROFILE"
        rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.menuImage,
            style: UIBarButtonItemStyle.Plain, target: self, action: "menu")
        rootVC.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Image.addImage,
            style: UIBarButtonItemStyle.Plain, target: self, action: "add")
        
        let rootNC = UINavigationController(rootViewController: rootVC)
        
        let menuVC = MenuTableViewController()
        
        var options = WKAwesomeMenuOptions.defaultOptions()
        options.backgroundImage = UIImage(named: "bg")
        self.awesomeMenu = WKAwesomeMenu(rootViewController: rootNC, menuViewController: menuVC, options: options)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = self.awesomeMenu
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
    
    func menu() {
        self.awesomeMenu.openMenu()
    }
    
    func add() {
        //
    }

}
