//
//  MyCodeTVC.swift
//  Holistic
//
//  Created by Keyur on 26/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class MyCodeTVC: UITableViewCell {

    @IBOutlet weak var imgView: ImageView!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var codeLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupHotelDetails(_ dict : HotelModel) {
        
    }
    
    func setupRestaurantDetails(_ dict : RestaurantModel) {
        
    }
    
    func setupCouponCode(_ dict : ActivedOfferModel) {
        setImageBackgroundImage(imgView, dict.get_offer.get_single_offer_image.url, IMAGE.PLACEHOLDER)
        let tempDate = dict.created_at.components(separatedBy: ".").first!
        let date = getDateFromDateString(date: tempDate, format: "yyyy-MM-dd'T'HH:mm:ss")
        dateLbl.text = getLocalDateStringFromDate(date: date, format: "d MMM, yyyy")
        nameLbl.text = dict.get_offer.title.html2String
        codeLbl.text = "Code " + dict.code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
