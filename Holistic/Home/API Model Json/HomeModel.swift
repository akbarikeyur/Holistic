//
//  HomeModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct TaskModel {
    var title, time, action, action_img, image, color : String!
    
    init(_ dict : [String : Any]) {
        title = dict["title"] as? String ?? ""
        time = dict["time"] as? String ?? ""
        action = dict["action"] as? String ?? ""
        action_img = dict["action_img"] as? String ?? ""
        image = dict["image"] as? String ?? ""
        color = dict["color"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["title" : title!, "time" : time!, "action" : action!, "action_img" : action_img!, "image" : image!, "color" : color!]
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
