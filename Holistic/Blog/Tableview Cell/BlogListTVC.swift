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

    func setupDetails(_ dict : BlogModel) {
        setImageBackgroundImage(imgVIew, dict.get_single_media.url, IMAGE.PLACEHOLDER)
        titleLbl.text = dict.title
        
        if let strDate = dict.created_at.components(separatedBy: "T").first {
            let date = getDateFromDateString(date: strDate, format: "yyyy-MM-dd")
            dateLbl.text = getDateStringFromDate(date: date, format: "MMMM d, yyyy")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
