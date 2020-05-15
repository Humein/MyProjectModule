//
//  SubTwoSwiftDemosViewController.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/5/12.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class SubTwoSwiftDemosViewController: SwiftDemosViewController {
    lazy var knowledgePlayerView: SDKnowledgePlayerBottomView = {
        var pointButton = SDKnowledgePlayerBottomView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.width, height: 90))
        return pointButton
    }()
    
    override func viewDidLoad() {
        SDDeviceOrientation.sharedInstance.allowRotation(self)
        SDDeviceOrientation.sharedInstance
        .screenExChangeforOrientation(.landscapeRight)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.view.addSubview(knowledgePlayerView)

    }
}

//MARK:- 知识点选择
///*******   知识点选择  *******////
// http://code.cocoachina.com/list/33/1
// https://blog.csdn.net/u013282507/article/details/54136812

// XLCardSwitch-master





//MARK:- 播放进度条
///*******    播放进度条  *******////
// 播放进度
protocol SDPlaySliderDelegate {
    func sliderValueChanging(_ slider: SDGradientSlider)
}
class SDGradientSlider: UIView{
    var touchView = UIView()
    var thumbImageView = UIImageView()
    var foregroundView = UIView()
    var kThumbW: CGFloat?
    var kSliderW: CGFloat?
    var kSliderH: CGFloat?
    var value: CGFloat?
    var delegate: SDPlaySliderDelegate?


    lazy var gradientLayer:CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = 10
        gradientLayer.colors = [UIColor.yellow.cgColor,UIColor.red.cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
        gradientLayer.locations = [0,1]
        return gradientLayer
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWidget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWidget(){
        self.isUserInteractionEnabled = true
        kSliderW = self.bounds.size.width
        kSliderH = self.bounds.size.height
        kThumbW = 20
        value = 0
        thumbImageView.isUserInteractionEnabled = true
        self.addSubview(foregroundView)
        self.addSubview(thumbImageView)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = .black
        thumbImageView.backgroundColor = .blue
        touchView = thumbImageView
        let point = CGPoint.init(x: 0, y: 0)
        fillForeGroundViewWithPoint(point)
    }
    
    func setSliderValue(_ value: CGFloat){
        var v = value
        if (v > 1) {
            v = 1
        }
        let point = CGPoint.init(x: v * kSliderW!, y: 0)
        fillForeGroundViewWithPoint(point)
    }
    
    
    func fillForeGroundViewWithPoint(_ point: CGPoint){
        var p = point
        p.x += CGFloat(kThumbW!/2)
        if (p.x > kSliderW!) {
            p.x = kSliderW!
        }
        if (p.x < 0) {
            p.x = 0
        }
        value = p.x / kSliderW!
        if value == 1.0 || value == 0.0 {
            return
        }
        foregroundView.frame = CGRect.init(x: 0, y: 0, width: point.x, height: kSliderH!)
        if (foregroundView.frame.size.width <= 0) {
            thumbImageView.frame = CGRect.init(x: 0, y: 0, width: kThumbW!, height: kSliderH!)
        }else if (foregroundView.frame.size.width >= kSliderW!) {
            thumbImageView.frame = CGRect.init(x: foregroundView.frame.size.width - kThumbW!, y: 0, width: kThumbW!, height: kSliderH!)
        }else{
            thumbImageView.frame = CGRect.init(x: foregroundView.frame.size.width - kThumbW!, y: 0, width: kThumbW!, height: kSliderH!)
        }
        gradientLayer.frame = foregroundView.bounds
        gradientLayer.cornerRadius = 10
        foregroundView.layer.addSublayer(gradientLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = ((touches as NSSet).anyObject() as AnyObject)
        if touchView == thumbImageView {
            return
        }
        let point = touch.location(in:self)
        fillForeGroundViewWithPoint(point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = ((touches as NSSet).anyObject() as AnyObject)
        if touch.view != touchView {
            return
        }
        let point = touch.location(in:self)
        fillForeGroundViewWithPoint(point)
        delegate?.sliderValueChanging(self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = ((touches as NSSet).anyObject() as AnyObject)
        if touch.view != touchView {
            return
        }
        let point = touch.location(in:self)
        fillForeGroundViewWithPoint(point)
        
    }
    
}



// 知识点播放进度
class SDKnowledgePlayerSliderView: UIView, SDPlaySliderDelegate{
    
    lazy var currentTimeLabel: UILabel = {
        var inputBarrage = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 17))
        inputBarrage.backgroundColor = .clear
        inputBarrage.text = "6:00"
        inputBarrage.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        inputBarrage.textAlignment = .center
        inputBarrage.textColor = .red // #FFFFFF
        return inputBarrage
    }()
    lazy var totalTimeLabel: UILabel = {
        var inputBarrage = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 17))
        inputBarrage.backgroundColor = .clear
        inputBarrage.text = "12:00"
        inputBarrage.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        inputBarrage.textAlignment = .center
        inputBarrage.textColor = .red // #FFFFFF
        return inputBarrage
    }()
    lazy var playerSlider: SDGradientSlider = {
        var pointButton = SDGradientSlider.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width - 10 - 80, height: 24))
        return pointButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWidget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWidget(){
        playerSlider.delegate = self
        self.addSubview(currentTimeLabel)
        self.addSubview(totalTimeLabel)
        self.addSubview(playerSlider)
        currentTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
        }
        totalTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-10)
        }
        playerSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(currentTimeLabel.snp_right).offset(10)
            make.size.equalTo(CGSize.init(width: self.frame.size.width - 10 - 80, height: 24))
        }
    }
    
    func sliderValueChanging(_ slider: SDGradientSlider) {
        print(slider.value as Any)
    }
    
    
}

