//
//  BlogListTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 02/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class BlogListTVC: UITableViewCell {

    @IBOutlet weak var imgVIew: UIImageView!
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
