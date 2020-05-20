//
//  SDTimeAlertPickerView.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/11/1.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit
import SnapKit
let IS5SBOOL =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 640, height: 1136).equalTo((UIScreen.main.currentMode?.size)!) : false)
let IS6SBOOL =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 750, height: 1334).equalTo((UIScreen.main.currentMode?.size)!) : false)
let IS6SPBOOL =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2208).equalTo((UIScreen.main.currentMode?.size)!) : false)
let ISXBOOL =  (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false)

// 参数宏
func WidthRank(A:CGFloat, B:CGFloat, C:CGFloat, D:CGFloat, E:CGFloat) -> CGFloat {
    return (IS5SBOOL ? A : (IS6SBOOL ? B : (IS6SPBOOL ? C : (ISXBOOL ? D : E))))
}
func FontRank(A:CGFloat, B:CGFloat, C:CGFloat, D:CGFloat, E:CGFloat) -> CGFloat {
    return (IS5SBOOL ? A : (IS6SBOOL ? B : (IS6SPBOOL ? C : (ISXBOOL ? D : E))))
}


class SDTimeAlertPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource{
    typealias AlertPickCallBack = (_ currentHour :String,_ currentMinute :String) -> Void
    var buttonClick: AlertPickCallBack?
    
    struct PickerDataSource {
        var isLoop :Bool = false
        var width :CGFloat = 0
        var tag :NSInteger = 0
        var pickerArray :NSArray = NSArray()
        var label :UILabel = UILabel()
    }
    
