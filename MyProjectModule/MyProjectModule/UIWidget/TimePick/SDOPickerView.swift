//
//  SDOPickerView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/11/1.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

class SDOPickerView: UIPickerView {
    
    private var isScoll = true
    //  过滤事件
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView != self && hitView != nil{
            getSub(view: hitView!)
            if isScoll {
                return hitView
            }else{
                return nil
            }
        }
        return hitView
    }
    
    func getSub(view :UIView) -> Void {
        if view.subviews.count > 0 {
            for subView in view.subviews{
                if subView.isKind(of: UILabel.classForCoder()) {
                    if subView.tag == 101 {
                        isScoll = false
                    }else{
                        isScoll = true
                    }
                    break
                }
                getSub(view: subView)
            }
        }
    }

    
}
