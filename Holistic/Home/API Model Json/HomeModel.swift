//
//  HomeModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct TaskModel {
    var title, time, detail, image, color : String!
    
    init(_ dict : [String : Any]) {
        title = dict["title"] as? String ?? ""
        time = dict["time"] as? String ?? ""
        detail = dict["detail"] as? String ?? ""
        image = dict["image"] as? String ?? ""
        color = dict["color"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["title" : title!, "time" : time!, "detail" : detail!, "image" : image!, "color" : color!]
    }
}
