//
//  ClinicPrescriptionsVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 20/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ClinicPrescriptionsVC: UIViewController {

    @IBOutlet weak var prescriptionCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func clickToDiet(_ sender: Any) {
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
extension ClinicPrescriptionsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        prescriptionCV.register(UINib.init(nibName: "PrescriptionsCVC", bundle: nil), forCellWithReuseIdentifier: "PrescriptionsCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: (135*3))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PrescriptionsCVC = prescriptionCV.dequeueReusableCell(withReuseIdentifier: "PrescriptionsCVC", for: indexPath) as! PrescriptionsCVC
        cell.setupDetails()
        return cell
    }
}
