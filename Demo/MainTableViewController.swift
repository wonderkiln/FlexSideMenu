//
//  MainTableViewController.swift
//  WKAwesomeMenu
//
//  Created by Adrian Mateoaea on 09.02.2016.
//  Copyright © 2016 Wonderkiln. All rights reserved.
//

import UIKit
import WKAwesomeMenu

class MainTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1)
        self.title = "HOME"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.menuImage,
                                                                style: UIBarButtonItemStyle.plain,
                                                                target: self,
                                                                action: #selector(MainTableViewController.menu))
    }
    
    func menu() {
        self.openSideMenu()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "Item number \((indexPath as NSIndexPath).row)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
