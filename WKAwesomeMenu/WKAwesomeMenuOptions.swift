//
//  WKAwesomeMenuOptions.swift
//  WKAwesomeMenu
//
//  Created by Adrian Mateoaea on 30.01.2016.
//  Copyright © 2016 Wonderkiln. All rights reserved.
//

import UIKit

public struct WKAwesomeMenuOptions {
    
    public static func defaultOptions() -> WKAwesomeMenuOptions {
        return WKAwesomeMenuOptions()
    }
    
    public var backgroundImage: UIImage?
    
    public var cornerRadius: CGFloat = 5
    
    public var shadowColor: UIColor = UIColor(red:0.56, green:0.77, blue:0.84, alpha:1)
    
    public var shadowOffset: CGPoint = CGPoint(x: -10, y: 0)
    
    public var shadowScale: CGFloat = 0.94
    
    public var rootScale: CGFloat = 0.8
    
    public var menuWidth: CGFloat = 250
    
    public var menuParallax: CGFloat = -40
    
    public var menuGripWidth: CGFloat = 50
    
}
