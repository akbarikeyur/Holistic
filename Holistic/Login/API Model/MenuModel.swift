//
//  MenuModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct WelcomeModel {
    var title, image, desc : String!
    
    init(_ dict : [String : Any]) {
        title = dict["title"] as? String ?? ""
        image = dict["image"] as? String ?? ""
        desc = dict["desc"] as? String ?? ""
    }
}

struct MenuModel {
    var title, image, select_image : String!
    var data : [SubMenuModel]!
    var isExpand : Bool!
    
    init(_ dict : [String : Any]) {
        title = dict["title"] as? String ?? ""
        image = dict["image"] as? String ?? ""
        select_image = dict["select_image"] as? String ?? ""
        data = [SubMenuModel]()
        if let tempData = dict["data"] as? [[String : Any]] {
            for temp in tempData {
                data.append(SubMenuModel.init(temp))
            }
        }
        isExpand = dict["isExpand"] as? Bool ?? false
    }
}

struct SubMenuModel {
    var title : String!
    
    init(_ dict : [String : Any]) {
        title = dict["title"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["title" : title!]
    }
}

struct CountryModel {
    var id : Int!
    var sortname, name, phonecode : String!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        sortname = dict["sortname"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        phonecode = dict["phonecode"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "sortname" : sortname!, "name" : name!, "phonecode" : phonecode!]
    }
}

struct StateModel {
    var id, country_id : Int!
    var name : String!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        country_id = AppModel.shared.getIntValue(dict, "country_id")
        name = dict["name"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "country_id" : country_id!, "name" : name!]
    }
}

struct CityModel {
    var id, state_id : Int!
    var name : String!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        state_id = AppModel.shared.getIntValue(dict, "state_id")
        name = dict["name"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "state_id" : state_id!, "name" : name!]
    }
}

struct UserModel {
    var id, country_id, points : Int!
    var building_address, email, floor, name, phone_number, roles, room_no, street_address, clinicea_user_id, state_id, city_id, phone_code : String!
    var is_clincia, is_anglo : Bool!
    var get_profile : MediaModel!
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        city_id = AppModel.shared.getStringValue(dict, "city_id")
        state_id = AppModel.shared.getStringValue(dict, "state_id")
        country_id = AppModel.shared.getIntValue(dict, "country_id")
        building_address = dict["building_address"] as? String ?? ""
        email = dict["email"] as? String ?? ""
        floor = dict["floor"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        phone_number = dict["phone_number"] as? String ?? ""
        roles = dict["roles"] as? String ?? ""
        room_no = dict["room_no"] as? String ?? ""
        street_address = dict["street_address"] as? String ?? ""
        clinicea_user_id = dict["clinicea_user_id"] as? String ?? ""
        is_clincia = dict["is_clincia"] as? Bool ?? false
        is_anglo = dict["is_anglo"] as? Bool ?? false
        points = AppModel.shared.getIntValue(dict, "points")
        get_profile = MediaModel.init(dict["get_profile"] as? [String : Any] ?? [String : Any]())
        phone_code = AppModel.shared.getStringValue(dict, "phone_code")
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "city_id" : city_id!, "state_id" : state_id!, "country_id" : country_id!, "building_address" : building_address!, "email" : email!, "floor" : floor!, "name" : name!, "phone_number" : phone_number!, "roles" : roles!, "room_no" : room_no!, "street_address" : street_address!, "clinicea_user_id" : clinicea_user_id!, "is_clincia" : is_clincia!, "is_anglo" : is_anglo!, "points" : points!, "get_profile" : get_profile.dictionary(), "phone_code" : phone_code!]
    }
}
