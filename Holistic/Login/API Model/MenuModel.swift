//
//  MenuModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct MenuModel {
    var title, image : String!
    
    init(_ dict : [String : Any]) {
        title = dict["title"] as? String ?? ""
        image = dict["image"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["title" : title!, "image" : image!]
    }
}
