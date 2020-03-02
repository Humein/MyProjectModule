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
        
        //MARK:-  面向协议编程
        let AB = ActionButton(), FI = FoodImageView(), AO = ActionObject()
        AB.shake()
        AB.ex_shake()
        AB.protocol_shake(); AB.protocol_close() // 组合
        FI.shake()
        FI.ex_shake()
        FI.protocol_shake(); FI.protocol_close() // 组合
        // AO.protocol_shake()  -- where Self: UIView 限制只能UIView
        AO.protocol_close()
        var modelProtocol :[CloseDelegate] = [CloseDelegate]()
        
        
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
        
        //MARK:- LRU
        let cache = LRUCacheSimple(2)
        cache.put(1, 1)
        cache.put(2, 2)
        cache.put(3, 3)
        cache.put(4, 4)
        print(cache.get(4))
        print(cache.get(3))
        print(cache.get(2))
        print(cache.get(1))
        
        let cache1 = LRUCache<Any>.init(size: 2)
        cache1.put(key: 1, val: 1)
        cache1.put(key: 2, val: "2")
        cache1.put(key: 3, val: cache)
        cache1.put(key: 4, val: 4)
        print(cache1.get(key: 4))
        print(cache1.get(key: 3))
        print(cache1.get(key: 2))
        print(cache1.get(key: 1))
        

        //MARK:- 链式编程 以及 双向链表
//        let linkC = DoublyLinkedList.init()
        
        
        //MARK:- chain
        let aC = AChain.init("A")
        let bC = BChain.init("B")
        let cC = CChain.init("C")
        let chain = BindResponderOfChain.init()
        chain.initWith { (link) in
            _ = link.next(aC).next(bC).next(cC)
        }
        let model = BlockModel()
        aC.sendEvent(eventType: -1, with: model)
        
        print(chain.getChainList())
        print(chain.headerNode as Any)
        print(chain.lastNode as Any)
        
        
    }

}
