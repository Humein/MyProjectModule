//
//  UIView+Radius.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/11/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit
public extension UIView{

/** 部分圆角
 * - corners: 需要实现为圆角的角，可传入多个
 * - radii: 圆角半径
 */
func exCorner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
    let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.bounds
    maskLayer.path = maskPath.cgPath
    self.layer.mask = maskLayer
  }

}
