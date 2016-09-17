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
        self.tableView.register(UINib(nibName: "HeaderView", bundle:nil), forHeaderFooterViewReuseIdentifier: String(describing: HeaderView.self))
    }

    
    // MARK: - delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSouure.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (!self.expandArray[section]) {
            return 0
        }
        return self.dataSouure[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = self.dataSouure[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: HeaderView.self)) as! HeaderView
        header.titleButton .setTitle(self.titleArray[section], for: UIControlState())
        header.clickedClosure = { [unowned self] () in
            let isExpand = self.expandArray[section]
            self.expandArray[section] = !isExpand
            
            let indexSet = IndexSet(integer: section)
            tableView.beginUpdates()
            tableView.reloadSections(indexSet, with: .none)
            tableView.endUpdates()
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
