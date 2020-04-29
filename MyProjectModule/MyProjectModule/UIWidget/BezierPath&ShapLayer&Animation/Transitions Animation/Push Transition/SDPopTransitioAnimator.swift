//
//  SDPopTransitioAnimator.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/29.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class SDPopTransitioAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as! SDPushBViewController
        let toVC = transitionContext.viewController(forKey: .to) as! SDPushAViewController
        
        let container = transitionContext.containerView
        
        let snapView = fromVC.bView!.snapshotView(afterScreenUpdates: false)
        snapView?.frame = (fromVC.bView?.frame)!
        
        toVC.aView?.isHidden = true
        
        container.addSubview(toVC.view)
        container.addSubview(snapView!)
        
        UIView.animate(withDuration: 0.5, animations: {
            snapView?.frame = container.convert((toVC.aView?.frame)!, from: toVC.view)
        }) { (result) in
            snapView?.removeFromSuperview()
            toVC.aView!.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    

}
