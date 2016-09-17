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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMembers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableViewController.cellIdentifier, for: indexPath)
        
        let member = filteredMembers[(indexPath as NSIndexPath).row]
        self.configCell(cell, forData: member)
        return cell
    }
}
