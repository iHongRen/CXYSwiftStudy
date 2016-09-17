//
//  MyDismissAnimatedTransitioning.swift
//  Demo
//
//  Created by chen on 16/6/19.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

class MyDismissAnimatedTransitioning: NSObject,UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval;
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    //转场时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    
    //转场动画- 可以在这里做一些比较好看合理的动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        UIView.animate(withDuration: self.duration, animations: {
                presentedView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }, completion: { (completed) in
                presentedView?.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                transitionContext.completeTransition(completed)
        })
    }
}
