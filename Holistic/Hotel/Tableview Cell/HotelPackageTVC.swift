//
//  HotelPackageTVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 27/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import TagListView

class HotelPackageTVC: UITableViewCell, TagListViewDelegate {

    @IBOutlet weak var packagePriceLbl: Label!
    @IBOutlet weak var benifitsCV: UICollectionView!
    @IBOutlet weak var packageTagView: TagListView!
    @IBOutlet weak var constraintHeightPackageTagView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        registerCollectionView()
    }

    func setupDetails() {
        let arrTags = ["Breakfast", "Gym", "Pool", "Cleaning", "20% discount on food"]
        packageTagView.delegate = self
        packageTagView.removeAllTags()
        packageTagView.addTags(arrTags)
        packageTagView.reloadInputViews()
        constraintHeightPackageTagView.constant = packageTagView.intrinsicContentSize.height
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK:- CollectionView Method
extension HotelPackageTVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        benifitsCV.register(UINib.init(nibName: "HotelBenefitsCVC", bundle: nil), forCellWithReuseIdentifier: "HotelBenefitsCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HotelBenefitsCVC = benifitsCV.dequeueReusableCell(withReuseIdentifier: "HotelBenefitsCVC", for: indexPath) as! HotelBenefitsCVC
        
        return cell
    }
}
