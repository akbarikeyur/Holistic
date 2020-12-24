//
//  ProfileVC.swift
//  Holistic
//
//  Created by Keyur on 02/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var displayNameLbl: Label!
    @IBOutlet weak var usernameLbl: Label!
    @IBOutlet weak var nameLbl: Label!
    @IBOutlet weak var emailLbl: Label!
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var countryCodeLbl: Label!
    @IBOutlet weak var phoneLbl: Label!
    @IBOutlet weak var addressLbl: Label!
    @IBOutlet weak var countryLbl: Label!
    
    @IBOutlet weak var currentPasswordTxt: TextField!
    @IBOutlet weak var newPasswordTxt: TextField!
    @IBOutlet weak var confirmPasswordTxt: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
    }
    
    func setupDetails() {
        if AppModel.shared.currentUser == nil {
            return
        }
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
            flagImg.image = UIImage(named: selectedCountry.sortname.lowercased())
            countryCodeLbl.text = "+" + selectedCountry.phonecode
            countryLbl.text = selectedCountry.name
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
    @IBAction func clickToSideMenu(_ sender: Any) {
        self.menuContainerViewController.toggleLeftSideMenuCompletion {}
    }
    
    @IBAction func clickToEdit(_ sender: Any) {
        let vc : EditProfileVC = STORYBOARD.PROFILE.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func clickToShowHideCurrentPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        currentPasswordTxt.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func clickToShowHideNewPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        newPasswordTxt.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func clickToShowHideConfirmPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        confirmPasswordTxt.isSecureTextEntry = !sender.isSelected
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
