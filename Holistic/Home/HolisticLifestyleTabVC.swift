//
//  HolisticLifestyleTabVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class HolisticLifestyleTabVC: UIViewController {

    @IBOutlet weak var tabCV: UICollectionView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var constraintHeightView: NSLayoutConstraint!
    
    var arrTabData = ["Flower of Life", "Current Tasks", "Completed Tasks", "Missed Tasks", "Statistics"]
    var selectedTab = 0
    
    let flowerTab : FlowerLifeTabVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "FlowerLifeTabVC") as! FlowerLifeTabVC
    let taskTab : CurrentTaskTabVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "CurrentTaskTabVC") as! CurrentTaskTabVC
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(updateHeight(_:)), name: NSNotification.Name.init("UPDATE_LIFESTYLE_HEIGHT"), object: nil)
        registerCollectionView()
        selecteTab()
    }
    
    func setupDetails() {
        
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
extension HolisticLifestyleTabVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        tabCV.register(UINib.init(nibName: "TabCVC", bundle: nil), forCellWithReuseIdentifier: "TabCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTabData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = arrTabData[indexPath.row]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 20, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : TabCVC = tabCV.dequeueReusableCell(withReuseIdentifier: "TabCVC", for: indexPath) as! TabCVC
        cell.titleLbl.text = arrTabData[indexPath.row]
        if selectedTab == indexPath.row {
            cell.titleLbl.textColor = OrangeColor
            cell.lineImg.isHidden = false
        }else{
            cell.titleLbl.textColor = BLACK_COLOR
            cell.lineImg.isHidden = true
        }
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
            displaySubViewtoParentView(mainContainerView, subview: flowerTab.view)
            flowerTab.setupDetails()
        }
        else if selectedTab == 1 {
            displaySubViewtoParentView(mainContainerView, subview: taskTab.view)
            taskTab.setupDetails()
        }
    }
    
    func resetContainerView()
    {
        flowerTab.view.removeFromSuperview()
        taskTab.view.removeFromSuperview()
    }
    
    @objc func updateHeight(_ noti : Notification) {
        if let height = noti.object as? CGFloat {
            constraintHeightView.constant = height
        }
    }
}
