//
//  CustomPopCover.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/15.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit
let cAnimDuration = 0.25
let cAlpha = 0.5


class CustomPopCover: UIView {
    private static var _cover: CustomPopCover? // 遮罩
    private static var _contentView: UIView? // 显示的视图
    private static var _fromView: UIView? // 显示在此视图上

    public class func coverFrom(fromView: UIView = UIApplication.shared.keyWindow!, contentView: UIView, style: Int, showStyle: Int, showAnimStyle: Int, hideAnimStyle: Int){
        _fromView = fromView
        _contentView = contentView
        
        // 创建遮罩
        let cover = CustomPopCover()
        cover.frame = fromView.frame
        // 添加遮罩
        fromView.addSubview(cover)
        _cover = cover
        
        setupTranslucentCover(cover)
        showCover()
    }
    
    private class func setupTranslucentCover(_ cover: UIView){
        cover.backgroundColor = .black
        cover.alpha = CGFloat(cAlpha)
        coverAddTap(cover)
    }
    
    private class func coverAddTap(_ cover: UIView){
        cover.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hideCover)))
    }
    
    @objc private class func hideCover(){
        _contentView!.center = _fromView!.center
        remove()
    }
    
    private class func showCover(){
        
        _fromView?.addSubview(_contentView!)
        
        _contentView!.extCenterX = _fromView!.extCenterX
        _contentView!.extY = -_contentView!.extHeight
        UIView.animate(withDuration: cAnimDuration, animations: {
            _contentView!.center = _fromView!.center
        }) { (finished: Bool) in
            
        }
    }
    
    private class func remove(){
        _cover?.removeFromSuperview()
        _cover       = nil
        _contentView!.removeFromSuperview()
        _contentView = nil
    }
    
}

extension UIView {
    public var extCenterX : CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    public var extY : CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.y     = newValue
            frame                 = tmpFrame
        }
    }
    public var extHeight : CGFloat {
        get {
            return frame.size.height
        }
    }

}
