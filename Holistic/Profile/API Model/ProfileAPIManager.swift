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
}
