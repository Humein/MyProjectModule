//
//  PlayerFullScreenViewController.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/15.
//  Copyright © 2020 xinxin. All rights reserved.
//
/**
 // 方式3 将播放器所在的view放置到window上，用transform的方式做一个旋转动画，最终让view完全覆盖window
 [[BKPlayerWindow share] enterFullScreenWith:_videoPlayer];
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [[BKPlayerWindow share] exitFullScreenWithSubView:self.view];
 });
 */

import UIKit

class PlayerFullScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
    }
}

class BKPlayerWindow: UIWindow {
    
    @objc static let share: BKPlayerWindow = BKPlayerWindow(frame: UIScreen.main.bounds)
    
    var targetView: UIView!
    var smallPreViewFrame: CGRect!
    
    // 进入全屏模式
    @objc func enterFullScreen(with v: UIView) {
        targetView = v
        guard let currentWindow = UIApplication.shared.keyWindow else {
            return
        }
        self.smallPreViewFrame = v.frame
        let rectInWindow = v.convert(v.bounds, to: UIApplication.shared.keyWindow)
//        v.removeFromSuperview()
        v.frame = rectInWindow
        
        let vc = PlayerFullScreenViewController()
        self.makeKeyAndVisible()
        self.windowLevel = .alert + 3
        self.backgroundColor = UIColor.clear
        self.rootViewController = vc
        
        UIView.animate(withDuration: 0.5, animations: {
            v.transform = v.transform.rotated(by: .pi / 2)
            v.bounds = CGRect(x: 0, y: 0, width: max(UIScreen.main.bounds.width, UIScreen.main.bounds.height), height: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height))
            v.center = CGPoint(x: v.superview!.bounds.midX, y: v.superview!.bounds.midY)
        }) { (isFinished) in
            
        }
        
        currentWindow.makeKey()
    }
    
    
    // 退出全屏
    @objc func exitFullScreen(subView: UIView) {
        let frame = subView.convert(self.smallPreViewFrame, to: self)
        UIView.animate(withDuration: 0.5, animations: {
            self.targetView.transform = CGAffineTransform.identity
            self.targetView.frame = frame
        }) { (isFinished) in
        }
        self.resignKey()
        self.isHidden = true
    }
    
}
