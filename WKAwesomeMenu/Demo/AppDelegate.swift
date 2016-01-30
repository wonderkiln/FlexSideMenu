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
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1)
        vc1.title = "YOUR PROFILE"
        vc1.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.menuImage,
            style: UIBarButtonItemStyle.Plain, target: self, action: "")
        vc1.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Image.addImage,
            style: UIBarButtonItemStyle.Plain, target: self, action: "")
        
        let vc3 = UINavigationController(rootViewController: vc1)
        
        let vc2 = MenuTableViewController()
        
        var options = WKAwesomeMenuOptions.defaultOptions()
        options.backgroundImage = UIImage(named: "bg")
        let nc = WKAwesomeMenu(rootViewController: vc3, menuViewController: vc2, options: options)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = nc
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
