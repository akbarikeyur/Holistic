//
//  LoginVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

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
    @IBAction func clickToSelectCountryCode(_ sender: UIButton) {
        
    }
    
    @IBAction func clickToSignIn(_ sender: Any) {
        AppDelegate().sharedDelegate().navigateToDashBoard()
    }
    
    @IBAction func clickToSignup(_ sender: Any) {
        
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
