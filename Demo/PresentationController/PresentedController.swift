//
//  PresentedController.swift
//  Demo
//
//  Created by chen on 16/6/14.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

class PresentedController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {  //初始化
        super.init(coder: aDecoder)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension PresentedController: UIViewControllerTransitioningDelegate {
    
    //UIPresentationController 控制器
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MyPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    //呈现动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyPresentAnimatedTransitioning(duration: 0.3)
    }
    
    //dismiss动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyDismissAnimatedTransitioning(duration: 0.3)
    }
}
