//
//  MenuTableViewController.swift
//  CMP10C
//
//  Created by Adrian Mateoaea on 29.01.2016.
//  Copyright © 2016 CMP10C. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    let items = MenuItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .None
        self.tableView.layoutMargins = UIEdgeInsetsZero
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.bounces = false
        
        self.tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 30, right: 0)
        
        self.tableView.registerClass(MenuTableViewCell.self,
            forCellReuseIdentifier: "MenuTableViewCell")
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuTableViewCell",
            forIndexPath: indexPath) as! MenuTableViewCell
        
        cell.iconView.image = self.items.getIcon(indexPath.row)
        cell.titleLabel.text = self.items.getTitle(indexPath.row)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UIViewController()
        let x = CGFloat(indexPath.row) / 5.0
        vc.view.backgroundColor = UIColor(red: x, green: x, blue: x, alpha: 1)
        if indexPath.row == 0 {
            let vc1 = UIViewController()
            vc1.view.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1)
            vc1.title = "YOUR PROFILE"
            vc1.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.menuImage,
                style: UIBarButtonItemStyle.Plain, target: self, action: "")
            vc1.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Image.addImage,
                style: UIBarButtonItemStyle.Plain, target: self, action: "")
            self.changeViewController(UINavigationController(rootViewController: vc1))
        } else {
            self.changeViewController(vc)
        }
    }

}
