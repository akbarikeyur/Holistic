//
//  ClinicPackageVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 11/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicPackageVC: UIViewController {

    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var fromDateTxt: UITextField!
    @IBOutlet weak var toDateTxt: UITextField!
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
extension ClinicPackageVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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
        if arrClinicCategory[indexPath.row].name == "Family Members" {
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
extension ClinicPackageVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "ClinicPackageTVC", bundle: nil), forCellReuseIdentifier: "ClinicPackageTVC")
        updateTableviewHeight()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ClinicPackageTVC = tblView.dequeueReusableCell(withIdentifier: "ClinicPackageTVC") as! ClinicPackageTVC
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : ClinicPackageDetailVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "ClinicPackageDetailVC") as! ClinicPackageDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateTableviewHeight() {
        constraintHeightTblView.constant = 2 * 198
    }
}
