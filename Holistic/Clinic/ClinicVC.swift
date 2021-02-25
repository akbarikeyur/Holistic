//
//  ClinicVC.swift
//  Holistic
//
//  Created by Keyur on 26/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicVC: UIViewController {

    @IBOutlet weak var tabCV: UICollectionView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    var arrTab = [ClinicCategoryModel]()
    var selectedTab = 0
    
    let clinicTab : ClinicListVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "ClinicListVC") as! ClinicListVC
    let dietTab : DietPlanVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "DietPlanVC") as! DietPlanVC
    let prescriptionsTab : ClinicPrescriptionsVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "ClinicPrescriptionsVC") as! ClinicPrescriptionsVC
    let packageTab : ClinicPackageVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "ClinicPackageVC") as! ClinicPackageVC
    let familyTab : FamilyMemberVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "FamilyMemberVC") as! FamilyMemberVC
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToTab(_:)), name: NSNotification.Name.init(NOTIFICATION.REDIRECT_CLINIC_TAB), object: nil)
        registerCollectionView()
        if getClinicUserId() != "" {
            tabCV.isHidden = false
            mainContainerView.isHidden = false
            noDataLbl.isHidden = true
            arrTab = [ClinicCategoryModel]()
            for temp in getJsonFromFile("clinic_category") {
                arrTab.append(ClinicCategoryModel.init(temp))
            }
            tabCV.reloadData()
            selecteTab()
        }else{
            tabCV.isHidden = true
            mainContainerView.isHidden = true
            noDataLbl.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().showTabBar()
    }
    
    @objc func redirectToTab(_ noti : Notification) {
        if let dict = noti.object as? [String : Any]{
            if let index = dict["index"] as? Int {
                selectedTab = index
                selecteTab()
            }
        }
    }
    
    func setupDetails() {
        
    }
    
    //MARK:- Button click event
    @IBAction func clickToSideMenu(_ sender: Any) {
        self.menuContainerViewController.toggleLeftSideMenuCompletion {}
    }
    
    @IBAction func clickToNotification(_ sender: Any) {
        let vc : NotificationVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
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

//MARK:- CollectionView Method
extension ClinicVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        tabCV.register(UINib.init(nibName: "ClinicTabCVC", bundle: nil), forCellWithReuseIdentifier: "ClinicTabCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTab.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ClinicTabCVC = tabCV.dequeueReusableCell(withReuseIdentifier: "ClinicTabCVC", for: indexPath) as! ClinicTabCVC
        cell.setupDetails(arrTab[indexPath.row])
        cell.categoryView.isHidden = (indexPath.row != selectedTab)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTab = indexPath.row
        selecteTab()
    }
    
    func selecteTab() {
        resetContainerView()
        tabCV.reloadData()
        tabCV.scrollToItem(at: IndexPath(item: selectedTab, section: 0), at: .left, animated: true)
        if selectedTab == 0 {
            displaySubViewtoParentView(mainContainerView, subview: clinicTab.view)
            clinicTab.setupDetails()
        }
        else if selectedTab == 1 {
            displaySubViewtoParentView(mainContainerView, subview: dietTab.view)
            dietTab.setupDetails()
        }
        else if selectedTab == 2 {
            displaySubViewtoParentView(mainContainerView, subview: prescriptionsTab.view)
            prescriptionsTab.setupDetails()
        }
        else if selectedTab == 3 {
            displaySubViewtoParentView(mainContainerView, subview: packageTab.view)
            packageTab.setupDetails()
        }
        else if selectedTab == 4 {
            displaySubViewtoParentView(mainContainerView, subview: familyTab.view)
            familyTab.setupDetails()
        }
    }
    
    func resetContainerView()
    {
        clinicTab.view.removeFromSuperview()
        dietTab.view.removeFromSuperview()
        prescriptionsTab.view.removeFromSuperview()
        packageTab.view.removeFromSuperview()
        familyTab.view.removeFromSuperview()
    }
}
