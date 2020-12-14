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
}
