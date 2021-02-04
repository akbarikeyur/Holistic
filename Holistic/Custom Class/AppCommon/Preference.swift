//
//  Preference.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit

class Preference: NSObject {

    static let sharedInstance = Preference()
}


func setDataToPreference(data: AnyObject, forKey key: String)
{
    UserDefaults.standard.set(data, forKey: MD5(key))
    UserDefaults.standard.synchronize()
}

func getDataFromPreference(key: String) -> AnyObject?
{
    return UserDefaults.standard.object(forKey: MD5(key)) as AnyObject?
}

func removeDataFromPreference(key: String)
{
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}

func removeUserDefaultValues()
{
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    UserDefaults.standard.synchronize()
}

//MARK: - Access Token
func setAuthToken(_ token: String)
{
    setDataToPreference(data: token as AnyObject, forKey: "user_access_token")
}

func getAuthToken() -> String
{
    if let token : String = getDataFromPreference(key: "user_access_token") as? String
    {
        return token
    }
    return ""
}

//MARK: - Push notification device token
func setPushToken(_ token: String)
{
    setDataToPreference(data: token as AnyObject, forKey: "PUSH_DEVICE_TOKEN")
}

func getPushToken() -> String
{
    if let token : String = getDataFromPreference(key: "PUSH_DEVICE_TOKEN") as? String
    {
        return token
    }
    return AppDelegate().sharedDelegate().getFCMToken()
}

func setClinicToken(_ token: String)
{
    setDataToPreference(data: token as AnyObject, forKey: "clinic_token")
    setClinicLogin(true)
}

func getClinicToken() -> String
{
    if let token : String = getDataFromPreference(key: "clinic_token") as? String
    {
        return token
    }
    return ""
}

func setClinicLogin(_ value : Bool) {
    setDataToPreference(data: value as AnyObject, forKey: "is_clinic_login")
}

func isClinicLogin() -> Bool {
    if let value : Bool = getDataFromPreference(key: "is_clinic_login") as? Bool
    {
        return value
    }
    return false
}

func setClinicUserId(_ value: String)
{
    setDataToPreference(data: value as AnyObject, forKey: "clinic_user_id")
}

func getClinicUserId() -> String
{
    if let token : String = getDataFromPreference(key: "clinic_user_id") as? String
    {
        return token
    }
    return ""
}

func setClinicUserData() {
    setDataToPreference(data: AppModel.shared.clinicUser.dictionary() as AnyObject, forKey: "clinic_user_data")
}

func getClinicUserData() -> ClinicUserModel
{
    if let data : [String : Any] = getDataFromPreference(key: "clinic_user_data") as? [String : Any] {
        return ClinicUserModel.init(data)
    }
    return ClinicUserModel.init([String : Any]())
}

func setLoginUserData() {
    if AppModel.shared.currentUser.clinicea_user_id != "" {
        setClinicUserId(AppModel.shared.currentUser.clinicea_user_id)
    }
    setDataToPreference(data: AppModel.shared.currentUser.dictionary() as AnyObject, forKey: "login_user_data")
    setUserLogin(true)
}

func getLoginUserData() -> UserModel
{
    if let data : [String : Any] = getDataFromPreference(key: "login_user_data") as? [String : Any] {
        return UserModel.init(data)
    }
    return UserModel.init([String : Any]())
}

func setUserLogin(_ value : Bool) {
    setDataToPreference(data: value as AnyObject, forKey: "is_user_login")
}

func isUserLogin() -> Bool {
    if let value : Bool = getDataFromPreference(key: "is_user_login") as? Bool
    {
        return value
    }
    return false
}

func setCliniciaUser(_ value : Bool) {
    setDataToPreference(data: value as AnyObject, forKey: "is_clinicia_user")
}

func isCliniciaUser() -> Bool {
    if let value : Bool = getDataFromPreference(key: "is_clinicia_user") as? Bool
    {
        return value
    }
    return false
}

func setAngloUser(_ value : Bool) {
    setDataToPreference(data: value as AnyObject, forKey: "is_anglo_user")
}

func isAngloUser() -> Bool {
    if let value : Bool = getDataFromPreference(key: "is_anglo_user") as? Bool
    {
        return value
    }
    return false
}


func setCountryData(_ data: [CountryModel])
{
    var arrData = [[String : Any]]()
    for temp in data {
        arrData.append(temp.dictionary())
    }
    setDataToPreference(data: arrData as AnyObject, forKey: "country_data")
}

func getCountryData() -> [CountryModel]
{
    var arrCountry = [CountryModel]()
    if let data : [[String : Any]] = getDataFromPreference(key: "country_data") as? [[String : Any]]
    {
        for temp in data {
            arrCountry.append(CountryModel.init(temp))
        }
    }
    return arrCountry
}

func setFirstHotelPopup(_ value : Bool) {
    setDataToPreference(data: value as AnyObject, forKey: "is_first_hotel_popup")
}

func isFirstHotelPopup() -> Bool {
    if let value : Bool = getDataFromPreference(key: "is_first_hotel_popup") as? Bool
    {
        return value
    }
    return false
}
