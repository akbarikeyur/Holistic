//
//  ProfileVC.swift
//  Holistic
//
//  Created by Keyur on 02/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var userImg: ImageView!
    @IBOutlet weak var displayNameLbl: Label!
    @IBOutlet weak var usernameLbl: Label!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var emailLbl: Label!
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var countryCodeLbl: Label!
    @IBOutlet weak var phoneLbl: Label!
    @IBOutlet weak var addressLbl: Label!
    @IBOutlet weak var countryLbl: Label!
    @IBOutlet weak var notiTbl: UITableView!
    @IBOutlet weak var constraintHeightNotiTbl: NSLayoutConstraint!
    
    var arrLocalSetting = [NotificationSettingModel]()
    var arrSetting = [NotificationSettingModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(setupDetails), name: NSNotification.Name.init(NOTIFICATION.UPDATE_CURRENT_USER_DATA), object: nil)
        setupDetails()
        registerTableViewMethod()
        serviceCallToGetNotificationSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    @objc func setupDetails() {
        if AppModel.shared.currentUser == nil {
            return
        }
        setImageBackgroundImage(userImg, AppModel.shared.currentUser.get_profile.url, IMAGE.PLACEHOLDER)
        displayNameLbl.text = AppModel.shared.currentUser.name
        usernameLbl.text = ""
        nameLbl.text = AppModel.shared.currentUser.name
        emailLbl.text = AppModel.shared.currentUser.email
        
        let arrCountry = getCountryData()
        let index = arrCountry.firstIndex { (temp) -> Bool in
            temp.id == AppModel.shared.currentUser.country_id
        }
        if index != nil {
            let selectedCountry = arrCountry[index!]
            countryLbl.text = selectedCountry.name
            countryLbl.text = selectedCountry.name
        }
        let index1 = arrCountry.firstIndex { (temp) -> Bool in
            ("+" + temp.phonecode) == AppModel.shared.currentUser.phone_code
        }
        if index1 != nil {
            let tempCountry = arrCountry[index1!]
            flagImg.image = UIImage(named: tempCountry.sortname.lowercased())
            countryCodeLbl.text = "+" + tempCountry.phonecode
        }
        phoneLbl.text = AppModel.shared.currentUser.phone_number
        
        addressLbl.text = AppModel.shared.currentUser.room_no
        if AppModel.shared.currentUser.floor != "" {
            if addressLbl.text != "" {
                addressLbl.text = addressLbl.text! + ", " + AppModel.shared.currentUser.floor
            }else{
                addressLbl.text = AppModel.shared.currentUser.floor
            }
        }
        if AppModel.shared.currentUser.building_address != "" {
            if addressLbl.text != "" {
                addressLbl.text = addressLbl.text! + ", " + AppModel.shared.currentUser.building_address
            }else{
                addressLbl.text = AppModel.shared.currentUser.building_address
            }
        }
        if AppModel.shared.currentUser.street_address != "" {
            if addressLbl.text != "" {
                addressLbl.text = addressLbl.text! + ", " + AppModel.shared.currentUser.street_address
            }else{
                addressLbl.text = AppModel.shared.currentUser.street_address
            }
        }
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToEdit(_ sender: Any) {
        let vc : EditProfileVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func clickToChangePassword(_ sender: Any) {
        self.view.endEditing(true)
        showAlertWithOption("Change Password", message: "We will send you email to your registerd email address to change password. Are you sure want to Change passwprd?", btns: ["cancel_button", "change_password"], completionConfirm: {
            
            var param = [String : Any]()
            param["email"] = AppModel.shared.currentUser.email
            LoginAPIManager.shared.serviceCallToForgotPassword(param) { (dict) in
                displayToast("Link sent to your email address.")
            }
        }) {
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- Tableview Method
extension ProfileVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        notiTbl.register(UINib.init(nibName: "NotificationSettingTVC", bundle: nil), forCellReuseIdentifier: "NotificationSettingTVC")
        
        arrLocalSetting = [NotificationSettingModel]()
        for temp in getJsonFromFile("notification") {
            arrLocalSetting.append(NotificationSettingModel.init(temp))
        }
        notiTbl.reloadData()
        updateNotiTableviewHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLocalSetting.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NotificationSettingTVC = notiTbl.dequeueReusableCell(withIdentifier: "NotificationSettingTVC") as! NotificationSettingTVC
        cell.setupDetails(arrLocalSetting[indexPath.row])
        let index = arrSetting.firstIndex { (temp) -> Bool in
            temp.type == arrLocalSetting[indexPath.row].type
        }
        if index != nil {
            if arrSetting[index!].status == "on" {
                cell.notiSwitch.setOn(true, animated: false)
            }else{
                cell.notiSwitch.setOn(false, animated: false)
            }
        }
        cell.notiSwitch.tag = indexPath.row
        cell.notiSwitch.addTarget(self, action: #selector(clickToChangeValue(_:)), for: .valueChanged)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc @IBAction func clickToChangeValue(_ sender: UISwitch) {
        let dict = arrLocalSetting[sender.tag]
        var param = [String : Any]()
        param["user_id"] = AppModel.shared.currentUser.id
        param["type"] = dict.type
        param["status"] = sender.isOn ? "on" : "off"
        ProfileAPIManager.shared.serviceCallToSetNotificationSetting(param) {
            
        }
    }
    
    func updateNotiTableviewHeight() {
        constraintHeightNotiTbl.constant = CGFloat.greatestFiniteMagnitude
        notiTbl.reloadData()
        notiTbl.layoutIfNeeded()
        constraintHeightNotiTbl.constant = notiTbl.contentSize.height
    }
}

extension ProfileVC {
    func serviceCallToGetNotificationSetting() {
        ProfileAPIManager.shared.serviceCallToGetNotificationSetting(["user_id" : AppModel.shared.currentUser.id!]) { (data) in
            self.arrSetting = [NotificationSettingModel]()
            for temp in data {
                self.arrSetting.append(NotificationSettingModel.init(temp))
            }
            self.notiTbl.reloadData()
        }
    }
}
