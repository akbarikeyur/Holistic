//
//  ProfileVC.swift
//  Holistic
//
//  Created by Keyur on 02/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var currentPasswordTxt: TextField!
    @IBOutlet weak var newPasswordTxt: TextField!
    @IBOutlet weak var confirmPasswordTxt: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
    }
    //MARK:- Button click event
    @IBAction func clickToSideMenu(_ sender: Any) {
        self.menuContainerViewController.toggleLeftSideMenuCompletion {}
    }
    
    @IBAction func clickToNotification(_ sender: Any) {
        
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
