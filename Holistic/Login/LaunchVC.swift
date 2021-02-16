//
//  LaunchVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 15/02/21.
//  Copyright © 2021 Keyur Akbari. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var logo_titleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        logoImg.alpha = 0
        logo_titleLbl.alpha = 0
        UIView.animate(withDuration: 1.0, animations: {
            self.logoImg.alpha = 1.0
        }) { (isDone) in
            UIView.animate(withDuration: 1.0, animations: {
                self.logo_titleLbl.alpha = 1.0
            }) { (isDone) in
                delay(0.5) {
                    if isUserLogin() {
                        AppModel.shared.currentUser = getLoginUserData()
                        AppDelegate().sharedDelegate().navigateToDashBoard()
                    }
                    else{
                        if isInfoScreenDisplayed() {
                            let vc : EmailLoginVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "EmailLoginVC") as! EmailLoginVC
                            self.navigationController?.pushViewController(vc, animated: false)
                        }else{
                            let vc : WelcomeVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
                            self.navigationController?.pushViewController(vc, animated: false)
                        }
                    }
                }
            }
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
