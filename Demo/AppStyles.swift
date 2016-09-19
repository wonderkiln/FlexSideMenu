//
//  AppStyles.swift
//  CMP10C
//
//  Created by Adrian Mateoaea on 29.01.2016.
//  Copyright © 2016 CMP10C. All rights reserved.
//

import UIKit

struct Color {
    
    static let textFieldBorderColor = UIColor(red:0.71, green:0.71, blue:0.71, alpha:1)
    static let textFieldTextColor   = UIColor(red:0.6, green:0.6, blue:0.6, alpha:1)
    
    static let appTintColor         = UIColor(red:0.27, green:0.52, blue:0.65, alpha:1)
    static let appTitleColor        = UIColor(red:0.27, green:0.27, blue:0.27, alpha:1)
    static let appBackgroundColor   = UIColor(red:0.96, green:0.97, blue:0.98, alpha:1)
    
}

struct Image {
    
    static let userImage     = UIImage(named: "ic_user")!
    static let passwordImage = UIImage(named: "ic_password")!
    
    static let menuImage     = UIImage(named: "ic_menu")!
    static let addImage      = UIImage(named: "ic_add")!
    
    static let homeImage      = UIImage(named: "ic_home")!
    static let notifImage     = UIImage(named: "ic_notifications")!
    static let reviewsImage   = UIImage(named: "ic_reviews")!
    static let settingsImage  = UIImage(named: "ic_settings")!
    static let helpImage      = UIImage(named: "ic_help")!

    static let generalBG     = UIImage(named: "general_bg")!
    static let buttonBG      = UIImage(named: "button_bg")!
    
    static let logo          = UIImage(named: "logo")!
    static let shadow        = UIImage(named: "shadow")!
    
}

struct Font {
    
    static let textFieldFont  = UIFont.boldSystemFont(ofSize: 14)
    
    static let buttonLinkFont = UIFont.systemFont(ofSize: 13)
    static let buttonFont     = UIFont.boldSystemFont(ofSize: 15)
    
    static let menuLabelFont  = UIFont.systemFont(ofSize: 16)
    
}
