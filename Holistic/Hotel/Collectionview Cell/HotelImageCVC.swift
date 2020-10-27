//
//  HotelImageCVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class HotelImageCVC: UICollectionViewCell {

    @IBOutlet weak var outerView: View!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outerView.layer.borderColor = WHITE_COLOR.cgColor
    }

    func setupDetails(_ isSelect : Bool) {
        if isSelect {
            constraintWidth.constant = 70
            constraintHeight.constant = 70
            outerView.setCornerRadius(35)
            outerView.layer.borderWidth = 3.0
        }
        else{
            constraintWidth.constant = 80
            constraintHeight.constant = 80
            outerView.setCornerRadius(40)
            outerView.layer.borderWidth = 0
        }
    }
}
