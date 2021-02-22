//
//  LoyalityPointCVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 19/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import FSPagerView

class LoyalityPointCVC: FSPagerViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var discountLbl: Label!
    @IBOutlet weak var pointLbl: Label!
    @IBOutlet weak var getCodeBtn: Button!
    @IBOutlet weak var redeemBtn: Button!
    @IBOutlet weak var removeBtn: Button!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        logoImg.isHidden = true
        removeBtn.isHidden = true
    }

    func setupDetails(_ dict : OfferModel) {
        setImageBackgroundImage(imgView, dict.get_single_offer_image.url, IMAGE.PLACEHOLDER)
        titleLbl.text = dict.title
        discountLbl.text = dict.desc.html2String
        pointLbl.text = "Required Points: " + String(dict.points_required)
    }
}
