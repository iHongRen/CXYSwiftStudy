//
//  HeaderView.swift
//  Demo
//
//  Created by chen on 16/5/9.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

typealias ClickedClosure = ()->Void

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleButton: UIButton!
    var clickedClosure: ClickedClosure?
    
    @IBAction func titleClicked(_ sender: AnyObject) {
        self.clickedClosure?()
    }
}
