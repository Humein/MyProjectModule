//
//  SDCustomStatusBarView.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/5/7.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class SDCustomStatusBarView: UIView {
    var cBattery = SDCustomBattery()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cBattery.frame = CGRect.init(x: 20, y: 15, width: 40, height: 15)
        self.addSubview(cBattery)
        cBattery.batteryProgress(100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class SDCustomBattery: UIView {
    var w: Int = 0
    var lineW: CGFloat = 0
    var batteryView: UIView?
    var batteryLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        draw()
    }
    
    private func draw(){
        //电池的宽度
        w = 40
        //电池的x的坐标
        let x = 0
        //电池的y的坐标
        let y = 0
        //电池的线宽
        lineW = 1.5
        //电池的高度
        let h = 15
        
        //画电池
        let path1 = UIBezierPath.init(roundedRect: CGRect.init(x: x, y: y, width: w, height: h), cornerRadius: 2)
        let batteryLayer = CAShapeLayer()
        batteryLayer.lineWidth = lineW
        batteryLayer.strokeColor = UIColor.white.cgColor
        batteryLayer.fillColor = UIColor.clear.cgColor
        batteryLayer.path = path1.cgPath
        self.layer.addSublayer(batteryLayer)
        
        let path2 = UIBezierPath()
        path2.addArc(withCenter: CGPoint.init(x: x+w+2, y: y+h/2), radius: CGFloat(h)/4.8, startAngle: CGFloat(Double.pi*1.5), endAngle: CGFloat(Double.pi*0.5), clockwise: true)
        let layer2 = CAShapeLayer()
        layer2.path = path2.cgPath
        layer2.fillColor = UIColor.white.cgColor
        self.layer.addSublayer(layer2)

        //绘制进度
        batteryView = UIView.init(frame: CGRect.init(x: x+Int(lineW), y: y+Int(lineW), width: 0, height: h-Int(lineW)*2))
        batteryView?.layer.cornerRadius = 2
        batteryView?.backgroundColor = .init(red: 0.324, green: 0.941, blue: 0.413, alpha: 1.000)
        self.addSubview(batteryView ?? UIView())
        
    }
    
    public func batteryProgress(_ progressValue: NSInteger){
        UIView.animate(withDuration: 0.3) {
            var frame = self.batteryView!.frame
            frame.size.width = CGFloat(progressValue * (self.w - Int(self.lineW * 2))) / 100
            self.batteryView!.frame  = frame
            if (progressValue < 20) {
                self.batteryView!.backgroundColor = .red
            }else if (progressValue >= 20 && progressValue < 30){
                self.batteryView!.backgroundColor = .yellow
            }else{
                self.batteryView!.backgroundColor = .init(red: 0.324, green: 0.941, blue: 0.413, alpha: 1.000)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
