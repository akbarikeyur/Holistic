//
//  EditProfileVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 24/12/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    @IBOutlet weak var profileImg: ImageView!
    @IBOutlet weak var nameTxt: TextField!
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
        
        registerTableViewMethod()
        
        if getCountryData().count == 0 {
            AppDelegate().sharedDelegate().serviceCallToGetCountry()
        }else{
            arrCountry = getCountryData()
        }
        setupDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    func setupDetails() {
        if AppModel.shared.currentUser == nil {
            return
        }
        nameTxt.text = AppModel.shared.currentUser.name
        let index = arrCountry.firstIndex { (temp) -> Bool in
            temp.id == AppModel.shared.currentUser.country_id
        }
        if index != nil {
            selectedCountry = arrCountry[index!]
            countryTxt.text = selectedCountry.name
            flagImg.image = UIImage(named: selectedCountry.sortname.lowercased())
            phonecodeTxt.text = "+" + selectedCountry.phonecode
            serviceCallToGetState(1)
        }
        phoneTxt.text = AppModel.shared.currentUser.phone_number
        addressTxt.text = AppModel.shared.currentUser.street_address
        buildingNameTxt.text = AppModel.shared.currentUser.building_address
        floorTxt.text = AppModel.shared.currentUser.floor
        roomTxt.text = AppModel.shared.currentUser.room_no
        
    }
    
    //MARK:- Button click event
    @IBAction func clickToSelectImage(_ sender: Any) {
        
    }
    
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

    @IBAction func clickToCloseSearchView(_ sender: Any) {
        searchView.removeFromSuperview()
        searchTxt.text = ""
    }
    
    @IBAction func clickToSave(_ sender: Any) {
        self.view.endEditing(true)
        if nameTxt.text?.trimmed == "" {
            displayToast("Please enter name")
        }
        else if phonecodeTxt.text?.trimmed == "" {
            displayToast("Please select phone code")
        }
        else if phoneTxt.text?.trimmed == "" {
            displayToast("Please enter phone number")
        }
        else if addressTxt.text?.trimmed == "" {
            displayToast("Please enter address")
        }
        else if buildingNameTxt.text?.trimmed == "" {
            displayToast("Please enter building name")
        }
        else if floorTxt.text?.trimmed == "" {
            displayToast("Please enter floor number")
        }
        else if roomTxt.text?.trimmed == "" {
            displayToast("Please enter room number")
        }
        else if countryTxt.text?.trimmed == "" {
            displayToast("Please select country")
        }
        else if stateTxt.text?.trimmed == "" {
            displayToast("Please select state")
        }
        else if cityTxt.text?.trimmed == "" {
            displayToast("Please select city")
        }
        else {
            var param = [String : Any]()
            param["name"] = nameTxt.text
            param["email"] = AppModel.shared.currentUser.email
            param["city_id"] = selectedState.id
            param["country_id"] = selectedCountry.id
            param["room_no"] = roomTxt.text
            param["floor"] = floorTxt.text
            param["building_address"] = buildingNameTxt.text
            param["street_address"] = addressTxt.text
            param["phone_number"] = phoneTxt.text
            param["user_id"] = AppModel.shared.currentUser.id
            printData(param)
            ProfileAPIManager.shared.serviceCallToUpdateProfile(param) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //MARK:- Textfield method
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
extension EditProfileVC : UITableViewDelegate, UITableViewDataSource {
    
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
            serviceCallToGetState(2)
        }
        else if selectedType == 1 {
            selectedState = (searchTxt.text?.trimmed == "" ? arrState : arrSearchState)[indexPath.row]
            stateTxt.text = selectedState.name
            serviceCallToGetCity(2)
        }
        else if selectedType == 2 {
            selectedCity = (searchTxt.text?.trimmed == "" ? arrCity : arrSearchCity)[indexPath.row]
            cityTxt.text = selectedCity.name
        }
        searchView.removeFromSuperview()
        searchTxt.text = ""
    }
}

extension EditProfileVC {
    func serviceCallToGetState(_ type : Int) {
        LoginAPIManager.shared.serviceCallToGetState(["country_id" : selectedCountry.id!]) { (data) in
            self.arrState = [StateModel]()
            for temp in data {
                self.arrState.append(StateModel.init(temp))
            }
        }
    }
    
    func serviceCallToGetCity(_ type : Int) {
        LoginAPIManager.shared.serviceCallToGetCity(["state_id" : selectedState.id!]) { (data) in
            self.arrCity = [CityModel]()
            for temp in data {
                self.arrCity.append(CityModel.init(temp))
            }
        }
    }
}
