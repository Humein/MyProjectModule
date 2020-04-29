//
//  SDPushAViewController.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/29.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class SDPushAViewController: UIViewController {
    var aView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        aView = UIView.init(frame: CGRect.init(x: 40, y: 80, width: 80, height: 80))
        aView!.backgroundColor = .red
        self.view.addSubview(aView!)
        self.navigationController?.delegate = self
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = SDPushBViewController()
        vc.bView = aView
        self.navigationController?.pushViewController(vc, animated: true)

    }

}

extension SDPushAViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return SDPushTransitionAnimator()
        } else {
            return nil
        }
    }
}
