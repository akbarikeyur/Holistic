//
//  ProductListVC.swift
//  Holistic
//
//  Created by Keyur Akbari on 28/10/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class ProductListVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var notiLbl: Label!
    @IBOutlet weak var cartLbl: Label!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var bannerCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        registerCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate().sharedDelegate().hideTabBar()
    }
    
    //MARK:- Button click event
    @IBAction func clickToSideMenu(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToNotification(_ sender: Any) {
        
    }
    
    @IBAction func clickToCart(_ sender: Any) {
        let vc : MyCartVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "MyCartVC") as! MyCartVC
        self.navigationController?.pushViewController(vc, animated: true)
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
extension ProductListVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        bannerCV.register(UINib.init(nibName: "BannerImageCVC", bundle: nil), forCellWithReuseIdentifier: "BannerImageCVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : BannerImageCVC = bannerCV.dequeueReusableCell(withReuseIdentifier: "BannerImageCVC", for: indexPath) as! BannerImageCVC
        
        return cell
    }
}


//MARK:- Tableview Method
extension ProductListVC : UITableViewDelegate, UITableViewDataSource {
    
    func registerTableViewMethod() {
        tblView.register(UINib.init(nibName: "ProductListTVC", bundle: nil), forCellReuseIdentifier: "ProductListTVC")
        tblView.tableHeaderView = headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductListTVC = tblView.dequeueReusableCell(withIdentifier: "ProductListTVC") as! ProductListTVC
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : ProductDetailVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
