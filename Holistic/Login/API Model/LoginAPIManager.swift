//
//  LoginAPIManager.swift
//  Holistic
//
//  Created by Keyur Akbari on 25/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

public class LoginAPIManager {

    static let shared = LoginAPIManager()

    func serviceCallToGetCountry(_ completion: @escaping (_ dict : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_COUNTRY, [String : Any](), false) { (dict) in
            if let data = dict["data"] as? [[String : Any]] {
                completion(data)
                return
            }
        }
    }
    
    func serviceCallToGetState(_ param : [String : Any], _ completion: @escaping (_ dict : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_STATE, param, true) { (dict) in
            if let data = dict["data"] as? [[String : Any]] {
                completion(data)
                return
            }
        }
    }
    
    func serviceCallToGetCity(_ param : [String : Any], _ completion: @escaping (_ dict : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.GET_CITY, param, true) { (dict) in
            if let data = dict["data"] as? [[String : Any]] {
                completion(data)
                return
            }
        }
    }
    
    func serviceCallToEmailLogin(_ param : [String : Any], _ completion: @escaping () -> Void) {
        printData(param)
        APIManager.shared.callPostRequest(API.EMAIL_LOGIN, param, true) { (dict) in
            print(dict)
            if let status = dict["status"] as? String, status == "success" {
                if let data = dict["data"] as? [String : Any] {
                    AppModel.shared.currentUser = UserModel.init(data)
                    setLoginUserData()
                    completion()
                    return
                }
            }
        }
    }
    
    func serviceCallToGetUserQuestion(_ param : [String : Any], _ completion: @escaping (_ dict : [[String : Any]]) -> Void) {
        APIManager.shared.callPostRequest(API.QUESTION_USER, param, true) { (dict) in
            printData(dict)
            if let data = dict["data"] as? [[String : Any]] {
                completion(data)
                return
            }
        }
    }
    
    func serviceCallToSignup(_ param : [String : Any], _ completion: @escaping (_ dict : [String : Any]) -> Void) {
        printData(param)
        APIManager.shared.callPostRequest(API.SIGNUP, param, true) { (dict) in
            print(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion(dict)
                return
            }
        }
    }
    
    func serviceCallToMobileLogin(_ param : [String : Any], _ completion: @escaping (_ dict : [String : Any]) -> Void) {
        printData(param)
        APIManager.shared.callPostRequest(API.MOBILE_LOGIN, param, true) { (dict) in
            print(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion(dict)
                return
            }
        }
    }
    
    func serviceCallToVerify(_ param : [String : Any], _ completion: @escaping (_ dict : [String : Any]) -> Void) {
        printData(param)
    }
    
    func serviceCallToForgotPassword(_ param : [String : Any], _ completion: @escaping (_ dict : [String : Any]) -> Void) {
        printData(param)
        APIManager.shared.callPostRequest(API.FORGOT_PASSWORD, param, true) { (dict) in
            print(dict)
            if let status = dict["status"] as? String, status == "success" {
                completion(dict)
                return
            }
        }
    }
}
