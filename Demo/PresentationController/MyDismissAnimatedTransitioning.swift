//
//  MyDismissAnimatedTransitioning.swift
//  Demo
//
//  Created by chen on 16/6/19.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

class MyDismissAnimatedTransitioning: NSObject,UIViewControllerAnimatedTransitioning {
    
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
        
        let presentedView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        
        UIView.animateWithDuration(self.duration, animations: {
                presentedView?.transform = CGAffineTransformMakeScale(0.1, 0.1)
            }, completion: { (completed) in
                presentedView?.transform = CGAffineTransformMakeScale(0.0, 0.0)
                transitionContext.completeTransition(completed)
        })
    }
}
