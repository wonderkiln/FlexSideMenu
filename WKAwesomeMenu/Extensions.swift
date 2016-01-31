//
//  Extensions.swift
//  WKAwesomeMenu
//
//  Created by Adrian Mateoaea on 31.01.2016.
//  Copyright © 2016 Wonderkiln. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func openSideMenu() {
        self.awesomeMenu?.openMenu()
    }
    
    public func closeSideMenu() {
        self.awesomeMenu?.closeMenu()
    }
    
    public func changeViewController(vc: UIViewController) {
        self.awesomeMenu?.changeRootViewController(vc)
    }
    
    var awesomeMenu: WKAwesomeMenu? {
        if let nc = self.parentViewController as? UINavigationController {
            return nc.parentViewController as? WKAwesomeMenu
        }
        return self.parentViewController as? WKAwesomeMenu
    }
    
}
