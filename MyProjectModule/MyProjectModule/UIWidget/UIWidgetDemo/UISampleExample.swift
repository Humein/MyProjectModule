//
//  UISampleExample.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/2/26.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class UISampleExample: UIView {


    /// 部分圆角 + 阴影效果
    func shadowAndMask() {
        let view1 = UIView()
        let view2 = UIView()
        view1.frame = CGRect(x: 100, y: 200, width: 100, height: 100);
        view2.frame = CGRect(x: 0, y: 0, width: 100, height: 100);
        view2.backgroundColor = .yellow
        let maskPath = UIBezierPath(roundedRect: view1.bounds,
                                    byRoundingCorners: [.topRight, .bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 10, height: 10))
        let layer = CALayer()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowPath = maskPath.cgPath
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        view1.layer.addSublayer(layer)
        let maskLayer2 = CAShapeLayer()
        maskLayer2.path = maskPath.cgPath
        view2.layer.mask = maskLayer2
        self.addSubview(view1)
        view1.addSubview(view2)
    }
    
    /// button 图片和文字位置以及图片大小调整
    func adjustButtonImageSize() {
        let button = UIButton()
        button.imageEdgeInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: 10, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -48, bottom: -39-6/2, right: 0)
        button.imageView?.contentMode = .scaleAspectFit
    }

    /// 查找view所在的VC
    func findTheVC(_ view: UIView) -> UIViewController? {
        var temp = view.next
        if temp != nil {
            if temp!.isKind(of: UIViewController.self) {
                return (temp as! UIViewController)
            }
            temp = temp?.next
        }
        return nil
    }
}


