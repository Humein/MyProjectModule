//
//  SDTimerObserver.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/10.
//  Copyright © 2020 xinxin. All rights reserved.
//
import UIKit
/**
 需要接收定时器回调的模块，只要实现TimerObserver协议，在需要接收定时器回调的时把其添加到TimerService中，在业务不需要接收定时器回调的时候把其从TimerService中移除即可，这样所有的倒计时业务只需要维护一个定时器即可搞定
 */
@objc protocol TimerObserverDelegate: AnyObject {
    func timerCallBack(timer: SDTimerObserver)
}

class SDTimerObserver: NSObject {
    ///  静态类型属性创建简单的单例对象，它保证只被惰性初始化一次，即使是在多个线程同时访问时:
    @objc static let sharedInstance: SDTimerObserver = {
        let instance = SDTimerObserver()
        // setup code
        instance.loadDefaultConfig()
        return instance
    }()

    private var operationsLock: DispatchSemaphore? = nil
    private var timerMap: NSHashTable<AnyObject>?
    private var timer: Timer? = nil

    private func loadDefaultConfig(){
        operationsLock = DispatchSemaphore(value: 1)
        timerMap = NSHashTable.init(options: [.objectPointerPersonality,.weakMemory], capacity: 0)
    }
    
    private func startTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(trigger), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .common)
        }
    }
    
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func trigger(_ timer: Timer){
        for(_,item) in (timerMap?.allObjects.enumerated())!{
            if let listener = item as? TimerObserverDelegate {
                listener.timerCallBack(timer: self)
            }
        }
    }
    
    /// 添加定时器监听
    /// - Parameter listener: TimerObserverDelegate
    @objc public func addTimerObserver(_ listener: TimerObserverDelegate){
        operationsLock?.wait() // -1
        guard timerMap != nil else {
            return
        }
        if timerMap?.contains(listener) == false {
            timerMap?.add(listener)
            if timerMap!.count > 0 {
                startTimer()
            }
        }
        operationsLock?.signal() // +1
    }
    
    /// 移除监听 就算忘记了,只是Timer没被销毁, 也不影响使用者销毁；
    /// - Parameter listener: TimerObserverDelegate
    @objc public func removeTimerObserver(_ listener: TimerObserverDelegate){
        operationsLock?.wait() // -1
        guard timerMap != nil else {
            return
        }
        if timerMap?.contains(listener) == true {
            timerMap?.remove(listener)
            if timerMap!.count == 0 {
                stopTimer()
            }
        }
        operationsLock?.signal() // +1
    }
    
}



/// 秒-格式化-时分秒
/// - Parameter sec: Int
/// - Return HH,MM,SS
func secCalculate(with sec: Int) -> (NSString, NSString, NSString){
    let hour = sec / (60 * 60)
    let minute = (sec - hour * 60 * 60) / 60
    let second = (sec - hour * 60 * 60) % 60
    let hh: NSString = NSString(format: "%02d", hour)
    let mm: NSString = NSString(format: "%02d", minute)
    let ss: NSString = NSString(format: "%02d", second)
    let time = (hh, mm, ss)    
    return time
}
