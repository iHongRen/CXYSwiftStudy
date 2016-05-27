//
//  BaseTableViewController.swift
//  Demo
//
//  Created by chen on 16/5/25.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    static let nibName = "TableCell"
    static let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: BaseTableViewController.nibName, bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: BaseTableViewController.cellIdentifier)
    }
}


// MARK: configure cell
extension BaseTableViewController {
    
    func configCell(cell: UITableViewCell, forData member: Member) {
        cell.textLabel?.text = member.name
        cell.detailTextLabel?.text = member.mobile
    }
}