    private var pickerView = SDOPickerView.init(frame: CGRect.zero)
    private var currentHour :String = "00"
    private var currentMinute :String = "00"
    private var pickerDataSize :NSInteger = 0
    private var pickerLabel :UILabel = UILabel()
    var pickerDataSources = [PickerDataSource]()


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    touchesBegan点击事件拦截 手势
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = ((touches as NSSet).anyObject() as AnyObject)
        let point = touch.location(in:self)
        if self.bgView.frame.contains(point){
            return
        }
        self.hideAnimation()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeupData()
        updatePickView()
    }
    
    
    func setupUI() -> Void {
        self.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.backgroundColor = UIColor.gray
//        self.backgroundColor =  UIColor.extColorWithHex("000000", alpha: 0.4)
        self.addSubview(self.bgView)
        pickerView.delegate = self
        pickerView.dataSource = self
        self.bgView.addSubview(pickerView)
        self.bgView.addSubview(pickButton)
        
        pickerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.bgView).offset(0)
            make.left.equalTo(self.bgView).offset(50)
            make.right.equalTo(self.bgView).offset(-50)
            make.height.equalTo(100)
        }
        pickButton.snp.makeConstraints { (make) in
            make.top.equalTo(pickerView.snp_bottom).offset(10)
            make.centerX.equalTo(pickerView)
            make.height.equalTo(36)
            make.width.equalTo(139)
        }

        self.showAnimation()
    }
    
    func makeupData() {
        let day = PickerDataSource.init(isLoop: false, width: pickerView.frame.width / WidthRank(A: 5.5, B: 5.5, C: 5.5, D: 5.5, E: 5.5), tag: 101, pickerArray: ["每天"], label: pickerLabel)
        let hour = PickerDataSource.init(isLoop: true, width: pickerView.frame.width / WidthRank(A: 5.5, B: 5.5, C: 5.5, D: 5.5, E: 5.5), pickerArray: fetchHours, label: pickerLabel)
        let link = PickerDataSource.init(isLoop: false, width: pickerView.frame.width / WidthRank(A: 18.5, B: 18.5, C: 18.5, D: 18.5, E: 18.5), tag: 101, pickerArray: [":"], label: pickerLabel)
        let minute = PickerDataSource.init(isLoop: true, width: pickerView.frame.width / WidthRank(A: 5.5, B: 5.5, C: 5.5, D: 5.5, E: 5.5), pickerArray: fetchMinutes, label: pickerLabel)
        pickerDataSources = [day,hour,link,minute]
        pickerDataSize = 10000
    }

    func updatePickView() -> Void {
        var hourIndex = 24
        var minuteIndex = 10
        hourIndex = hourIndex > self.fetchHours.count - 1 ? self.fetchHours.count - 1 : hourIndex;
        minuteIndex = minuteIndex > self.fetchMinutes.count - 1 ? self.fetchMinutes.count - 1 : minuteIndex;
//        pickerView.selectRow(0, inComponent: 0, animated: true)
//        pickerView.selectRow(0, inComponent: 1, animated: true)
//        pickerView.selectRow(0, inComponent: 2, animated: true)
//        pickerView.selectRow(0, inComponent: 3, animated: true)

//        pickerView.reloadAllComponents()


    }
    

    
    //MARK:- PickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerDataSources.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSources[component].pickerArray.count * (pickerDataSources[component].isLoop ? pickerDataSize :1)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        return pickerDataSources[component].width
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel.init()
        label.textAlignment = .center
        //label.textColor = UIColor.extColorWithHex("0x4A4A4A", alpha: 1)
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: FontRank(A: 23, B: 23, C: 23, D: 23, E: 23)) ?? UIFont.boldSystemFont(ofSize: 23)
        label.tag = pickerDataSources[component].tag
        label.text = (pickerDataSources[component].pickerArray[row % pickerDataSources[component].pickerArray.count] as! String)
        return label;
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentHour = component == 1 ? (pickerDataSources[1].pickerArray[row % pickerDataSources[1].pickerArray.count] as! String) : currentHour
        currentMinute = component == 3 ? (pickerDataSources[3].pickerArray[row % pickerDataSources[3].pickerArray.count] as! String) : currentMinute
        
    }
    
    //MARK:- Private Method

    @objc func setSel(){
        if buttonClick != nil {
            buttonClick!(currentHour,currentMinute)
        }
    }
    
    //MARK:- Public Method
    func showAnimation(){
        UIView.animate(withDuration: 0.5 , delay: 0 , usingSpringWithDamping: 0.5 , initialSpringVelocity: 8 , options: [] , animations: {
          var frame = self.bgView.frame;
          frame.origin.y = UIScreen.main.bounds.height-170;
          self.bgView.frame = frame
        }, completion: nil)
    }
    
    func hideAnimation(){
        UIView.animate(withDuration: 0.5, animations: {
            var frame = self.bgView.frame;
            frame.origin.y = UIScreen.main.bounds.height;
            self.bgView.frame = frame
        }) { (finished :Bool) in
            self.bgView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }

    //MARK:- Lazy
    private lazy var pickButton: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 139, height: 36))
        button.setTitle("完成", for: .normal)
        button.addTarget(self, action: #selector(setSel), for: .touchUpInside)
        button.layer.cornerRadius = 18
        button.backgroundColor = UIColor.blue
//        button.backgroundColor = UIColor.extColorWithHex("#0C65F6", alpha: 1)
//        button.setTitleColor(UIColor.extColorWithHex("#FFFFFF", alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "PingFangSC-Semibold", size: 18) ?? UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    lazy private var bgView :UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 170))
        view.backgroundColor = UIColor.white
        view.exCorner(byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.topRight], radii: 10)
        return  view
    }()
    
    lazy private var fetchHours: NSArray = {
        var hours = NSMutableArray()
        for i in 0...23 {
            var str = "\(i)"
            if i < 10 {
                str = "0\(i)"
            }
            
            hours.add(str)
            
        }
        return hours.copy() as! NSArray
    }()
    
    lazy private var fetchMinutes: NSArray = {
        var minutes = NSMutableArray()
        for i in 0...59 {
            var str = "\(i)"
            if i < 10 {
                str = "0\(i)"
            }
            minutes.add(str)
        }
        return minutes.copy() as! NSArray
    }()

    
}
