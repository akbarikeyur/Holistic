//
//  DietPlanVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 09/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class DietPlanVC: UIViewController {

    @IBOutlet weak var dietCV: UICollectionView!
    @IBOutlet weak var constraintHeightDietCV: NSLayoutConstraint!
    
    var arrExpand = [Int]()
    
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
    
    @IBAction func clickToAppointment(_ sender: Any) {
        var isRedirect = false
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: ClinicListVC.self) {
                isRedirect = true
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        if !isRedirect {
            let vc : ClinicListVC = STORYBOARD.CLINIC.instantiateViewController(withIdentifier: "ClinicListVC") as! ClinicListVC
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
extension DietPlanVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        dietCV.register(UINib.init(nibName: "DietPlanCVC", bundle: nil), forCellWithReuseIdentifier: "DietPlanCVC")
        constraintHeightDietCV.constant = (9/3) * (SCREEN.WIDTH/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : DietPlanCVC = dietCV.dequeueReusableCell(withReuseIdentifier: "DietPlanCVC", for: indexPath) as! DietPlanCVC
        if (indexPath.row+1) % 3 == 0 {
            cell.sideIMg.isHidden = true
        }else{
            cell.sideIMg.isHidden = false
        }
        return cell
    }
}
