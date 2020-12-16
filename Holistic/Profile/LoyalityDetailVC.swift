//
//  LoyalityDetailVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 19/11/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class LoyalityDetailVC: UIViewController {

    @IBOutlet weak var topImgView: UIImageView!
    @IBOutlet weak var imageCV: UICollectionView!
    @IBOutlet weak var discountLbl: Label!
    
    var arrImage = ["hotel1", "hotel2", "hotel3", "hotel4", "hotel5", "hotel6", "hotel7"]
    var selectedImageIndex = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionView()
        discountLbl.attributedText = attributedStringWithColor(discountLbl.text!, ["10% Discount"], color: OrangeColor)
    }
    
    //MARK:- Button click event
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension LoyalityDetailVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        imageCV.register(UINib.init(nibName: "HotelImageCVC", bundle: nil), forCellWithReuseIdentifier: "HotelImageCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HotelImageCVC = imageCV.dequeueReusableCell(withReuseIdentifier: "HotelImageCVC", for: indexPath) as! HotelImageCVC
        //cell.setupDetails((indexPath.row == selectedImageIndex))
        cell.imgView.image = UIImage(named: arrImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageIndex = indexPath.row
        imageCV.reloadData()
        topImgView.image = UIImage(named: arrImage[indexPath.row])
    }
}
