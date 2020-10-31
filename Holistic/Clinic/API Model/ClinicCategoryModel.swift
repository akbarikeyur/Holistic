//
//  ClinicCategoryModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 31/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct ClinicCategoryModel {
    var name, image, color : String!
    
    init(_ dict : [String : Any]) {
        name = dict["name"] as? String ?? ""
        image = dict["image"] as? String ?? ""
        color = dict["color"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["name" : name!, "image" : image!, "color" : color!]
    }
}