// 知识点播放bar
class SDKnowledgePlayerBottomView: UIView {
    lazy var gradientLayer:CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
        gradientLayer.colors = [UIColor.gray.cgColor,UIColor.gray.cgColor]
//        gradientLayer.colors = [UIColor.extColorWithHex("000000", alpha: 0.0).cgColor,UIColor.extColorWithHex("000000", alpha: 0.7).cgColor]
           return gradientLayer
    }()
    lazy var leftPointButton: SDKnowledgePointsView = {
        var pointButton = SDKnowledgePointsView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), .leftDirection)
        pointButton.backgroundColor = .clear
        return pointButton
    }()
    lazy var rightPointButton: SDKnowledgePointsView = {
        var pointButton = SDKnowledgePointsView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), .rightDirection)
        pointButton.backgroundColor = .clear
        return pointButton
    }()
    lazy var playerSliderView: SDKnowledgePlayerSliderView = {
        var pointButton = SDKnowledgePlayerSliderView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width - (rightPointButton.viewsWidth * 2), height: 24))
        pointButton.backgroundColor = .white
        return pointButton
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWidget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWidget(){
        self.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.bounds
        self.addSubview(leftPointButton)
        self.addSubview(rightPointButton)
        self.addSubview(playerSliderView)
        playerSliderView.playerSlider.setSliderValue(0.5)

        leftPointButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(0)
            make.size.equalTo(CGSize.init(width: leftPointButton.viewsWidth, height: leftPointButton.viewsHeight))
        }
        rightPointButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(0)
            make.size.equalTo(CGSize.init(width: rightPointButton.viewsWidth, height: rightPointButton.viewsHeight))
        }
        playerSliderView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize.init(width: self.frame.size.width - (rightPointButton.viewsWidth * 2), height: 24))
        }
        
    }
}



// 左右知识点片段
enum SDPointsDirection {
    case leftDirection
    case rightDirection
}
class SDKnowledgePointsView: UIView {
    public var viewsDirection: SDPointsDirection = .leftDirection
    public let viewsWidth: CGFloat = 15 + 4*25 + 3 * 5
    public let viewsHeight: CGFloat = 10.0

    init(frame: CGRect,_ direction: SDPointsDirection){
        super.init(frame: frame)
        viewsDirection = direction
        initWidget()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWidget(){
        let buttonArray = [UIButton(), UIButton(), UIButton(), UIButton()]
        let alphaArray = [0.5, 0.35, 0.25, 0.10]
        var alphaphArray = [0.0, 0.0, 0.0, 0.0]
        let tempArray = [1, 2, 3, 4]
        
        for(idx,_) in tempArray.enumerated() {
            guard alphaphArray.count >= tempArray.count else {
                return
            }
            alphaphArray[idx] = alphaArray[idx]
        }
        
        for(idx,btn) in buttonArray.enumerated() {
            btn.backgroundColor = .white
            btn.clipsToBounds = true
            btn.layer.cornerRadius = 5
            if viewsDirection == .leftDirection{
                btn.frame = CGRect.init(x: idx * 30 + 15, y: 0, width: 25, height: Int(viewsHeight))
                btn.alpha = CGFloat(alphaphArray.reversed()[idx])
            }else{
                btn.frame = CGRect.init(x: idx * 30, y: 0, width: 25, height: Int(viewsHeight))
                btn.alpha = CGFloat(alphaphArray[idx])
            }
            self.addSubview(btn)
        }
    }
    
}
