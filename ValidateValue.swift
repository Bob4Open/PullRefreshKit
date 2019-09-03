//
//  ValidateValue.swift
//  
//
//  Created by Bob Wu on 2017/7/19.
//  Copyright © 2017 Bob. All rights reserved.
//

import Foundation

protocol ValidateValue {
    associatedtype Object = Self
    init()
    static func validateValue<T: Any>(_ data: T?) -> Object
}

extension ValidateValue {
    static func validateValue<T: Any>(_ data: T?) -> Object {
        
        switch self {
        case _ as String.Type:
            if data == nil {
                return "" as! Object
            }
            let rString = "\(data!)"
            if rString == "<null>" {
                return "" as! Object
            }
            return rString as! Object
            
        case _ as Bool.Type:
            if let result = data as? Bool {
                return result as! Object
            }
            return false as! Object
            
        case _ as Double.Type,
             _ as CGFloat.Type,
             _ as Int.Type:
            if let rst = (data as AnyObject).doubleValue {
                return rst as! Object
            }
            return 0 as! Object

        case _ as Int64.Type:
            if data == nil {
                return 0 as! Object
            } else {
                return (data as AnyObject).longLongValue as! Object
            }

        case _ as Date.Type:
            if let r = data as? Date {
                return r as! Object
            }
            return Date() as! Object

        case _ as NSDictionary.Type:
            if let nsDict = data as? NSDictionary {
                return nsDict as! Object
            }
            return NSDictionary() as! Object

        case _ as Dictionary<String, Any>.Type:
            if let dict = data as? Dictionary<String, Any> {
                return dict as! Object
            }
            return Dictionary<String, Any>() as! Object

        case _ as NSArray.Type:
            if let nsArray = data as? NSArray {
                return nsArray as! Object
            }
            return NSArray() as! Object

        case _ as Array<Any>.Type:
            if let r = data as? Array<Any> {
                return r as! Object
            }
            return Array<Any>() as! Object
            
        default:
            break
        }
        
        if let s = data as? Object {
            return s
        }
        
        return Self.init() as! Object
    }
}

extension Bool: ValidateValue { }
extension String: ValidateValue { }
extension Double: ValidateValue { }
extension CGFloat: ValidateValue { }
extension Int: ValidateValue { }
extension Int64: ValidateValue { }
extension Date: ValidateValue { }
extension NSDictionary: ValidateValue { }
extension Dictionary: ValidateValue { }
extension NSArray: ValidateValue { }
extension Array: ValidateValue { }

