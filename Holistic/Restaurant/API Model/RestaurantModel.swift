//
//  RestaurantModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 24/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct RestaurantModel {
    var id : Int!
    var title, desc, address, type, main_price : String!
    var ratings : Double!
    var views : Int!
    var get_restaurant_media : [MediaModel]!
    var get_restaurant_category : [CategoryModel]!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        title = dict["title"] as? String ?? ""
        desc = dict["description"] as? String ?? ""
        address = dict["address"] as? String ?? ""
        type = dict["type"] as? String ?? ""
        main_price = AppModel.shared.getStringValue(dict, "main_price")
        ratings = AppModel.shared.getDoubleValue(dict, "ratings")
        views = AppModel.shared.getIntValue(dict, "views")
        get_restaurant_media = [MediaModel]()
        if let temp = dict["get_single_restaurant_media"] as? [String : Any] {
            get_restaurant_media.append(MediaModel.init(temp))
        }
        else if let tempData = dict["get_restaurant_media"] as? [[String : Any]] {
            for temp in tempData {
                get_restaurant_media.append(MediaModel.init(temp))
            }
        }
        else if let temp = dict["get_single_media"] as? [String : Any] {
            get_restaurant_media.append(MediaModel.init(temp))
        }
        get_restaurant_category = [CategoryModel]()
        if let tempData = dict["get_restaurant_category"] as? [[String : Any]] {
            for temp in tempData {
                get_restaurant_category.append(CategoryModel.init(temp))
            }
        }
    }
}

struct CategoryModel {
    var id, restaurant_id : Int!
    var category_name : String!
    var get_restaurant_menu : [RestaurantMenuModel]!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        restaurant_id = AppModel.shared.getIntValue(dict, "restaurant_id")
        category_name = dict["category_name"] as? String ?? ""
        get_restaurant_menu = [RestaurantMenuModel]()
        if let tempData = dict["get_restaurant_menu"] as? [[String : Any]] {
            for temp in tempData {
                get_restaurant_menu.append(RestaurantMenuModel.init(temp))
            }
        }
    }
}

struct RestaurantMenuModel {
    var id, restaurant_id, category_id : Int!
    var title, desc, price : String!
    var get_single_media : MediaModel!

    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        restaurant_id = AppModel.shared.getIntValue(dict, "restaurant_id")
        category_id = AppModel.shared.getIntValue(dict, "category_id")
        title = dict["title"] as? String ?? ""
        desc = dict["desc"] as? String ?? ""
        price = AppModel.shared.getStringValue(dict, "price")
        get_single_media = MediaModel.init(dict["get_single_media"] as? [String : Any] ?? [String : Any]())
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "restaurant_id" : restaurant_id!, "category_id" : category_id!, "title" : title!, "desc" : desc!, "price" : price!, "get_single_media" : get_single_media.dictionary()]
    }
}
