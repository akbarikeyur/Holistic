//
//  WelcomeVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var swipeView: SwipeButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        swipeView.handleAction { (isFinish) in
            if isFinish {
                //redirect
                let vc : MobileLoginVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "MobileLoginVC") as! MobileLoginVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
}
