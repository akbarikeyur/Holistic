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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
    }
    
    func setupDetails() {
        serviceCallToGetFamilyData()
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
}

extension FamilyMemberVC {
    func serviceCallToGetFamilyData() {
        ClinicAPIManager.shared.serviceCallToGetFamilyData { (data) in
            self.arrMember = [ClinicUserModel]()
            for temp in data {
                self.arrMember.append(ClinicUserModel.init(temp))
            }
            self.clinicCV.reloadData()
        }
    }
}
