//
//  FamilyMemberVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 09/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class FamilyMemberVC: UIViewController {

    @IBOutlet weak var clinicCV: UICollectionView!
    
    var arrMember = [ClinicUserModel]()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name.init(NOTIFICATION.REFRESH_CLINIC_DATA), object: nil)
        registerCollectionView()
    }
    
    @objc func refreshData() {
        page = 1
        serviceCallToGetFamilyData()
    }
    
    func setupDetails() {
        if arrMember.count == 0 {
            page = 1
            serviceCallToGetFamilyData()
        }else{
            clinicCV.reloadData()
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

//MARK:- CollectionView Method
extension FamilyMemberVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        clinicCV.register(UINib.init(nibName: "FamilyMemberCVC", bundle: nil), forCellWithReuseIdentifier: "FamilyMemberCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMember.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: (collectionView.frame.size.width/2)-50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : FamilyMemberCVC = clinicCV.dequeueReusableCell(withReuseIdentifier: "FamilyMemberCVC", for: indexPath) as! FamilyMemberCVC
        cell.setupDetails(arrMember[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if page != 0 && ((arrMember.count-1) == indexPath.row) {
            serviceCallToGetFamilyData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setClinicUserId(arrMember[indexPath.row].ID)
        clinicCV.reloadData()
        serviceCallToGetFamilyData()
        NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REDIRECT_CLINIC_TAB), object: ["index" : 0])
        NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.REFRESH_CLINIC_DATA), object: nil)
    }
}

extension FamilyMemberVC {
    func serviceCallToGetFamilyData() {
        if getClinicUserId() == "" {
            return
        }
        ClinicAPIManager.shared.serviceCallToGetFamilyData(page) { (data) in
            if self.page == 1 {
                self.arrMember = [ClinicUserModel]()
            }
            for temp in data {
                self.arrMember.append(ClinicUserModel.init(temp))
            }
            if data.count < 10 {
                self.page = 0
            }else{
                self.page += 1
            }
            self.clinicCV.reloadData()
        }
    }
}
