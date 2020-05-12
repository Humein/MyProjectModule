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

//
class GradientProgressView: UIProgressView {
    
}


// 知识点播放进度
class SDKnowledgePlayerSliderView: UIView {
    lazy var currentTimeLabel: UILabel = {
        var inputBarrage = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 17))
        inputBarrage.backgroundColor = .clear
        inputBarrage.text = "6:00"
        inputBarrage.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        inputBarrage.textAlignment = .center
        inputBarrage.textColor = .white // #FFFFFF
        inputBarrage.clipsToBounds = true
        return inputBarrage
    }()
    lazy var totalTimeLabel: UILabel = {
        var inputBarrage = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 17))
        inputBarrage.backgroundColor = .clear
        inputBarrage.text = "12:00"
        inputBarrage.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        inputBarrage.textAlignment = .center
        inputBarrage.textColor = .white // #FFFFFF
        return inputBarrage
    }()
    lazy var playerSlider: GradientProgressView = {
        var pointButton = GradientProgressView.init(frame: CGRect.init(x: 0, y: 0, width: 310, height: 24))
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
        self.addSubview(playerSlider)
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
        var pointButton = SDKnowledgePlayerSliderView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        pointButton.backgroundColor = .clear
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
            make.right.equalTo(rightPointButton.snp_left).offset(0)
            make.left.equalTo(leftPointButton.snp_right).offset(0)
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
