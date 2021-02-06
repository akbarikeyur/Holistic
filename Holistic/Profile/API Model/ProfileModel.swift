//
//  ProfileModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 03/02/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import Foundation

struct OfferModel {
    var id, points_required : Int!
    var title, desc, status : String!
    var get_single_offer_image : MediaModel!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        points_required = AppModel.shared.getIntValue(dict, "points_required")
        title = dict["title"] as? String ?? ""
        desc = dict["description"] as? String ?? ""
        status = dict["status"] as? String ?? ""
        get_single_offer_image = MediaModel.init(dict["get_single_offer_image"] as? [String : Any] ?? [String : Any]())
    }
}

struct ActivedOfferModel {
    var id, points_spent : Int!
    var code, redeem : String!
    var get_offer : OfferModel!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        points_spent = AppModel.shared.getIntValue(dict, "points_spent")
        code = dict["code"] as? String ?? ""
        redeem = dict["redeem"] as? String ?? ""
        get_offer = OfferModel.init(dict["get_offer"] as? [String : Any] ?? [String : Any]())
    }
}

struct NotificationSettingModel {
    var title, desc, type, status : String!
    var id : Int!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        title = dict["title"] as? String ?? ""
        desc = dict["desc"] as? String ?? ""
        type = dict["type"] as? String ?? ""
        status = dict["status"] as? String ?? ""
    }
}
