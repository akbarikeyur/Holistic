//
//  HomeAPIManager.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/12/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

public class HomeAPIManager {

static let shared = HomeAPIManager()

    func serviceCallToGetTask(_ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_TASK_LIST, ["user_id" : AppModel.shared.currentUser.id!], true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let data = dict["data"] as? [[String : Any]] {
                    completion(data)
                    return
                }
            }
        }
    }
    
    func serviceCallToCompleteTask(_ param : [String : Any], _ completion: @escaping () -> Void) {
        APIManager.shared.callPostRequest(API.MAKE_TASK_COMPLETE, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion()
                return
            }
        }
    }
    
    func serviceCallToGetMissedTask(_ param : [String : Any], _ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_MISSED_TASK_LIST, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let data = dict["data"] as? [[String : Any]] {
                    completion(data)
                    return
                }
            }
        }
    }
    
    func serviceCallToGetNotification(_ param : [String : Any], _ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_NOTIFICATION, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let dataDict = dict["data"] as? [String : Any] {
                    if let data = dataDict["data"] as? [[String : Any]] {
                        completion(data)
                        return
                    }
                }
                
            }
        }
    }
}
