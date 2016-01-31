//
//  MenuItem.swift
//  CMP10C
//
//  Created by Adrian Mateoaea on 29.01.2016.
//  Copyright © 2016 CMP10C. All rights reserved.
//

import UIKit

struct MenuItems {
    
    private let titles = ["Home", "Notifications", "Reviews", "Settings", "Help"]
    private let icons  = [Image.homeImage, Image.notifImage, Image.reviewsImage, Image.settingsImage, Image.helpImage]
    
    var count: Int {
        return self.titles.count
    }
    
    func getTitle(index: Int) -> String {
        return self.titles[index]
    }
    
    func getIcon(index: Int) -> UIImage {
        return self.icons[index]
    }
    
}
