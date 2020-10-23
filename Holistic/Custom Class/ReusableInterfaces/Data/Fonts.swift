//
//  Fonts.swift
//  Cozy Up
//
//  Created by Keyur on 22/05/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import Foundation
import UIKit

let APP_REGULAR = "WorkSans-Regular"
let APP_MEDIUM = "WorkSans-Medium"
let APP_BOLD = "WorkSans-Bold"
let APP_EXTRA_BOLD = "WorkSans-ExtraBold"
let APP_LIGHT = "WorkSans-Light"

enum FontType : String {
    case Clear = ""
    case ARegular = "ar"
    case AMedium = "am"
    case ABold = "ab"
    case AExtraBold = "aeb"
    case ALight = "al"
}


extension FontType {
    var value: String {
        get {
            switch self {
                case .Clear:
                    return APP_REGULAR
                case .ARegular:
                    return APP_REGULAR
                case .ABold:
                    return APP_BOLD
                case .AMedium:
                    return APP_MEDIUM
                case .AExtraBold:
                    return APP_EXTRA_BOLD
                case .ALight:
                    return APP_LIGHT
            }
        }
    }
}

