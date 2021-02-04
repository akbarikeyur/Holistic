//
//  ProfileAPIManager.swift
//  Holistic
//
//  Created by Keyur Akbari on 31/12/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

public class ProfileAPIManager {

    static let shared = ProfileAPIManager()

    func serviceCallToGetUserDetail(_ completion: @escaping () -> Void) {
        if !isUserLogin() || AppModel.shared.currentUser == nil || AppModel.shared.currentUser.id == 0 {
            return
        }
        APIManager.shared.callPostRequest(API.GET_USER_DETAIL, ["user_id" : AppModel.shared.currentUser.id!], false) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let data = dict["data"] as? [String : Any] {
                    AppModel.shared.currentUser = UserModel.init(data)
                    AppModel.shared.currentUser.points = AppModel.shared.getIntValue(dict, "points")
                    setLoginUserData()
                    NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
                }
                completion()
                return
            }
        }
    }
    
    func serviceCallToUpdateProfile(_ param : [String : Any], _ completion: @escaping () -> Void) {
        APIManager.shared.callPostRequest(API.SIGNUP, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion()
                return
            }
        }
    }
    
    func serviceCallToGetOffer( _ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_OFFER, [String : Any](), true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let dictData = dict["data"] as? [String : Any] {
                    if let data = dictData["data"] as? [[String : Any]] {
                        completion(data)
                        return
                    }
                }
            }
        }
    }
    
    func serviceCallToBookmarkOffer(_ param : [String : Any], _ completion: @escaping () -> Void) {
        APIManager.shared.callPostRequest(API.ADD_BOOKMARK_OFFER, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion()
                return
            }
        }
    }
    
    func serviceCallToGetBookmarkOffer(_ param : [String : Any], _ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_BOOKMARK_OFFER, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let dictData = dict["data"] as? [String : Any] {
                    if let data = dictData["data"] as? [[String : Any]] {
                        completion(data)
                        return
                    }
                }
            }
        }
    }
    
    func serviceCallToRemoveBookmarkOffer(_ param : [String : Any], _ completion: @escaping () -> Void) {
        APIManager.shared.callPostRequest(API.REMOVE_BOOKMARK_OFFER, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion()
                return
            }
        }
    }
    
    func serviceCallToGetOfferCode(_ param : [String : Any], _ completion: @escaping () -> Void) {
        APIManager.shared.callPostRequest(API.GET_OFFER_CODE, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion()
                return
            }
        }
    }
    
    func serviceCallToGetNotificationSetting(_ param : [String : Any], _ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_NOTI_SETTING, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let data = dict["data"] as? [[String : Any]] {
                    completion(data)
                    return
                }
            }
        }
    }
    
    func serviceCallToSetNotificationSetting(_ param : [String : Any], _ completion: @escaping () -> Void) {
        APIManager.shared.callPostRequest(API.SET_NOTI_SETTING, param, false) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion()
                return
            }
        }
    }
}
