//
//  SignupVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 03/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var signinBtn: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
    }
    
    func configUI() {
        signinBtn.setAttributedTitle(attributedStringWithColor("Already member? Sign in", ["Sign in"], color: OrangeColor), for: .normal)
    }
    
    
    //MARK:- Button click event
    @IBAction func clickToLogin(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickToSignup(_ sender: Any) {
        self.view.endEditing(true)
        AppDelegate().sharedDelegate().navigateToDashBoard()
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
