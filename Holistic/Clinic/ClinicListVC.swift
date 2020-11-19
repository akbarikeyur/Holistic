//
//  ClinicListVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 09/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicListVC: UIViewController {

    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var fromTxt: UITextField!
    @IBOutlet weak var toTxt: UITextField!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var constraintHeightTblView: NSLayoutConstraint!
    
    var arrClinicCategory = [ClinicCategoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
        registerTableViewMethod()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToNotification(_ sender: Any) {
        
    }
    
    @IBAction func clickToSelectFromDate(_ sender: Any) {
        
    }
    
    @IBAction func clickToSelectToDate(_ sender: Any) {
        
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

//MARK:- CollectionView Method
extension ClinicListVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        categoryCV.register(UINib.init(nibName: "ClinicCategoryCVC", bundle: nil), forCellWithReuseIdentifier: "ClinicCategoryCVC")
        
        arrClinicCategory = [ClinicCategoryModel]()
        for temp in getJsonFromFile("clinic_category") {
            arrClinicCategory.append(ClinicCategoryModel.init(temp))
        }
        categoryCV.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrClinicCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ClinicCategoryCVC = categoryCV.dequeueReusableCell(withReuseIdentifier: "ClinicCategoryCVC", for: indexPath) as! ClinicCategoryCVC
        cell.setupDetails(arrClinicCategory[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if arrClinicCategory[indexPath.row].name == "Packages" {
            let vc : ClinicPackageVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "ClinicPackageVC") as! ClinicPackageVC
            UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
        else if arrClinicCategory[indexPath.row].name == "Family Members" {
            let vc : FamilyMemberVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "FamilyMemberVC") as! FamilyMemberVC
            UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
        else if arrClinicCategory[indexPath.row].name == "Diet Plans" {
            let vc : DietPlanVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "DietPlanVC") as! DietPlanVC
            UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK:- Tableview Method
extension ClinicListVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "ClinicAppointmentTVC", bundle: nil), forCellReuseIdentifier: "ClinicAppointmentTVC")
        updateTableviewHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ClinicAppointmentTVC = tblView.dequeueReusableCell(withIdentifier: "ClinicAppointmentTVC") as! ClinicAppointmentTVC
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func updateTableviewHeight() {
        constraintHeightTblView.constant = 150 * 3
    }
}
