//
//  TestOnewCollecionViewController.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/5/15.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit

class TestOnewCollecionViewController: UIViewController,SDCardSwitchDelegate,SDCardSwitchDataSource {
    func cardSwitchNumberOfCard() -> (Int) {
        return self.cellInfoArr().count
    }
    
    func cardSwitchCellForItemAtIndex(index: Int) -> (UICollectionViewCell) {
        let cell = self.cardSwitch.dequeueReusableCell(withReuseIdentifier:"CustomCellID", for: index) as! AbstractCollectionViewCell
        return cell
    }
    
    func cellInfoArr() -> Array<(String, String)> {
        return [("1","fword"),("1","fword"),("1","fword"),("1","fword"),("1","fword"),("1","fword"),("1","fword"),("1","fword"),("1","fword"),("1","fword")]
    }

    //滚动卡片
    lazy var cardSwitch: SDPointsTransformView = {
        let temp = SDPointsTransformView.init()
        temp.frame = CGRect.init(x: 0, y: 120, width: self.view.frame.size.width, height: 180)
        temp.dataSource = self
        temp.delegate = self
        temp.pagingEnabled = true
        //注册cell
        temp.register(cellClass: AbstractCollectionViewCell.self, forCellWithReuseIdentifier:"CustomCellID")
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SDDeviceOrientation.sharedInstance.allowRotation(self)
         SDDeviceOrientation.sharedInstance
         .screenExChangeforOrientation(.landscapeRight)

        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        self.view.addSubview(self.cardSwitch)

    }


}
