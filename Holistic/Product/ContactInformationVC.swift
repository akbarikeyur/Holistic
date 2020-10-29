//
//  ContactInformationVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 29/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ContactInformationVC: UIViewController {

    @IBOutlet weak var loginLbl: Label!
    @IBOutlet weak var emailPhoneTxt: TextField!
    @IBOutlet weak var updateNewsBtn: Button!
    @IBOutlet weak var fnameTxt: TextField!
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var countryLbl: Label!
    @IBOutlet weak var phoneTxt: TextField!
    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var addressTxt: TextField!
    @IBOutlet weak var apartmentTxt: TextField!
    @IBOutlet weak var cityTxt: TextField!
    @IBOutlet weak var countryTxt: TextField!
    @IBOutlet weak var saveInfoBtn: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToLogin(_ sender: Any) {
        
    }
    
    @IBAction func clickToUpdateNews(_ sender: UIButton) {
        updateNewsBtn.isSelected = !updateNewsBtn.isSelected
    }
    
    @IBAction func clickToSelectNation(_ sender: Any) {
        
    }
    
    @IBAction func clickToSelectCity(_ sender: Any) {
        
    }
    
    @IBAction func clickToSelectCountry(_ sender: Any) {
        
    }
    
    @IBAction func clickToSaveInformation(_ sender: UIButton) {
        saveInfoBtn.isSelected = !saveInfoBtn.isSelected
    }
    
    @IBAction func clickToContinue(_ sender: Any) {
        let vc : OrderSummaryVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "OrderSummaryVC") as! OrderSummaryVC
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
