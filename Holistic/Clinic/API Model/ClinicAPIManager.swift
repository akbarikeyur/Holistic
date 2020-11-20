//
//  ClinicAPIManager.swift
//  Holistic
//
//  Created by Keyur Akbari on 20/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire

public class ClinicAPIManager {

    static let shared = ClinicAPIManager()

    
    func serviceCallToGenerateToken() {
        APIManager.shared.callGetRequest(CLINIC_API.GET_TOKEN, false) { (key) in
            print(key)
            setAuthToken(key)
        }
    }
    
}
