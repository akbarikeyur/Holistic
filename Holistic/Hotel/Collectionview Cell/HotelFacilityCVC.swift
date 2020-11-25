//
//  HotelFacilityCVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class HotelFacilityCVC: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : FacilityModel) {
        nameLbl.text = dict.name
        setImageBackgroundImage(imgView, dict.get_single_media.url, IMAGE.PLACEHOLDER)
    }
}
