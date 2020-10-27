//
//  HomeVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 23/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var flowerView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var searchTxt: TextField!
    @IBOutlet weak var tabCV: UICollectionView!
    
    var arrTabData = ["Holistic Lifestyle", "Holistic Clinic", "Holistic Restaurants", "Holistic Hotels"]
    var selectedTab = 0
    
    let holisticTab : HolisticLifestyleTabVC = STORYBOARD.HOME.instantiateViewController(withIdentifier: "HolisticLifestyleTabVC") as! HolisticLifestyleTabVC
    let restaurantTab : RestaurantTabVC = STORYBOARD.RESTAURANT.instantiateViewController(withIdentifier: "RestaurantTabVC") as! RestaurantTabVC
    let hotelTab : HotelsTabVC = STORYBOARD.HOTEL.instantiateViewController(withIdentifier: "HotelsTabVC") as! HotelsTabVC
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
        delay(2.0) {
            self.flowerView.isHidden = true
            self.selecteTab()
        }
    }
    
    //MARK:- Button click event
    @IBAction func clickToSideMenu(_ sender: Any) {
        self.menuContainerViewController.toggleLeftSideMenuCompletion {}
    }
    
    @IBAction func clickToNotification(_ sender: Any) {
        
    }
    
    @IBAction func clickToFilter(_ sender: Any) {
        
    }
    
    
    /*
     @IBAction func clickToNotification(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- CollectionView Method
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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
            displaySubViewtoParentView(mainContainerView, subview: holisticTab.view)
            holisticTab.setupDetails()
        }
        else if selectedTab == 1 {
            
        }
        else if selectedTab == 2 {
            displaySubViewtoParentView(mainContainerView, subview: restaurantTab.view)
            restaurantTab.setupDetails()
        }
        else if selectedTab == 3 {
            displaySubViewtoParentView(mainContainerView, subview: hotelTab.view)
            hotelTab.setupDetails()
        }
    }
    
    func resetContainerView()
    {
        holisticTab.view.removeFromSuperview()
        hotelTab.view.removeFromSuperview()
    }
}
