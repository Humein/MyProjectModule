//
//  SDCacheManagers.swift
//  MyProjectModule
//
//  Created by XinXin on 2020/4/10.
//  Copyright © 2020 xinxin. All rights reserved.
//

import UIKit
/**
 包含
- YYCache
  - key-value存储方式、线程安全。存储通过数据库+文件系统
  - YYCache存储自定义对象的时候，需要对该自定义对象先进行归档与反归档的操作，这样才能将其成功存储到本地
  - 大家可以统一用YYCache替代UserDefaults，以及NSKeyedArchiver
- 数据库
  - 利用运行时的class_getProperty方法和KVC机制构造对象，返回给外部对象，而不是FMDB直接返回的数据
  - 以model的属性创建表，以model为对象进行增删改查
  -     简单说就是，让一个对象映射了一个数据库里的表，然后针对这个对象做操作就等同于针对这个表以及这个对象所表达的数据做操作。这里有一个不好的地方就在于，这个Record既是数据库中数据表的映射，又是这个表中某一条数据的映射。
  - 另外，数据操作和数据表达混在一起会导致的问题在于：客观情况下，数据在view层业务上的表达方式多种多样，有可能是个View，也有可能是个别的什么对象。如果采用映射数据库表的数据对象去映射数据，那么这种多样性就会被限制，实际编码时每到使用数据的地方，就不得不多一层转换。
 - 
 */
class SDCacheManagers: NSObject {
    private var yyCache: YYCache?
    
    @objc static let sharedInstance: SDCacheManagers = {
        let instance = SDCacheManagers()
        instance.loadDefaultConfig()
        return instance
    }()

    private func loadDefaultConfig(){
        let home = NSHomeDirectory()
        let cachePath = "\(home)/Documents/CacheData/SDCacheManagers"
        yyCache = YYCache(path: cachePath)
    }

//MARK:- key-value 存储方式
    /// NSCoding对象(包括String、model、json、dic/array等容器)
    public func setObject(object: NSCoding?, forKey key: String, with block: (() -> Swift.Void)? = nil) {
        yyCache?.setObject(object, forKey: key, with: block)
    }
    
    public func object(forKey key: String) -> NSCoding?{
        return yyCache?.object(forKey: key)
    }
    
    /// Bool
    public func setBoolValue(boolValue:Bool, forKey key:String){
        let value = NSNumber(value: boolValue)
        yyCache?.setObject(value, forKey: key)
    }
    
    public func boolValue(forKey key:String)->Bool? {
        if let value = yyCache?.object(forKey: key) as? NSNumber {
            return value.boolValue
        }
        return nil
    }
    
    /// Int
    public func setIntValue(intValue:Int, forKey key:String)
    {
        let value = NSNumber(value: intValue)
        yyCache?.setObject(value, forKey: key)
    }
    
    public func intValue(forKey key:String)->Int? {
        if let value = yyCache?.object(forKey: key) as? NSNumber {
            return value.intValue
        }
        return nil
    }
    
    /// Float
    public func setFloatValue(floatValue:Float, forKey key:String)
    {
        let value = NSNumber(value: floatValue)
        yyCache?.setObject(value, forKey: key)
    }
    
    public func floatValue(forKey key:String)->Float? {
        if let value = yyCache?.object(forKey: key) as? NSNumber {
            return value.floatValue
        }
        return nil
    }
    
    /// Double
    public func setDoubleValue(doubleValue:Double, forKey key:String)
    {
        let value = NSNumber(value: doubleValue)
        yyCache?.setObject(value, forKey: key)
    }
    
    public func doubleValue(forKey key:String)->Double? {
        if let value = yyCache?.object(forKey: key) as? NSNumber {
            return value.doubleValue
        }
        return nil
    }
    
    /// remove object
    public func removeObject(forKey key: String, with block: ((String) -> Swift.Void)? = nil){
        yyCache?.removeObject(forKey: key, with: block)
    }

//MARK:- 表 存储方式
    
}
