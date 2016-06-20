//
//  MyPresentAnimatedTransitioning.swift
//  Demo
//
//  Created by chen on 16/6/19.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

class MyPresentAnimatedTransitioning: NSObject,UIViewControllerAnimatedTransitioning {
    
    let duration: NSTimeInterval;
    
    init(duration: NSTimeInterval) {
        self.duration = duration
    }
    
    //转场时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration
    }
    
    
     //转场动画- 可以在这里做一些比较好看合理的动画
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey),
            let container = transitionContext.containerView()
        else {
            return
        }
        
        presentedView.frame = transitionContext.finalFrameForViewController(presentedController)
        container.addSubview(presentedView)
     
        presentedView.transform = CGAffineTransformMakeScale(0.3, 0.3)
        UIView.animateWithDuration(self.duration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .CurveEaseInOut, animations: {
            presentedView.transform = CGAffineTransformIdentity
        }) { (completed: Bool) in
                transitionContext.completeTransition(completed)
        }
    }
}