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
    
    var page = 1
    var arrProduct = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableViewMethod()
        registerCollectionView()
        
        if AppModel.shared.MY_CART != nil && AppModel.shared.MY_CART.count > 0 {
            cartLbl.text = String(AppModel.shared.MY_CART.count)
            cartLbl.isHidden = false
        }else{
            cartLbl.text = ""
            cartLbl.isHidden = true
        }
        serviceCallToGetProductList()
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
        return arrProduct.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductListTVC = tblView.dequeueReusableCell(withIdentifier: "ProductListTVC") as! ProductListTVC
        cell.setupDetails(arrProduct[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (arrProduct.count-1 == indexPath.row) && page != 0 {
            serviceCallToGetProductList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc : ProductDetailVC = STORYBOARD.PRODUCT.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.productData = arrProduct[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductListVC {
    func serviceCallToGetProductList() {
        ProductAPIManager.shared.serviceCallToGetProductList(page) { (data, last_page) in
            if self.page == 1 {
                self.arrProduct = [ProductModel]()
            }
            for temp in data {
                self.arrProduct.append(ProductModel.init(temp))
            }
            self.tblView.reloadData()
            if last_page == self.page {
                self.page = 0
            }else{
                self.page += 1
            }
        }
    }
}
