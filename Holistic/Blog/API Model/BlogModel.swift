//
//  BlogModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 24/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation


struct BlogModel {
    var id : Int!
    var title, desc, created_at : String!
    var get_single_media : MediaModel!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        title = dict["title"] as? String ?? ""
        desc = dict["description"] as? String ?? ""
        created_at = dict["created_at"] as? String ?? ""
        get_single_media = MediaModel.init(dict["get_single_media"] as? [String : Any] ?? [String : Any]())
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "title" : title!, "description" : desc!, "created_at" : created_at!, "get_single_media" : get_single_media.dictionary()]
    }
}

struct MediaModel {
    var id, type_id : Int!
    var type, url, model_name : String!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        type_id = AppModel.shared.getIntValue(dict, "type_id")
        type = dict["type"] as? String ?? ""
        url = dict["url"] as? String ?? ""
        model_name = dict["model_name"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "type_id" : type_id!, "type" : type!, "url" : url!, "model_name" : model_name!]
    }
}
