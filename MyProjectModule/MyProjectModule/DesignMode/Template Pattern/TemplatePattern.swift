//
//  TemplatePattern.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/12/27.
//  Copyright © 2019 xinxin. All rights reserved.
//
/**
    模版模式属于最基础的设计模式，实际就是把不变的行为放在父类，把自定义行为放在子类. 主要的思想是将公共方法提取到父类。并且通过父类定义子类的框架。
 */
import UIKit

class TemplatePattern: NSObject {
    
    public func initPlayer() -> String{
        return "initPlayer"
    }
    
    public func play() -> String{
        return "play"
    }
    
    public func pause() -> String{
        return "pause"
    }
    
    public func stop() -> String{
        return "stop"
    }
}

class Player1: TemplatePattern {
    override func initPlayer() -> String {
        return "initPlayer1"
    }
}

class Player2: TemplatePattern {
    override func initPlayer() -> String {
        return "initPlayer2"
    }
}
