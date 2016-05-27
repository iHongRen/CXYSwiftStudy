//
//  ResultsViewController.swift
//  Demo
//
//  Created by chen on 16/5/25.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

class ResultsViewController: BaseTableViewController {

    var filteredMembers = [Member]()
}

extension ResultsViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMembers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BaseTableViewController.cellIdentifier, forIndexPath: indexPath)
        
        let member = filteredMembers[indexPath.row]
        self.configCell(cell, forData: member)
        return cell
    }
}