//
//  MyPresentationController.swift
//  Demo
//
//  Created by chen on 16/6/14.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

class MyPresentationController: UIPresentationController {
    
    
    lazy var dimmingView :UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    func dimmingViewTapped(_ tap: UIGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    
    //呈现过渡即将开始的时候被调用的
    override func presentationTransitionWillBegin() {
        //添加半透明背景
        guard let
             containerView = containerView,
             let presentedView = presentedView
        else {
            return
        }
        
        self.dimmingView.frame = containerView.bounds
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(MyPresentationController.dimmingViewTapped(_:)))
        self.dimmingView.addGestureRecognizer(tap)
        containerView.addSubview(self.dimmingView)
        containerView.addSubview(presentedView)
        
        self.dimmingView.alpha = 0.0
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext!) in
                self.dimmingView.alpha = 0.5
                }, completion: nil)
        }
        
    }
    
    //呈现过渡结束时被调用的
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    //呈现过渡即将取消的时候被调用的
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha  = 0.0
                }, completion:nil)
        }
    }
    
    //取消呈现过渡完成的时候被调用的
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    
    //改变转场后第二页View的 frame
    override var frameOfPresentedViewInContainerView : CGRect {
        guard let
             containerView = containerView
        else {
            return CGRect()
        }
        
        let frame = containerView.bounds;
        return frame.insetBy(dx: 50.0, dy: 50.0)
    }
}



