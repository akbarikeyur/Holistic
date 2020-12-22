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
    
    var arrDietPlan = [DietPlanModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
    }
    
    func setupDetails() {
        if arrDietPlan.count == 0 {
            serviceCallToGetDietPlan()
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
        updateDietCVHeight()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDietPlan.count
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
        cell.setupDetails(arrDietPlan[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openUrlInSafari(strUrl: arrDietPlan[indexPath.row].DocumentOnlineURL)
    }
    func updateDietCVHeight() {
        if arrDietPlan.count % 3 == 0 {
            constraintHeightDietCV.constant = (CGFloat(arrDietPlan.count)/3) * (SCREEN.WIDTH/3)
        }else{
            constraintHeightDietCV.constant = ((CGFloat(arrDietPlan.count)/3) + 1) * (SCREEN.WIDTH/3)
        }
    }
}

extension DietPlanVC {
    func serviceCallToGetDietPlan() {
        ClinicAPIManager.shared.serviceCallToGetDietPlan { (data) in
            self.arrDietPlan = [DietPlanModel]()
            for temp in data {
                self.arrDietPlan.append(DietPlanModel.init(temp))
            }
            self.dietCV.reloadData()
            self.updateDietCVHeight()
        }
    }
}
