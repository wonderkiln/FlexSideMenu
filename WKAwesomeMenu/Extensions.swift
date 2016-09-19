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
    
    public func changeViewController(_ vc: UIViewController) {
        self.awesomeMenu?.changeRootViewController(vc)
    }
    
    var awesomeMenu: WKAwesomeMenu? {
        if let nc = self.parent as? UINavigationController {
            return nc.parent as? WKAwesomeMenu
        }
        return self.parent as? WKAwesomeMenu
    }
    
}
