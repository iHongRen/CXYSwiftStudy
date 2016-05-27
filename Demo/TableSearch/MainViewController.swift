//
//  MainVIewController.swift
//  Demo
//
//  Created by chen on 16/5/25.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

class MainViewController: BaseTableViewController {

    var members = [Member]()
    
    private lazy var resultsController: ResultsViewController! = {
        let rc = ResultsViewController()
        rc.tableView.delegate = self
        return rc
    }()
    
    
    private lazy var searchController: UISearchController! = {
        let sc = UISearchController(searchResultsController: self.resultsController)
        sc.searchResultsUpdater = self
        sc.searchBar.sizeToFit()
        sc.delegate = self
        sc.searchBar.delegate = self
        sc.dimsBackgroundDuringPresentation = false
        return sc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configData()
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.tableView.tableFooterView = UIView()
        self.definesPresentationContext = true
    }

    private func configData() {
        self.members = [
            Member(name: "3Tom",mobile: "13100000000"),
            Member(name: "赵龙",mobile: "13111111111"),
            Member(name: "Bob",mobile: "13222222222"),
            Member(name: "关羽",mobile: "13333333333"),
            Member(name: "Ada",mobile: "13144444444"),
            Member(name: "Co7ra",mobile: "13555555555"),
            Member(name: "老王",mobile: "13666666666"),
            Member(name: "老六",mobile: "13666666666"),
            Member(name: "小李",mobile: "13777777777"),
            Member(name: "小a",mobile:  "13708099777"),
            Member(name: "张三",mobile: "13888888888"),
            Member(name: "Haley",mobile: "13999999999")
        ]
    }
    
    private func filterMember(member: Member, argumentArray args: [AnyObject]?) -> Bool {
        return NSPredicate(format: "%@ contains[cd] %@",argumentArray: args).evaluateWithObject(member)
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


extension MainViewController: UISearchControllerDelegate {
    
    func presentSearchController(searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willPresentSearchController(searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didPresentSearchController(searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willDismissSearchController(searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didDismissSearchController(searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }

}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {

        //去掉左右空格
        let trimString = searchController.searchBar.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        let filteredResults = self.members.filter {
            
            //是否匹配手机号  139... -> 13999999999
            let match_mobile = self.filterMember($0, argumentArray: [$0.mobile,trimString])
            
            //是否匹配名字   老 -> 老王、老六
            let match_name = self.filterMember($0, argumentArray: [$0.name,trimString])
            
            //是否匹配带空格名字 laowang -> lao wang
            let match_space_name = self.filterMember($0, argumentArray: [$0.pinyinName.stringByReplacingOccurrencesOfString(" ", withString: ""),trimString])

            //是否匹配名字拼音  lao -> 老
            let match_pinyin = self.filterMember($0, argumentArray: [$0.pinyinName,trimString])
            
            //是否匹配名字拼音缩写  lw -> 老王
            let match_abbr = self.filterMember($0, argumentArray: [$0.pinyinNameAbbreviation,trimString])
            
            return match_mobile || match_name || match_space_name || match_pinyin || match_abbr
        }
        
        self.resultsController.filteredMembers = filteredResults
        self.resultsController.tableView.reloadData()
    }
}


// MARK: UITableViewDataSource
extension MainViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.members.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BaseTableViewController.cellIdentifier, forIndexPath: indexPath)
        
        let member = self.members[indexPath.row]
        self.configCell(cell, forData: member)
        return cell
    }
}

// MARK: UITableViewDelegate
extension MainViewController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let member: Member
        
        if tableView === self.tableView {
            member = self.members[indexPath.row]
        } else {
            member = self.resultsController.filteredMembers[indexPath.row]
        }
        print(member.name)
    }
}
