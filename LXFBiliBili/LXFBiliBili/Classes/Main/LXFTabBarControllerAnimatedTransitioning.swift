//
//  LXFTabBarControllerAnimatedTransitioning.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/17.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit

public enum LXFTabOperationDirection : Int {
    case left
    case right
}

class LXFTabBarControllerAnimatedTransitioning: NSObject {
    
    var direction: LXFTabOperationDirection
    
    init(_ direction: LXFTabOperationDirection) {
        self.direction = direction
    }
}

extension LXFTabBarControllerAnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let fromView = fromVc?.view, let toView = toVc?.view  else {
            return
        }
        
        var toViewTransform = CGAffineTransform.identity
        var fromViewTransform = CGAffineTransform.identity
        
        let containerViewWidth = containerView.frame.size.width
        if self.direction == .left {
            toViewTransform = CGAffineTransform(translationX: -containerViewWidth, y: 0)
            fromViewTransform = CGAffineTransform(translationX: containerViewWidth, y: 0)
        } else {
            toViewTransform = CGAffineTransform(translationX: containerViewWidth, y: 0)
            fromViewTransform = CGAffineTransform(translationX: -containerViewWidth, y: 0)
        }
        
        containerView.addSubview(toView)
        
        toView.transform = toViewTransform
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            toView.transform = CGAffineTransform.identity
            fromView.transform = fromViewTransform
        }) { (finished) in
            toView.transform = CGAffineTransform.identity
            fromView.transform = CGAffineTransform.identity
            let isCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!isCancelled)
        }
    }
    
}
