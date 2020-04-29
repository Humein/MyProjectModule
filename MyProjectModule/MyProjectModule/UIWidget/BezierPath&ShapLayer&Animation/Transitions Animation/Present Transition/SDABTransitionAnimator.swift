//
//  SDABTransitionAnimator.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/28.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class SDABTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    // 设置动画的进行方式
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        
        var fromView = fromViewController?.view
        var toView = toViewController?.view
        fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        // 我们让toview的origin.y在屏幕的一半处，这样它从屏幕的中间位置弹起而不是从屏幕底部弹起，弹起过程中逐渐变为不透明
        toView?.frame = CGRect(x: fromView!.frame.origin.x, y: fromView!.frame.maxY / 2, width: fromView!.frame.width, height: fromView!.frame.height)
        toView?.alpha = 0.0
        
        // 在present和dismiss时，必须将toview添加到视图层次中
        containerView.addSubview(toView!)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        // 使用spring动画，有弹簧效果，动画结束后一定要调用completeTransition方法
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: { () -> Void in
            toView!.alpha = 1.0     // 逐渐变为不透明
            toView?.frame = transitionContext.finalFrame(for: toViewController!)    // 移动到指定位置
            }) { (finished: Bool) -> Void in
                let wasCancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!wasCancelled)
        }
    }
    

}
