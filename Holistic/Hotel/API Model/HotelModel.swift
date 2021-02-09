//
//  HotelModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 25/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct HotelModel {
    var id : Int!
    var title, desc, address, type, main_price : String!
    var ratings : Double!
    var views : Int!
    var get_hotels_media : [MediaModel]!
    var get_packages : [PackageModel]!
    var register_facility : [FacilityModel]!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        title = dict["title"] as? String ?? ""
        desc = dict["description"] as? String ?? ""
        address = dict["address"] as? String ?? ""
        type = dict["type"] as? String ?? ""
        main_price = AppModel.shared.getStringValue(dict, "main_price")
        ratings = AppModel.shared.getDoubleValue(dict, "ratings")
        views = AppModel.shared.getIntValue(dict, "views")
        get_hotels_media = [MediaModel]()
        if let temp = dict["get_hotel_single_media"] as? [String : Any] {
            get_hotels_media.append(MediaModel.init(temp))
        }
        else if let tempData = dict["get_hotels_media"] as? [[String : Any]] {
            for temp in tempData {
                get_hotels_media.append(MediaModel.init(temp))
            }
        }
        get_packages = [PackageModel]()
        if let tempData = dict["get_packages"] as? [[String : Any]] {
            for temp in tempData {
                get_packages.append(PackageModel.init(temp))
            }
        }
        register_facility = [FacilityModel]()
        if let tempData = dict["register_facility"] as? [[String : Any]] {
            for temp in tempData {
                register_facility.append(FacilityModel.init(temp))
            }
        }
    }
}

struct PackageModel {
    var get_amunities : [AmunitiesModel]!
    var get_includes : [IncludeModel]!
    var name, price : String!
    var hotel_id, id : Int!
    
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        hotel_id = AppModel.shared.getIntValue(dict, "hotel_id")
        price = AppModel.shared.getStringValue(dict, "price")
        name = dict["name"] as? String ?? ""
        get_amunities = [AmunitiesModel]()
        if let data = dict["get_amunities"] as? [[String :Any]] {
            for temp in data {
                get_amunities.append(AmunitiesModel.init(temp))
            }
        }
        get_includes = [IncludeModel]()
        if let data = dict["get_includes"] as? [[String :Any]] {
            for temp in data {
                get_includes.append(IncludeModel.init(temp))
            }
        }
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "name" : name!]
    }
}

struct AmunitiesModel {
    var get_icon : AmunitiesIconModel!
    var hotel_id, icon_id, id, package_id : Int!
    var name : String!
    
    init(_ dict : [String : Any]) {
        get_icon = AmunitiesIconModel.init(dict["get_icon"] as? [String : Any] ?? [String : Any]())
        hotel_id = AppModel.shared.getIntValue(dict, "hotel_id")
        icon_id = AppModel.shared.getIntValue(dict, "icon_id")
        id = AppModel.shared.getIntValue(dict, "id")
        package_id = AppModel.shared.getIntValue(dict, "package_id")
        name = dict["name"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["get_icon" : get_icon.dictionary(), "hotel_id" : hotel_id!, "icon_id" : icon_id!, "id" : id!, "package_id" : package_id!, "name" : name!]
    }
}

struct AmunitiesIconModel {
    var id : Int!
    var name : String!
    var get_single_icon_media : MediaModel!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        name = dict["name"] as? String ?? ""
        get_single_icon_media = MediaModel.init(dict["get_single_icon_media"] as? [String : Any] ?? [String : Any]())
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "name" : name!, "get_single_icon_media" : get_single_icon_media.dictionary()]
    }
}

struct IncludeModel {
    var id, hotel_id, package_id : Int!
    var name : String!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        hotel_id = AppModel.shared.getIntValue(dict, "hotel_id")
        package_id = AppModel.shared.getIntValue(dict, "package_id")
        name = dict["name"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "hotel_id" : hotel_id!, "package_id" : package_id!, "name" : name!]
    }
}

struct FacilityModel {
    var facility_id, id : Int!
    var get_single_media : MediaModel!
    var name : String!
    
    init(_ dict : [String : Any]) {
        facility_id = AppModel.shared.getIntValue(dict, "facility_id")
        if let tempDict = dict["get_facility"] as? [String : Any] {
            id = AppModel.shared.getIntValue(dict, "id")
            name = tempDict["name"] as? String ?? ""
            get_single_media = MediaModel.init(tempDict["get_single_media"] as? [String : Any] ?? [String : Any]())
        }
    }
}

struct CodeModel {
    var title, code, created_at : String!
    
    init(_ dict : [String : Any]) {
        code = AppModel.shared.getStringValue(dict, "code")
        created_at = AppModel.shared.getStringValue(dict, "created_at")
        if let tempData = dict["get_listing"] as? [[String : Any]], tempData.count > 0 {
            if let temp = tempData[0]["title"] as? String {
                title = temp
            }
        }
    }
}
