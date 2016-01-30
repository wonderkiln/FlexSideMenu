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
    
    var cornerRadius: CGFloat = 5
    
    var shadowColor: UIColor = UIColor(red:0.56, green:0.77, blue:0.84, alpha:1)
    
    var shadowOffset: CGPoint = CGPoint(x: -10, y: 0)
    
    var shadowScale: CGFloat = 0.94
    
    public var backgroundImage: UIImage?
    
    var menuWidth: CGFloat = 250
    
    var viewScale: CGFloat = 0.8
    
    var menuTranslation: CGFloat = -40
    
    var edgeGrip: CGFloat = 40
    
}
