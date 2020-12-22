//
//  ProductModel.swift
//  Holistic
//
//  Created by Keyur Akbari on 14/12/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import Foundation

struct ProductModel {
    var id : Int!
    var name, desc, price, benifits, how_to_use, delivery, created_at : String!
    var product_single_image : [MediaModel]!
    var product_total_qty : QuantityModel!
    var product_total_qty_in_count : Int!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        name = dict["name"] as? String ?? ""
        desc = dict["description"] as? String ?? ""
        price = AppModel.shared.getStringValue(dict, "price")
        benifits = dict["benifits"] as? String ?? ""
        how_to_use = dict["how_to_use"] as? String ?? ""
        delivery = dict["delivery"] as? String ?? ""
        created_at = dict["created_at"] as? String ?? ""
        product_single_image = [MediaModel]()
        if let temp = dict["product_single_image"] as? [String : Any] {
            product_single_image.append(MediaModel.init(temp))
        }
        else if let tempData = dict["product_single_image"] as? [[String : Any]] {
            for temp in tempData {
                product_single_image.append(MediaModel.init(temp))
            }
        }
        else if let tempData = dict["get_product_images"] as? [[String : Any]] {
            for temp in tempData {
                product_single_image.append(MediaModel.init(temp))
            }
        }
        product_total_qty = QuantityModel.init(dict["product_total_qty"] as? [String : Any] ?? [String : Any]())
        product_total_qty_in_count = AppModel.shared.getIntValue(dict, "product_total_qty_in_count")
    }
}

struct QuantityModel {
    var id, product_id, qty, total_qty : Int!
    var stock_type : String!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        product_id = AppModel.shared.getIntValue(dict, "product_id")
        qty = AppModel.shared.getIntValue(dict, "qty")
        total_qty = AppModel.shared.getIntValue(dict, "total_qty")
        stock_type = dict["stock_type"] as? String ?? ""
    }
    
    func dictionary() -> [String : Any] {
        return ["id" : id!, "product_id" : product_id!, "qty" : qty!, "total_qty" : total_qty!, "stock_type" : stock_type!]
    }
}

struct CartModel {
    var id, product_id, qty, user_id : Int!
    var get_product : [ProductModel]!
    
    init(_ dict : [String : Any]) {
        id = AppModel.shared.getIntValue(dict, "id")
        product_id = AppModel.shared.getIntValue(dict, "product_id")
        qty = AppModel.shared.getIntValue(dict, "qty")
        user_id = AppModel.shared.getIntValue(dict, "user_id")
        get_product = [ProductModel]()
        if let tempData = dict["get_product"] as? [[String : Any]] {
            for temp in tempData {
                get_product.append(ProductModel.init(temp))
            }
        }
    }
}
