//
//  EmailLoginVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 03/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class EmailLoginVC: UIViewController {

    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    @IBOutlet weak var rememberSwitch: UISwitch!
    @IBOutlet weak var signupBtn: Button!
    @IBOutlet weak var mobileLoginBtn: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
    }
    
    func configUI() {
        signupBtn.setAttributedTitle(attributedStringWithColor("If not a member yet, Sign up", ["Sign up"], color: OrangeColor), for: .normal)
        mobileLoginBtn.setAttributedTitle(attributedStringWithColor("If already a member in Clincia App, Click Here", ["Click Here"], color: OrangeColor), for: .normal)
        
        rememberSwitch.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if PLATFORM.isSimulator {
//            emailTxt.text = "arm@anglotestserver.website"
//            passwordTxt.text = "abc"
            emailTxt.text = "keyur2@gmail.com"
            passwordTxt.text = "qqqqqq"
        }
    }
    
    @IBAction func clickToShowHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTxt.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func clickToForgotPassword(_ sender: Any) {
        self.view.endEditing(true)
        let vc : ForgotPasswordVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToSignIn(_ sender: Any) {
        self.view.endEditing(true)
        if emailTxt.text?.trimmed == "" {
            displayToast("enter_email")
        }
        else if !emailTxt.text!.isValidEmail {
            displayToast("invalid_email")
        }
        else if passwordTxt.text?.trimmed == "" {
            displayToast("enter_password")
        }
        else {
            var param = [String : Any]()
            param["email"] = emailTxt.text
            param["password"] = passwordTxt.text
            param["remember_token"] = getPushToken()
            printData(param)
            LoginAPIManager.shared.serviceCallToEmailLogin(param) { (dict) in
                if let data = dict["data"] as? [String : Any] {
                    AppModel.shared.currentUser = UserModel.init(data)
                    setLoginUserData()
                    if AppModel.shared.currentUser.clinicea_user_id != "" {
                        setCliniciaUser(true)
                    }
                    setAngloUser(true)
                    
                    if let cliniciaData = dict["checkClincia"] as? [[String : Any]] {
                        var arrUser = [CliniciaUserModel]()
                        for temp in cliniciaData {
                            arrUser.append(CliniciaUserModel.init(temp))
                        }
                        setCliniciaMemberData(arrUser)
                    }
                    
                    if getCliniciaMemberData().count > 0 {
                        setClinicUserId(getCliniciaMemberData()[0].ID)
                    }
                    
                    if getCliniciaMemberData().count > 1 {
                        let vc : SelectUserVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SelectUserVC") as! SelectUserVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        AppDelegate().sharedDelegate().navigateToDashBoard()
                    }
                }
            }
        }
    }
    
    @IBAction func clickToSignup(_ sender: Any) {
        self.view.endEditing(true)
        let vc : SignupVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickToMobileLogin(_ sender: Any) {
        self.view.endEditing(true)
        let vc : MobileLoginVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "MobileLoginVC") as! MobileLoginVC
        self.navigationController?.pushViewController(vc, animated: true)
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
