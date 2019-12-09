//
//  SwiftDemosViewController.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/23.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

class SwiftDemosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK:-  面向协议
        
        let f = FirstView()
        f.eat("default")
        f.drink()
        
        //MARK-  面向协议编程
        let AB = ActionButton(), FI = FoodImageView()
        AB.shake()
        AB.ex_shake()
        FI.shake()
        FI.ex_shake()
        
        
        
        //MARK:-  strategy Usage
        let rachel = TestSubject(pupilDiameter: 30.2,
                                 blushResponse: 0.3,
                                 isOrganic: false)
        
        // strategy 1
        let deckard = BladeRunner(test: VoightKampffTest())
        _ = deckard.testIfAndroid(rachel)
        deckard.videoPlay()
        // strategy 2
        let gaff = BladeRunner(test: GeneticTest())
        _ = gaff.testIfAndroid(rachel)
        gaff.videoPlay()

    }


}
