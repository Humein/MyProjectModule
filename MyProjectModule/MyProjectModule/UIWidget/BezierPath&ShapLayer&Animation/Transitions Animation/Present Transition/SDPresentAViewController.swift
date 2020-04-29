//
//  SDPresentAViewController.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/28.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class SDPresentAViewController: UIViewController, UIViewControllerTransitioningDelegate{
    lazy var B: SDPresentBViewController = SDPresentBViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        B.modalPresentationStyle = .fullScreen
        B.transitioningDelegate = self // 设置动画代理，这里的代理就是这个类自己
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.present(B, animated: true, completion: nil)
    }

}


// MARK: - 实现UIViewControllerTransitioningDelegate协议
/**
 作为代理，需要提供present和dismiss时的animator，有时候一个animator可以同时在present和dismiss时用
 */
extension SDPresentAViewController {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SDABTransitionAnimator()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SDBATransitionAnimator()
    }
}
