//
//  Colors.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import UIKit

var ClearColor = UIColor.clear
var BorderColor = LIGHT_GRAY_COLOR
var LightBorderColor = colorFromHex(hex: "D8D8D8")
var OrangeColor = colorFromHex(hex: "FF7900")
var PurpleBorderColor = colorFromHex(hex: "ADADDC")
var WhiteColor = colorFromHex(hex: "FFFFFF")
var GreenColor = colorFromHex(hex: "669900")
var RedColor = colorFromHex(hex: "ED5454")
var BlueColor = colorFromHex(hex: "4A68DB")

enum ColorType : Int32 {
    case Clear = 0
    case Border = 1
    case LightBorder = 2
    case Orange = 3
    case PurpleBorder = 4
    case White = 5
}

extension ColorType {
    var value: UIColor {
        get {
            switch self {
                case .Clear:
                    return ClearColor
                case .Border:
                    return BorderColor
                case .LightBorder:
                    return LightBorderColor
                case .Orange:
                    return OrangeColor
                case .PurpleBorder:
                    return PurpleBorderColor
                case .White:
                    return WhiteColor
            }
        }
    }
}

enum GradientColorType : Int32 {
    case Clear = 0
    case Login = 1
}

extension GradientColorType {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .Login: //1
                gradient.colors = [
                    colorFromHex(hex: "FD7F5E").cgColor,
                    colorFromHex(hex: "FF625F").cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 0)
            }
            
            return gradient
        }
    }
}


enum GradientColorTypeForView : Int32 {
    case Clear = 0
    case App = 1
}


extension GradientColorTypeForView {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .App: //1
                gradient.colors = [
                    colorFromHex(hex: "FD7F5E").cgColor,
                    colorFromHex(hex: "FF625F").cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 0)
            }
            
            return gradient
        }
    }
}

