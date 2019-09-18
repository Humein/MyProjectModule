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

        //MARK:  面向协议
        
        let f = FirstView()
        let s = SecendView()
        f.eat()
        s.eat()
        
        
        //MARK:  strategy Usage
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
