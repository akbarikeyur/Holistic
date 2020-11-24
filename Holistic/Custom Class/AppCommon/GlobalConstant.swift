//
//  GlobalConstant.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import Foundation
import UIKit

let APP_VERSION = 1.0
let BUILD_VERSION = 1
let DEVICE_ID = UIDevice.current.identifierForVendor?.uuidString

let ITUNES_URL = ""
let CURRENCY = "AED"

let GOOGLE_KEY = ""
var isDarkMode = false
var BLACK_COLOR = UIColor.black
var WHITE_COLOR = UIColor.white
var GRAY_COLOR = UIColor.systemGray
var LIGHT_GRAY_COLOR = UIColor.lightGray

struct SCREEN
{
    static var WIDTH = UIScreen.main.bounds.size.width
    static var HEIGHT = UIScreen.main.bounds.size.height
}

struct DEVICE {
    static var IS_IPHONE_X = (fabs(Double(SCREEN.HEIGHT - 812)) < Double.ulpOfOne)
}

struct IMAGE {
    static var PLACEHOLDER = "ic_placeholder"
}

struct STORYBOARD {
    static var MAIN = UIStoryboard(name: "Main", bundle: nil)
    static var HOME = UIStoryboard(name: "Home", bundle: nil)
    static var HOTEL = UIStoryboard(name: "Hotel", bundle: nil)
    static var RESTAURANT = UIStoryboard(name: "Restaurant", bundle: nil)
    static var PRODUCT = UIStoryboard(name: "Product", bundle: nil)
    static var CLINIC = UIStoryboard(name: "Clinic", bundle: nil)
    static var PROFILE = UIStoryboard(name: "Profile", bundle: nil)
}

struct NOTIFICATION {
    static var UPDATE_CURRENT_USER_DATA     =   "UPDATE_CURRENT_USER_DATA"
    static var REDICT_TAB_BAR               =   "REDICT_TAB_BAR"
    static var NOTIFICATION_TAB_CLICK       =   "NOTIFICATION_TAB_CLICK"
    static var REDIRECT_HOME_LIFESTYLE      =   "REDIRECT_HOME_LIFESTYLE"
    static var REDIRECT_HOME_CLINIC         =   "REDIRECT_HOME_CLINIC"
    static var REDIRECT_CLINIC_TAB          =   "REDIRECT_CLINIC_TAB"
}

struct Platform {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}
