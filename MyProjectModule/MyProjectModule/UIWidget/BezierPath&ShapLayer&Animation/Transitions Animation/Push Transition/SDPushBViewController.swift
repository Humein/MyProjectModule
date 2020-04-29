//
//  SDPushBViewController.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/29.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class SDPushBViewController: UIViewController {
    var bView: UIView?
    // 交互式动画
    var percentTranstion: UIPercentDrivenInteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()
        bView = UIImageView(frame: CGRect(x: 100, y: 100, width: 180, height: 180))
        self.view.addSubview(bView!)
        bView?.center = CGPoint(x: self.view.center.x, y: 200)
        bView?.backgroundColor = .blue
        self.navigationController?.delegate = self
        // Do any additional setup after loading the view.
    }

}

extension SDPushBViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return SDPopTransitioAnimator()
        } else {
            return nil
        }
    }
    
    //交互式转场
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is SDPopTransitioAnimator {
            return percentTranstion
        }
        return nil
    }
    
    
}
