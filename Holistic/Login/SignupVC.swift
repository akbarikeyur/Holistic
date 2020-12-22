//
//  SignupVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 03/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var nameTxt: TextField!
    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var phonecodeTxt: Label!
    @IBOutlet weak var phoneTxt: TextField!
    @IBOutlet weak var addressTxt: TextField!
    @IBOutlet weak var buildingNameTxt: TextField!
    @IBOutlet weak var floorTxt: TextField!
    @IBOutlet weak var roomTxt: TextField!
    @IBOutlet weak var countryTxt: TextField!
    @IBOutlet weak var stateTxt: TextField!
    @IBOutlet weak var cityTxt: TextField!
    @IBOutlet weak var howFindTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    @IBOutlet weak var confirmPasswordTxt: TextField!
    
    @IBOutlet weak var signinBtn: Button!
    @IBOutlet var searchView: UIView!
    @IBOutlet weak var searchTxt: TextField!
    @IBOutlet weak var searchTbl: UITableView!
    
    var arrCountry = [CountryModel]()
    var arrState = [StateModel]()
    var arrCity = [CityModel]()
    var arrSearchCountry = [CountryModel]()
    var arrSearchState = [StateModel]()
    var arrSearchCity = [CityModel]()
    var selectedCountry = CountryModel.init([String : Any]())
    var selectedState = StateModel.init([String : Any]())
    var selectedCity = CityModel.init([String : Any]())
    var selectedType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        configUI()
    }
    
    func configUI() {
        signinBtn.setAttributedTitle(attributedStringWithColor("Already member? Sign in", ["Sign in"], color: OrangeColor), for: .normal)
        registerTableViewMethod()
        
        if getCountryData().count == 0 {
            AppDelegate().sharedDelegate().serviceCallToGetCountry()
        }
    }
    
    //MARK:- Button click event
    @IBAction func clickToSelectPhoneCode(_ sender: UIButton) {
        searchTxt.text = ""
        arrCountry = getCountryData()
        selectedType = 3
        displaySubViewtoParentView(self.view, subview: searchView)
        searchTbl.reloadData()
    }
    
    @IBAction func clickToSelectCountry(_ sender: UIButton) {
        searchTxt.text = ""
        arrCountry = getCountryData()
        selectedType = 0
        displaySubViewtoParentView(self.view, subview: searchView)
        searchTbl.reloadData()
    }
    
    @IBAction func clickToSelectState(_ sender: UIButton) {
        searchTxt.text = ""
        if selectedCountry.id == 0 {
            displayToast("select_country_first")
            return
        }
        selectedType = 1
        displaySubViewtoParentView(self.view, subview: searchView)
        searchTbl.reloadData()
    }
    
    @IBAction func clickToSelectCity(_ sender: UIButton) {
        searchTxt.text = ""
        if selectedState.id == 0 {
            displayToast("select_state_first")
            return
        }
        selectedType = 2
        displaySubViewtoParentView(self.view, subview: searchView)
        searchTbl.reloadData()
    }
    
    @IBAction func clickToShowPassword(_ sender: UIButton) {
        if sender.tag == 1 {
            sender.isSelected = !sender.isSelected
            passwordTxt.isSecureTextEntry = !sender.isSelected
        }else{
            sender.isSelected = !sender.isSelected
            confirmPasswordTxt.isSecureTextEntry = !sender.isSelected
        }
    }
    
    @IBAction func clickToCloseSearchView(_ sender: Any) {
        searchView.removeFromSuperview()
        searchTxt.text = ""
    }
    
    @IBAction func clickToLogin(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickToSignup(_ sender: Any) {
        self.view.endEditing(true)
        if nameTxt.text?.trimmed == "" {
            displayToast("enter_name")
        }
        else if emailTxt.text?.trimmed == "" {
            displayToast("enter_email")
        }
        else if !emailTxt.text!.isValidEmail {
            displayToast("invalid_email")
        }
        else if phonecodeTxt.text?.trimmed == "" {
            displayToast("enter_phonecode")
        }
        else if phoneTxt.text?.trimmed == "" {
            displayToast("enter_phone")
        }
        else if addressTxt.text?.trimmed == "" {
            displayToast("enter_address")
        }
        else if buildingNameTxt.text?.trimmed == "" {
            displayToast("enter_building")
        }
        else if floorTxt.text?.trimmed == "" {
            displayToast("enter_floor")
        }
        else if roomTxt.text?.trimmed == "" {
            displayToast("enter_room_number")
        }
        else if countryTxt.text?.trimmed == "" {
            displayToast("enter_country")
        }
        else if stateTxt.text?.trimmed == "" {
            displayToast("enter_state")
        }
        else if cityTxt.text?.trimmed == "" {
            displayToast("enter_city")
        }
        else if passwordTxt.text?.trimmed == "" {
            displayToast("enter_password")
        }
        else if confirmPasswordTxt.text?.trimmed == "" {
            displayToast("enter_confirm_password")
        }
        else if passwordTxt.text != confirmPasswordTxt.text {
            displayToast("password_confirm_validation")
        }
        else {
            var param = [String : Any]()
            param["name"] = nameTxt.text
            param["email"] = emailTxt.text
            param["password"] = passwordTxt.text
            param["country_id"] = selectedCountry.id
            param["city_id"] = selectedCity.id
            param["room_no"] = roomTxt.text
            param["floor"] = floorTxt.text
            param["building_address"] = buildingNameTxt.text
            param["street_address"] = addressTxt.text
            param["phone_number"] = phoneTxt.text
            printData(param)
            LoginAPIManager.shared.serviceCallToSignup(param) { (dict) in
                AppDelegate().sharedDelegate().navigateToDashBoard()
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        if textField == searchTxt {
            if selectedType == 0 || selectedType == 3 {
                arrSearchCountry = [CountryModel]()
                arrSearchCountry = arrCountry.filter({ (result) -> Bool in
                    let nameTxt: NSString = result.name! as NSString
                    return (nameTxt.range(of: textField.text!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                })
            }
            else if selectedType == 1 {
                arrSearchState = [StateModel]()
                arrSearchState = arrState.filter({ (result) -> Bool in
                    let nameTxt: NSString = result.name! as NSString
                    return (nameTxt.range(of: textField.text!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                })
            }
            else if selectedType == 2 {
                arrSearchCity = [CityModel]()
                arrSearchCity = arrCity.filter({ (result) -> Bool in
                    let nameTxt: NSString = result.name! as NSString
                    return (nameTxt.range(of: textField.text!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                })
            }
            searchTbl.reloadData()
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

//MARK:- Tableview Method
extension SignupVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        searchTbl.register(UINib.init(nibName: "SingleLableTVC", bundle: nil), forCellReuseIdentifier: "SingleLableTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedType == 0 || selectedType == 3 {
            return searchTxt.text?.trimmed == "" ? arrCountry.count : arrSearchCountry.count
        }
        else if selectedType == 1 {
            return searchTxt.text?.trimmed == "" ? arrState.count : arrSearchState.count
        }
        else if selectedType == 2 {
            return searchTxt.text?.trimmed == "" ? arrCity.count : arrSearchCity.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SingleLableTVC = searchTbl.dequeueReusableCell(withIdentifier: "SingleLableTVC") as! SingleLableTVC
        if selectedType == 0 {
            cell.titleLbl.text = (searchTxt.text?.trimmed == "" ? arrCountry : arrSearchCountry)[indexPath.row].name
        }
        else if selectedType == 1 {
            cell.titleLbl.text = (searchTxt.text?.trimmed == "" ? arrState : arrSearchState)[indexPath.row].name
        }
        else if selectedType == 2 {
            cell.titleLbl.text = (searchTxt.text?.trimmed == "" ? arrCity : arrSearchCity)[indexPath.row].name
        }
        else if selectedType == 3 {
            cell.titleLbl.text = "(+" + (searchTxt.text?.trimmed == "" ? arrCountry : arrSearchCountry)[indexPath.row].phonecode + ") " + (searchTxt.text?.trimmed == "" ? arrCountry : arrSearchCountry)[indexPath.row].name
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedType == 0 || selectedType == 3 {
            selectedCountry = (searchTxt.text?.trimmed == "" ? arrCountry : arrSearchCountry)[indexPath.row]
            countryTxt.text = selectedCountry.name
            flagImg.image = UIImage(named: selectedCountry.sortname.lowercased())
            phonecodeTxt.text = "+" + (searchTxt.text?.trimmed == "" ? arrCountry : arrSearchCountry)[indexPath.row].phonecode
            serviceCallToGetState()
        }
        else if selectedType == 1 {
            selectedState = (searchTxt.text?.trimmed == "" ? arrState : arrSearchState)[indexPath.row]
            stateTxt.text = selectedState.name
            serviceCallToGetCity()
        }
        else if selectedType == 2 {
            selectedCity = (searchTxt.text?.trimmed == "" ? arrCity : arrSearchCity)[indexPath.row]
            cityTxt.text = selectedCity.name
        }
        searchView.removeFromSuperview()
        searchTxt.text = ""
    }
}

extension SignupVC {
    func serviceCallToGetState() {
        LoginAPIManager.shared.serviceCallToGetState(["country_id" : selectedCountry.id!]) { (data) in
            self.arrState = [StateModel]()
            for temp in data {
                self.arrState.append(StateModel.init(temp))
            }
        }
    }
    
    func serviceCallToGetCity() {
        LoginAPIManager.shared.serviceCallToGetCity(["state_id" : selectedState.id!]) { (data) in
            self.arrCity = [CityModel]()
            for temp in data {
                self.arrCity.append(CityModel.init(temp))
            }
        }
    }
}
