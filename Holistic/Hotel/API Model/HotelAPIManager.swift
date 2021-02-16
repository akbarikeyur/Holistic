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

    func serviceCallToGetHotelList(_ page : Int, _ completion: @escaping (_ data : [[String : Any]], _ last_page : Int) -> Void) {
        APIManager.shared.callPostRequest((API.GET_HOTEL_LIST + "?page=" + String(page)), [String : Any](), (page==1)) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let tempDict = dict["data"] as? [String : Any] {
                    if let data = tempDict["data"] as? [[String : Any]] {
                        if let last_page = tempDict["last_page"] as? Int {
                            completion(data, last_page)
                            return
                        }else{
                            completion(data, 0)
                            return
                        }
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
            else if let message = dict["message"] as? String, message != "" {
                displayToast(message)
            }
        }
    }
    
    func serviceCallToGetMyCode(_ param : [String : Any], _ completion: @escaping (_ data : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_MY_CODES, param, true) { (dict) in
            print(dict)
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
