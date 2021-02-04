//
//  ContactInformationVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 29/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import DropDown

class ContactInformationVC: UIViewController {

    @IBOutlet weak var loginView: UIView!
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
    @IBOutlet weak var stateTxt: TextField!
    @IBOutlet weak var cityTxt: TextField!
    @IBOutlet weak var saveInfoBtn: Button!
    
    var arrCartData = [CartModel]()
    
    let arrCountry = getCountryData()
    var arrState = [StateModel]()
    var arrCity = [CityModel]()
    var selectedCountry = CountryModel.init([String : Any]())
    var selectedState = StateModel.init([String : Any]())
    var selectedCity = CityModel.init([String : Any]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginView.isHidden = isUserLogin()
        if arrCountry.count == 0 {
            AppDelegate().sharedDelegate().serviceCallToGetCountry()
        }
        setupDetails()
    }
    
    func setupDetails() {
        fnameTxt.text = AppModel.shared.currentUser.name
        
        let index = arrCountry.firstIndex { (temp) -> Bool in
            temp.id == AppModel.shared.currentUser.country_id
        }
        if index != nil {
            flagImg.image = UIImage(named: arrCountry[index!].sortname.lowercased())
            selectedCountry = arrCountry[index!]
            serviceCallToGetState()
        }
        phoneTxt.text = AppModel.shared.currentUser.phone_number
        emailTxt.text = AppModel.shared.currentUser.email
        addressTxt.text = AppModel.shared.currentUser.street_address
        apartmentTxt.text = AppModel.shared.currentUser.building_address
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
    
    @IBAction func clickToSelectNation(_ sender: UIButton) {
        self.view.endEditing(true)
        var arrData = [String]()
        for temp in arrCountry {
            arrData.append(temp.name)
        }
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = arrData
        dropDown.selectionAction = { [unowned self] (dropindex: Int, item: String) in
            if self.selectedCountry.id != self.arrCountry[dropindex].id {
                self.countryLbl.text = item
                self.selectedCountry = self.arrCountry[dropindex]
                self.flagImg.image = UIImage(named: self.arrCountry[dropindex].sortname.lowercased())
                self.stateTxt.text = ""
                self.selectedState = StateModel.init([String : Any]())
                self.cityTxt.text = ""
                self.selectedCity = CityModel.init([String : Any]())
                self.serviceCallToGetState()
            }
        }
        dropDown.show()
    }
    
    @IBAction func clickToSelectState(_ sender: UIButton) {
        self.view.endEditing(true)
        if selectedCountry.id == 0 {
            displayToast("Please select country")
            return
        }
        var arrData = [String]()
        for temp in arrState {
            arrData.append(temp.name)
        }
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = arrData
        dropDown.selectionAction = { [unowned self] (dropindex: Int, item: String) in
            if self.selectedState.id != self.arrState[dropindex].id {
                self.stateTxt.text = item
                self.selectedState = self.arrState[dropindex]
                self.cityTxt.text = ""
                self.selectedCity = CityModel.init([String : Any]())
                self.serviceCallToGetCity()
            }
        }
        dropDown.show()
    }
    
    @IBAction func clickToSelectCity(_ sender: UIButton) {
        self.view.endEditing(true)
        if selectedState.id == 0 {
            displayToast("Please select state")
            return
        }
        var arrData = [String]()
        for temp in arrCity {
            arrData.append(temp.name)
        }
        let dropDown = DropDown()
        dropDown.anchorView = sender
        dropDown.dataSource = arrData
        dropDown.selectionAction = { [unowned self] (dropindex: Int, item: String) in
            self.cityTxt.text = item
            self.selectedCity = self.arrCity[dropindex]
        }
        dropDown.show()
    }
    
    @IBAction func clickToSaveInformation(_ sender: UIButton) {
        saveInfoBtn.isSelected = !saveInfoBtn.isSelected
    }
    
    @IBAction func clickToContinue(_ sender: Any) {
        let vc : OrderSummaryVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "OrderSummaryVC") as! OrderSummaryVC
        vc.arrCartData = arrCartData
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

extension ContactInformationVC {
    func serviceCallToGetState() {
        LoginAPIManager.shared.serviceCallToGetState(["country_id" : selectedCountry.id!]) { (data) in
            self.arrState = [StateModel]()
            for temp in data {
                self.arrState.append(StateModel.init(temp))
            }
            if self.selectedState.id == 0 && AppModel.shared.currentUser.state_id != 0 {
                let index = self.arrState.firstIndex { (temp) -> Bool in
                    temp.id == AppModel.shared.currentUser.state_id
                }
                if index != nil {
                    self.selectedState = self.arrState[index!]
                    self.stateTxt.text = self.selectedState.name
                    self.cityTxt.text = ""
                    self.selectedCity = CityModel.init([String : Any]())
                    self.serviceCallToGetCity()
                }
            }
        }
    }
    
    func serviceCallToGetCity() {
        LoginAPIManager.shared.serviceCallToGetCity(["state_id" : selectedState.id!]) { (data) in
            self.arrCity = [CityModel]()
            for temp in data {
                self.arrCity.append(CityModel.init(temp))
            }
            if self.selectedCity.id == 0 && AppModel.shared.currentUser.city_id != 0 {
                let index = self.arrCity.firstIndex { (temp) -> Bool in
                    temp.id == AppModel.shared.currentUser.city_id
                }
                if index != nil {
                    self.selectedCity = self.arrCity[index!]
                    self.cityTxt.text = self.selectedCity.name                    
                }
            }
        }
    }
}
