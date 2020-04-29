//
//  SDPushTransitionAnimator.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/29.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class SDPushTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as! SDPushAViewController
        let toVC = transitionContext.viewController(forKey: .to) as! SDPushBViewController
        let container = transitionContext.containerView
        
        let snapView = fromVC.aView!.snapshotView(afterScreenUpdates: true)
        snapView?.frame = container.convert(fromVC.aView!.frame, from: fromVC.view)

        
        toVC.bView?.isHidden = true
        
        container.addSubview(toVC.view)
        container.addSubview(snapView!)
        
        UIView.animate(withDuration: 0.5, animations: {
            snapView?.frame = toVC.bView!.frame
        }) { (result) in
            snapView?.removeFromSuperview()
            toVC.bView?.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    

}
