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
    
    struct PickerDataSource {
        var isLoop :Bool = false
        var width :CGFloat = 0
        var tag :NSInteger = 0
        var pickerArray :NSArray = NSArray()
        var label :UILabel = UILabel()
    }
    
    private var pickerView = SDOPickerView.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300))
    private var currentHour :NSInteger = 0
    private var currentMinute :NSInteger = 0
    private var pickerDataSize :NSInteger = 0
    private var pickerLabel :UILabel = UILabel()
    var pickerDataSources = [PickerDataSource]()


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    
    func setUpUI() -> Void {
        self.frame = CGRect.init(x: 0, y: 0, width: 300, height: 300)
        self.backgroundColor = UIColor.gray
        pickerDataSize = 10000
        pickerView.delegate = self
        pickerView.dataSource = self
        let day = PickerDataSource.init(isLoop: false, width: pickerView.frame.width / WidthRank(A: 5.5, B: 5.5, C: 5.5, D: 5.5, E: 5.5), tag: 101, pickerArray: ["每天"], label: pickerLabel)
        let hour = PickerDataSource.init(isLoop: true, width: pickerView.frame.width / WidthRank(A: 5.5, B: 5.5, C: 5.5, D: 5.5, E: 5.5), pickerArray: fetchHours, label: pickerLabel)
        let link = PickerDataSource.init(isLoop: false, width: pickerView.frame.width / WidthRank(A: 6.5, B: 6.5, C: 6.5, D: 6.5, E: 6.5), tag: 101, pickerArray: [":"], label: pickerLabel)
        let minute = PickerDataSource.init(isLoop: true, width: pickerView.frame.width / WidthRank(A: 5.5, B: 5.5, C: 5.5, D: 5.5, E: 5.5), pickerArray: fetchMinutes, label: pickerLabel)
        pickerDataSources = [day,hour,link,minute]
        self.addSubview(pickerView)
        updatePickView()
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
//        currentHour = pickerDataSources[component].pickerArray[row % pickerDataSources[component].pickerArray.count] as! NSInteger
        
    }

    
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
