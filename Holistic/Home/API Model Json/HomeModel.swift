//
//  HomeModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct TaskModel {
    var country_id, id, life_style_id, user_id : Int!
    var status, task_sent_on : String!
    var get_life_style : LifeStyleModel!
    var get_description : [TaskDescModel]!
    
    init(_ dict : [String : Any]) {
        country_id = AppModel.shared.getIntValue(dict, "country_id")
        id = AppModel.shared.getIntValue(dict, "id")
        life_style_id = AppModel.shared.getIntValue(dict, "life_style_id")
        user_id = AppModel.shared.getIntValue(dict, "user_id")
        status = dict["status"] as? String ?? ""
        task_sent_on = dict["task_sent_on"] as? String ?? ""
        get_life_style = LifeStyleModel.init(dict["get_life_style"] as? [String : Any] ?? [String : Any]())
        get_description = [TaskDescModel]()
        if let tempData = dict["get_description"] as? [[String : Any]] {
            for temp in tempData {
                get_description.append(TaskDescModel.init(temp))
            }
        }
    }
    
    func dictionary() -> [String : Any] {
        return ["country_id" : country_id!, "id" : id!, "life_style_id" : life_style_id!, "user_id" : user_id!, "status" : status!, "task_sent_on" : task_sent_on!, "get_life_style" : get_life_style.dictionary(), "get_description" : AppModel.shared.getTaskDescArrOfDictionary(arr: get_description)]
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

struct LifeStyleModel {
    var id : Int!
    var color_select, title, task_start_date_time, task_end_date_time :String!
    var get_single_media : MediaModel!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        title = dict["title"] as? String ?? ""
        color_select = dict["color_select"] as? String ?? ""
        task_start_date_time = dict["task_start_date_time"] as? String ?? ""
        task_end_date_time = dict["task_end_date_time"] as? String ?? ""
        get_single_media = MediaModel.init(dict["get_single_media"] as? [String : Any] ?? [String : Any]())
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "title" : title!, "color_select" : color_select!, "task_start_date_time" : task_start_date_time!, "task_end_date_time" : task_end_date_time!, "get_single_media" : get_single_media.dictionary()]
    }
}

struct TaskDescModel {
    var title, desc :String!
    var get_media : MediaModel!
    var id, life_style_id : Int!
    var isExpand : Bool!
    
    init(_ dict : [String : Any]) {
        title = dict["title"] as? String ?? ""
        desc = dict["description"] as? String ?? ""
        get_media = MediaModel.init(dict["get_media"] as? [String : Any] ?? [String : Any]())
        id = AppModel.shared.getIntValue(dict, "id")
        life_style_id = AppModel.shared.getIntValue(dict, "life_style_id")
        isExpand = false
    }
    
    func dictionary() -> [String : Any] {
        return ["title" : title!, "description" : desc!, "get_media" : get_media.dictionary(), "id" : id!, "life_style_id" : life_style_id!]
    }
}

struct NotificationModel {
    var id, user_id : Int!
    var title, desc, type, status, created_at :String!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        user_id = AppModel.shared.getIntValue(dict, "user_id")
        title = dict["title"] as? String ?? ""
        desc = dict["desc"] as? String ?? ""
        status = dict["status"] as? String ?? ""
        type = dict["type"] as? String ?? ""
        created_at = dict["created_at"] as? String ?? ""
    }
}

struct StatisticModel {
    var completed, missed, total : Int!
    var date : String!
    
    init(_ dict : [String : Any]) {
        completed = AppModel.shared.getIntValue(dict, "completed")
        missed = AppModel.shared.getIntValue(dict, "missed")
        total = AppModel.shared.getIntValue(dict, "total")
        date = dict["date"] as? String ?? ""
    }
}
