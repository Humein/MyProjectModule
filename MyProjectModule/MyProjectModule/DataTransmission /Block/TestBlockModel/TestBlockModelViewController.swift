//
//  TestBlockModelViewController.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/11/15.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit

class TestBlockModelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = AView(), b = BView(), c = CView()
        let model = BlockModel()
        a.refreshView(model)

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
