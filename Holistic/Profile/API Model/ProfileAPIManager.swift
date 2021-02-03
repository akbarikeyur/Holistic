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
        APIManager.shared.callPostRequest(API.GET_OFFER, param, true) { (dict) in
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
}
