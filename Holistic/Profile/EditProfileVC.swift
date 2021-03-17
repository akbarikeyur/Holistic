//
//  EditProfileVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 24/12/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class EditProfileVC: UploadImageVC {

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
    @IBOutlet weak var questionTbl: UITableView!
    @IBOutlet weak var constraintHeightQuestionTbl: NSLayoutConstraint!
    @IBOutlet weak var phoneView: View!
    
    @IBOutlet var searchView: UIView!
    @IBOutlet weak var searchTxt: TextField!
    @IBOutlet weak var searchTbl: UITableView!
    
    var arrCountry = [CountryModel]()
    var arrSearchCountry = [CountryModel]()
    var selectedCountry = CountryModel.init([String : Any]())
    var selectedType = 0
    var arrQuestion = [QuestionModel]()
    var profileImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        phoneView.isHidden = true
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
        setImageBackgroundImage(profileImg, AppModel.shared.currentUser.get_profile.url, IMAGE.PLACEHOLDER)
        nameTxt.text = AppModel.shared.currentUser.name
        let index = arrCountry.firstIndex { (temp) -> Bool in
            temp.id == AppModel.shared.currentUser.country_id
        }
        if index != nil {
            selectedCountry = arrCountry[index!]
            countryTxt.text = selectedCountry.name
            serviceCallToGetUserQuestion()
        }
        let index1 = arrCountry.firstIndex { (temp) -> Bool in
            ("+" + temp.phonecode) == AppModel.shared.currentUser.phone_code
        }
        if index1 != nil {
            let tempCountry = arrCountry[index1!]
            flagImg.image = UIImage(named: tempCountry.sortname.lowercased())
            phonecodeTxt.text = "+" + tempCountry.phonecode
        }
        stateTxt.text = AppModel.shared.currentUser.state_id
        cityTxt.text = AppModel.shared.currentUser.city_id
        phoneTxt.text = AppModel.shared.currentUser.phone_number
        addressTxt.text = AppModel.shared.currentUser.street_address
        buildingNameTxt.text = AppModel.shared.currentUser.building_address
        floorTxt.text = AppModel.shared.currentUser.floor
        roomTxt.text = AppModel.shared.currentUser.room_no
        
    }
    
    //MARK:- Button click event
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToSelectImage(_ sender: Any) {
        uploadImage()
    }
    
    override func selectedImage(choosenImage: UIImage) {
        profileImage = choosenImage
        profileImg.image = choosenImage
        ProfileAPIManager.shared.serviceCallToUploadProfileImage(["user_id":AppModel.shared.currentUser.id!], choosenImage) {
            AppDelegate().sharedDelegate().serviceCallToGetUserDetail()
        }
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
//        else if addressTxt.text?.trimmed == "" {
//            displayToast("Please enter address")
//        }
//        else if buildingNameTxt.text?.trimmed == "" {
//            displayToast("Please enter building name")
//        }
//        else if floorTxt.text?.trimmed == "" {
//            displayToast("Please enter floor number")
//        }
//        else if roomTxt.text?.trimmed == "" {
//            displayToast("Please enter room number")
//        }
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
            
            var isRemaining = false
            for temp in arrQuestion {
                if temp.answer == "" {
                    isRemaining = true
                }
            }
            
            if isRemaining {
                displayToast("Please select all answer")
            }
            else{
                var param = [String : Any]()
                param["name"] = nameTxt.text
                param["email"] = AppModel.shared.currentUser.email
                param["city_id"] = cityTxt.text
                param["state_id"] = stateTxt.text
                param["country_id"] = selectedCountry.id
                param["room_no"] = roomTxt.text
                param["floor"] = floorTxt.text
                param["building_address"] = buildingNameTxt.text
                param["street_address"] = addressTxt.text
                param["phone_number"] = phoneTxt.text
                param["phone_code"] = phonecodeTxt.text
                param["countrycode"] = selectedCountry.id
                param["user_id"] = AppModel.shared.currentUser.id
                var arrData = [[String : Any]]()
                for temp in arrQuestion {
                    var dict = [String : Any]()
                    dict["question_id"] = temp.id
                    dict["answer"] = temp.answer
                    arrData.append(dict)
                }
                param["answers"] = arrData
                printData(param)
                ProfileAPIManager.shared.serviceCallToUpdateProfile(param) {
                    AppDelegate().sharedDelegate().serviceCallToGetUserDetail()
                    self.navigationController?.popViewController(animated: true)
                }
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
        questionTbl.register(UINib.init(nibName: "QuestionAnswerTVC", bundle: nil), forCellReuseIdentifier: "QuestionAnswerTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == questionTbl {
            return arrQuestion.count
        }
        else if selectedType == 0 || selectedType == 3 {
            return searchTxt.text?.trimmed == "" ? arrCountry.count : arrSearchCountry.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == questionTbl {
            let cell : QuestionAnswerTVC = questionTbl.dequeueReusableCell(withIdentifier: "QuestionAnswerTVC") as! QuestionAnswerTVC
            cell.setupDetails(arrQuestion[indexPath.row], indexPath.row)
            cell.answer1Btn.tag = indexPath.row
            cell.answer1Btn.addTarget(self, action: #selector(clickToAnswe1(_:)), for: .touchUpInside)
            cell.answer2Btn.tag = indexPath.row
            cell.answer2Btn.addTarget(self, action: #selector(clickToAnswe2(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
        else{
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchTbl {
            if selectedType == 0 {
                selectedCountry = (searchTxt.text?.trimmed == "" ? arrCountry : arrSearchCountry)[indexPath.row]
                countryTxt.text = selectedCountry.name
                serviceCallToGetUserQuestion()
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
    
    @objc @IBAction func clickToAnswe1(_ sender: UIButton) {
        arrQuestion[sender.tag].answer = "yes"
        questionTbl.reloadData()
    }
    
    @objc @IBAction func clickToAnswe2(_ sender: UIButton) {
        arrQuestion[sender.tag].answer = "no"
        questionTbl.reloadData()
    }
    
    func updateQuestionTableviewHeight() {
        constraintHeightQuestionTbl.constant = CGFloat.greatestFiniteMagnitude
        questionTbl.reloadData()
        questionTbl.layoutIfNeeded()
        constraintHeightQuestionTbl.constant = questionTbl.contentSize.height
    }
}

extension EditProfileVC {
    
    func serviceCallToGetUserQuestion() {
        LoginAPIManager.shared.serviceCallToGetUserQuestion(["country_id" : selectedCountry.id!]) { (data) in
            self.arrQuestion = [QuestionModel]()
            for temp in data {
                self.arrQuestion.append(QuestionModel.init(temp))
            }
            if AppModel.shared.currentUser.answers.count > 0 {
                for i in 0..<self.arrQuestion.count {
                    let index = AppModel.shared.currentUser.answers.firstIndex { (tempAns) -> Bool in
                        tempAns.get_question.id == self.arrQuestion[i].id
                    }
                    if index != nil {
                        self.arrQuestion[i].answer = AppModel.shared.currentUser.answers[index!].answer
                    }
                }
            }
            
            self.updateQuestionTableviewHeight()
        }
    }
}
