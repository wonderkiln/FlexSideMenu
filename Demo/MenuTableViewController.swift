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
    
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.bounces = false
        
        self.tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 30, right: 0)
        
        self.tableView.register(MenuTableViewCell.self,
                                forCellReuseIdentifier: "MenuTableViewCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.selectRow(at: IndexPath(row: selectedIndex, section: 0),
                                 animated: false,
                                 scrollPosition: UITableViewScrollPosition.top)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell",
                                                 for: indexPath) as! MenuTableViewCell
        
        cell.iconView.image = self.items.getIcon((indexPath as NSIndexPath).row)
        cell.titleLabel.text = self.items.getTitle((indexPath as NSIndexPath).row)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootVC = MainTableViewController()
        let rootNC = UINavigationController(rootViewController: rootVC)
        self.changeViewController(rootNC)
        
        selectedIndex = indexPath.row
    }

}
