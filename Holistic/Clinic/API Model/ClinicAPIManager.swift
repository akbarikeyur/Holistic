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

struct CLINIC_API {
    static let BASE_URL = "https://api.clinicea.com/api/v2/"
    
    static let KEY              =       "a38a3f404b604d57c7d7aba15b4dd951"
    static let USERNAME         =       "dr.rifas@gmail.com"
    static let PASSWORD         =       "Rifas12345"
    
    static let GET_TOKEN        =       BASE_URL + "login/getTokenByStaffUsernamePwd?apiKey=" + CLINIC_API.KEY + "&loginUserName=" + CLINIC_API.USERNAME + "&pwd=" + CLINIC_API.PASSWORD
    static let GET_USER_ID_BY_TOKEN        =       BASE_URL + "login/getUserIDByToken?api_key=" + getClinicToken()
    static let GET_PATIENT_DETAIL          =       BASE_URL + "patients/getPatientByID?patientID=" + getClinicUserId() + "&api_key=" + getClinicToken()
}


public class ClinicAPIManager {

    static let shared = ClinicAPIManager()

    func getClinicJsonHeader() -> HTTPHeaders {
        return ["Content-Type":"application/json", "Accept":"application/json"]
    }
    
    func getClinicMultipartHeader() -> [String:String] {
        return ["Content-Type":"multipart/form-data", "Accept":"application/json"]
    }
    
    //MARK:- Service called
    func serviceCallToGenerateToken() {
        ClinicAPIManager.shared.callGetRequest(CLINIC_API.GET_TOKEN, false) { (key) in
            setClinicToken(key)
            self.serviceCallToGetUserIdByToken()
        }
    }
    
    func serviceCallToGetUserIdByToken() {
        ClinicAPIManager.shared.callGetRequest(CLINIC_API.GET_USER_ID_BY_TOKEN, false) { (key) in
            setClinicUserId(key)
            self.serviceCallToGetUserDetail()
        }
    }
    
    func serviceCallToGetUserDetail() {
        ClinicAPIManager.shared.callGetRequest(CLINIC_API.GET_PATIENT_DETAIL, false) { (key) in
            
            
        }
    }
    
    //MARK:- Get request
    func callGetRequest(_ api : String, _ isLoaderDisplay : Bool, _ completion: @escaping (_ result : String) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        if isLoaderDisplay {
            showLoader()
        }
        
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getClinicJsonHeader()).responseJSON { (response) in
            removeLoader()
            switch response.result {
            case .success:
                printData(response.result.value)
                if let result = response.result.value as? String {
                    completion(result)
                    return
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                break
            case .failure(let error):
                printData(error)
                break
            }
        }
    }
    
    //MARK:- Post request
    func callPostRequest(_ api : String, _ params : [String : Any], _ isLoaderDisplay : Bool, _ completion: @escaping (_ result : [String:Any]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        if isLoaderDisplay {
            showLoader()
        }
        Alamofire.request(api, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getClinicJsonHeader()).responseJSON { (response) in
            removeLoader()
            switch response.result {
            case .success:
                if let result = response.result.value as? [String:Any] {
                    completion(result)
                    return
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                break
            case .failure(let error):
                printData(error)
                break
            }
        }
    }
}
