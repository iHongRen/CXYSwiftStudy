//
//  MyPresentAnimatedTransitioning.swift
//  Demo
//
//  Created by chen on 16/6/19.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import UIKit

class MyPresentAnimatedTransitioning: NSObject,UIViewControllerAnimatedTransitioning {
    
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
        
        guard let
            presentedController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        else {
            return
        }
        
        let container = transitionContext.containerView

        presentedView.frame = transitionContext.finalFrame(for: presentedController)
        container.addSubview(presentedView)
     
        presentedView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: UIViewAnimationOptions(), animations: {
            presentedView.transform = CGAffineTransform.identity
        }) { (completed: Bool) in
                transitionContext.completeTransition(completed)
        }
    }
}
