//
//  ProductAPIManager.swift
//  Holistic
//
//  Created by Keyur Akbari on 14/12/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

public class ProductAPIManager {

    static let shared = ProductAPIManager()

    func serviceCallToGetProductList(_ page : Int, _ completion: @escaping (_ data : [[String : Any]], _ last_page : Int) -> Void) {
        let strUrl = API.GET_PRODUCT_LIST + "?page=" + String(page)
        APIManager.shared.callPostRequest(strUrl, [String : Any](), true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let tempDict = dict["data"] as? [String : Any] {
                    if let data = tempDict["data"] as? [[String : Any]] {
                        if let last_page = tempDict["last_page"] as? Int {
                            completion(data, last_page)
                        }else{
                            completion(data, 0)
                        }
                        return
                    }
                }
            }
        }
    }
    
    func serviceCallToGetProductDetail(_ param : [String : Any], _ completion: @escaping (_ dict : [String : Any], _ otherData : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_PRODUCT_DETAIL, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let tempDict = dict["data"] as? [String : Any] {
                    if let otherData = dict["other_product"] as? [[String : Any]] {
                        completion(tempDict, otherData)
                    }else{
                        completion(tempDict, [[String : Any]]())
                    }
                }
            }
        }
    }
    
    func serviceCallToCheckProductQty(_ param : [String : Any], _ completion: @escaping (_ dict : [String : Any]) -> Void) {
        APIManager.shared.callPostRequest(API.CHECK_PRODUCT_QTY, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let tempDict = dict["data"] as? [String : Any] {
                    completion(tempDict)
                }
            }
        }
    }
    
    func serviceCallToAddToCart(_ param : [String : Any], _ completion: @escaping () -> Void) {
        APIManager.shared.callPostRequest(API.ADD_TO_CART, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion()
            }
            else if let message = dict["message"] as? String {
                displayToast(message)
            }
        }
    }
    
    func serviceCallToGetMyCart(_ isLoaderDisplay : Bool, _ completion: @escaping (_ dict : [[String : Any]]) -> Void) {
        if !isUserLogin() || AppModel.shared.currentUser == nil {
            return
        }
        APIManager.shared.callPostRequest(API.GET_MY_CART, ["user_id" : AppModel.shared.currentUser.id!], isLoaderDisplay) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let data = dict["data"] as? [[String : Any]] {
                    completion(data)
                }
            }
        }
    }
    
    func serviceCallToProductPurchase(_ param : [String : Any], _ completion: @escaping (_ dict : [String : Any]) -> Void) {
        APIManager.shared.callPostRequest(API.PRODUCT_PURCHASE, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion(dict)
            }
        }
    }
    
    func serviceCallToGetPurchaseProductHistory(_ page : Int, _ param : [String : Any], _ completion: @escaping (_ data : [[String : Any]], _ last_page : Int) -> Void) {
        let strUrl = API.GET_PURCHASE_HISTORY + "?page=" + String(page)
        APIManager.shared.callPostRequest(strUrl, param, true) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let tempDict = dict["data"] as? [String : Any] {
                    if let data = tempDict["data"] as? [[String : Any]] {
                        if let last_page = tempDict["last_page"] as? Int {
                            completion(data, last_page)
                        }else{
                            completion(data, 0)
                        }
                        return
                    }
                }
            }
        }
    }
    
    func serviceCallToRemoveProductFromCart(_ param : [String : Any], _ completion: @escaping () -> Void) {
        APIManager.shared.callPostRequest(API.REMOVE_FROM_CART, param, false) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion()
                return
            }
        }
    }
    
    func serviceCallToClearFullCart(_ param : [String : Any], _ completion: @escaping () -> Void) {
        APIManager.shared.callPostRequest(API.EMPTY_FULL_CART, param, false) { (dict) in
            printData(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion()
                return
            }
        }
    }
}
