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

struct WakeupModel {
    var imgBtn, title, desc :String!
    var isExpand : Bool!
    
    init(_ dict : [String : Any]) {
        imgBtn = dict["imgBtn"] as? String ?? ""
        title = dict["title"] as? String ?? ""
        desc = dict["desc"] as? String ?? ""
        isExpand = dict["isExpand"] as? Bool ?? false
    }
    
    func dictionary() -> [String : Any] {
        return ["imgBtn" : imgBtn!, "title" : title!, "desc" : desc!, "isExpand" : isExpand!]
    }
}
