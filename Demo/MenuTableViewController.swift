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

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0),
            animated: false, scrollPosition: UITableViewScrollPosition.Top)
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
        let rootVC = MainTableViewController()
        let rootNC = UINavigationController(rootViewController: rootVC)
        self.changeViewController(rootNC)
    }

}
