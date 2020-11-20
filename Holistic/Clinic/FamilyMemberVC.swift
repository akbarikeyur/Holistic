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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickToPackage(_ sender: Any) {
        var isRedirect = false
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: ClinicPackageVC.self) {
                isRedirect = true
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        if !isRedirect {
            let vc : ClinicPackageVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "ClinicPackageVC") as! ClinicPackageVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clickToDietPlan(_ sender: Any) {
        var isRedirect = false
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: DietPlanVC.self) {
                isRedirect = true
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        if !isRedirect {
            let vc : DietPlanVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "DietPlanVC") as! DietPlanVC
            self.navigationController?.pushViewController(vc, animated: true)
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: (collectionView.frame.size.width/2)-50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : FamilyMemberCVC = clinicCV.dequeueReusableCell(withReuseIdentifier: "FamilyMemberCVC", for: indexPath) as! FamilyMemberCVC
        
        return cell
    }
}