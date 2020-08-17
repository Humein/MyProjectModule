//
//  CustomPopCover.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/15.
//  Copyright © 2020 xinxin. All rights reserved.
//
/**
 - useAge:
  - CustomPopCover.coverFrom(contentView: self.cycleView)
  - CustomPopCover.coverFrom(contentView: self.cycleView, showStyle: .SDCoverShowStyleBottom, showAnimStyle: .SDCoverShowStyleBottom, hideAnimStyle: .SDCoverHideStyleBottom)

 */
import UIKit
let cAnimDuration = 0.25
let cAlpha = 0.5
typealias SDCoverBlock = ()->()
/** 视图显示类型 */
enum SDCoverShowStyle {
    case SDCoverShowStyleTop, SDCoverShowStyleCenter, SDCoverShowStyleBottom
}
/** 弹窗显示时的动画类型 */
enum SDCoverShowAnimStyle {
    case SDCoverShowStyleTop, // 从上弹出
         SDCoverShowStyleCenter, // 中间弹出
         SDCoverShowStyleBottom,  // 底部弹出
         SDCoverShowStyleNone
}
/** 弹窗隐藏时的动画类型 */
enum SDCoverHideAnimStyle {
    case SDCoverHideStyleTop, // 从上隐藏
         SDCoverHideStyleCenter, // 中间隐藏
         SDCoverHideStyleBottom,  // 底部隐藏
         SDCoverHideStyleNone
}


class CustomPopCover: UIView {
    private static var _cover: CustomPopCover? // 遮罩
    private static var _contentView: UIView? // 显示的视图
    private static var _fromView: UIView? // 显示在此视图上
    private static var _showStyle: SDCoverShowStyle? // 显示类型
    private static var _showAnimStyle: SDCoverShowAnimStyle? // 显示动画
    private static var _hideAnimStyle: SDCoverHideAnimStyle? // 消失动画
    private static var _showBlock: SDCoverBlock?       // 显示时的回调block
    private static var _hideBlock: SDCoverBlock?      // 隐藏时的回调block
    /// 弹窗
    /// - Parameters:
    ///   - fromView: 默认 keyWindow
    ///   - contentView: 默认 UIView
    ///   - showStyle: 默认 SDCoverShowStyleCenter
    ///   - showAnimStyle: 默认 SDCoverShowStyleBottom
    ///   - hideAnimStyle: 默认 SDCoverHideAnimStyle
    ///   - showBlock: 显示回调
    ///   - hideBlock: 移除回调
    public class func coverFrom(fromView: UIView = UIApplication.shared.keyWindow!, contentView: UIView, showStyle: SDCoverShowStyle = .SDCoverShowStyleCenter, showAnimStyle: SDCoverShowAnimStyle = .SDCoverShowStyleBottom, hideAnimStyle: SDCoverHideAnimStyle = .SDCoverHideStyleBottom, showBlock: (SDCoverBlock)? = nil, hideBlock: (SDCoverBlock)? = nil){
        _fromView      = fromView
        _contentView   = contentView
        _showStyle     = showStyle
        _showAnimStyle = showAnimStyle
        _hideAnimStyle = hideAnimStyle
        _showBlock     = showBlock
        _hideBlock     = hideBlock
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
        cover.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: CGFloat(cAlpha))
        coverAddTap(cover)
    }
    
    private class func coverAddTap(_ cover: UIView){
        cover.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hideCover)))
    }
    
    @objc private class func hideCover(){
        switch _showStyle {
        case .SDCoverShowStyleTop:
            switch _hideAnimStyle {
            case .SDCoverHideStyleTop:
                UIView.animate(withDuration: cAnimDuration, animations: {
                    _contentView!.extY = -_contentView!.extHeight
                }) { (finished: Bool) in
                    remove()
                }
                break
            default:
                _contentView!.extY = -_contentView!.extHeight
                remove()
                break
            }
            break
        case .SDCoverShowStyleCenter:
            switch _hideAnimStyle {
            case .SDCoverHideStyleTop:
                UIView.animate(withDuration: cAnimDuration, animations: {
                    _contentView!.extY = -_contentView!.extHeight
                }) { (finished: Bool) in
                    remove()
                }
                break
            case .SDCoverHideStyleCenter:
                remove()
                // XXTODO 动画
                break
            case .SDCoverHideStyleBottom:
                UIView.animate(withDuration: cAnimDuration, animations: {
                    _contentView!.extY = _fromView!.extHeight
                }) { (finished: Bool) in
                    remove()
                }
                break
            default:
                _contentView!.center = _fromView!.center
                remove()
                break
            }
            break
        case .SDCoverShowStyleBottom:
            switch _hideAnimStyle {
            case .SDCoverHideStyleBottom:
                UIView.animate(withDuration: cAnimDuration, animations: {
                    _contentView!.extY = _fromView!.extHeight
                }) { (finished: Bool) in
                    remove()
                }
                break
            default:
                _contentView!.extY = _fromView!.extHeight
                remove()
                break
            }
            break
        default:
            remove()
            break
        }

    }
    
    private class func showCover(){
        _fromView?.addSubview(_contentView!)
        switch _showStyle {
        case .SDCoverShowStyleTop:
            _contentView!.extCenterX = _fromView!.extCenterX
            switch _showAnimStyle {
            case .SDCoverShowStyleTop:
                _contentView!.extY = -_contentView!.extHeight
                UIView.animate(withDuration: cAnimDuration, animations: {
                    _contentView!.extY = 0
                }) { (finished: Bool) in
                    _showBlock?()
                }
                break
            default:
                _contentView!.extY = 0
                _showBlock?()
                break
            }
            break
        case .SDCoverShowStyleCenter:
            _contentView!.extCenterX = _fromView!.extCenterX
            switch _showAnimStyle {
            case .SDCoverShowStyleTop:
                _contentView!.extY = -_contentView!.extHeight
                UIView.animate(withDuration: cAnimDuration, animations: {
                    _contentView!.center = _fromView!.center
                }) { (finished: Bool) in
                    _showBlock?()
                }
                break
            case .SDCoverShowStyleCenter:
                _contentView!.center = _fromView!.center
                _showBlock?()
                // XXTODO 动画
                break
            case .SDCoverShowStyleBottom:
                _contentView!.extY = _fromView!.extHeight
                UIView.animate(withDuration: cAnimDuration, animations: {
                    _contentView!.center = _fromView!.center
                }) { (finished: Bool) in
                    _showBlock?()
                }
                break
            default:
                _showBlock?()
                break
            }
            break
        case .SDCoverShowStyleBottom:
            _contentView!.extCenterX = _fromView!.extCenterX
            switch _showAnimStyle {
            case .SDCoverShowStyleBottom:
                _contentView!.extY = _fromView!.extHeight
                UIView.animate(withDuration: cAnimDuration, animations: {
                    _contentView!.extY = _fromView!.extHeight - _contentView!.extHeight
                }) { (finished: Bool) in
                    _showBlock?()
                }
                break
            default:
                _contentView!.extY = _fromView!.extHeight - _contentView!.extHeight
                _showBlock?()
                break
            }
            break
        default:
            _showBlock?()
            break
        }
    }
    
    private class func remove(){
        _hideBlock?()
        _cover?.removeFromSuperview()
        _cover       = nil
        _contentView?.removeFromSuperview()
        _contentView = nil
    }
    
    deinit {
        print("deinit")
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
