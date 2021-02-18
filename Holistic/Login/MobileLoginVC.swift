//
//  MobileLoginVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import DropDown

class MobileLoginVC: UIViewController {

    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var phoneCodeLbl: Label!
    @IBOutlet weak var phoneTxt: TextField!
    @IBOutlet weak var signupBtn: Button!
    
    var arrCountry = [CountryModel]()
    var selectedCountry = CountryModel.init([String : Any]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
        
        if getCountryData().count == 0 {
            AppDelegate().sharedDelegate().serviceCallToGetCountry()
        }
        else{
            arrCountry = getCountryData()
            let index = arrCountry.firstIndex { (temp) -> Bool in
                temp.sortname.lowercased() == CURRENT_COUNTRY_CODE.lowercased()
            }
            if index != nil {
                self.selectedCountry = self.arrCountry[index!]
                self.phoneCodeLbl.text = "+" + self.selectedCountry.phonecode
                self.flagImg.image = UIImage(named: self.selectedCountry.sortname.lowercased())
            }
        }
    }
    
    func configUI() {
        signupBtn.setAttributedTitle(attributedStringWithColor("If you are not already a member, Sign Up", ["Sign Up"], color: OrangeColor), for: .normal)
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToSelectCountryCode(_ sender: UIButton) {
        self.view.endEditing(true)
        if arrCountry.count == 0 {
            arrCountry = getCountryData()
        }
        var arrData = [String]()
        for temp in arrCountry {
            arrData.append("(+" + temp.phonecode + ") " + temp.name)
        }
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = arrData
        dropDown.selectionAction = { [unowned self] (dropindex: Int, item: String) in
            self.selectedCountry = self.arrCountry[dropindex]
            self.phoneCodeLbl.text = "+" + self.selectedCountry.phonecode
            self.flagImg.image = UIImage(named: self.selectedCountry.sortname.lowercased())
        }
        dropDown.show()
    }
    
    @IBAction func clickToSignIn(_ sender: Any) {
        self.view.endEditing(true)
        if phoneTxt.text?.trimmed == "" {
            displayToast("enter_phone")
        }
        else{
            var param = [String : Any]()
            param["countrycode"] = self.selectedCountry.phonecode
            param["phonenumber"] = phoneTxt.text
            param["remember_token"] = getPushToken()
            LoginAPIManager.shared.serviceCallToMobileLogin(param) { (dict) in
                
                if let is_clincia = dict["is_clincia"] as? Bool {
                    if let is_anglo = dict["is_anglo"] as? Bool {
                        if !is_anglo {
                            self.clickToSignup(self)
                        }
                        else if let data = dict["data"] as? [String : Any] {
                            AppModel.shared.currentUser = UserModel.init(data)
                            AppModel.shared.currentUser.is_clincia = is_clincia
                            AppModel.shared.currentUser.is_anglo = is_anglo
                            setLoginUserData()
                            setCliniciaUser(is_clincia)
                            setAngloUser(is_anglo)
                            AppDelegate().sharedDelegate().navigateToDashBoard()
                        }
                        else if let data = dict["data"] as? [[String : Any]], data.count > 0 {
                            
                        }
                    }
                }
//                let vc : OTPVerificationVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "OTPVerificationVC") as! OTPVerificationVC
//                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func clickToSignup(_ sender: Any) {
        self.view.endEditing(true)
        var isRedirect = false
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: SignupVC.self) {
                isRedirect = true
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        if !isRedirect {
            let vc : SignupVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
            self.navigationController?.pushViewController(vc, animated: true)
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
