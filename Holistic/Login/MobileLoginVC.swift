//
//  MobileLoginVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class MobileLoginVC: UIViewController {

    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var phoneCodeLbl: Label!
    @IBOutlet weak var phoneTxt: TextField!
    @IBOutlet weak var signupBtn: Button!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
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
    }
    
    @IBAction func clickToSignIn(_ sender: Any) {
        self.view.endEditing(true)
        if phoneTxt.text?.trimmed == "" {
            displayToast("enter_phone")
        }
        else{
            var param = [String : Any]()
            param["phone"] = phoneTxt.text
            
            LoginAPIManager.shared.serviceCallToMobileLogin(param) { (dict) in
                let vc : OTPVerificationVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "OTPVerificationVC") as! OTPVerificationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func clickToSignup(_ sender: Any) {
        self.view.endEditing(true)
        let vc : SignupVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
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
