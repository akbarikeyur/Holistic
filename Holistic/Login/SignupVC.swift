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
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTxt: TextField!
    @IBOutlet weak var confirmPasswordTxt: TextField!
    
    @IBOutlet weak var signinBtn: Button!
    @IBOutlet var searchView: UIView!
    @IBOutlet weak var searchTxt: TextField!
    @IBOutlet weak var searchTbl: UITableView!
    
    @IBOutlet weak var mobileLoginBtn: Button!
    
    var arrCountry = [CountryModel]()
    var arrSearchCountry = [CountryModel]()
    var selectedCountry = CountryModel.init([String : Any]())
    var selectedType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        configUI()
    }
    
    func configUI() {
        signinBtn.setAttributedTitle(attributedStringWithColor("Already member? Sign in", ["Sign in"], color: OrangeColor), for: .normal)
        mobileLoginBtn.setAttributedTitle(attributedStringWithColor("If already a member in Clincia App, Click Here", ["Click Here"], color: OrangeColor), for: .normal)
        registerTableViewMethod()
        passwordView.isHidden = false
        
        if getCountryData().count == 0 {
            AppDelegate().sharedDelegate().serviceCallToGetCountry()
        }
        else{
            arrCountry = getCountryData()
            let index = arrCountry.firstIndex { (temp) -> Bool in
                temp.sortname.lowercased() == "ae"
            }
            if index != nil {
                selectedCountry = arrCountry[index!]
                countryTxt.text = selectedCountry.name
                flagImg.image = UIImage(named: selectedCountry.sortname.lowercased())
                phonecodeTxt.text = "+" + selectedCountry.phonecode
            }
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
        var isRedirect = false
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: EmailLoginVC.self) {
                isRedirect = true
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        if !isRedirect {
            self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func clickToMobileLogin(_ sender: Any) {
        self.view.endEditing(true)
        var isRedirect = false
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: MobileLoginVC.self) {
                isRedirect = true
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        if !isRedirect {
            let vc : MobileLoginVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "MobileLoginVC") as! MobileLoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
//        else if addressTxt.text?.trimmed == "" {
//            displayToast("enter_address")
//        }
//        else if buildingNameTxt.text?.trimmed == "" {
//            displayToast("enter_building")
//        }
//        else if floorTxt.text?.trimmed == "" {
//            displayToast("enter_floor")
//        }
//        else if roomTxt.text?.trimmed == "" {
//            displayToast("enter_room_number")
//        }
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
            param["state_id"] = stateTxt.text
            param["city_id"] = cityTxt.text
            param["room_no"] = roomTxt.text
            param["floor"] = floorTxt.text
            param["building_address"] = buildingNameTxt.text
            param["street_address"] = addressTxt.text
            param["phone_code"] = phonecodeTxt.text
            param["phone_number"] = phoneTxt.text
            param["countrycode"] = self.selectedCountry.phonecode
            printData(param)
            LoginAPIManager.shared.serviceCallToSignup(param) { (dict) in
                var newParam = [String : Any]()
                newParam["email"] = self.emailTxt.text
                newParam["password"] = self.passwordTxt.text
                newParam["remember_token"] = getPushToken()
                printData(newParam)
                LoginAPIManager.shared.serviceCallToEmailLogin(newParam) { (dict) in
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
        else if selectedType == 3 {
            cell.titleLbl.text = "(+" + (searchTxt.text?.trimmed == "" ? arrCountry : arrSearchCountry)[indexPath.row].phonecode + ") " + (searchTxt.text?.trimmed == "" ? arrCountry : arrSearchCountry)[indexPath.row].name
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedType == 0 {
            selectedCountry = (searchTxt.text?.trimmed == "" ? arrCountry : arrSearchCountry)[indexPath.row]
            countryTxt.text = selectedCountry.name
        }
        else if selectedType == 0 || selectedType == 3 {
            let tempCountry = (searchTxt.text?.trimmed == "" ? arrCountry : arrSearchCountry)[indexPath.row]
            flagImg.image = UIImage(named: tempCountry.sortname.lowercased())
            phonecodeTxt.text = "+" + tempCountry.phonecode
        }
        searchView.removeFromSuperview()
        searchTxt.text = ""
    }
}

