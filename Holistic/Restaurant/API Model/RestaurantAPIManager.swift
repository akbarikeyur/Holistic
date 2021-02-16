//
//  RestaurantAPIManager.swift
//  Holistic
//
//  Created by Keyur Akbari on 24/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

public class RestaurantAPIManager {

    static let shared = RestaurantAPIManager()

    func serviceCallToGetRestaurantList(_ page : Int, _ completion: @escaping (_ data : [[String : Any]], _ last_page : Int) -> Void) {
        
        APIManager.shared.callPostRequest((API.GET_RESTAURANT_LIST + "?page=" + String(page)), [String : Any](), (page==1)) { (dict) in
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
    
    func serviceCallToGetRestaurantDetail(_ param : [String : Any], _ completion: @escaping (_ dict : [String : Any]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_RESTAURANT_DETAIL, param, true) { (dict) in
            print(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let tempDict = dict["data"] as? [String : Any] {
                    completion(tempDict)
                    return
                }
            }
        }
    }
}
