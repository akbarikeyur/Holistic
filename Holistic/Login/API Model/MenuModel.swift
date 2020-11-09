//
//  MenuModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

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
