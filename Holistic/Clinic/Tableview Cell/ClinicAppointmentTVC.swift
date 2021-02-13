//
//  ClinicAppointmentTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 31/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicAppointmentTVC: UITableViewCell {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var monthLbl: Label!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var yearLbl: Label!
    @IBOutlet weak var serviceNameLbl: Label!
    @IBOutlet weak var userNameLbl: Label!
    @IBOutlet weak var orgNameLbl: Label!
    @IBOutlet weak var statusBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupDetails(_ dict : AppointmentModel) {
        //2018-05-24T13:05:00Z
        let strDate = dict.StartDateTime.components(separatedBy: "T").first!
        let date = getDateFromDateString(date: strDate, format: "yyyy-MM-dd")
        monthLbl.text = getLocalDateStringFromDate(date: date, format: "MMM")
        dateLbl.text = getLocalDateStringFromDate(date: date, format: "dd")
        yearLbl.text = getLocalDateStringFromDate(date: date, format: "yyyy")
        serviceNameLbl.text = dict.ServiceName
        userNameLbl.text = dict.PatientName
        orgNameLbl.text = dict.OrganisationName
        statusBtn.setTitle(dict.AppointmentStatus, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
