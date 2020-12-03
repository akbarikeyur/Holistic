//
//  HotelAPIManager.swift
//  Holistic
//
//  Created by Keyur Akbari on 25/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

public class HotelAPIManager {

    static let shared = HotelAPIManager()

    func serviceCallToGetHotelList( _ completion: @escaping (_ data : [[String : Any]], _ last_page : Int) -> Void) {
        APIManager.shared.callPostRequest(API.GET_HOTEL_LIST, [String : Any](), true) { (dict) in
            if let status = dict["status"] as? String, status == "success" {
                if let tempDict = dict["data"] as? [String : Any] {
                    if let data = tempDict["data"] as? [[String : Any]] {
                        completion(data, 0)
                        return
                    }
                }
            }
        }
    }
    
    func serviceCallToGetHotelDetail(_ param : [String : Any], _ completion: @escaping (_ dict : [String : Any]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_HOTEL_DETAIL, param, true) { (dict) in
            print(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let tempDict = dict["data"] as? [String : Any] {
                    completion(tempDict)
                    return
                }
            }
        }
    }
    
    func serviceCallToGenerateCode(_ param : [String : Any], _ completion: @escaping (_ code : String) -> Void) {
        APIManager.shared.callPostRequest(API.GENERATE_CODE, param, true) { (dict) in
            print(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion(AppModel.shared.getStringValue(dict, "data"))
                return
            }
        }
    }
    
    func serviceCallToGetMyCode(_ param : [String : Any], _ completion: @escaping (_ code : String) -> Void) {
        APIManager.shared.callPostRequest(API.GET_MY_CODES, param, true) { (dict) in
            print(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion(AppModel.shared.getStringValue(dict, "data"))
                return
            }
        }
    }
}
