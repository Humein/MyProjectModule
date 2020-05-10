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
    var cNet = SDCustomNet()
    var cData = SDCustomDate()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cBattery.frame = CGRect.init(x: self.frame.width - 20 - 5, y: 5, width: 20, height: 10)
        self.addSubview(cBattery)
        
        cNet.frame = CGRect.init(x: cBattery.frame.origin.x - 20, y: 5, width: 20, height: 10)
        self.addSubview(cNet)
        
        cData.frame = CGRect.init(x: cNet.frame.origin.x - 43, y: 5, width: 20, height: 10)
        cData.configDate()
        self.addSubview(cData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SDCustomDate: UIView {
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 10))
        dateLabel.textAlignment = .center
        dateLabel.textColor = .white
        dateLabel.font = UIFont.systemFont(ofSize: 11)
        return dateLabel
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(dateLabel)
    }
    
    func configDate() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        let time = dateformatter.string(from: Date())
        dateLabel.text = "\(time)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class SDCustomNet: UIView {
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 10))
        dateLabel.textAlignment = .left
        dateLabel.textColor = .white
        dateLabel.text = "4G"
        dateLabel.font = UIFont.systemFont(ofSize: 11)
        return dateLabel
    }()
    let wifiLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        monitorNet()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 监听网络
    func monitorNet(){
        draw()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.wifiLayer.removeFromSuperlayer()
            self.addSubview(self.dateLabel)
        }
    }
    
    func draw(){
        // Wi-Fi
        let wiFi = UIBezierPath()
        wiFi.move(to: CGPoint(x: 8.64, y: 6.94))
        wiFi.addLine(to: CGPoint(x: 6.52, y: 9))
        wiFi.addLine(to: CGPoint(x: 4.36, y: 6.91))
        wiFi.addCurve(to: CGPoint(x: 6.49, y: 5.97), controlPoint1: CGPoint(x: 4.88, y: 6.33), controlPoint2: CGPoint(x: 5.64, y: 5.97))
        wiFi.addCurve(to: CGPoint(x: 8.64, y: 6.94), controlPoint1: CGPoint(x: 7.35, y: 5.97), controlPoint2: CGPoint(x: 8.13, y: 6.35))
        wiFi.close()
        wiFi.move(to: CGPoint(x: 10.82, y: 4.82))
        wiFi.addLine(to: CGPoint(x: 10.82, y: 4.82))
        wiFi.addLine(to: CGPoint(x: 9.73, y: 5.88))
        wiFi.addCurve(to: CGPoint(x: 6.49, y: 4.48), controlPoint1: CGPoint(x: 8.94, y: 5.02), controlPoint2: CGPoint(x: 7.78, y: 4.48))
        wiFi.addCurve(to: CGPoint(x: 3.27, y: 5.85), controlPoint1: CGPoint(x: 5.21, y: 4.48), controlPoint2: CGPoint(x: 4.07, y: 5.01))
        wiFi.addLine(to: CGPoint(x: 2.18, y: 4.79))
        wiFi.addCurve(to: CGPoint(x: 6.49, y: 2.98), controlPoint1: CGPoint(x: 3.26, y: 3.68), controlPoint2: CGPoint(x: 4.79, y: 2.98))
        wiFi.addCurve(to: CGPoint(x: 10.82, y: 4.82), controlPoint1: CGPoint(x: 8.2, y: 2.98), controlPoint2: CGPoint(x: 9.74, y: 3.69))
        wiFi.close()
        wiFi.move(to: CGPoint(x: 13, y: 2.71))
        wiFi.addLine(to: CGPoint(x: 11.91, y: 3.76))
        wiFi.addCurve(to: CGPoint(x: 6.49, y: 1.49), controlPoint1: CGPoint(x: 10.55, y: 2.37), controlPoint2: CGPoint(x: 8.63, y: 1.49))
        wiFi.addCurve(to: CGPoint(x: 1.09, y: 3.74), controlPoint1: CGPoint(x: 4.36, y: 1.49), controlPoint2: CGPoint(x: 2.45, y: 2.35))
        wiFi.addLine(to: CGPoint(x: 0, y: 2.68))
        wiFi.addCurve(to: CGPoint(x: 6.49, y: 0), controlPoint1: CGPoint(x: 1.64, y: 1.03), controlPoint2: CGPoint(x: 3.94, y: 0))
        wiFi.addCurve(to: CGPoint(x: 13, y: 2.71), controlPoint1: CGPoint(x: 9.05, y: 0), controlPoint2: CGPoint(x: 11.36, y: 1.04))
        wiFi.close()
        wiFi.move(to: CGPoint(x: 13, y: 2.71))

        wifiLayer.path = wiFi.cgPath
        wifiLayer.fillColor = UIColor.white.cgColor
        self.layer.addSublayer(wifiLayer)
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
        monitorBatteryLevel()
    }
    
    // 监听电量
    func monitorBatteryLevel(){
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        batteryProgress(NSInteger(device.batteryLevel * 100))
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: UIDevice.batteryLevelDidChangeNotification, object: device)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange), name: UIDevice.batteryStateDidChangeNotification, object: device)

    }
    @objc func batteryLevelDidChange(){
        let device = UIDevice.current
        batteryProgress(NSInteger(device.batteryLevel * 100))
    }
    
    @objc func batteryStateDidChange(){
        let device = UIDevice.current
        let batteryLevel = device.batteryState
        
    }
    
    private func draw(){
        //电池的宽度
        w = 20
        //电池的x的坐标
        let x = 0
        //电池的y的坐标
        let y = 0
        //电池的线宽
        lineW = 1.5
        //电池的高度
        let h = 10
        
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
