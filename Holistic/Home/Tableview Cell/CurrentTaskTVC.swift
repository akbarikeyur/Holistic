//
//  CurrentTaskTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class CurrentTaskTVC: UITableViewCell {

    @IBOutlet weak var outerView: View!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: Label!
    @IBOutlet weak var actionLbl: Label!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var actionImgView: UIView!
    @IBOutlet weak var actionImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : TaskModel) {
        
        outerView.backgroundColor = colorFromHex(hex: dict.get_life_style.color_select)
        titleLbl.text = dict.get_life_style.title
        if dict.get_life_style.task_start_date_time != "" && dict.get_life_style.task_end_date_time != "" {
            let startDate = getDateFromDateString(date: dict.get_life_style.task_start_date_time, format: "yyyy-MM-dd hh:mm:ss")
            let endDate = getDateFromDateString(date: dict.get_life_style.task_end_date_time, format: "yyyy-MM-dd hh:mm:ss")
            timeLbl.text = getLocalDateStringFromDate(date: startDate, format: "hh:mm a") + " - " + getLocalDateStringFromDate(date: endDate, format: "hh:mm a")
        }else{
            timeLbl.text = ""
        }
        actionLbl.text = dict.status
        setImageBackgroundImage(imgView, dict.get_life_style.get_single_media.url, IMAGE.PLACEHOLDER)
        
        if dict.status == "pending" {
            actionImgView.isHidden = true
        }
        else if dict.status == "completed" {
            actionImgView.isHidden = false
            actionImg.image = UIImage(named: "ic_complete")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
