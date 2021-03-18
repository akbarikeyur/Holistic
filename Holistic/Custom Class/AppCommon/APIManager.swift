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
    static let BASE_URL = "http://anglotestserver.website/clinic/api/"
    
    static let GET_COUNTRY               =       BASE_URL + "country/get_country"
    static let GET_STATE                 =       BASE_URL + "country/get_states"
    static let GET_CITY                  =       BASE_URL + "country/get_cities"
    
    static let SIGNUP                    =       BASE_URL + "user/signup"
    static let QUESTION_USER             =       BASE_URL + "user/getQuestion"

    static let EMAIL_LOGIN               =       BASE_URL + "user/loginwithemail"
    static let MOBILE_LOGIN              =       BASE_URL + "user/login"
    static let FORGOT_PASSWORD           =       BASE_URL + "user/forgetPassword"
    static let UPLOAD_IMAGE              =       BASE_URL + "user/updateProfilePicture"
    static let UPDATE_PROFILE            =       BASE_URL + "user/updateProfile"
    static let GET_USER_DETAIL           =       BASE_URL + "user/getUserDetails"
    
    static let GLOBAL_SEARCH             =       BASE_URL + "user/globalSearch"
    
    static let GET_FLOWER_LIFE           =       BASE_URL + "lifestyle/floweroflife"
    static let GET_TASK_LIST             =       BASE_URL + "lifestyle/getTasks"
    static let MAKE_TASK_COMPLETE        =       BASE_URL + "lifestyle/complete_task"
    static let GET_MISSED_TASK_LIST      =       BASE_URL + "lifestyle/missed_n_completed_task"
    static let GET_STATISTIC             =       BASE_URL + "lifestyle/getStatistic"
    
    static let GET_BLOG_LIST             =       BASE_URL + "blog/all"
    
    static let GET_RESTAURANT_LIST       =       BASE_URL + "restaurant/all"
    static let GET_RESTAURANT_DETAIL     =       BASE_URL + "restaurant/detail"
    
    static let GENERATE_CODE             =       BASE_URL + "codes/getCode"
    static let GET_MY_CODES              =       BASE_URL + "codes/myCode"
    
    static let GET_HOTEL_LIST            =       BASE_URL + "hotels/all"
    static let GET_HOTEL_DETAIL          =       BASE_URL + "hotels/detail"
    
    static let GET_PRODUCT_LIST          =       BASE_URL + "product/get_product"
    static let GET_PRODUCT_DETAIL        =       BASE_URL + "product/single_product"
    static let CHECK_PRODUCT_QTY         =       BASE_URL + "product/checkproductqty"
    static let ADD_TO_CART               =       BASE_URL + "cart/addtocart"
    static let GET_MY_CART               =       BASE_URL + "cart/getCart"
    static let REMOVE_FROM_CART          =       BASE_URL + "cart/removeIndividualProduct"
    static let EMPTY_FULL_CART           =       BASE_URL + "cart/emptyCart"
    
    static let PRODUCT_PURCHASE          =       BASE_URL + "product/purchase"
    static let GET_PURCHASE_HISTORY      =       BASE_URL + "product/productPurchaseHistory"
    
    static let GET_OFFER                 =       BASE_URL + "offers/getOffers"
    static let ADD_BOOKMARK_OFFER        =       BASE_URL + "offers/createBookmark"
    static let REMOVE_BOOKMARK_OFFER     =       BASE_URL + "offers/removeOfferbookmark"
    static let GET_BOOKMARK_OFFER        =       BASE_URL + "offers/getOfferBookmark"
    static let GET_OFFER_CODE            =       BASE_URL + "offers/generateCode"
    static let GET_REDEEM_CODE_LIST      =       BASE_URL + "offers/offersRedeemed"
    
    static let GET_NOTIFICATION          =       BASE_URL + "notification/getNotificationList"
    static let GET_NOTI_SETTING          =       BASE_URL + "notification/getNotificationSettings"
    static let SET_NOTI_SETTING          =       BASE_URL + "notification/changeNotificationSetting"
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
            if let postData : NSData = try JSONSerialization.data(withJSONObject: array, options: JSONSerialization.WritingOptions.prettyPrinted) as? NSData {
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
                showAlert("Error", message: message.capitalized) {}
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

struct JSONStringArrayEncoding: ParameterEncoding {
    private let jsonArray: [[String: String]]

    init(jsonArray: [[String: String]]) {
        self.jsonArray = jsonArray
    }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        let data = try JSONSerialization.data(withJSONObject: jsonArray, options: [])

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        urlRequest.httpBody = data

        return urlRequest
    }
}
