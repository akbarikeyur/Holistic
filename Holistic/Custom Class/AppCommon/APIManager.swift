//
//  APIManager.swift
//  Ecommerce
//
//  Created by Keyur Akbari on 01/09/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire


struct API {
    static let BASE_URL = ""
    
    static let LOGIN                                 =       BASE_URL + "user/login"
    
}

struct CLINIC_API {
    static let BASE_URL = "https://api.clinicea.com/api/v2/"
    
    static let KEY              =       "a38a3f404b604d57c7d7aba15b4dd951"
    static let USERNAME         =       "dr.rifas@gmail.com"
    static let PASSWORD         =       "Rifas12345"
    
    static let GET_TOKEN        =       BASE_URL + "login/getTokenByStaffUsernamePwd?apiKey=" + CLINIC_API.KEY + "&loginUserName=" + CLINIC_API.USERNAME + "&pwd=" + CLINIC_API.PASSWORD
}

public class APIManager {
    
    static let shared = APIManager()
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func getJsonHeader() -> HTTPHeaders {
//        if isUserLogin() {
//            return ["Content-Type":"application/json", "Accept":"application/json", "Authorization" : "Bearer " + getAuthToken()]
//        }else{
            return ["Content-Type":"application/json", "Accept":"application/json"]
//        }
    }
    
    func getMultipartHeader() -> [String:String]{
//        if isUserLogin() {
//            return ["Content-Type":"multipart/form-data", "Accept":"application/json", "Authorization" : "Bearer " + getAuthToken()]
//        }else{
            return ["Content-Type":"multipart/form-data", "Accept":"application/json"]
//        }
    }
    
    func networkErrorMsg()
    {
        removeLoader()
        showAlert("Holistic", message: "no_network") {
            
        }
    }
    
    func toJson(_ dict:[String:Any]) -> String {
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString!
    }
    
    func toJson(_ array : [[String:Any]]) -> String {
        var jsonString : String = ""
        do {
            if let postData : NSData = try JSONSerialization.data(withJSONObject: array, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData {
                jsonString = NSString(data: postData as Data, encoding: String.Encoding.utf8.rawValue)! as String
            }
        } catch {
            print(error)
        }
        return jsonString
    }
    
    func handleError(_ dict : [String : Any])
    {
        if let status = dict["status"] as? String, status == "error" {
            if let message = dict["message"] as? String {
                showAlert("Error", message: message) {}
            }
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
        
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getJsonHeader()).responseJSON { (response) in
            removeLoader()
            switch response.result {
            case .success:
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
        Alamofire.request(api, method: .post, parameters: params, encoding: JSONEncoding.default, headers: getJsonHeader()).responseJSON { (response) in
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
    
    //MARK:- Multipart request
    func callMultipartRequest(_ api : String, _ params : [String : Any], _ isLoaderDisplay : Bool, _ completion: @escaping (_ result : [String:Any]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        if isLoaderDisplay {
            showLoader()
        }
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, usingThreshold: UInt64.init(), to: api, method: .post, headers: getJsonHeader()) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (Progress) in
                    printData("Upload Progress: \(Progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    removeLoader()
                    if let result = response.result.value as? [String:Any] {
                        completion(result)
                        return
                    }
                    else if let error = response.error{
                        displayToast(error.localizedDescription)
                        return
                    }
                }
            case .failure(let error):
                removeLoader()
                printData(error.localizedDescription)
                break
            }
        }
    }
    
    func callMultipartRequestWithImage(_ api : String, _ params : [String : Any], _ arrImg : [UIImage?], _ imgName : String, _ isLoaderDisplay : Bool, _ completion: @escaping (_ result : [String:Any]) -> Void) {
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        if isLoaderDisplay {
            showLoader()
        }
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            for temp in arrImg {
                if let image = temp {
                    if let imageData = image.jpegData(compressionQuality: 1.0) {
                        multipartFormData.append(imageData, withName: imgName, fileName: (imgName + ".jpg"), mimeType: "image/jpg")
                    }
                }
            }
        }, usingThreshold: UInt64.init(), to: api, method: .post, headers: getMultipartHeader()) { (result) in
            switch result{
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (Progress) in
                        printData("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    upload.responseJSON { response in
                        removeLoader()
                        if let result = response.result.value as? [String:Any] {
                            completion(result)
                            return
                        }
                        else if let error = response.error{
                            displayToast(error.localizedDescription)
                            return
                        }
                    }
                case .failure(let error):
                    removeLoader()
                    printData(error.localizedDescription)
                    break
            }
        }
    }
}
