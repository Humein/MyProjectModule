//
//  UISampleExample.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/2/26.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class UISampleExampleVC: UIViewController {
    let circleView = UISampleExample.init(frame: CGRect.init(x: 30, y: 140, width: 44, height: 44))
    
    override func viewDidLoad() {
        self.view.addSubview(circleView)
        circleView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//            self.circleView.transform = .identity
            self.circleView.transform = CGAffineTransform(scaleX: 2, y: 2)

        }, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //CAShapeLayer和UIBezierPath 动画
        /**
         请画出一条开始和结束比较慢，中间比较快的贝塞尔曲线(即
         UIViewAnimationOptionCurveEaselnOut)。另外能否画出- -条有弹性效果的曲线?
         */

          //  创建CAShapeLayer
          let layer = CAShapeLayer.init()
          layer.fillColor = UIColor.clear.cgColor
          layer.lineWidth =  20.0
          layer.lineCap = .round
          layer.lineJoin = .round
          layer.strokeColor = UIColor.red.cgColor
          self.view.layer.addSublayer(layer)
          // 创建贝塞尔路径
          let path = UIBezierPath.init()
          path.move(to: CGPoint.init(x: 20, y: 90))
          path.addLine(to: CGPoint.init(x: 20, y: 590))
          path.lineWidth = 20.0
          path.lineCapStyle = .round  //线条拐角
          path.lineJoinStyle = .round //终点处理
          
          // 关联layer和贝塞尔路径
          layer.path = path.cgPath
          
          
          // 创建Animation
          let animation = CABasicAnimation.init(keyPath: "strokeEnd")
          animation.fromValue = (0.0)
          animation.toValue = (1.0)
          animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
          animation.duration = 3
//          animation.autoreverses = true
//          animation.repeatCount = 5
//          animation.beginTime = CACurrentMediaTime() + 2;

          // 设置layer的animation
          layer.add(animation, forKey: "nil")
    }
}


class UISampleExample: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 仅仅使用UIBezierPath来绘图的话，需要在view的drawRect方法里实现，core graphic 框架在此没问题
    override func draw(_ rect: CGRect) {
        let color =  UIColor.red
        color.set() //设置线条颜色
         
        let path = UIBezierPath.init()
        path.move(to: CGPoint.init(x: 10, y: 10))
        path.addLine(to: CGPoint.init(x: 200, y: 80))
        path.lineWidth = 2.0
        path.lineCapStyle = .round  //线条拐角
        path.lineJoinStyle = .round //终点处理
        
        path.stroke()
    }
    
    
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
//    -(UIView *)shawdowWithMask{
//        UIView *shadowView = [UIView new];
//        UIView *borderContent = [UIView new];
//        shadowView.frame = CGRectMake(20, 6, kScreenWidth - 40, 161 - 12);
//        borderContent.frame = CGRectMake(0, 0, kScreenWidth - 40, 161 - 12);
//        borderContent.backgroundColor = [UIColor clearColor];
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:shadowView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(8, 8)];
//        CALayer *layer = [CALayer new];
//        layer.shadowColor = [UIColor xesApp_colorWithHex:0xCCCCCC alpha:1].CGColor;
//        layer.shadowOpacity = 0.24;
//        layer.shadowPath = maskPath.CGPath;
//        layer.shadowOffset = CGSizeZero;
//        layer.shadowRadius = 8;
//        [shadowView.layer addSublayer:layer];
//        CAShapeLayer *maskLayer = [CAShapeLayer layer];
//        maskLayer.path = maskPath.CGPath;
//        borderContent.layer.mask = maskLayer;
//        [shadowView addSubview:borderContent];
//        return shadowView;
//    }
    
    /// 全部圆角阴影效果        clipsToBounds = YES; 如果设置会使阴影失效

//    - (UIView *)cellBackgroundView{
//        if (!_cellBackgroundView) {
//            _cellBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
//            _cellBackgroundView.layer.cornerRadius = 4.f;
//            _cellBackgroundView.layer.borderWidth = 0.5f;
//            _cellBackgroundView.layer.borderColor = kXesAppColor(0xF5F5F5, 0.1).CGColor;
//            _cellBackgroundView.layer.shadowColor = kXesAppColor(0xCCCCCC, 0.24).CGColor;
//            _cellBackgroundView.layer.shadowRadius = 6.f;
//            _cellBackgroundView.layer.shadowOffset = CGSizeMake(0, 2.f);
//            _cellBackgroundView.layer.shadowOpacity = 1.f;
//            _cellBackgroundView.userInteractionEnabled = YES;
//            _cellBackgroundView.backgroundColor = [UIColor xesApp_white];
//        }
//        return _cellBackgroundView;
//    }
    
    
    
    // 阴影圆角共存 https://www.jianshu.com/p/48b1a601febf
    /**
     
     */
    
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


