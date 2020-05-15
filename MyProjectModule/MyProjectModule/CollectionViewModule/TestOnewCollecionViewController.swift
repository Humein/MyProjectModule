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
        <#code#>
    }
    
    func cardSwitchCellForItemAtIndex(index: Int) -> (UICollectionViewCell) {
        <#code#>
    }
    

    //滚动卡片
    lazy var cardSwitch: SDPointsTransformView = {
        let temp = SDPointsTransformView.init()
        temp.frame = CGRect.init(x: 0, y: 400, width: self.view.frame.size.width, height: 100)
        temp.dataSource = self
        temp.delegate = self
        //注册cell
        temp.register(cellClass: CustomCollectionViewCell.self, forCellWithReuseIdentifier:"CustomCellID")
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
