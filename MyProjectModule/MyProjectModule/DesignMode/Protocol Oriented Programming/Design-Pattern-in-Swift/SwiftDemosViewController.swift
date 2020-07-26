//
//  SwiftDemosViewController.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/23.
//  Copyright © 2019 xinxin. All rights reserved.
//

import UIKit
import SDWebImage

class SwiftDemosViewController: AbstractViewController {
    
    var list = [SDBarrageInfo]()

    lazy var cycleView: SDCycleView =  {
        let cycle = SDCycleView(frame: CGRect.init(x: 0, y: 200, width: self.view.frame.width, height: 200))
        cycle.scrollDirection = .horizontal
        cycle.isInfinite = true
        cycle.isAutomatic = true
        cycle.placeholderImage = UIImage(named: "弹窗")
        cycle.setImagesGroup([UIImage(named: "exercise_ZTYL_point"),UIImage(named: "mine_train_tree_two_open")])
        cycle.delegate = self
        return cycle
    }()
    
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
        print(cache.removeHead() as Any)


        
        
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
        let aC = AChain.init("A", CGRect.init(x: 50, y: 50, width: 50, height: 50))
        aC.backgroundColor = .red
        let bC = BChain.init("B", CGRect.init(x: 50, y: 50, width: 50, height: 50))
        bC.backgroundColor = .yellow
        let cC = CChain.init("C", CGRect.init(x: 50, y: 50, width: 50, height: 50))
        cC.backgroundColor = .blue
        let chain = BindResponderOfChain.init()
        chain.initWith { (link) in
            _ = link.next(aC).next(bC).next(cC)
        }
        let model = BlockModel()
        aC.sendEvent(eventType: -11111, with: model)
        
        print(chain.getChainList())
        print(chain.headerNode as Any)
        print(chain.lastNode as Any)
        
        
        //MARK:- SilderShow
//        view.addSubview(self.cycleView)
        
        //MARK:- customBar
        let bar = SDCustomStatusBarView.init(frame: CGRect.init(x: 0, y: 180, width: self.view.frame.width, height: 20))
        bar.backgroundColor = .gray
        view.addSubview(bar)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        CustomPopCover.coverFrom(contentView: self.cycleView)
    
    }
    
    deinit {
        print("deinit")
    }
    
}




extension SwiftDemosViewController: SDCycleViewProtocol {
    /// 显示本地图片，需要实现下面的代理方法
    func cycleViewConfigureDefaultCellImage(_ cycleView: SDCycleView, imageView: UIImageView, image: UIImage?, index: Int) {
            imageView.image = image
            imageView.layer.borderColor = UIColor.gray.cgColor
            imageView.layer.borderWidth = 1
    }
    
    /// 要显示网络图片，需要实现下面的代理方法
    func cycleViewConfigureDefaultCellImageUrl(_ cycleView: SDCycleView, imageView: UIImageView, imageUrl: String?, index: Int) {
        imageView.sd_setImage(with: URL(string: imageUrl!), placeholderImage: cycleView.placeholderImage)
    }
    
    /// 修改label的样式，你可以使用下面的代理方法
    func cycleViewConfigureDefaultCellText(_ cycleView: SDCycleView, titleLabel: UILabel, index: Int) {
    }
    
    /// 修改pageControl的样式，你可以使用下面的代理方法
    func cycleViewConfigurePageControl(_ cycleView: SDCycleView, pageControl: SDPageControl) {
        pageControl.alignment = .center
        pageControl.spacing = 10
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.dotSize = CGSize(width: 20, height: 10)
    }
    
    func cycleViewDidSelectedIndex(_ cycleView: SDCycleView, index: Int) {
        print(index)
    }
}

//MARK: - String 转 VC
extension String{
    func stringChangeToVC() -> UIViewController?{
        //Swift中命名空间的概念
        var vc = UIViewController()
        if let nameSpage = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String {
            if let childVcClass = NSClassFromString(nameSpage + "." + self) {
                if let childVcType = childVcClass as? UIViewController.Type {
                    //根据类型创建对应的对象
                    vc = childVcType.init() as UIViewController
                    return vc
                }
            }
        }
        return nil
    }
}
