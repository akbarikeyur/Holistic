//
//  RestaurantDetailVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class RestaurantDetailVC: UIViewController {

    @IBOutlet weak var restaurantImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var starView: FloatRatingView!
    @IBOutlet weak var addressLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    @IBOutlet var codeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        setupDetails()
    }
    
    func setupDetails() {
        nameLbl.text = "Moshi - Momo & Sushi"
        addressLbl.text = "Business Central Towers | Dubai Media City, Dubai, United Arab Emirates"
        descLbl.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToGetCode(_ sender: Any) {
        displaySubViewtoParentView(self.view, subview: codeView)
    }
    
    @IBAction func clickToCloseCodeView(_ sender: Any) {
        codeView.removeFromSuperview()
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
extension RestaurantDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "FoodListSectionTVC", bundle: nil), forCellReuseIdentifier: "FoodListSectionTVC")
        tblView.register(UINib.init(nibName: "FoodListTVC", bundle: nil), forCellReuseIdentifier: "FoodListTVC")
        updateWakeupTableviewHeight()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell : FoodListSectionTVC = tblView.dequeueReusableCell(withIdentifier: "FoodListSectionTVC") as! FoodListSectionTVC
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FoodListTVC = tblView.dequeueReusableCell(withIdentifier: "FoodListTVC") as! FoodListTVC
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updateWakeupTableviewHeight() {
        constraintHeightTblView.constant = CGFloat.greatestFiniteMagnitude
        tblView.reloadData()
        tblView.layoutIfNeeded()
        constraintHeightTblView.constant = tblView.contentSize.height
    }
}
