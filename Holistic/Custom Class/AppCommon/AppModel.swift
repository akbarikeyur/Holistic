//
//  AppModel.swift
//  Ecommerce
//
//  Created by Keyur Akbari on 26/06/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class AppModel: NSObject {
    
    static let shared = AppModel()
    var currentUser : UserModel!
    
    func resetData() {
        currentUser = UserModel.init([String : Any]())
    }
    
    func getIntValue(_ dict : [String : Any], _ key : String) -> Int {
        if let temp = dict[key] as? Int {
            return temp
        }
        else if let temp = dict[key] as? String, temp != "" {
            return Int(temp)!
        }
        else if let temp = dict[key] as? Float {
            return Int(temp)
        }
        else if let temp = dict[key] as? Double {
            return Int(temp)
        }
        return 0
    }
    
    func getStringValue(_ dict : [String : Any], _ key : String) -> String {
        if let temp = dict[key] as? String {
            return temp
        }
        else if let temp = dict[key] as? Int {
            return String(temp)
        }
        else if let temp = dict[key] as? Float {
            return String(temp)
        }
        else if let temp = dict[key] as? Double {
            return String(temp)
        }
        return ""
    }
    
    func getFloatValue(_ dict : [String : Any], _ key : String) -> Float {
        if let temp = dict[key] as? Float {
            return temp
        }
        else if let temp = dict[key] as? String, temp != "" {
            return Float(temp)!
        }
        else if let temp = dict[key] as? Int {
            return Float(temp)
        }
        else if let temp = dict[key] as? Double {
            return Float(temp)
        }
        return 0
    }
    
    func getDoubleValue(_ dict : [String : Any], _ key : String) -> Double {
        if let temp = dict[key] as? Double {
            return temp
        }
        else if let temp = dict[key] as? String, temp != "" {
            return Double(temp)!
        }
        else if let temp = dict[key] as? Int {
            return Double(temp)
        }
        else if let temp = dict[key] as? Float {
            return Double(temp)
        }
        return 0
    }
}
