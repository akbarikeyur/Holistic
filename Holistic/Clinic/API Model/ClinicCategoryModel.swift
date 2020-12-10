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

struct ClinicUserModel {
    var ID, Email, FirstName, LastName, Age, Gender : String!
    
    init(_ dict : [String : Any]) {
        ID = AppModel.shared.getStringValue(dict, "ID")
        Email = dict["Email"] as? String ?? ""
        FirstName = dict["FirstName"] as? String ?? ""
        LastName = dict["LastName"] as? String ?? ""
        Age = dict["Age"] as? String ?? ""
        Gender = dict["Gender"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["ID" : ID!, "Email" : Email!, "FirstName" : FirstName!, "LastName" : LastName!, "Age" : Age!, "Gender" : Gender!]
    }
}
