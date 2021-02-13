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
    @IBOutlet weak var percentageAchiveLbl: Label!
    @IBOutlet weak var goalLbl: Label!
    
    var arrTabData = ["Flower of Life", "Current Tasks", "Completed Tasks", "Missed Tasks", "Statistics"]
    var selectedTab = 0
    
    let flowerTab : FlowerLifeTabVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "FlowerLifeTabVC") as! FlowerLifeTabVC
    let currentTab : CurrentTaskTabVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "CurrentTaskTabVC") as! CurrentTaskTabVC
    let completedTab : CompletedTaskTabVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "CompletedTaskTabVC") as! CompletedTaskTabVC
    let missedTab : MissedTaskTabVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "MissedTaskTabVC") as! MissedTaskTabVC
    let statisticsTab : StatisticsTabVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "StatisticsTabVC") as! StatisticsTabVC
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(updateHeight(_:)), name: NSNotification.Name.init("UPDATE_LIFESTYLE_HEIGHT"), object: nil)
        registerCollectionView()
        selecteTab()
        serviceCallToGetFlowerOfLife()
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
            displaySubViewtoParentView(mainContainerView, subview: currentTab.view)
            currentTab.setupDetails()
        }
        else if selectedTab == 2 {
            displaySubViewtoParentView(mainContainerView, subview: completedTab.view)
            completedTab.setupDetails()
        }
        else if selectedTab == 3 {
            displaySubViewtoParentView(mainContainerView, subview: missedTab.view)
            missedTab.setupDetails()
        }
        else if selectedTab == 4 {
            displaySubViewtoParentView(mainContainerView, subview: statisticsTab.view)
            statisticsTab.setupDetails()
        }
    }
    
    func resetContainerView() {
        flowerTab.view.removeFromSuperview()
        currentTab.view.removeFromSuperview()
        completedTab.view.removeFromSuperview()
        missedTab.view.removeFromSuperview()
        statisticsTab.view.removeFromSuperview()
    }
    
    @objc func updateHeight(_ noti : Notification) {
        if let height = noti.object as? CGFloat {
            constraintHeightView.constant = height
        }
    }
}

extension HolisticLifestyleTabVC {
    func serviceCallToGetFlowerOfLife() {
        var param = [String : Any]()
        param["user_id"] = AppModel.shared.currentUser.id
        HomeAPIManager.shared.serviceCallToGetFlowerOfLife(param) { (data) in
            var completedTask = 0
            var totalTask = 0
            for temp in data {
                completedTask += AppModel.shared.getIntValue(temp, "completed")
                totalTask += AppModel.shared.getIntValue(temp, "total")
            }
            var percentage = 0
            if totalTask > 0 {
                percentage = Int(completedTask * 100 / totalTask)
            }
            self.flowerTab.setFlower(percentage)
            self.percentageAchiveLbl.text = String(percentage) + "% achieved"
            self.goalLbl.text = "Based on your overall health test, your score is " + String(completedTask) + " and consider good..."
        }
    }
}
