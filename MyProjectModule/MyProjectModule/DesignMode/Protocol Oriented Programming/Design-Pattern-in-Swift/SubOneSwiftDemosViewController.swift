//
//  SubOneSwiftDemosViewController.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/5/12.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// 测试弹幕
class SubOneSwiftDemosViewController: SwiftDemosViewController {
    lazy var danmuView: SDBarrageView = {
        var danmuView = SDBarrageView(frame: CGRect(x: 0, y: 50, width: self.view.width(), height: 150))
        return danmuView
    }()
    
    lazy var switchView: SDBarrageSwitchView = {
        var switchView = SDBarrageSwitchView(frame: CGRect(x: 0, y: 50, width: 29, height: 29))
        return switchView
    }()
    
    override func viewDidLoad() {
        self.view.addSubview(switchView)
        
        
        
        
        
        
        switchView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(88)
            make.left.equalTo(self.view).offset(40)
            make.size.equalTo(CGSize.init(width: 28.5, height: 28.5))
        }
        switchView.tapBlock = {[weak self] tapTypes in
            switch tapTypes {
            case .tagInputType:
                break
            case .isSelectedType:
                self?.danmuResume()
                break
            case .unselectedType:
                self?.danmuReset()
                break
            }
        }
    }
    
    func danmuResume(){
        let timer = Timer(timeInterval: 2.0, target: self, selector: #selector(calculateRate), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
         self.view.addSubview(danmuView)
        danmuView.resume()
    }
    
    func danmuReset(){
        danmuView.removeAll()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        SDDeviceOrientation.sharedInstance.allowRotation(self)
         SDDeviceOrientation.sharedInstance
         .screenExChangeforOrientation(.landscapeRight)
    }
    
    @objc func calculateRate() {
        for _ in 0...10 {
            let str1 = "姓名:"
            let str2 = "你说啥呢你说啥呢你说啥呢你说啥呢你说啥呢"
            let mutableStr = NSMutableAttributedString.init(string: "\(str1) \(str2)")
            mutableStr.setColor(.red, range: NSRange.init(location: 0, length: str1.count))
            mutableStr.setColor(.black, range:NSRange.init(location: str1.count, length: str2.count))
            let ainfo = SDBarrageInfo.init(attrText: mutableStr, aItemViewClass: SDBarrageBgItemView.self)
            list.append(ainfo)
        }
        if danmuView.pendingList.count > 100 {
            return
        }
        
        danmuView.pendingList.append(contentsOf: list)
    }
}


// 弹出弹幕按钮
enum SDBarrageTapTypes {
    case isSelectedType
    case unselectedType
    case tagInputType
}
class SDBarrageSwitchView: UIView {
    let disposeBag = DisposeBag()
    typealias TapTypesBlock = (SDBarrageTapTypes) -> Void
    public var tapBlock :TapTypesBlock?

    lazy var switchButton: UIButton = {
        var switchButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 28.5, height: 28.5))
        switchButton.backgroundColor = .red
        switchButton.isSelected = false
        return switchButton
    }()
    
    lazy var inputBarrage: UILabel = {
        var inputBarrage = UILabel.init(frame: CGRect.init(x: 28.5 + 10, y: 0, width: 98, height: 25))
        inputBarrage.backgroundColor = .black // #000000
        inputBarrage.alpha = 0.3
        inputBarrage.text = "弹幕走一波…"
        inputBarrage.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        inputBarrage.textAlignment = .center
        inputBarrage.textColor = .white // #FFFFFF
        inputBarrage.clipsToBounds = true
        inputBarrage.layer.cornerRadius = 4
        return inputBarrage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWidget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initWidget() {
        self.addSubview(switchButton)
        self.addSubview(inputBarrage)
        switchButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(0)
            make.size.equalTo(CGSize.init(width: 28.5, height: 28.5))
        }
        inputBarrage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(switchButton.snp_right).offset(10)
            make.size.equalTo(CGSize.init(width: 0, height: 25))
        }
        
        switchButton.rx.tap.subscribe(onNext:{ [weak self] in
            self?.switchButton.isSelected = !(self?.switchButton.isSelected)!
            self?.refreshFrame(newWidth: (self?.switchButton.isSelected)! ? 98 : 0)
            self?.tapBlock?((self?.switchButton.isSelected)! ? .isSelectedType : .unselectedType)
        }).disposed(by: disposeBag)
        
        //rx添加一个点击手势
        let tap = UITapGestureRecognizer()
        inputBarrage.addGestureRecognizer(tap)
        tap.rx.event.subscribe(onNext: { [weak self] _ in
            self?.tapBlock?(.tagInputType)

        }).disposed(by: disposeBag)
    }
    
    func refreshFrame(newWidth: CGFloat){
        self.inputBarrage.snp.updateConstraints { (make) in
            make.size.equalTo(CGSize.init(width: newWidth, height: 25))
        }
        /**
         layout 动画更新 约束变化后视图更新
         可以使用layoutIfNeeded()立即更新视图布局，使用setNeedsLayout()在下个绘图周期中触发布局更新。这两个方法都会触发layoutSubviews()方法。
         */
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }

    //解决子控件超出父控件的时候无法点击的问题
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var vi = super.hitTest(point, with: event)
        if vi == nil {
            let newPoint = inputBarrage.convert(point, from: self)
            if inputBarrage.bounds.contains(newPoint) {
                vi = inputBarrage
            }
        }
        return vi
    }
    
}
