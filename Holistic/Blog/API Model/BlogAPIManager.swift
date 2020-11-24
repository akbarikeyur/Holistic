//
//  BlogAPIManager.swift
//  Holistic
//
//  Created by Keyur Akbari on 24/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

public class BlogAPIManager {

    static let shared = BlogAPIManager()

    func serviceCallToGetBlogList( _ completion: @escaping (_ data : [[String : Any]], _ last_page : Int) -> Void) {
        APIManager.shared.callPostRequest(API.GET_BLOG_LIST, [String : Any](), true) { (dict) in
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
}
