//
//  Command.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/29.
//  Copyright © 2019 xinxin. All rights reserved.
//
/*
 The command pattern is used to express a request, including the call to be made and all of its required parameters, in a command object. The command may then be executed immediately or held for later use.
 
 
 命令模式（Command Pattern）是一种数据驱动的设计模式，它属于行为型模式。请求以命令的形式包裹在对象中，并传给调用对象。调用对象寻找可以处理该命令的合适的对象，并把该命令传给相应的对象，该对象执行命令。
 
 认为是命令的地方都可以使用命令模式，比如：
 GUI 中每一个按钮都是一条命令。
 模拟 CMD。
 在某些场合，比如要对行为进行"记录、撤销/重做、事务"等处理，这种无法抵御变化的紧耦合是不合适的。在这种情况下，如何将"行为请求者"与"行为实现者"解耦？将一组行为抽象为对象，可以实现二者之间的松耦合。
 
 
 优点
 降低了系统耦合度。
 新的命令可以很容易添加到系统中去。
 
 缺点
 使用命令模式可能会导致某些系统有过多的具体命令类

 */

//定义一个命令协议(关于门的命令协议)
protocol DoorCommand {
    
    func execute() -> String
}

//创建开门命令类(遵循门的命令协议)

final class OpenCommand: DoorCommand {
    let doors:String
    
    required init(doors: String) {
        self.doors = doors
    }
    
    func execute() -> String {
        return "Opened \(doors)"
    }
}

//创建关门命令类(遵循门的命令协议)
final class CloseCommand: DoorCommand {
    let doors:String
    
    required init(doors: String) {
        self.doors = doors
    }
    
    func execute() -> String {
        return "Closed \(doors)"
    }
}

//自定义一个门
final class HAL9000DoorsOperations {
    let openCommand: DoorCommand
    let closeCommand: DoorCommand
    
    init(doors: String) {
        self.openCommand = OpenCommand(doors:doors)
        self.closeCommand = CloseCommand(doors:doors)
    }
    
    func close() -> String {
        return closeCommand.execute()
    }
    
    func open() -> String {
        return openCommand.execute()
    }
}

/*:
 ### Usage:
 */
let podBayDoors = "Pod Bay Doors"
let doorModule = HAL9000DoorsOperations(doors:podBayDoors)

//doorModule.open()
//doorModule.close()

