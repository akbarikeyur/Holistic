//
//  ClinicPackageTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 11/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicPackageTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var appointmentTxt: TextField!
    @IBOutlet weak var onGoingBtn: Button!
    @IBOutlet weak var orgNameLbl: Label!
    @IBOutlet weak var progressLbl: Label!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : ClinicPackageModel) {
        titleLbl.text = dict.PatientName
        dateView.isHidden = true
//        let strDate = dict.PackageSoldOnDate.components(separatedBy: "T").first!
//        dateLbl.text = ""
//        if let date = getDateFromDateString(date: strDate, format: "yyyy-MM-dd") {
//            dateLbl.text = "Sold on " + getDateStringFromDate(date: date, format: "EEE") + ", " + getDateStringFromDate(date: date, format: "dd-MMM-yyyy")
//            if getDifferentTimeAgo(date) != "" {
//                dateLbl.text = dateLbl.text! + " (" + getDifferentTimeAgo(date) + ")"
//            }
//        }else{
//            dateLbl.text = "Sold on " + strDate
//        }
        descLbl.text = dict.PackageName
        if dict.PackageIsCompleted == 1 {
            onGoingBtn.setTitle("Completed", for: .normal)
            onGoingBtn.backgroundColor = GreenColor
        }
        else if dict.PackageIsClosed == 1 {
            onGoingBtn.setTitle("Closed", for: .normal)
            onGoingBtn.backgroundColor = GRAY_COLOR
        } else {
            onGoingBtn.setTitle("Ongoing", for: .normal)
            onGoingBtn.backgroundColor = OrangeColor
        }
        orgNameLbl.text = dict.OrganisationName
        progressLbl.text = String(Int(dict.PackageServiceCompletedCount * 100 / dict.PackageServiceTotalCount)) + "%"
        progressBar.progress = Float(dict.PackageServiceCompletedCount * 100 / dict.PackageServiceTotalCount) / 100
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
