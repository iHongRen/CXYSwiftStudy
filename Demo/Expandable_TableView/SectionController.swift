//
//  SectionController.swift
//  Demo
//
//  Created by chen on 16/5/9.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

class SectionController: UITableViewController {

    var expandArray = [true,true,true,true]
    let titleArray = ["A","B","C","D"]
    let dataSouure = [["App","And","All"],
                      ["Bug","Bed"],
                      ["CEO","CTO"],
                      ["Data","Down","Day","Deep","Do"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.registerNib(UINib(nibName: "HeaderView", bundle:nil), forHeaderFooterViewReuseIdentifier: String(HeaderView))
    }

    
    // MARK: - delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSouure.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (!self.expandArray[section]) {
            return 0
        }
        return self.dataSouure[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = self.dataSouure[indexPath.section][indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(String(HeaderView)) as! HeaderView
        header.titleButton .setTitle(self.titleArray[section], forState: .Normal)
        header.clickedClosure = { [unowned self] () in
            let isExpand = self.expandArray[section]
            self.expandArray[section] = !isExpand
            
            let indexSet = NSIndexSet(index: section)
            tableView.beginUpdates()
            tableView.reloadSections(indexSet, withRowAnimation: .None)
            tableView.endUpdates()
        }
        return header
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
